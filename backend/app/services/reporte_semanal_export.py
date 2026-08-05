import io
from xml.sax.saxutils import escape

from openpyxl import Workbook
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils import get_column_letter
from pptx import Presentation
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE
from pptx.util import Inches, Pt
from reportlab.lib import colors
from reportlab.lib.pagesizes import landscape, letter
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import inch
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle

from app.models import Mesa
from app.services.semanas import rango_semana

ENCABEZADOS = ["Código", "Fecha de resolución real", "Solución", "Observaciones"]

_COLOR_FONDO = "0F1B2D"
_COLOR_TEXTO = "E8EDF2"
_COLOR_FILA_A = "16273D"
_COLOR_FILA_B = "1C3149"
_COLOR_BORDE = "2A3F58"


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


def generar_xlsx_reporte(titulo: str, filas: list[tuple[str, str, str]]) -> io.BytesIO:
    wb = Workbook()
    ws = wb.active
    ws.title = "Reporte"
    ws.sheet_view.showGridLines = False

    ws.merge_cells("A1:D1")
    celda_titulo = ws["A1"]
    celda_titulo.value = titulo
    celda_titulo.font = Font(name="Calibri", bold=True, size=14, color=_COLOR_TEXTO)
    celda_titulo.fill = PatternFill("solid", fgColor=_COLOR_FONDO)
    ws.row_dimensions[1].height = 28

    fila_encabezado = 3
    ws.cell(fila_encabezado, 1)
    for col, texto in enumerate(ENCABEZADOS, start=1):
        celda = ws.cell(fila_encabezado, col, texto)
        celda.font = Font(name="Calibri", bold=True, color=_COLOR_TEXTO, size=11)
        celda.fill = PatternFill("solid", fgColor=_COLOR_FONDO)
    ws.row_dimensions[fila_encabezado].height = 20

    borde_fino = Border(bottom=Side(style="thin", color=_COLOR_BORDE))
    for i, (codigo, fecha, solucion) in enumerate(filas, start=fila_encabezado + 1):
        for col, valor in enumerate((codigo, fecha, solucion, ""), start=1):
            celda = ws.cell(i, col, valor)
            celda.font = Font(name="Calibri", color=_COLOR_TEXTO, size=11)
            celda.fill = PatternFill("solid", fgColor=_COLOR_FILA_B if i % 2 == 0 else _COLOR_FILA_A)
            celda.border = borde_fino
            celda.alignment = Alignment(vertical="center", wrap_text=col == 3)

    for col, ancho in enumerate((16, 20, 55, 32), start=1):
        ws.column_dimensions[get_column_letter(col)].width = ancho

    out = io.BytesIO()
    wb.save(out)
    out.seek(0)
    return out


def generar_pptx_reporte(titulo: str, filas: list[tuple[str, str, str]]) -> io.BytesIO:
    prs = Presentation()
    prs.slide_width = Inches(13.33)
    prs.slide_height = Inches(7.5)
    slide = prs.slides.add_slide(prs.slide_layouts[6])

    fondo = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, 0, 0, prs.slide_width, prs.slide_height)
    fondo.fill.solid()
    fondo.fill.fore_color.rgb = RGBColor.from_string(_COLOR_FONDO)
    fondo.line.fill.background()
    fondo.shadow.inherit = False

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
        celda.fill.fore_color.rgb = RGBColor.from_string(_COLOR_FONDO)
        for p in celda.text_frame.paragraphs:
            p.font.bold = True
            p.font.size = Pt(13)
            p.font.color.rgb = RGBColor.from_string(_COLOR_TEXTO)

    for r, (codigo, fecha, solucion) in enumerate(filas, start=1):
        for c, valor in enumerate((codigo, fecha, solucion, "")):
            celda = tabla.cell(r, c)
            celda.text = valor
            celda.fill.solid()
            celda.fill.fore_color.rgb = RGBColor.from_string(_COLOR_FILA_B if r % 2 == 0 else _COLOR_FONDO)
            for p in celda.text_frame.paragraphs:
                p.font.size = Pt(11)
                p.font.color.rgb = RGBColor.from_string(_COLOR_TEXTO)

    out = io.BytesIO()
    prs.save(out)
    out.seek(0)
    return out


def _fondo_pagina_pdf(canvas, doc):
    canvas.saveState()
    canvas.setFillColor(colors.HexColor(f"#{_COLOR_FONDO}"))
    canvas.rect(0, 0, doc.pagesize[0], doc.pagesize[1], fill=1, stroke=0)
    canvas.restoreState()


def generar_pdf_reporte(titulo: str, filas: list[tuple[str, str, str]]) -> io.BytesIO:
    out = io.BytesIO()
    doc = SimpleDocTemplate(
        out, pagesize=landscape(letter), leftMargin=36, rightMargin=36, topMargin=36, bottomMargin=36
    )

    color_texto = colors.HexColor(f"#{_COLOR_TEXTO}")
    estilo_titulo = ParagraphStyle("titulo", fontName="Helvetica-Bold", fontSize=16, textColor=color_texto)
    estilo_celda = ParagraphStyle("celda", fontName="Helvetica", fontSize=9, textColor=color_texto, leading=12)

    datos = [ENCABEZADOS] + [
        [codigo, fecha, Paragraph(escape(solucion), estilo_celda), ""] for codigo, fecha, solucion in filas
    ]

    tabla = Table(datos, colWidths=[1.3 * inch, 1.6 * inch, 5.2 * inch, 2.2 * inch], repeatRows=1)
    estilos = [
        ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor(f"#{_COLOR_FONDO}")),
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
    for i in range(1, len(datos)):
        color_fila = _COLOR_FILA_B if i % 2 == 0 else _COLOR_FILA_A
        estilos.append(("BACKGROUND", (0, i), (-1, i), colors.HexColor(f"#{color_fila}")))
    tabla.setStyle(TableStyle(estilos))

    doc.build(
        [Paragraph(escape(titulo), estilo_titulo), Spacer(1, 14), tabla],
        onFirstPage=_fondo_pagina_pdf,
        onLaterPages=_fondo_pagina_pdf,
    )
    out.seek(0)
    return out
