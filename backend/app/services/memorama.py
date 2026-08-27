from datetime import date, datetime, timedelta

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import IntentoMemorama
from app.services import cooldown as cooldown_service
from app.services import tienda
from app.services.jefes import danar_jefe
from app.services.semanas import semana_de

PARES_MEMORAMA = 6
DANIO_MEMORAMA = 2
COOLDOWN_MEMORAMA = timedelta(minutes=5)
# Nadie resuelve 6 pares (12 cartas) de verdad en menos de esto — filtra un
# "completar" enviado sin haber jugado. El servidor mide el tiempo real
# transcurrido entre iniciar y completar, nunca confía en un valor del cliente.
DURACION_MINIMA_MEMORAMA = timedelta(seconds=3)


class MemoramaError(Exception):
    pass


async def _ultimo_intento(session: AsyncSession, usuario_id: int) -> IntentoMemorama | None:
    stmt = (
        select(IntentoMemorama)
        .where(IntentoMemorama.usuario_id == usuario_id)
        .order_by(IntentoMemorama.created_at.desc())
        .limit(1)
    )
    return (await session.execute(stmt)).scalar_one_or_none()


async def iniciar_intento(session: AsyncSession, usuario_id: int, ahora: datetime) -> IntentoMemorama:
    ultimo = await _ultimo_intento(session, usuario_id)
    if ultimo is not None:
        bono = await tienda.bono_de_usuario(session, usuario_id, semana_de(date.today()))
        cooldown = cooldown_service.cooldown_efectivo(COOLDOWN_MEMORAMA, bono.cooldown_pct)
        if not cooldown_service.puede_jugar(ultimo.created_at, ahora, cooldown):
            raise MemoramaError("Todavía en cooldown")

    intento = IntentoMemorama(usuario_id=usuario_id)
    session.add(intento)
    await session.commit()
    await session.refresh(intento)
    return intento


async def completar_intento(
    session: AsyncSession, intento_id: int, usuario_id: int, ahora: datetime, nombre: str
) -> IntentoMemorama:
    intento = await session.get(IntentoMemorama, intento_id)
    if intento is None or intento.usuario_id != usuario_id:
        raise MemoramaError("Intento no encontrado")
    if intento.resuelto:
        raise MemoramaError("Ese intento ya se resolvió")

    transcurrido = ahora - intento.created_at
    intento.resuelto = True
    intento.acierto = transcurrido >= DURACION_MINIMA_MEMORAMA
    if intento.acierto:
        await danar_jefe(session, semana_de(date.today()), DANIO_MEMORAMA, nombre, "minijuego_memorama")

    await session.commit()
    await session.refresh(intento)
    return intento
