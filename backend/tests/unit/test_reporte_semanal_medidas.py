from io import BytesIO

from openpyxl import load_workbook

from app.services.reporte_semanal_export import ENCABEZADOS, OPCIONES_MEDIDAS, generar_xlsx_reporte

_FILAS = [
    ("TCK-001", "03/08/2026 09:00", "Se aplicó el fix"),
    ("TCK-002", "04/08/2026 10:00", "Se reinició el servicio"),
    ("TCK-003", "05/08/2026 11:00", "Se corrigió el registro"),
]


def _xlsx(filas=_FILAS):
    return load_workbook(BytesIO(generar_xlsx_reporte("Reporte de prueba", filas, {}).getvalue()))


def test_ultima_columna_se_llama_medidas_para_disminuir_el_impacto():
    assert ENCABEZADOS[-1] == "Medidas realizadas para disminuir el impacto"


def test_xlsx_columna_medidas_tiene_lista_desplegable():
    wb = _xlsx()
    validaciones = wb["Reporte"].data_validations.dataValidation

    assert len(validaciones) == 1
    assert validaciones[0].type == "list"


def test_opciones_de_la_lista_son_las_dos_exactas():
    assert OPCIONES_MEDIDAS == (
        "Ninguna.",
        "En progreso la validación de la correctez de la información ingresada por el proveedor. "
        "Esto determinará la acción correctiva: a) ajustar la validación para rechazar la info o  "
        "b) ajustar el sistema para aceptarla y procesarla.",
    )


def test_validacion_cubre_todas_las_filas_de_datos():
    wb = _xlsx()
    dv = wb["Reporte"].data_validations.dataValidation[0]

    assert str(dv.sqref) == "D4:D6"  # encabezado en fila 3, 3 filas de datos: 4,5,6


def test_sin_filas_no_agrega_validacion():
    wb = _xlsx(filas=[])
    validaciones = wb["Reporte"].data_validations.dataValidation

    assert len(validaciones) == 0
