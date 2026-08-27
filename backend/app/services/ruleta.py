import random
from datetime import date, datetime, timedelta

from sqlalchemy import func, select, update
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import IntentoRuleta, Usuario
from app.services import cooldown as cooldown_service
from app.services import tienda
from app.services.jefes import danar_jefe
from app.services.semanas import semana_de

DANIO_RULETA_GANA = 5
PENALIZACION_RULETA_PIERDE = 5
PROBABILIDAD_GANAR = 0.5
COOLDOWN_RULETA = timedelta(minutes=5)


class RuletaError(Exception):
    pass


async def _ultimo_intento(session: AsyncSession, usuario_id: int) -> IntentoRuleta | None:
    stmt = (
        select(IntentoRuleta)
        .where(IntentoRuleta.usuario_id == usuario_id)
        .order_by(IntentoRuleta.created_at.desc())
        .limit(1)
    )
    return (await session.execute(stmt)).scalar_one_or_none()


async def _aplicar_resultado(session: AsyncSession, usuario_id: int, gano: bool, nombre: str) -> None:
    if gano:
        await danar_jefe(session, semana_de(date.today()), DANIO_RULETA_GANA, nombre, "minijuego_ruleta")
        return
    await session.execute(
        update(Usuario)
        .where(Usuario.id == usuario_id)
        .values(xp=func.greatest(Usuario.xp - PENALIZACION_RULETA_PIERDE, 0))
    )


async def jugar_ruleta(session: AsyncSession, usuario_id: int, ahora: datetime, nombre: str) -> IntentoRuleta:
    ultimo = await _ultimo_intento(session, usuario_id)
    if ultimo is not None:
        bono = await tienda.bono_de_usuario(session, usuario_id, semana_de(date.today()))
        cooldown = cooldown_service.cooldown_efectivo(COOLDOWN_RULETA, bono.cooldown_pct)
        if not cooldown_service.puede_jugar(ultimo.created_at, ahora, cooldown):
            raise RuletaError("Todavía en cooldown")

    gano = random.random() < PROBABILIDAD_GANAR
    intento = IntentoRuleta(usuario_id=usuario_id, gano=gano)
    session.add(intento)
    await _aplicar_resultado(session, usuario_id, gano, nombre)

    await session.commit()
    await session.refresh(intento)
    return intento
