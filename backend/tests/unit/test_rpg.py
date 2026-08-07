from app.services.rpg import XP_POR_ACCION, XP_POR_LOGRO, nivel_y_progreso, titulo_para_nivel


def test_nivel_1_al_empezar_sin_xp():
    info = nivel_y_progreso(0)
    assert info.nivel == 1
    assert info.xp_en_nivel_actual == 0
    assert info.xp_para_siguiente_nivel == 100


def test_xp_negativo_se_trata_como_cero():
    assert nivel_y_progreso(-50) == nivel_y_progreso(0)


def test_justo_antes_del_umbral_no_sube_de_nivel():
    info = nivel_y_progreso(99)
    assert info.nivel == 1
    assert info.xp_en_nivel_actual == 99


def test_justo_en_el_umbral_sube_a_nivel_2():
    info = nivel_y_progreso(100)
    assert info.nivel == 2
    assert info.xp_en_nivel_actual == 0
    assert info.xp_para_siguiente_nivel == 300


def test_acumula_varios_niveles():
    # nivel 1->2 cuesta 100, nivel 2->3 cuesta 300: 400 exacto llega a nivel 3
    info = nivel_y_progreso(400)
    assert info.nivel == 3
    assert info.xp_en_nivel_actual == 0


def test_titulo_aprendiz_niveles_bajos():
    assert titulo_para_nivel(1) == "Aprendiz"
    assert titulo_para_nivel(4) == "Aprendiz"


def test_titulo_tecnico_niveles_medios():
    assert titulo_para_nivel(5) == "Técnico"
    assert titulo_para_nivel(9) == "Técnico"


def test_titulo_veterano_niveles_altos():
    assert titulo_para_nivel(10) == "Veterano"


def test_constantes_de_xp_son_positivas_y_logro_vale_mas_que_accion():
    assert XP_POR_ACCION > 0
    assert XP_POR_LOGRO > XP_POR_ACCION
