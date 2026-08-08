import pytest
from pydantic import ValidationError

from app.schemas import AparienciaUpdate, UsuarioRegistro


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
        AparienciaUpdate(color_piel="#f2c9a1", color_cuerpo="#3b82f6", accesorio="sombrero")


def test_registro_sin_apariencia_usa_valores_por_defecto():
    registro = UsuarioRegistro(nombre="Juan Pérez", pin="1234")
    assert registro.color_piel == "#f2c9a1"
    assert registro.color_cuerpo == "#3b82f6"
    assert registro.accesorio == "ninguno"
