from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import PartidaGato

VACIO = " "

_LINEAS_GANADORAS = [
    (0, 1, 2), (3, 4, 5), (6, 7, 8),
    (0, 3, 6), (1, 4, 7), (2, 5, 8),
    (0, 4, 8), (2, 4, 6),
]


def verificar_ganador(tablero: str) -> str | None:
    for a, b, c in _LINEAS_GANADORAS:
        if tablero[a] != VACIO and tablero[a] == tablero[b] == tablero[c]:
            return tablero[a]
    return None


def tablero_lleno(tablero: str) -> bool:
    return VACIO not in tablero


def resultado_partida(tablero: str) -> str | None:
    ganador = verificar_ganador(tablero)
    if ganador:
        return ganador
    return "empate" if tablero_lleno(tablero) else None


def aplicar_movimiento(tablero: str, posicion: int, simbolo: str) -> str:
    return tablero[:posicion] + simbolo + tablero[posicion + 1 :]


def otro_simbolo(simbolo: str) -> str:
    return "O" if simbolo == "X" else "X"


class MovimientoInvalido(Exception):
    pass


async def _partida_propia_en_espera(session: AsyncSession, usuario_id: int) -> PartidaGato | None:
    return await session.scalar(
        select(PartidaGato).where(PartidaGato.estado == "esperando", PartidaGato.jugador_x_id == usuario_id)
    )


async def _partida_de_otro_en_espera(session: AsyncSession, usuario_id: int) -> PartidaGato | None:
    stmt = (
        select(PartidaGato)
        .where(PartidaGato.estado == "esperando", PartidaGato.jugador_x_id != usuario_id)
        .order_by(PartidaGato.created_at)
        .limit(1)
    )
    return (await session.execute(stmt)).scalar_one_or_none()


async def buscar_o_crear_partida(session: AsyncSession, usuario_id: int) -> PartidaGato:
    """La propia fila 'esperando' actua como cola: si ya tengo una la reuso, si hay
    una de otro usuario me uno, si no hay ninguna creo una nueva en espera."""
    propia = await _partida_propia_en_espera(session, usuario_id)
    if propia is not None:
        return propia

    disponible = await _partida_de_otro_en_espera(session, usuario_id)
    if disponible is not None:
        disponible.jugador_o_id = usuario_id
        disponible.estado = "jugando"
        await session.commit()
        await session.refresh(disponible)
        return disponible

    nueva = PartidaGato(jugador_x_id=usuario_id)
    session.add(nueva)
    await session.commit()
    await session.refresh(nueva)
    return nueva


def _simbolo_del_jugador(partida: PartidaGato, usuario_id: int) -> str | None:
    if usuario_id == partida.jugador_x_id:
        return "X"
    if usuario_id == partida.jugador_o_id:
        return "O"
    return None


def _validar_movimiento(partida: PartidaGato, simbolo: str | None, posicion: int) -> None:
    if simbolo is None or partida.estado != "jugando" or partida.turno != simbolo:
        raise MovimientoInvalido("No es tu turno o la partida no está en juego")
    if not (0 <= posicion < 9) or partida.tablero[posicion] != VACIO:
        raise MovimientoInvalido("Casilla ocupada o inválida")


async def jugar_movimiento(session: AsyncSession, partida_id: int, usuario_id: int, posicion: int) -> PartidaGato:
    partida = await session.get(PartidaGato, partida_id)
    if partida is None:
        raise MovimientoInvalido("La partida no existe")

    simbolo = _simbolo_del_jugador(partida, usuario_id)
    _validar_movimiento(partida, simbolo, posicion)

    partida.tablero = aplicar_movimiento(partida.tablero, posicion, simbolo)
    resultado = resultado_partida(partida.tablero)
    if resultado:
        partida.estado, partida.ganador = "terminada", resultado
    else:
        partida.turno = otro_simbolo(simbolo)

    await session.commit()
    await session.refresh(partida)
    return partida


async def cancelar_espera(session: AsyncSession, partida_id: int, usuario_id: int) -> None:
    partida = await session.get(PartidaGato, partida_id)
    if partida is None or partida.jugador_x_id != usuario_id or partida.estado != "esperando":
        return
    await session.delete(partida)
    await session.commit()
