from types import SimpleNamespace

from app.services.sintesis_soluciones import agrupar_por_categoria_y_tipo, muestra_representativa


def _mesa(categoria_id: int, tipo_solucion: str | None, solucion: str = "x"):
    return SimpleNamespace(categoria_id=categoria_id, tipo_solucion=tipo_solucion, solucion=solucion)


def test_agrupa_mesas_de_misma_categoria_y_tipo():
    mesas = [_mesa(1, "Modificación en BD") for _ in range(3)]

    grupos = agrupar_por_categoria_y_tipo(mesas)

    assert grupos == {(1, "Modificación en BD"): mesas}


def test_descarta_grupos_bajo_el_minimo():
    mesas = [_mesa(1, "Modificación en BD") for _ in range(2)]

    grupos = agrupar_por_categoria_y_tipo(mesas)

    assert grupos == {}


def test_categorias_distintas_no_se_mezclan():
    mesas = [_mesa(1, "Modificación en BD") for _ in range(3)] + [_mesa(2, "Modificación en BD") for _ in range(3)]

    grupos = agrupar_por_categoria_y_tipo(mesas)

    assert set(grupos.keys()) == {(1, "Modificación en BD"), (2, "Modificación en BD")}


def test_muestra_representativa_quita_duplicados_y_respeta_limite():
    soluciones = ["a", "a", "b", "c", "c", "d", "e"]

    resultado = muestra_representativa(soluciones, limite=3)

    assert resultado == ["a", "b", "c"]
    assert len(resultado) == len(set(resultado))


def test_muestra_representativa_ignora_vacios():
    soluciones = ["", "  ", "a"]

    assert muestra_representativa(soluciones) == ["a"]
