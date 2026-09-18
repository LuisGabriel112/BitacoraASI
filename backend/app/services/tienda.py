from dataclasses import dataclass

from sqlalchemy import delete, func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import CreditoEvento, InventarioItem
from app.services.catalogo_objetos import OBJETOS, Objeto
from app.services.auth import resolver_usuario_id

MAX_SLOTS_INVENTARIO = 6


_OBJETOS_POR_ID = {o.id: o for o in OBJETOS}


def objeto_por_id(item_id: str) -> Objeto:
    return _OBJETOS_POR_ID[item_id]


class TiendaError(Exception):
    pass


@dataclass(frozen=True)
class BonoStats:
    danio_pct: int = 0
    critico_pct: int = 0
    cooldown_pct: int = 0
    xp_pct: int = 0


def bono_stats(objetos: list[Objeto]) -> BonoStats:
    return BonoStats(
        danio_pct=sum(o.danio_pct for o in objetos),
        critico_pct=sum(o.critico_pct for o in objetos),
        cooldown_pct=sum(o.cooldown_pct for o in objetos),
        xp_pct=sum(o.xp_pct for o in objetos),
    )


async def bono_de_usuario(session: AsyncSession, usuario_id: int | None, semana: str) -> BonoStats:
    """Punto único para "qué bono tiene este usuario esta semana" — usado por
    jefes.py (daño/crítico), xp.py (XP%) y los minijuegos (cooldown%). Sin
    usuario_id (catálogo sin cuenta vinculada) no hay nada que buscar."""
    if usuario_id is None:
        return BonoStats()
    return bono_stats(await objetos_equipados(session, usuario_id, semana))


def _delta_slots(objeto: Objeto) -> int:
    """Un básico ocupa 1 slot; un combinado consume las 2 partes que reemplaza."""
    return 1 if objeto.requiere is None else 1 - len(objeto.requiere)


async def creditos_disponibles(session: AsyncSession, usuario_id: int, semana: str) -> int:
    total = await session.scalar(
        select(func.coalesce(func.sum(CreditoEvento.cantidad), 0)).where(
            CreditoEvento.usuario_id == usuario_id, CreditoEvento.semana == semana
        )
    )
    return total or 0


async def objetos_equipados(session: AsyncSession, usuario_id: int, semana: str) -> list[Objeto]:
    stmt = select(InventarioItem.item_id).where(
        InventarioItem.usuario_id == usuario_id, InventarioItem.semana == semana
    )
    ids = (await session.execute(stmt)).scalars().all()
    return [objeto_por_id(i) for i in ids]


async def comprar_objeto(session: AsyncSession, usuario_id: int, semana: str, item_id: str) -> list[Objeto]:
    objeto = _OBJETOS_POR_ID.get(item_id)
    if objeto is None:
        raise TiendaError("Objeto no encontrado")

    equipados = await objetos_equipados(session, usuario_id, semana)
    ids_equipados = {o.id for o in equipados}

    if objeto.id in ids_equipados:
        raise TiendaError("Ya tienes ese objeto esta semana")
    if objeto.requiere and not set(objeto.requiere) <= ids_equipados:
        faltantes = [objeto_por_id(r).nombre for r in objeto.requiere if r not in ids_equipados]
        raise TiendaError(f"Te falta: {', '.join(faltantes)}")
    if len(equipados) + _delta_slots(objeto) > MAX_SLOTS_INVENTARIO:
        raise TiendaError("Inventario lleno")
    if await creditos_disponibles(session, usuario_id, semana) < objeto.costo:
        raise TiendaError("Créditos insuficientes")

    if objeto.requiere:
        await session.execute(
            delete(InventarioItem).where(
                InventarioItem.usuario_id == usuario_id,
                InventarioItem.semana == semana,
                InventarioItem.item_id.in_(objeto.requiere),
            )
        )

    session.add(InventarioItem(usuario_id=usuario_id, item_id=objeto.id, semana=semana))
    session.add(
        CreditoEvento(usuario_id=usuario_id, semana=semana, cantidad=-objeto.costo, motivo=f"compra:{objeto.id}")
    )
    await session.commit()

    return await objetos_equipados(session, usuario_id, semana)


async def otorgar_creditos(
    session: AsyncSession, nombre: str, cantidad: int, motivo: str, semana: str, usuario_id_directo: int | None = None
) -> None:
    """Best effort: un fallo aquí nunca debe tumbar la creación del registro/mesa."""
    try:
        await _otorgar_creditos(session, nombre, cantidad, motivo, semana, usuario_id_directo)
    except Exception:
        await session.rollback()


async def _otorgar_creditos(
    session: AsyncSession, nombre: str, cantidad: int, motivo: str, semana: str, usuario_id_directo: int | None
) -> None:
    usuario_id = await resolver_usuario_id(session, nombre, usuario_id_directo)
    if usuario_id is None:
        return
    session.add(CreditoEvento(usuario_id=usuario_id, semana=semana, cantidad=cantidad, motivo=motivo))
    await session.commit()
