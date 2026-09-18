from app.services.recompensas import CREDITOS_POR_ACCION, creditos_de


def test_registro_de_soporte_cobra_la_tarifa_completa():
    assert creditos_de("registro_creado") == CREDITOS_POR_ACCION


def test_abrir_mesa_paga_menos_que_un_soporte():
    assert creditos_de("mesa_creada") == 2


def test_cerrar_mesa_paga_menos_que_un_soporte():
    assert creditos_de("mesa_cerrada") == 3


def test_una_mesa_completa_no_supera_a_un_soporte():
    assert creditos_de("mesa_creada") + creditos_de("mesa_cerrada") <= CREDITOS_POR_ACCION


def test_motivo_desconocido_cobra_la_tarifa_completa():
    assert creditos_de("motivo_inventado") == CREDITOS_POR_ACCION
