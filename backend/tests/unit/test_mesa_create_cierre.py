from datetime import datetime

import pytest
from pydantic import ValidationError

from app.schemas import MesaCreate

_CAMPOS_APERTURA = dict(
    codigo="TCK-001",
    titulo="Falla login",
    fecha_carga=datetime(2026, 8, 3, 14, 30),
    descripcion="No entra al portal",
    categoria_id=1,
    solicitante_id=1,
    resolutor_id=1,
    fecha_estimada_resolucion=datetime(2026, 8, 5, 9, 0),
)

_CAMPOS_CIERRE = dict(
    ventana_id=1,
    solucion="Se reinició el servicio",
    tipo_solucion="Modificación en BD",
    fecha_cierre_real=datetime(2026, 8, 3, 16, 0),
)


def test_crear_mesa_abierta_sin_info_de_cierre_es_valida():
    mesa = MesaCreate(**_CAMPOS_APERTURA)

    assert mesa.ventana_id is None
    assert mesa.solucion is None
    assert mesa.tipo_solucion is None
    assert mesa.fecha_cierre_real is None


def test_crear_mesa_ya_cerrada_con_los_4_campos_es_valida():
    mesa = MesaCreate(**_CAMPOS_APERTURA, **_CAMPOS_CIERRE)

    assert mesa.ventana_id == 1
    assert mesa.fecha_cierre_real == datetime(2026, 8, 3, 16, 0)


def test_crear_mesa_con_cierre_parcial_se_rechaza():
    with pytest.raises(ValidationError, match="juntos"):
        MesaCreate(**_CAMPOS_APERTURA, solucion="Se reinició el servicio")


def test_crear_mesa_con_solo_fecha_cierre_se_rechaza():
    with pytest.raises(ValidationError, match="juntos"):
        MesaCreate(**_CAMPOS_APERTURA, fecha_cierre_real=datetime(2026, 8, 3, 16, 0))


def test_crear_mesa_con_solo_ventana_se_rechaza():
    with pytest.raises(ValidationError, match="juntos"):
        MesaCreate(**_CAMPOS_APERTURA, ventana_id=1)
