import pytest

from app.services.exportar_seguro import celda_segura


def test_texto_normal_no_cambia():
    assert celda_segura("Se corrigió el importe en SIIP") == "Se corrigió el importe en SIIP"


@pytest.mark.parametrize("prefijo", ["=", "+", "-", "@", "\t", "\r"])
def test_texto_con_caracter_de_formula_se_neutraliza(prefijo):
    original = f"{prefijo}HYPERLINK(\"http://evil.com\")"

    resultado = celda_segura(original)

    assert resultado == f"'{original}"
    assert not resultado.startswith(("=", "+", "-", "@", "\t", "\r"))


def test_none_pasa_sin_cambios():
    assert celda_segura(None) is None


def test_caracter_de_formula_en_medio_no_se_toca():
    assert celda_segura("Total = 5") == "Total = 5"
