from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import PartidaRPS

JUGADAS_VALIDAS = {"piedra", "papel", "tijera"}
_GANA_A = {"piedra": "tijera", "tijera": "papel", "papel": "piedra"}


def ganador_rps(jugada_x: str, jugada_o: str) -> str:
    if jugada_x == jugada_o:
        return "empate"
    return "X" if _GANA_A[jugada_x] == jugada_o else "O"


class JugadaInvalida(Exception):
    pass


async def _partida_propia_en_espera(session: AsyncSession, usuario_id: int) -> PartidaRPS | None:
    return await session.scalar(
        select(PartidaRPS).where(PartidaRPS.estado == "esperando", PartidaRPS.jugador_x_id == usuario_id)
    )


async def _partida_de_otro_en_espera(session: AsyncSession, usuario_id: int) -> PartidaRPS | None:
    stmt = (
        select(PartidaRPS)
        .where(PartidaRPS.estado == "esperando", PartidaRPS.jugador_x_id != usuario_id)
        .order_by(PartidaRPS.created_at)
        .limit(1)
    )
    return (await session.execute(stmt)).scalar_one_or_none()


async def buscar_o_crear_partida(session: AsyncSession, usuario_id: int) -> PartidaRPS:
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

    nueva = PartidaRPS(jugador_x_id=usuario_id)
    session.add(nueva)
    await session.commit()
    await session.refresh(nueva)
    return nueva


def _campo_jugada(partida: PartidaRPS, usuario_id: int) -> str | None:
    if usuario_id == partida.jugador_x_id:
        return "jugada_x"
    if usuario_id == partida.jugador_o_id:
        return "jugada_o"
    return None


def _resolver_si_ambos_jugaron(partida: PartidaRPS) -> None:
    if partida.jugada_x is not None and partida.jugada_o is not None:
        partida.resultado = ganador_rps(partida.jugada_x, partida.jugada_o)
        partida.estado = "terminada"


async def jugar_rps(session: AsyncSession, partida_id: int, usuario_id: int, jugada: str) -> PartidaRPS:
    if jugada not in JUGADAS_VALIDAS:
        raise JugadaInvalida("Jugada inválida")

    partida = await session.get(PartidaRPS, partida_id)
    if partida is None:
        raise JugadaInvalida("La partida no existe")

    campo = _campo_jugada(partida, usuario_id)
    if campo is None or partida.estado != "jugando":
        raise JugadaInvalida("No participas en esta partida o no está en juego")
    if getattr(partida, campo) is not None:
        raise JugadaInvalida("Ya jugaste esta ronda")

    setattr(partida, campo, jugada)
    _resolver_si_ambos_jugaron(partida)

    await session.commit()
    await session.refresh(partida)
    return partida


async def cancelar_espera_rps(session: AsyncSession, partida_id: int, usuario_id: int) -> None:
    partida = await session.get(PartidaRPS, partida_id)
    if partida is None or partida.jugador_x_id != usuario_id or partida.estado != "esperando":
        return
    await session.delete(partida)
    await session.commit()
