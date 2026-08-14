from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.gato import (
    VACIO,
    MovimientoInvalido,
    aplicar_movimiento,
    buscar_o_crear_partida,
    cancelar_espera,
    jugar_movimiento,
    otro_simbolo,
    resultado_partida,
    tablero_lleno,
    verificar_ganador,
)


def test_fila_ganadora_horizontal():
    tablero = "XXX      "
    assert verificar_ganador(tablero) == "X"


def test_columna_ganadora_vertical():
    tablero = "O  O  O  "
    assert verificar_ganador(tablero) == "O"


def test_diagonal_ganadora():
    tablero = "X   X   X"
    assert verificar_ganador(tablero) == "X"


def test_diagonal_inversa_ganadora():
    tablero = "  O O O  "
    assert verificar_ganador(tablero) == "O"


def test_sin_tres_en_linea_no_hay_ganador():
    tablero = "XOXOXOOXO"
    assert verificar_ganador(tablero) is None


def test_tablero_vacio_no_hay_ganador():
    assert verificar_ganador(VACIO * 9) is None


def test_tablero_lleno_sin_ganador_es_empate():
    tablero = "XOXOXOOXO"
    assert tablero_lleno(tablero) is True
    assert resultado_partida(tablero) == "empate"


def test_tablero_con_espacios_y_sin_ganador_sigue_en_juego():
    tablero = "XO " + VACIO * 6
    assert tablero_lleno(tablero) is False
    assert resultado_partida(tablero) is None


def test_resultado_partida_devuelve_ganador_aunque_falten_casillas():
    tablero = "XXX      "
    assert resultado_partida(tablero) == "X"


def test_aplicar_movimiento_coloca_simbolo_en_posicion_exacta():
    tablero = VACIO * 9
    resultado = aplicar_movimiento(tablero, 4, "X")
    assert resultado[4] == "X"
    assert resultado.count("X") == 1
    assert resultado.count(VACIO) == 8


@pytest.mark.parametrize("simbolo,esperado", [("X", "O"), ("O", "X")])
def test_otro_simbolo_alterna(simbolo, esperado):
    assert otro_simbolo(simbolo) == esperado


def _partida(**kwargs) -> SimpleNamespace:
    base = dict(id=1, jugador_x_id=1, jugador_o_id=None, tablero=VACIO * 9, turno="X", estado="esperando", ganador=None)
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
    session.commit.assert_awaited()


@pytest.mark.asyncio
async def test_buscar_o_crear_crea_nueva_si_no_hay_nada():
    session = AsyncMock()
    session.scalar.return_value = None
    session.add = MagicMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado_execute

    await buscar_o_crear_partida(session, 7)

    session.add.assert_called_once()
    nueva = session.add.call_args.args[0]
    assert nueva.jugador_x_id == 7


@pytest.mark.asyncio
async def test_jugar_movimiento_actualiza_tablero_y_cambia_turno():
    partida = _partida(estado="jugando", turno="X")
    session = AsyncMock()
    session.get.return_value = partida

    resultado = await jugar_movimiento(session, 1, 1, posicion=4)

    assert resultado.tablero[4] == "X"
    assert resultado.turno == "O"
    assert resultado.estado == "jugando"


@pytest.mark.asyncio
async def test_jugar_movimiento_marca_terminada_si_hay_ganador():
    partida = _partida(estado="jugando", turno="X", tablero="XX       ")
    session = AsyncMock()
    session.get.return_value = partida

    resultado = await jugar_movimiento(session, 1, 1, posicion=2)

    assert resultado.estado == "terminada"
    assert resultado.ganador == "X"


@pytest.mark.asyncio
async def test_jugar_movimiento_rechaza_si_no_es_tu_turno():
    partida = _partida(jugador_x_id=1, jugador_o_id=2, estado="jugando", turno="O")
    session = AsyncMock()
    session.get.return_value = partida

    with pytest.raises(MovimientoInvalido):
        await jugar_movimiento(session, 1, usuario_id=1, posicion=0)


@pytest.mark.asyncio
async def test_jugar_movimiento_rechaza_casilla_ocupada():
    partida = _partida(estado="jugando", turno="X", tablero="X        ")
    session = AsyncMock()
    session.get.return_value = partida

    with pytest.raises(MovimientoInvalido):
        await jugar_movimiento(session, 1, usuario_id=1, posicion=0)


@pytest.mark.asyncio
async def test_cancelar_espera_borra_si_es_dueno_y_sigue_esperando():
    partida = _partida(jugador_x_id=7, estado="esperando")
    session = AsyncMock()
    session.get.return_value = partida

    await cancelar_espera(session, 1, usuario_id=7)

    session.delete.assert_awaited_with(partida)


@pytest.mark.asyncio
async def test_cancelar_espera_no_borra_si_ya_no_esta_esperando():
    partida = _partida(jugador_x_id=7, estado="jugando")
    session = AsyncMock()
    session.get.return_value = partida

    await cancelar_espera(session, 1, usuario_id=7)

    session.delete.assert_not_awaited()
