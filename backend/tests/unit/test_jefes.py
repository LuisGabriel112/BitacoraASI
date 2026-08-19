from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.jefes import (
    DANIO_POR_ACCION,
    DANIO_POR_LOGRO,
    NOMBRES_JEFE,
    NOMBRES_JEFE_BONUS,
    VIDA_MAX_SEMANAL,
    VIDA_MAX_TOPE,
    _filtrar_derrotados,
    calcular_vida_max_siguiente,
    cruzo_a_derrotado,
    danar_jefe,
    nombre_del_jefe,
    nombre_del_jefe_bonus,
    obtener_o_crear_jefe,
    siguiente_jefe_bonus_activo,
    vida_jefe_bonus,
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


def test_jefe_con_vida_en_cero_es_mascota():
    jefe = SimpleNamespace(semana="SEM 32 - 2026", vida_actual=0)

    assert _filtrar_derrotados([jefe]) == [jefe]


def test_jefe_con_vida_restante_no_es_mascota():
    jefe = SimpleNamespace(semana="SEM 33 - 2026", vida_actual=150)

    assert _filtrar_derrotados([jefe]) == []


def test_filtra_solo_los_derrotados_entre_varias_semanas():
    derrotado_1 = SimpleNamespace(semana="SEM 30 - 2026", vida_actual=0)
    con_vida = SimpleNamespace(semana="SEM 31 - 2026", vida_actual=300)
    derrotado_2 = SimpleNamespace(semana="SEM 32 - 2026", vida_actual=0)

    assert _filtrar_derrotados([derrotado_1, con_vida, derrotado_2]) == [derrotado_1, derrotado_2]


def test_nombre_del_jefe_bonus_es_consistente():
    assert nombre_del_jefe_bonus("SEM 32 - 2026", 0) == nombre_del_jefe_bonus("SEM 32 - 2026", 0)


def test_nombre_del_jefe_bonus_sale_de_su_lista():
    assert nombre_del_jefe_bonus("SEM 32 - 2026", 1) in NOMBRES_JEFE_BONUS


def test_vida_jefe_bonus_es_25_por_ciento_redondeada():
    assert vida_jefe_bonus(1000) == 250


def test_vida_jefe_bonus_nunca_es_cero():
    assert vida_jefe_bonus(2) >= 1


def test_siguiente_jefe_bonus_activo_salta_al_derrotado():
    derrotado = SimpleNamespace(id=1, vida_actual=0)
    con_vida = SimpleNamespace(id=2, vida_actual=100)

    assert siguiente_jefe_bonus_activo([derrotado, con_vida]) is con_vida


def test_siguiente_jefe_bonus_activo_sin_candidatos_es_none():
    derrotado_1 = SimpleNamespace(id=1, vida_actual=0)
    derrotado_2 = SimpleNamespace(id=2, vida_actual=0)

    assert siguiente_jefe_bonus_activo([derrotado_1, derrotado_2]) is None


def test_cruzo_a_derrotado_de_vida_a_cero():
    assert cruzo_a_derrotado(vida_antes=5, vida_despues=0) is True


def test_cruzo_a_derrotado_ya_estaba_en_cero():
    assert cruzo_a_derrotado(vida_antes=0, vida_despues=0) is False


def test_cruzo_a_derrotado_sigue_con_vida():
    assert cruzo_a_derrotado(vida_antes=100, vida_despues=40) is False
