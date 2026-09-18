import pytest

from app.services.catalogo_objetos import OBJETOS, Objeto

IDS_ORIGINALES = (
    "daga_oxidada",
    "nucleo_inestable",
    "chip_overclock",
    "manual_pirata",
    "filo_sangriento",
    "terminal_hackeada",
)

_POR_ID = {o.id: o for o in OBJETOS}


def _bono_total(objeto: Objeto) -> int:
    return objeto.danio_pct + objeto.critico_pct + objeto.cooldown_pct + objeto.xp_pct


@pytest.mark.parametrize("item_id", IDS_ORIGINALES)
def test_los_objetos_originales_siguen_en_el_catalogo(item_id):
    assert item_id in _POR_ID


def test_el_catalogo_tiene_muchos_objetos():
    assert len(OBJETOS) >= 24


@pytest.mark.parametrize("objeto", OBJETOS, ids=lambda o: o.id)
def test_cada_objeto_cuesta_y_da_algo(objeto):
    assert objeto.costo > 0
    assert _bono_total(objeto) > 0


@pytest.mark.parametrize("objeto", [o for o in OBJETOS if o.requiere], ids=lambda o: o.id)
def test_cada_combinado_usa_dos_piezas_distintas_del_catalogo(objeto):
    assert len(set(objeto.requiere)) == 2
    assert set(objeto.requiere) <= set(_POR_ID)


@pytest.mark.parametrize("objeto", [o for o in OBJETOS if o.requiere], ids=lambda o: o.id)
def test_cada_combinado_rinde_mas_que_sus_piezas(objeto):
    piezas = sum(_bono_total(_POR_ID[r]) for r in objeto.requiere)
    assert _bono_total(objeto) > piezas
