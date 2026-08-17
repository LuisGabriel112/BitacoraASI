from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.rps import (
    JugadaInvalida,
    buscar_o_crear_partida,
    cancelar_espera_rps,
    ganador_rps,
    jugar_rps,
)


@pytest.mark.parametrize(
    "x,o,esperado",
    [
        ("piedra", "tijera", "X"),
        ("tijera", "papel", "X"),
        ("papel", "piedra", "X"),
        ("tijera", "piedra", "O"),
        ("papel", "tijera", "O"),
        ("piedra", "papel", "O"),
        ("piedra", "piedra", "empate"),
        ("papel", "papel", "empate"),
        ("tijera", "tijera", "empate"),
    ],
)
def test_ganador_rps(x, o, esperado):
    assert ganador_rps(x, o) == esperado


def _partida(**kwargs) -> SimpleNamespace:
    base = dict(
        id=1, jugador_x_id=1, jugador_o_id=None, jugada_x=None, jugada_o=None, estado="esperando", resultado=None
    )
    base.update(kwargs)
    return SimpleNamespace(**base)


@pytest.mark.asyncio
async def test_buscar_o_crear_devuelve_partida_propia_en_espera():
    propia = _partida(jugador_x_id=7)
    session = AsyncMock()
    session.scalar.return_value = propia

    resultado = await buscar_o_crear_partida(session, 7)

    assert resultado is propia
    session.add.assert_not_called()


@pytest.mark.asyncio
async def test_buscar_o_crear_se_une_a_partida_de_otro():
    disponible = _partida(jugador_x_id=3)
    session = AsyncMock()
    session.scalar.return_value = None
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = disponible
    session.execute.return_value = resultado_execute

    resultado = await buscar_o_crear_partida(session, 7)

    assert resultado is disponible
    assert disponible.jugador_o_id == 7
    assert disponible.estado == "jugando"


@pytest.mark.asyncio
async def test_jugar_registra_mi_jugada_sin_resolver_si_falta_el_rival():
    partida = _partida(estado="jugando")
    session = AsyncMock()
    session.get.return_value = partida

    resultado = await jugar_rps(session, 1, usuario_id=1, jugada="piedra")

    assert resultado.jugada_x == "piedra"
    assert resultado.estado == "jugando"
    assert resultado.resultado is None


@pytest.mark.asyncio
async def test_jugar_resuelve_cuando_ambos_ya_jugaron():
    partida = _partida(jugador_x_id=1, jugador_o_id=2, jugada_o="tijera", estado="jugando")
    session = AsyncMock()
    session.get.return_value = partida

    resultado = await jugar_rps(session, 1, usuario_id=1, jugada="piedra")

    assert resultado.estado == "terminada"
    assert resultado.resultado == "X"


@pytest.mark.asyncio
async def test_jugar_dos_veces_se_rechaza():
    partida = _partida(jugada_x="piedra", estado="jugando")
    session = AsyncMock()
    session.get.return_value = partida

    with pytest.raises(JugadaInvalida):
        await jugar_rps(session, 1, usuario_id=1, jugada="papel")


@pytest.mark.asyncio
async def test_jugada_invalida_se_rechaza():
    partida = _partida(estado="jugando")
    session = AsyncMock()
    session.get.return_value = partida

    with pytest.raises(JugadaInvalida):
        await jugar_rps(session, 1, usuario_id=1, jugada="lagarto")


@pytest.mark.asyncio
async def test_cancelar_espera_rps_borra_si_es_dueno_y_sigue_esperando():
    partida = _partida(jugador_x_id=7, estado="esperando")
    session = AsyncMock()
    session.get.return_value = partida

    await cancelar_espera_rps(session, 1, usuario_id=7)

    session.delete.assert_awaited_with(partida)
