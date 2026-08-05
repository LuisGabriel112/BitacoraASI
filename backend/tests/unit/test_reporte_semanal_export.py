from datetime import datetime
from types import SimpleNamespace

from app.services.reporte_semanal_export import filas_reporte, titulo_reporte


def test_titulo_reporte_con_rango_de_dias():
    assert titulo_reporte("SEM 32 - 2026") == "Reporte Semanal — Semana 32 de 2026 (03/08/2026 al 07/08/2026)"


def test_titulo_reporte_semana_de_un_solo_digito_sin_cero_a_la_izquierda():
    assert "Semana 5 " in titulo_reporte("SEM 05 - 2026")


def _mesa(codigo: str, cierre: datetime, solucion: str | None) -> SimpleNamespace:
    return SimpleNamespace(codigo=codigo, fecha_cierre_real=cierre, solucion=solucion)


def test_filas_reporte_ordena_por_fecha_de_cierre():
    m1 = _mesa("TCK-002", datetime(2026, 8, 4, 10, 0), "Solución B")
    m2 = _mesa("TCK-001", datetime(2026, 8, 3, 9, 0), "Solución A")

    filas = filas_reporte([m1, m2])

    assert [f[0] for f in filas] == ["TCK-001", "TCK-002"]


def test_filas_reporte_usa_cadena_vacia_si_no_hay_solucion():
    m = _mesa("TCK-003", datetime(2026, 8, 4, 10, 0), None)

    filas = filas_reporte([m])

    assert filas[0][2] == ""


def test_filas_reporte_formatea_fecha_dd_mm_yyyy_hh_mm():
    m = _mesa("TCK-004", datetime(2026, 8, 4, 17, 5), "ok")

    filas = filas_reporte([m])

    assert filas[0][1] == "04/08/2026 17:05"
