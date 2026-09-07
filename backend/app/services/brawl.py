from datetime import date, datetime, timedelta

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import IntentoBrawl
from app.services import cooldown as cooldown_service
from app.services import tienda
from app.services.jefes import danar_jefe
from app.services.semanas import semana_de

DANIO_BRAWL = 3
COOLDOWN_BRAWL = timedelta(minutes=5)
# Arena de 3 bots: eliminar 2 o los 3 cuenta como ronda ganada.
UMBRAL_ACIERTO = 2


def es_resultado_plausible(enemigos_eliminados: int) -> bool:
    return enemigos_eliminados >= UMBRAL_ACIERTO


class BrawlError(Exception):
    pass


async def _ultimo_intento(session: AsyncSession, usuario_id: int) -> IntentoBrawl | None:
    stmt = (
        select(IntentoBrawl)
        .where(IntentoBrawl.usuario_id == usuario_id)
        .order_by(IntentoBrawl.created_at.desc())
        .limit(1)
    )
    return (await session.execute(stmt)).scalar_one_or_none()


async def iniciar_intento(session: AsyncSession, usuario_id: int, ahora: datetime) -> IntentoBrawl:
    ultimo = await _ultimo_intento(session, usuario_id)
    if ultimo is not None:
        bono = await tienda.bono_de_usuario(session, usuario_id, semana_de(date.today()))
        cooldown = cooldown_service.cooldown_efectivo(COOLDOWN_BRAWL, bono.cooldown_pct)
        if not cooldown_service.puede_jugar(ultimo.created_at, ahora, cooldown):
            raise BrawlError("Todavía en cooldown")

    intento = IntentoBrawl(usuario_id=usuario_id)
    session.add(intento)
    await session.commit()
    await session.refresh(intento)
    return intento


async def resolver_intento(
    session: AsyncSession, intento_id: int, usuario_id: int, enemigos_eliminados: int, nombre: str
) -> IntentoBrawl:
    intento = await session.get(IntentoBrawl, intento_id)
    if intento is None or intento.usuario_id != usuario_id:
        raise BrawlError("Intento no encontrado")
    if intento.resuelto:
        raise BrawlError("Ese intento ya se resolvió")

    intento.enemigos_eliminados = enemigos_eliminados
    intento.resuelto = True
    intento.acierto = es_resultado_plausible(enemigos_eliminados)
    if intento.acierto:
        await danar_jefe(session, semana_de(date.today()), DANIO_BRAWL, nombre, "minijuego_brawl")

    await session.commit()
    await session.refresh(intento)
    return intento
