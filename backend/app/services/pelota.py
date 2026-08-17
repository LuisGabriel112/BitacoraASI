import random
from datetime import date, datetime, timedelta

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import IntentoPelota
from app.services import cooldown as cooldown_service
from app.services.jefes import danar_jefe
from app.services.semanas import semana_de

CASILLAS_PELOTA = 3
DANIO_PELOTA = 5
COOLDOWN_PELOTA = timedelta(minutes=5)


def tiempo_restante_cooldown(ultimo_intento: datetime | None, ahora: datetime) -> timedelta:
    return cooldown_service.tiempo_restante(ultimo_intento, ahora, COOLDOWN_PELOTA)


def puede_jugar(ultimo_intento: datetime | None, ahora: datetime) -> bool:
    return cooldown_service.puede_jugar(ultimo_intento, ahora, COOLDOWN_PELOTA)


class PelotaError(Exception):
    pass


async def _ultimo_intento(session: AsyncSession, usuario_id: int) -> IntentoPelota | None:
    stmt = (
        select(IntentoPelota)
        .where(IntentoPelota.usuario_id == usuario_id)
        .order_by(IntentoPelota.created_at.desc())
        .limit(1)
    )
    return (await session.execute(stmt)).scalar_one_or_none()


async def iniciar_intento(session: AsyncSession, usuario_id: int, ahora: datetime) -> IntentoPelota:
    ultimo = await _ultimo_intento(session, usuario_id)
    if ultimo is not None and not puede_jugar(ultimo.created_at, ahora):
        raise PelotaError("Todavía en cooldown")

    intento = IntentoPelota(usuario_id=usuario_id, posicion_correcta=random.randrange(CASILLAS_PELOTA))
    session.add(intento)
    await session.commit()
    await session.refresh(intento)
    return intento


async def resolver_intento(
    session: AsyncSession, intento_id: int, usuario_id: int, posicion: int, nombre: str
) -> IntentoPelota:
    intento = await session.get(IntentoPelota, intento_id)
    if intento is None or intento.usuario_id != usuario_id:
        raise PelotaError("Intento no encontrado")
    if intento.resuelto:
        raise PelotaError("Ese intento ya se resolvió")

    intento.resuelto = True
    intento.acierto = posicion == intento.posicion_correcta
    if intento.acierto:
        await danar_jefe(session, semana_de(date.today()), DANIO_PELOTA, nombre, "minijuego_pelota")

    await session.commit()
    await session.refresh(intento)
    return intento
