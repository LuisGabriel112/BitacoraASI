import hashlib
import random

from sqlalchemy import func, select, update
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import DanioJefeEvento, JefeBonus, JefeSemanal
from app.services import tienda
from app.services.auth import resolver_usuario_id
from app.services.xp import otorgar_xp

# Constantes propias, a propósito desacopladas de XP_POR_ACCION/XP_POR_LOGRO en
# app.services.rpg: recalibrar el nivel de personaje no debe acelerar/frenar sin
# querer qué tan rápido muere el jefe semanal.
DANIO_POR_ACCION = 5
DANIO_POR_LOGRO = 25
VIDA_MAX_SEMANAL = 1000
FACTOR_DIFICULTAD = 1.2
VIDA_MAX_TOPE = 5000

# Jefes bonus: aparecen apenas el jefe principal de la semana cae. Más chicos
# y rápidos de tumbar — el premio es XP extra, no alargar la semana.
CANTIDAD_JEFES_BONUS = 2
FACTOR_VIDA_JEFE_BONUS = 0.25
XP_BONUS_JEFE_BONUS = 60

NOMBRES_JEFE = [
    "Backlog Infinito",
    "El Ticket Zombie",
    "Cuello de Botella",
    "El Bug Legendario",
    "Sobrecarga de Turno",
    "El SLA Vencido",
    "Caos de Prioridades",
    "El Reinicio Eterno",
]

NOMBRES_JEFE_BONUS = [
    "El Ticket Duplicado",
    "El Falso Positivo",
    "La Fuga de Memoria",
    "El Deploy de Viernes",
    "El Merge Conflict",
    "La Caché Corrupta",
]


def nombre_del_jefe(semana: str) -> str:
    """Determinista por semana (mismo nombre toda la semana), varía entre semanas."""
    indice = int(hashlib.sha256(semana.encode()).hexdigest(), 16) % len(NOMBRES_JEFE)
    return NOMBRES_JEFE[indice]


def nombre_del_jefe_bonus(semana: str, indice: int) -> str:
    """Determinista por semana + índice. Usa un offset por semana y avanza por
    índice (no un hash independiente por índice) para que los jefes bonus de
    una misma semana nunca choquen en el mismo nombre — mientras
    CANTIDAD_JEFES_BONUS <= len(NOMBRES_JEFE_BONUS), siempre son distintos."""
    offset = int(hashlib.sha256(f"{semana}-bonus".encode()).hexdigest(), 16) % len(NOMBRES_JEFE_BONUS)
    return NOMBRES_JEFE_BONUS[(offset + indice) % len(NOMBRES_JEFE_BONUS)]


def vida_jefe_bonus(vida_max_semana: int) -> int:
    return max(1, round(vida_max_semana * FACTOR_VIDA_JEFE_BONUS))


def siguiente_jefe_bonus_activo(bonus: list[JefeBonus]) -> JefeBonus | None:
    return next((b for b in bonus if b.vida_actual > 0), None)


def cruzo_a_derrotado(vida_antes: int, vida_despues: int) -> bool:
    return vida_antes > 0 and vida_despues <= 0


def calcular_vida_max_siguiente(vida_max_anterior: int | None, derrotado_anterior: bool) -> int:
    """Sube un 20% si el equipo derrotó al jefe anterior; si no lo derrotó, se
    reinicia a la vida base — la dificultad solo escala tras una victoria."""
    if vida_max_anterior is None or not derrotado_anterior:
        return VIDA_MAX_SEMANAL
    return min(VIDA_MAX_TOPE, round(vida_max_anterior * FACTOR_DIFICULTAD))


async def _jefe_anterior(session: AsyncSession) -> JefeSemanal | None:
    stmt = select(JefeSemanal).order_by(JefeSemanal.id.desc()).limit(1)
    return (await session.execute(stmt)).scalar_one_or_none()


async def obtener_o_crear_jefe(session: AsyncSession, semana: str) -> JefeSemanal:
    jefe = (await session.execute(select(JefeSemanal).where(JefeSemanal.semana == semana))).scalar_one_or_none()
    if jefe is not None:
        return jefe

    anterior = await _jefe_anterior(session)
    derrotado_anterior = anterior.vida_actual <= 0 if anterior else False
    vida_max = calcular_vida_max_siguiente(anterior.vida_max if anterior else None, derrotado_anterior)

    jefe = JefeSemanal(semana=semana, vida_max=vida_max, vida_actual=vida_max)
    session.add(jefe)
    try:
        await session.commit()
    except IntegrityError:
        await session.rollback()
        jefe = (await session.execute(select(JefeSemanal).where(JefeSemanal.semana == semana))).scalar_one()
    else:
        await session.refresh(jefe)
    return jefe


async def danar_jefe(session: AsyncSession, semana: str, cantidad: int, nombre: str, motivo: str) -> None:
    """Best effort: un fallo aquí nunca debe tumbar la creación del registro/mesa."""
    try:
        await _danar_jefe(session, semana, cantidad, nombre, motivo)
    except Exception:
        await session.rollback()


