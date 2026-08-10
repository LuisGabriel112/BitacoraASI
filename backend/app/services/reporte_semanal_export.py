import io
from xml.sax.saxutils import escape

from openpyxl import Workbook
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils import get_column_letter
from pptx import Presentation
from pptx.chart.data import CategoryChartData
from pptx.dml.color import RGBColor
from pptx.enum.chart import XL_CHART_TYPE
from pptx.enum.shapes import MSO_SHAPE
from pptx.util import Inches, Pt
from reportlab.graphics.charts.barcharts import VerticalBarChart
from reportlab.graphics.shapes import Drawing, String
from reportlab.lib import colors
from reportlab.lib.pagesizes import landscape, letter
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import inch
from reportlab.platypus import PageBreak, Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle

from app.models import Mesa
from app.services.excel_charts import escribir_tabla_conteo, grafica_barras_conteo
from app.services.semanas import rango_semana

ENCABEZADOS = ["Código", "Fecha de resolución real", "Solución", "Observaciones"]

_COLOR_TITULO_FONDO = "FFFF00"
_COLOR_ENCABEZADO_FONDO = "FF9900"
_COLOR_TEXTO = "000000"
_COLOR_FILA = "FFFFFF"
_COLOR_BORDE = "BFBFBF"
_COLOR_ACENTO = "FF9900"


def titulo_reporte(semana: str) -> str:
    numero, anio = (parte.strip() for parte in semana.replace("SEM", "").split("-"))
    lunes, viernes = rango_semana(semana)
    return (
        f"Reporte Semanal — Semana {int(numero)} de {anio} "
        f"({lunes.strftime('%d/%m/%Y')} al {viernes.strftime('%d/%m/%Y')})"
    )


def filas_reporte(mesas_cerradas: list[Mesa]) -> list[tuple[str, str, str]]:
    ordenadas = sorted(mesas_cerradas, key=lambda m: m.fecha_cierre_real)
    return [(m.codigo, m.fecha_cierre_real.strftime("%d/%m/%Y %H:%M"), m.solucion or "") for m in ordenadas]


def generar_xlsx_reporte(
    titulo: str, filas: list[tuple[str, str, str]], graficas: dict[str, list[tuple[str, int]]]
) -> io.BytesIO:
    wb = Workbook()
    ws = wb.active
    ws.title = "Reporte"

    ws.merge_cells("A1:D1")
    celda_titulo = ws["A1"]
    celda_titulo.value = titulo
    celda_titulo.font = Font(name="Calibri", bold=True, size=12, color=_COLOR_TEXTO)
    celda_titulo.fill = PatternFill("solid", fgColor=_COLOR_TITULO_FONDO)
    ws.row_dimensions[1].height = 24

    fila_encabezado = 3
    for col, texto in enumerate(ENCABEZADOS, start=1):
        celda = ws.cell(fila_encabezado, col, texto)
        celda.font = Font(name="Calibri", bold=True, color=_COLOR_TEXTO, size=10)
        celda.fill = PatternFill("solid", fgColor=_COLOR_ENCABEZADO_FONDO)
    ws.row_dimensions[fila_encabezado].height = 20

    borde_fino = Border(*[Side(style="thin", color=_COLOR_BORDE)] * 4)
    for i, (codigo, fecha, solucion) in enumerate(filas, start=fila_encabezado + 1):
        for col, valor in enumerate((codigo, fecha, solucion, ""), start=1):
            celda = ws.cell(i, col, valor)
            celda.font = Font(name="Calibri", color=_COLOR_TEXTO, size=10)
            celda.fill = PatternFill("solid", fgColor=_COLOR_FILA)
            celda.border = borde_fino
            celda.alignment = Alignment(vertical="center", wrap_text=col == 3)

    for col, ancho in enumerate((16, 20, 55, 32), start=1):
        ws.column_dimensions[get_column_letter(col)].width = ancho

    ws_graficas = wb.create_sheet("Gráficas")
    fila = 1
    for i, (nombre, datos) in enumerate(graficas.items()):
        if not datos:
            continue
        fila_datos, fila = escribir_tabla_conteo(ws_graficas, nombre, fila, datos)
        grafica_barras_conteo(ws_graficas, nombre, fila_datos, len(datos), f"D{2 + i * 16}", _COLOR_ACENTO)
        fila += 1

    out = io.BytesIO()
    wb.save(out)
    out.seek(0)
    return out


