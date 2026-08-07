from sqlalchemy import func, select, update
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import Usuario, XpEvento
from app.services.auth import normalizar_nombre


async def otorgar_xp(session: AsyncSession, nombre: str, cantidad: int, motivo: str) -> None:
    """Best effort: un fallo aquí nunca debe tumbar la creación del registro/mesa."""
    try:
        await _otorgar_xp(session, nombre, cantidad, motivo)
    except Exception:
        await session.rollback()


async def _otorgar_xp(session: AsyncSession, nombre: str, cantidad: int, motivo: str) -> None:
    stmt = select(Usuario.id).where(func.lower(Usuario.nombre) == normalizar_nombre(nombre))
    usuario_id = (await session.execute(stmt)).scalar_one_or_none()

    if usuario_id is not None:
        await session.execute(update(Usuario).where(Usuario.id == usuario_id).values(xp=Usuario.xp + cantidad))

    session.add(XpEvento(usuario_id=usuario_id, nombre_capturado=nombre, cantidad=cantidad, motivo=motivo))
    await session.commit()