async def _bono_danio_objetos(session: AsyncSession, semana: str, nombre: str, cantidad: int) -> int:
    """+% de daño de los objetos equipados, más un roll de crítico (x2)
    independiente del crítico determinista de bonus.py. Sin cuenta vinculada
    al nombre capturado, no hay objetos que buscar — daño sin cambios."""
    usuario_id = await resolver_usuario_id(session, nombre)
    bono = await tienda.bono_de_usuario(session, usuario_id, semana)
    if bono.danio_pct == 0 and bono.critico_pct == 0:
        return cantidad

    cantidad = max(1, round(cantidad * (1 + bono.danio_pct / 100)))
    if bono.critico_pct > 0 and random.random() < bono.critico_pct / 100:
        cantidad *= 2
    return cantidad


async def _danar_jefe(session: AsyncSession, semana: str, cantidad: int, nombre: str, motivo: str) -> None:
    jefe = await obtener_o_crear_jefe(session, semana)
    cantidad = await _bono_danio_objetos(session, semana, nombre, cantidad)
    vida_antes = jefe.vida_actual
    await session.execute(
        update(JefeSemanal)
        .where(JefeSemanal.semana == semana)
        .values(vida_actual=func.greatest(JefeSemanal.vida_actual - cantidad, 0))
    )
    session.add(DanioJefeEvento(jefe_id=jefe.id, nombre_capturado=nombre, cantidad=cantidad, motivo=motivo))
    await session.commit()

    if cruzo_a_derrotado(vida_antes, max(0, vida_antes - cantidad)):
        await _crear_jefes_bonus(session, jefe.id, semana, jefe.vida_max)
    elif vida_antes <= 0:
        await asegurar_jefes_bonus(session, jefe)
        await _danar_jefes_bonus(session, jefe.id, cantidad, nombre)


async def asegurar_jefes_bonus(session: AsyncSession, jefe: JefeSemanal) -> list[JefeBonus]:
    """Get-or-create: cubre el jefe que ya estaba derrotado antes de que
    existieran los jefes bonus (o cualquier otro caso donde falten)."""
    existentes = await bonus_jefes_de_semana(session, jefe.id)
    if existentes or jefe.vida_actual > 0:
        return existentes
    await _crear_jefes_bonus(session, jefe.id, jefe.semana, jefe.vida_max)
    return await bonus_jefes_de_semana(session, jefe.id)


async def _crear_jefes_bonus(session: AsyncSession, jefe_id: int, semana: str, vida_max_semana: int) -> None:
    vida = vida_jefe_bonus(vida_max_semana)
    for indice in range(CANTIDAD_JEFES_BONUS):
        session.add(JefeBonus(jefe_id=jefe_id, nombre=nombre_del_jefe_bonus(semana, indice), vida_max=vida, vida_actual=vida))
    await session.commit()


async def bonus_jefes_de_semana(session: AsyncSession, jefe_id: int) -> list[JefeBonus]:
    stmt = select(JefeBonus).where(JefeBonus.jefe_id == jefe_id).order_by(JefeBonus.id)
    return (await session.execute(stmt)).scalars().all()


async def _danar_jefes_bonus(session: AsyncSession, jefe_id: int, cantidad: int, nombre: str) -> None:
    objetivo = siguiente_jefe_bonus_activo(await bonus_jefes_de_semana(session, jefe_id))
    if objetivo is None:
        return

    vida_despues = max(0, objetivo.vida_actual - cantidad)
    await session.execute(update(JefeBonus).where(JefeBonus.id == objetivo.id).values(vida_actual=vida_despues))
    await session.commit()

    if cruzo_a_derrotado(objetivo.vida_actual, vida_despues):
        await otorgar_xp(session, nombre, XP_BONUS_JEFE_BONUS, "jefe_bonus_derrotado")


def _filtrar_derrotados(jefes: list[JefeSemanal]) -> list[JefeSemanal]:
    return [j for j in jefes if j.vida_actual <= 0]


async def mascotas_derrotadas(session: AsyncSession) -> list[JefeSemanal]:
    """Cada jefe semanal que el equipo derrotó queda como mascota permanente
    — no se borra nada, solo se filtran los jefes ya guardados en la tabla."""
    stmt = select(JefeSemanal).order_by(JefeSemanal.created_at.desc())
    jefes = (await session.execute(stmt)).scalars().all()
    return _filtrar_derrotados(jefes)


async def eventos_de_dano(session: AsyncSession, jefe_id: int, limite: int = 200) -> list[DanioJefeEvento]:
    stmt = (
        select(DanioJefeEvento)
        .where(DanioJefeEvento.jefe_id == jefe_id)
        .order_by(DanioJefeEvento.created_at.desc())
        .limit(limite)
    )
    return (await session.execute(stmt)).scalars().all()
