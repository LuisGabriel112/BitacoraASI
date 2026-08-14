from datetime import datetime
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.bonus import (
    CLAVE_HORA_CIERRE_TARDIO,
    CLAVE_VOLUMEN_ALTO_DIA,
    aplicar_bono_y_critico,
    calcular_bono,
    es_critico_por_horario,
    es_critico_por_soportes,
    es_critico_soporte,
    porcentaje_bono_del_momento,
)

MOMENTO_TARDIO = datetime(2026, 8, 13, 17, 30)
MOMENTO_NORMAL = datetime(2026, 8, 13, 12, 0)


def _regla(clave: str, porcentaje: int, activo: bool = True) -> SimpleNamespace:
    return SimpleNamespace(clave=clave, nombre=f"regla_{clave}", porcentaje=porcentaje, activo=activo)


def test_bono_de_hora_tardia_se_aplica_si_la_regla_esta_activa():
    reglas = {CLAVE_HORA_CIERRE_TARDIO: _regla(CLAVE_HORA_CIERRE_TARDIO, 20)}
    porcentaje, etiquetas = calcular_bono(MOMENTO_TARDIO, 1, reglas)
    assert porcentaje == 20
    assert etiquetas == [f"regla_{CLAVE_HORA_CIERRE_TARDIO}"]


def test_bono_de_hora_tardia_no_se_aplica_si_la_regla_esta_inactiva():
    reglas = {CLAVE_HORA_CIERRE_TARDIO: _regla(CLAVE_HORA_CIERRE_TARDIO, 20, activo=False)}
    porcentaje, _ = calcular_bono(MOMENTO_TARDIO, 1, reglas)
    assert porcentaje == 0


def test_bono_de_volumen_alto_se_aplica_si_el_conteo_llega_al_umbral():
    reglas = {CLAVE_VOLUMEN_ALTO_DIA: _regla(CLAVE_VOLUMEN_ALTO_DIA, 15)}
    porcentaje, etiquetas = calcular_bono(MOMENTO_NORMAL, 10, reglas)
    assert porcentaje == 15
    assert etiquetas == [f"regla_{CLAVE_VOLUMEN_ALTO_DIA}"]


def test_bono_de_volumen_alto_no_se_aplica_bajo_el_umbral():
    reglas = {CLAVE_VOLUMEN_ALTO_DIA: _regla(CLAVE_VOLUMEN_ALTO_DIA, 15)}
    porcentaje, _ = calcular_bono(MOMENTO_NORMAL, 9, reglas)
    assert porcentaje == 0


def test_ambos_bonos_se_suman_si_las_dos_condiciones_se_cumplen():
    reglas = {
        CLAVE_HORA_CIERRE_TARDIO: _regla(CLAVE_HORA_CIERRE_TARDIO, 20),
        CLAVE_VOLUMEN_ALTO_DIA: _regla(CLAVE_VOLUMEN_ALTO_DIA, 15),
    }
    porcentaje, etiquetas = calcular_bono(MOMENTO_TARDIO, 10, reglas)
    assert porcentaje == 35
    assert len(etiquetas) == 2


def test_sin_reglas_no_hay_bono():
    porcentaje, etiquetas = calcular_bono(MOMENTO_TARDIO, 999, {})
    assert porcentaje == 0
    assert etiquetas == []


def test_es_critico_por_horario_a_las_23_50():
    assert es_critico_por_horario(datetime(2026, 8, 13, 23, 50)) is True


def test_no_es_critico_por_horario_antes_de_23_50():
    assert es_critico_por_horario(datetime(2026, 8, 13, 23, 49)) is False


@pytest.mark.parametrize("numero", [5, 10, 15])
def test_es_critico_por_soportes_multiplo_de_5(numero):
    assert es_critico_por_soportes(numero) is True


@pytest.mark.parametrize("numero", [0, 3, 4])
def test_no_es_critico_por_soportes(numero):
    assert es_critico_por_soportes(numero) is False


def test_aplicar_bono_sin_critico():
    assert aplicar_bono_y_critico(100, 20, es_critico=False) == 120


def test_aplicar_critico_sin_bono():
    assert aplicar_bono_y_critico(100, 0, es_critico=True) == 200


def test_aplicar_bono_y_critico_combinados():
    assert aplicar_bono_y_critico(100, 20, es_critico=True) == 240


def test_resultado_nunca_baja_de_1():
    assert aplicar_bono_y_critico(0, 0, es_critico=False) == 1
    assert aplicar_bono_y_critico(0, 50, es_critico=True) == 1


@pytest.mark.asyncio
async def test_porcentaje_bono_del_momento_combina_reglas_y_conteo_del_dia():
    session = AsyncMock()
    resultado_reglas = MagicMock()
    resultado_reglas.scalars.return_value.all.return_value = [_regla(CLAVE_HORA_CIERRE_TARDIO, 20)]
    session.execute.return_value = resultado_reglas
    session.scalar.side_effect = [3, 4]

    porcentaje, etiquetas = await porcentaje_bono_del_momento(session, MOMENTO_TARDIO)

    assert session.execute.await_count == 1
    assert session.scalar.await_count == 2
    assert porcentaje == 20
    assert etiquetas == [f"regla_{CLAVE_HORA_CIERRE_TARDIO}"]


@pytest.mark.asyncio
async def test_es_critico_soporte_por_multiplo_de_conteo():
    session = AsyncMock()
    session.scalar.return_value = 5

    assert await es_critico_soporte(session, MOMENTO_NORMAL) is True


@pytest.mark.asyncio
async def test_es_critico_soporte_por_horario_aunque_no_sea_multiplo():
    session = AsyncMock()
    session.scalar.return_value = 3

    assert await es_critico_soporte(session, datetime(2026, 8, 13, 23, 55)) is True


@pytest.mark.asyncio
async def test_es_critico_soporte_falso_si_ninguna_condicion_se_cumple():
    session = AsyncMock()
    session.scalar.return_value = 3

    assert await es_critico_soporte(session, MOMENTO_NORMAL) is False
