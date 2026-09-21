from datetime import date

import pytest
from pydantic import ValidationError

from app.schemas import AparienciaUpdate, RegistroCreate, UsuarioRegistro


def payload_de_alta(**extras):
    return {
        "fecha": date(2026, 9, 21),
        "empresa_id": 1,
        "sistema_id": 2,
        "medio_id": 3,
        "modulo_id": 4,
        "atendio_id": 5,
        "descripcion": "Falla de impresión",
        **extras,
    }


def test_minutos_de_atencion_se_aceptan():
    assert RegistroCreate(**payload_de_alta(minutos_atencion=45)).minutos_atencion == 45


def test_minutos_de_atencion_son_opcionales():
    assert RegistroCreate(**payload_de_alta()).minutos_atencion is None


@pytest.mark.parametrize("minutos", [0, -5, 1441])
def test_minutos_de_atencion_fuera_de_rango_se_rechazan(minutos):
    with pytest.raises(ValidationError):
        RegistroCreate(**payload_de_alta(minutos_atencion=minutos))


def test_color_hex_valido_se_acepta():
    apariencia = AparienciaUpdate(color_piel="#f2c9a1", color_cuerpo="#3b82f6", accesorio="ninguno")
    assert apariencia.color_cuerpo == "#3b82f6"


def test_color_sin_formato_hex_se_rechaza():
    with pytest.raises(ValidationError):
        AparienciaUpdate(color_piel="#f2c9a1", color_cuerpo="azul", accesorio="ninguno")


def test_color_hex_corto_se_rechaza():
    with pytest.raises(ValidationError):
        AparienciaUpdate(color_piel="#f2c9a1", color_cuerpo="#fff", accesorio="ninguno")


def test_accesorio_de_la_lista_se_acepta():
    apariencia = AparienciaUpdate(color_piel="#f2c9a1", color_cuerpo="#3b82f6", accesorio="gorra")
    assert apariencia.accesorio == "gorra"


def test_accesorio_fuera_de_la_lista_se_rechaza():
    with pytest.raises(ValidationError):
        AparienciaUpdate(color_piel="#f2c9a1", color_cuerpo="#3b82f6", accesorio="pinata_gigante")


def test_accesorio_nuevo_del_catalogo_ampliado_se_acepta():
    apariencia = AparienciaUpdate(color_piel="#f2c9a1", color_cuerpo="#3b82f6", accesorio="corona")
    assert apariencia.accesorio == "corona"


def test_apariencia_sin_ejes_nuevos_usa_valores_por_defecto():
    apariencia = AparienciaUpdate(color_piel="#f2c9a1", color_cuerpo="#3b82f6", accesorio="ninguno")
    assert apariencia.color_detalle == "#222222"
    assert apariencia.forma_cuerpo == "normal"
    assert apariencia.cara == "feliz"
    assert apariencia.espalda == "ninguna"


def test_forma_cuerpo_de_la_lista_se_acepta():
    apariencia = AparienciaUpdate(
        color_piel="#f2c9a1", color_cuerpo="#3b82f6", accesorio="ninguno", forma_cuerpo="robusto"
    )
    assert apariencia.forma_cuerpo == "robusto"


@pytest.mark.parametrize(
    ("campo", "valor"),
    [("forma_cuerpo", "gelatina"), ("cara", "dormido"), ("espalda", "jetpack"), ("color_detalle", "negro")],
)
def test_eje_de_apariencia_fuera_de_la_lista_se_rechaza(campo, valor):
    with pytest.raises(ValidationError):
        AparienciaUpdate(
            color_piel="#f2c9a1", color_cuerpo="#3b82f6", accesorio="ninguno", **{campo: valor}
        )


def test_registro_sin_apariencia_usa_valores_por_defecto():
    registro = UsuarioRegistro(nombre="Juan Pérez", pin="1234")
    assert registro.color_piel == "#f2c9a1"
    assert registro.color_cuerpo == "#3b82f6"
    assert registro.accesorio == "ninguno"
    assert registro.color_detalle == "#222222"
    assert registro.forma_cuerpo == "normal"
    assert registro.cara == "feliz"
    assert registro.espalda == "ninguna"
