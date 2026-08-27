from datetime import date

from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import Usuario, XpEvento
from app.services import tienda
from app.services.auth import resolver_usuario_id
from app.services.semanas import semana_de


async def otorgar_xp(
    session: AsyncSession,
    nombre: str,
    cantidad: int,
    motivo: str,
    usuario_id_directo: int | None = None,
) -> None:
    """Best effort: un fallo aquí nunca debe tumbar la creación del registro/mesa."""
    try:
        await _otorgar_xp(session, nombre, cantidad, motivo, usuario_id_directo)
    except Exception:
        await session.rollback()


async def _otorgar_xp(
    session: AsyncSession,
    nombre: str,
    cantidad: int,
    motivo: str,
    usuario_id_directo: int | None,
) -> None:
    usuario_id = await resolver_usuario_id(session, nombre, usuario_id_directo)

    if usuario_id is not None:
        bono = await tienda.bono_de_usuario(session, usuario_id, semana_de(date.today()))
        cantidad = max(1, round(cantidad * (1 + bono.xp_pct / 100)))
        await session.execute(update(Usuario).where(Usuario.id == usuario_id).values(xp=Usuario.xp + cantidad))

    session.add(XpEvento(usuario_id=usuario_id, nombre_capturado=nombre, cantidad=cantidad, motivo=motivo))
    await session.commit()
