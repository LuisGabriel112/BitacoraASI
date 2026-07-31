from app.routers.registros import _tema


def test_tema_es_la_descripcion_mas_repetida():
    descripciones = ["Cambio contraseña", "Cambio contraseña", "Cambiar contraseña"]

    assert _tema(descripciones) == "Cambio contraseña"


def test_tema_desempata_por_longitud_cuando_hay_empate():
    descripciones = ["Usuario bloqueado", "Bloqueo"]

    assert _tema(descripciones) == "Bloqueo"


def test_tema_de_una_sola_descripcion_es_ella_misma():
    assert _tema(["Acceso a facturación"]) == "Acceso a facturación"
