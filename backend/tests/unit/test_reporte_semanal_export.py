from datetime import datetime
from types import SimpleNamespace

from pptx import Presentation
from pptx.enum.shapes import MSO_SHAPE_TYPE

from app.services.reporte_semanal_export import filas_reporte, generar_pptx_reporte, titulo_reporte


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


_FILAS = [("TCK-001", "03/08/2026 09:00", "Se aplicó el fix"), ("TCK-002", "04/08/2026 10:00", "Se reinició el servicio")]
_GRAFICAS = {"Categorías de solución": [("Modificación en BD", 5), ("Seguimiento de proceso", 2)]}


def _pptx_reporte(filas=_FILAS, graficas=_GRAFICAS):
    return Presentation(generar_pptx_reporte("Reporte de prueba", filas, graficas))


def test_portada_usa_imagen_de_logo():
    prs = _pptx_reporte()
    portada = prs.slides[0]

    assert any(shape.shape_type == MSO_SHAPE_TYPE.PICTURE for shape in portada.shapes)


def test_graficas_van_en_la_segunda_diapositiva_antes_que_las_tablas():
    prs = _pptx_reporte()

    graficas_slide = prs.slides[1]
    tabla_slide = prs.slides[2]

    assert any(s.has_chart for s in graficas_slide.shapes if s.shape_type == MSO_SHAPE_TYPE.CHART)
    assert any(s.has_table for s in tabla_slide.shapes if s.shape_type == MSO_SHAPE_TYPE.TABLE)


def test_sin_graficas_la_segunda_diapositiva_ya_es_tabla():
    prs = _pptx_reporte(graficas={"Categorías de solución": []})

    segunda = prs.slides[1]

    assert any(s.has_table for s in segunda.shapes if s.shape_type == MSO_SHAPE_TYPE.TABLE)


def test_grafica_tiene_titulo_de_eje_y_etiquetas_de_dato():
    prs = _pptx_reporte()
    grafico = next(s for s in prs.slides[1].shapes if s.shape_type == MSO_SHAPE_TYPE.CHART)
    chart = grafico.chart

    assert chart.value_axis.has_title
    assert chart.value_axis.axis_title.text_frame.text == "Cantidad"
    assert chart.plots[0].has_data_labels


def test_tabla_tiene_fila_de_titulo_fusionada_y_luego_encabezados():
    prs = _pptx_reporte()
    tabla = next(s for s in prs.slides[2].shapes if s.shape_type == MSO_SHAPE_TYPE.TABLE).table

    assert tabla.cell(0, 0).is_merge_origin
    assert tabla.cell(0, 0).span_width == 4
    assert "Incidencias resueltas" in tabla.cell(0, 0).text
    assert tabla.cell(1, 0).text == "Código"


def test_filas_de_datos_alternan_color():
    prs = _pptx_reporte()
    tabla = next(s for s in prs.slides[2].shapes if s.shape_type == MSO_SHAPE_TYPE.TABLE).table

    color_fila_1 = tabla.cell(2, 0).fill.fore_color.rgb
    color_fila_2 = tabla.cell(3, 0).fill.fore_color.rgb

    assert color_fila_1 != color_fila_2


def test_celdas_de_tabla_tienen_los_4_bordes():
    prs = _pptx_reporte()
    tabla = next(s for s in prs.slides[2].shapes if s.shape_type == MSO_SHAPE_TYPE.TABLE).table
    tcPr = tabla.cell(1, 0)._tc.get_or_add_tcPr()

    etiquetas = {hijo.tag.split("}")[-1] for hijo in tcPr}
    assert {"lnL", "lnR", "lnT", "lnB"} <= etiquetas
