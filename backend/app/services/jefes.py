import hashlib

from sqlalchemy import func, select, update
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import JefeSemanal

# Constantes propias, a propósito desacopladas de XP_POR_ACCION/XP_POR_LOGRO en
# app.services.rpg: recalibrar el nivel de personaje no debe acelerar/frenar sin
# querer qué tan rápido muere el jefe semanal.
DANIO_POR_ACCION = 5
DANIO_POR_LOGRO = 25
VIDA_MAX_SEMANAL = 1000
FACTOR_DIFICULTAD = 1.2
VIDA_MAX_TOPE = 5000

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


def nombre_del_jefe(semana: str) -> str:
    """Determinista por semana (mismo nombre toda la semana), varía entre semanas."""
    indice = int(hashlib.sha256(semana.encode()).hexdigest(), 16) % len(NOMBRES_JEFE)
    return NOMBRES_JEFE[indice]


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


async def danar_jefe(session: AsyncSession, semana: str, cantidad: int) -> None:
    """Best effort: un fallo aquí nunca debe tumbar la creación del registro/mesa."""
    try:
        await _danar_jefe(session, semana, cantidad)
    except Exception:
        await session.rollback()


async def _danar_jefe(session: AsyncSession, semana: str, cantidad: int) -> None:
    await obtener_o_crear_jefe(session, semana)
    await session.execute(
        update(JefeSemanal)
        .where(JefeSemanal.semana == semana)
        .values(vida_actual=func.greatest(JefeSemanal.vida_actual - cantidad, 0))
    )
    await session.commit()
