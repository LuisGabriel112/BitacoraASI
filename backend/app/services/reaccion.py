from datetime import date, datetime, timedelta

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import IntentoReaccion
from app.services import cooldown as cooldown_service
from app.services import tienda
from app.services.jefes import danar_jefe
from app.services.semanas import semana_de

DANIO_REACCION = 2
COOLDOWN_REACCION = timedelta(minutes=5)
# Bajo 120ms nadie reacciona de verdad a un estímulo visual (probable script).
# Arriba de 3s ya no es "reacción rápida" — probable valor manipulado o distracción.
TIEMPO_MINIMO_MS = 120
TIEMPO_MAXIMO_MS = 3000


def es_tiempo_plausible(tiempo_ms: int) -> bool:
    return TIEMPO_MINIMO_MS <= tiempo_ms <= TIEMPO_MAXIMO_MS


class ReaccionError(Exception):
    pass


async def _ultimo_intento(session: AsyncSession, usuario_id: int) -> IntentoReaccion | None:
    stmt = (
        select(IntentoReaccion)
        .where(IntentoReaccion.usuario_id == usuario_id)
        .order_by(IntentoReaccion.created_at.desc())
        .limit(1)
    )
    return (await session.execute(stmt)).scalar_one_or_none()


async def iniciar_intento(session: AsyncSession, usuario_id: int, ahora: datetime) -> IntentoReaccion:
    ultimo = await _ultimo_intento(session, usuario_id)
    if ultimo is not None:
        bono = await tienda.bono_de_usuario(session, usuario_id, semana_de(date.today()))
        cooldown = cooldown_service.cooldown_efectivo(COOLDOWN_REACCION, bono.cooldown_pct)
        if not cooldown_service.puede_jugar(ultimo.created_at, ahora, cooldown):
            raise ReaccionError("Todavía en cooldown")

    intento = IntentoReaccion(usuario_id=usuario_id)
    session.add(intento)
    await session.commit()
    await session.refresh(intento)
    return intento


async def resolver_intento(
    session: AsyncSession, intento_id: int, usuario_id: int, tiempo_ms: int, nombre: str
) -> IntentoReaccion:
    intento = await session.get(IntentoReaccion, intento_id)
    if intento is None or intento.usuario_id != usuario_id:
        raise ReaccionError("Intento no encontrado")
    if intento.resuelto:
        raise ReaccionError("Ese intento ya se resolvió")

    intento.tiempo_ms = tiempo_ms
    intento.resuelto = True
    intento.acierto = es_tiempo_plausible(tiempo_ms)
    if intento.acierto:
        await danar_jefe(session, semana_de(date.today()), DANIO_REACCION, nombre, "minijuego_reaccion")

    await session.commit()
    await session.refresh(intento)
    return intento
