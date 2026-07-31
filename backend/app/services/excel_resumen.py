from typing import Protocol

from openpyxl.chart import BarChart, PieChart, Reference
from openpyxl.styles import Font
from openpyxl.workbook import Workbook
from openpyxl.worksheet.worksheet import Worksheet

from app.services.clustering import agrupar_por_similitud, tema_representativo
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


def _escribir_tabla(ws: Worksheet, titulo: str, fila_inicio: int, datos: list[tuple[str, int]]) -> tuple[int, int]:
    """Escribe título + encabezados + filas (etiqueta, cantidad). Devuelve (fila_datos_inicio, fila_siguiente_bloque)."""
    ws.cell(fila_inicio, 1, titulo).font = Font(bold=True)
    ws.cell(fila_inicio + 1, 1, "Etiqueta")
    ws.cell(fila_inicio + 1, 2, "Cantidad")
    fila_datos = fila_inicio + 2
    for i, (etiqueta, cantidad) in enumerate(datos, start=fila_datos):
        ws.cell(i, 1, etiqueta)
        ws.cell(i, 2, cantidad)
    return fila_datos, fila_datos + len(datos)


def _referencia_datos(ws: Worksheet, fila_inicio: int, num_filas: int) -> tuple[Reference, Reference]:
    datos = Reference(ws, min_col=2, min_row=fila_inicio, max_row=fila_inicio + num_filas - 1)
    categorias = Reference(ws, min_col=1, min_row=fila_inicio, max_row=fila_inicio + num_filas - 1)
    return datos, categorias


def _grafica_barras(ws: Worksheet, titulo: str, fila_datos: int, num_filas: int, ancla: str) -> None:
    chart = BarChart()
    chart.title = titulo
    chart.y_axis.title = "Cantidad"
    datos, categorias = _referencia_datos(ws, fila_datos, num_filas)
    chart.add_data(datos, titles_from_data=False)
    chart.set_categories(categorias)
    ws.add_chart(chart, ancla)


def _grafica_pastel(ws: Worksheet, titulo: str, fila_datos: int, num_filas: int, ancla: str) -> None:
    chart = PieChart()
    chart.title = titulo
    datos, categorias = _referencia_datos(ws, fila_datos, num_filas)
    chart.add_data(datos, titles_from_data=False)
    chart.set_categories(categorias)
    ws.add_chart(chart, ancla)


def agregar_hoja_resumen(wb: Workbook, registros: list[RegistroParaResumen]) -> None:
    """Hoja 'Resumen': tabla + gráfica de barras por día, y tabla + gráfica de
    pastel de temas más frecuentes (si hay embeddings cacheados para todos)."""
    ws = wb.create_sheet("Resumen")

    por_dia = _conteo_por_dia(registros)
    fila_datos_dia, fila_siguiente = _escribir_tabla(ws, "Registros por día", 1, por_dia)
    if por_dia:
        _grafica_barras(ws, "Soportes por día", fila_datos_dia, len(por_dia), "D2")

    temas = _temas_frecuentes(registros)
    fila_datos_temas, _ = _escribir_tabla(ws, "Temas más frecuentes", fila_siguiente + 1, temas)
    if temas:
        _grafica_pastel(ws, "Temas más frecuentes", fila_datos_temas, len(temas), "D20")