def generar_pptx_reporte(
    titulo: str, filas: list[tuple[str, str, str]], graficas: dict[str, list[tuple[str, int]]]
) -> io.BytesIO:
    prs = Presentation()
    prs.slide_width = Inches(13.33)
    prs.slide_height = Inches(7.5)
    slide = prs.slides.add_slide(prs.slide_layouts[6])

    caja_titulo = slide.shapes.add_textbox(Inches(0.5), Inches(0.3), Inches(12.3), Inches(0.8))
    parrafo = caja_titulo.text_frame.paragraphs[0]
    parrafo.text = titulo
    parrafo.font.size = Pt(22)
    parrafo.font.bold = True
    parrafo.font.color.rgb = RGBColor.from_string(_COLOR_TEXTO)

    filas_totales = len(filas) + 1
    tabla_shape = slide.shapes.add_table(filas_totales, 4, Inches(0.5), Inches(1.3), Inches(12.3), Inches(5.7))
    tabla = tabla_shape.table
    for col, ancho in zip(tabla.columns, (1.8, 2.2, 5.3, 3.0)):
        col.width = Inches(ancho)

    for c, texto in enumerate(ENCABEZADOS):
        celda = tabla.cell(0, c)
        celda.text = texto
        celda.fill.solid()
        celda.fill.fore_color.rgb = RGBColor.from_string(_COLOR_ENCABEZADO_FONDO)
        for p in celda.text_frame.paragraphs:
            p.font.bold = True
            p.font.size = Pt(13)
            p.font.color.rgb = RGBColor.from_string(_COLOR_TEXTO)

    for r, (codigo, fecha, solucion) in enumerate(filas, start=1):
        for c, valor in enumerate((codigo, fecha, solucion, "")):
            celda = tabla.cell(r, c)
            celda.text = valor
            celda.fill.solid()
            celda.fill.fore_color.rgb = RGBColor.from_string(_COLOR_FILA)
            for p in celda.text_frame.paragraphs:
                p.font.size = Pt(11)
                p.font.color.rgb = RGBColor.from_string(_COLOR_TEXTO)

    graficas_con_datos = {k: v for k, v in graficas.items() if v}
    if graficas_con_datos:
        slide_graficas = prs.slides.add_slide(prs.slide_layouts[6])
        ancho_grafica = Inches(6.0)
        for i, (nombre, datos) in enumerate(graficas_con_datos.items()):
            chart_data = CategoryChartData()
            chart_data.categories = [k for k, _ in datos]
            chart_data.add_series("Cantidad", [v for _, v in datos])
            left = Inches(0.5) + i * (ancho_grafica + Inches(0.3))
            grafico_shape = slide_graficas.shapes.add_chart(
                XL_CHART_TYPE.COLUMN_CLUSTERED, left, Inches(0.5), ancho_grafica, Inches(6.0), chart_data
            )
            chart = grafico_shape.chart
            chart.has_legend = False
            chart.has_title = True
            chart.chart_title.text_frame.text = nombre
            serie = chart.plots[0].series[0]
            serie.format.fill.solid()
            serie.format.fill.fore_color.rgb = RGBColor.from_string(_COLOR_ACENTO)

    out = io.BytesIO()
    prs.save(out)
    out.seek(0)
    return out


def _grafica_pdf(titulo: str, datos: list[tuple[str, int]], ancho: float, alto: float) -> Drawing:
    drawing = Drawing(ancho, alto)
    chart = VerticalBarChart()
    chart.x = 50
    chart.y = 30
    chart.height = alto - 55
    chart.width = ancho - 70
    chart.data = [[v for _, v in datos]]
    chart.categoryAxis.categoryNames = [k for k, _ in datos]
    chart.categoryAxis.labels.angle = 20
    chart.categoryAxis.labels.dy = -12
    chart.categoryAxis.labels.fontSize = 7
    chart.valueAxis.valueMin = 0
    chart.bars[0].fillColor = colors.HexColor(f"#{_COLOR_ACENTO}")
    drawing.add(chart)
    drawing.add(
        String(ancho / 2, alto - 15, titulo, fontName="Helvetica-Bold", fontSize=11, textAnchor="middle")
    )
    return drawing


def generar_pdf_reporte(
    titulo: str, filas: list[tuple[str, str, str]], graficas: dict[str, list[tuple[str, int]]]
) -> io.BytesIO:
    out = io.BytesIO()
    doc = SimpleDocTemplate(
        out, pagesize=landscape(letter), leftMargin=36, rightMargin=36, topMargin=36, bottomMargin=36
    )

    color_texto = colors.HexColor(f"#{_COLOR_TEXTO}")
    estilo_titulo = ParagraphStyle("titulo", fontName="Helvetica-Bold", fontSize=16, textColor=color_texto)
    estilo_celda = ParagraphStyle("celda", fontName="Helvetica", fontSize=9, textColor=color_texto, leading=12)

    datos_tabla = [ENCABEZADOS] + [
        [codigo, fecha, Paragraph(escape(solucion), estilo_celda), ""] for codigo, fecha, solucion in filas
    ]

    tabla = Table(datos_tabla, colWidths=[1.3 * inch, 1.6 * inch, 5.2 * inch, 2.2 * inch], repeatRows=1)
    tabla.setStyle(
        TableStyle(
            [
                ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor(f"#{_COLOR_ENCABEZADO_FONDO}")),
                ("BACKGROUND", (0, 1), (-1, -1), colors.HexColor(f"#{_COLOR_FILA}")),
                ("TEXTCOLOR", (0, 0), (-1, -1), color_texto),
                ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
                ("FONTNAME", (0, 1), (-1, -1), "Helvetica"),
                ("FONTSIZE", (0, 0), (-1, -1), 9),
                ("GRID", (0, 0), (-1, -1), 0.5, colors.HexColor(f"#{_COLOR_BORDE}")),
                ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
                ("LEFTPADDING", (0, 0), (-1, -1), 6),
                ("RIGHTPADDING", (0, 0), (-1, -1), 6),
                ("TOPPADDING", (0, 0), (-1, -1), 5),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
            ]
        )
    )

    story = [Paragraph(escape(titulo), estilo_titulo), Spacer(1, 14), tabla]

    graficas_con_datos = {k: v for k, v in graficas.items() if v}
    if graficas_con_datos:
        story.append(PageBreak())
        ancho_pagina = landscape(letter)[0] - 72
        for nombre, datos in graficas_con_datos.items():
            story.append(_grafica_pdf(nombre, datos, ancho_pagina, 240))
            story.append(Spacer(1, 20))

    doc.build(story)
    out.seek(0)
    return out
