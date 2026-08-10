from typing import Protocol

from openpyxl.chart import PieChart, Reference
from openpyxl.workbook import Workbook
from openpyxl.worksheet.worksheet import Worksheet

from app.services.clustering import agrupar_por_similitud, tema_representativo
from app.services.excel_charts import escribir_tabla_conteo, grafica_barras_conteo
from app.services.gemini import gemini_configurado

_UMBRAL_SIMILITUD_TEMA = 0.86


class RegistroParaResumen(Protocol):
    """Lo mínimo que necesita este módulo (DIP): no depende del ORM completo."""

    fecha: object
    descripcion: str
    embedding: list[float] | None


def _conteo_por_dia(registros: list[RegistroParaResumen]) -> list[tuple[str, int]]:
    conteos: dict[str, int] = {}
    for r in registros:
        clave = r.fecha.isoformat()
        conteos[clave] = conteos.get(clave, 0) + 1
    return sorted(conteos.items())


def _temas_frecuentes(registros: list[RegistroParaResumen]) -> list[tuple[str, int]]:
    """Reusa embeddings ya cacheados; si falta alguno o Gemini no está
    configurado, no calcula nada nuevo (el export no debe esperar ni pagar
    cómputo de embeddings), y devuelve vacío."""
    if not gemini_configurado() or any(r.embedding is None for r in registros):
        return []

    grupos = agrupar_por_similitud([r.embedding for r in registros], _UMBRAL_SIMILITUD_TEMA)
    temas = [
        (tema_representativo([registros[i].descripcion for i in idx]), len(idx))
        for idx in grupos
        if len(idx) >= 2
    ]
    return sorted(temas, key=lambda t: t[1], reverse=True)


def _grafica_pastel(ws: Worksheet, titulo: str, fila_datos: int, num_filas: int, ancla: str) -> None:
    chart = PieChart()
    chart.title = titulo
    datos = Reference(ws, min_col=2, min_row=fila_datos, max_row=fila_datos + num_filas - 1)
    categorias = Reference(ws, min_col=1, min_row=fila_datos, max_row=fila_datos + num_filas - 1)
    chart.add_data(datos, titles_from_data=False)
    chart.set_categories(categorias)
    ws.add_chart(chart, ancla)


def agregar_hoja_resumen(wb: Workbook, registros: list[RegistroParaResumen]) -> None:
    """Hoja 'Resumen': tabla + gráfica de barras por día, y tabla + gráfica de
    pastel de temas más frecuentes (si hay embeddings cacheados para todos)."""
    ws = wb.create_sheet("Resumen")

    por_dia = _conteo_por_dia(registros)
    fila_datos_dia, fila_siguiente = escribir_tabla_conteo(ws, "Registros por día", 1, por_dia)
    if por_dia:
        grafica_barras_conteo(ws, "Soportes por día", fila_datos_dia, len(por_dia), "D2")

    temas = _temas_frecuentes(registros)
    fila_datos_temas, _ = escribir_tabla_conteo(ws, "Temas más frecuentes", fila_siguiente + 1, temas)
    if temas:
        _grafica_pastel(ws, "Temas más frecuentes", fila_datos_temas, len(temas), "D20")
