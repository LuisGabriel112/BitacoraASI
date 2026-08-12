from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.jefes import (
    DANIO_POR_ACCION,
    DANIO_POR_LOGRO,
    NOMBRES_JEFE,
    VIDA_MAX_SEMANAL,
    VIDA_MAX_TOPE,
    calcular_vida_max_siguiente,
    danar_jefe,
    nombre_del_jefe,
    obtener_o_crear_jefe,
)


def test_nombre_del_jefe_es_consistente_en_la_misma_semana():
    assert nombre_del_jefe("SEM 32 - 2026") == nombre_del_jefe("SEM 32 - 2026")


def test_nombre_del_jefe_siempre_es_uno_de_la_lista():
    for semana in ("SEM 01 - 2026", "SEM 15 - 2026", "SEM 52 - 2026"):
        assert nombre_del_jefe(semana) in NOMBRES_JEFE


def test_danio_por_accion_y_logro_son_constantes_propias():
    assert DANIO_POR_ACCION == 5
    assert DANIO_POR_LOGRO == 25
    assert DANIO_POR_LOGRO > DANIO_POR_ACCION


@pytest.mark.asyncio
async def test_obtener_o_crear_jefe_devuelve_existente_sin_crear_otro():
    jefe_existente = MagicMock()
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = jefe_existente
    session.execute.return_value = resultado
    session.add = MagicMock()

    jefe = await obtener_o_crear_jefe(session, "SEM 32 - 2026")

    assert jefe is jefe_existente
    session.add.assert_not_called()


@pytest.mark.asyncio
async def test_obtener_o_crear_jefe_crea_con_vida_base_si_no_hay_jefe_anterior():
    session = AsyncMock()
    session.add = MagicMock()
    resultado_vacio = MagicMock()
    resultado_vacio.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado_vacio

    await obtener_o_crear_jefe(session, "SEM 32 - 2026")

    session.add.assert_called_once()
    nuevo = session.add.call_args.args[0]
    assert nuevo.semana == "SEM 32 - 2026"
    assert nuevo.vida_max == VIDA_MAX_SEMANAL
    assert nuevo.vida_actual == VIDA_MAX_SEMANAL


@pytest.mark.asyncio
async def test_obtener_o_crear_jefe_sube_la_vida_si_el_anterior_fue_derrotado():
    session = AsyncMock()
    session.add = MagicMock()
    resultado_actual = MagicMock()
    resultado_actual.scalar_one_or_none.return_value = None
    anterior = SimpleNamespace(vida_max=1000, vida_actual=0)
    resultado_anterior = MagicMock()
    resultado_anterior.scalar_one_or_none.return_value = anterior
    session.execute.side_effect = [resultado_actual, resultado_anterior]

    await obtener_o_crear_jefe(session, "SEM 33 - 2026")

    nuevo = session.add.call_args.args[0]
    assert nuevo.vida_max == round(1000 * 1.2)


@pytest.mark.asyncio
async def test_obtener_o_crear_jefe_reinicia_la_vida_si_el_anterior_no_fue_derrotado():
    session = AsyncMock()
    session.add = MagicMock()
    resultado_actual = MagicMock()
    resultado_actual.scalar_one_or_none.return_value = None
    anterior = SimpleNamespace(vida_max=3000, vida_actual=250)
    resultado_anterior = MagicMock()
    resultado_anterior.scalar_one_or_none.return_value = anterior
    session.execute.side_effect = [resultado_actual, resultado_anterior]

    await obtener_o_crear_jefe(session, "SEM 33 - 2026")

    nuevo = session.add.call_args.args[0]
    assert nuevo.vida_max == VIDA_MAX_SEMANAL


def test_primer_jefe_usa_vida_base():
    assert calcular_vida_max_siguiente(None, False) == VIDA_MAX_SEMANAL


def test_vida_sube_20_por_ciento_si_fue_derrotado():
    assert calcular_vida_max_siguiente(1000, True) == 1200


def test_vida_se_reinicia_a_la_base_si_no_fue_derrotado():
    assert calcular_vida_max_siguiente(3000, False) == VIDA_MAX_SEMANAL


def test_vida_tiene_un_tope_maximo():
    assert calcular_vida_max_siguiente(VIDA_MAX_TOPE, True) == VIDA_MAX_TOPE


@pytest.mark.asyncio
async def test_danar_jefe_nunca_propaga_excepcion():
    session = AsyncMock()
    session.execute.side_effect = Exception("boom")

    await danar_jefe(session, "SEM 32 - 2026", 5, "Alguien", "mesa_creada")

    session.rollback.assert_awaited()
