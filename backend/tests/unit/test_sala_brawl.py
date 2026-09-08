from app.services.motor_brawl import CANTIDAD_BOTS
from app.services.sala_brawl import (
    SEGUNDOS_ESPERA_EMPAREJAMIENTO,
    RegistroPases,
    RegistroSalas,
    estado_para_cliente,
    iniciar,
    otorgar_pases_si_hubo_rival,
)

AHORA = 1000.0


def _registro_con(*jugadores, ahora=AHORA):
    registro = RegistroSalas()
    salas = [registro.entrar(j, f"Jugador {j}", "🙂", ahora) for j in jugadores]
    return registro, salas


def test_el_primer_jugador_abre_una_sala_esperando():
    registro, (sala,) = _registro_con("a")

    assert sala.estado == "esperando"
    assert list(sala.ronda.jugadores) == ["a"]
    assert registro.sala_de("a") is sala


def test_el_segundo_jugador_cae_en_la_sala_del_primero():
    _, (sala_a, sala_b) = _registro_con("a", "b")

    assert sala_a is sala_b
    assert set(sala_a.ronda.jugadores) == {"a", "b"}


def test_un_tercer_jugador_abre_una_sala_nueva():
    _, (sala_a, _, sala_c) = _registro_con("a", "b", "c")

    assert sala_c is not sala_a
    assert list(sala_c.ronda.jugadores) == ["c"]


def test_cada_jugador_aparece_en_un_punto_distinto():
    _, (sala, _) = _registro_con("a", "b")
    jugadores = list(sala.ronda.jugadores.values())

    assert (jugadores[0].x, jugadores[0].y) != (jugadores[1].x, jugadores[1].y)


def test_una_sala_en_juego_no_acepta_jugadores_nuevos():
    registro, (sala_a, _) = _registro_con("a", "b")

    sala_c = registro.entrar("c", "Jugador c", "🙂", AHORA)

    assert sala_a.estado == "jugando"
    assert sala_c is not sala_a


def test_la_sala_arranca_sola_al_agotarse_la_espera():
    registro, (sala,) = _registro_con("a")

    registro.revisar_arranque(sala, AHORA + SEGUNDOS_ESPERA_EMPAREJAMIENTO + 1)

    assert sala.estado == "jugando"
    assert len(sala.ronda.bots) == CANTIDAD_BOTS


def test_la_sala_sigue_esperando_antes_del_tiempo():
    registro, (sala,) = _registro_con("a")

    registro.revisar_arranque(sala, AHORA + 1)

    assert sala.estado == "esperando"


def test_la_sala_arranca_de_inmediato_al_llenarse():
    _, (sala, _) = _registro_con("a", "b")

    assert sala.estado == "jugando"
    assert len(sala.ronda.bots) == CANTIDAD_BOTS


def test_salir_quita_al_jugador_de_la_sala():
    registro, (sala, _) = _registro_con("a", "b")

    registro.salir("a")

    assert list(sala.ronda.jugadores) == ["b"]
    assert registro.sala_de("a") is None


def test_una_sala_sin_jugadores_se_descarta():
    registro, (sala,) = _registro_con("a")

    registro.salir("a")

    assert sala.id not in registro.salas


def test_salir_de_una_sala_inexistente_no_truena():
    registro = RegistroSalas()

    registro.salir("fantasma")


def test_el_estado_para_el_cliente_trae_el_mundo_completo():
    _, (sala, _) = _registro_con("a", "b")

    estado = estado_para_cliente(sala)

    assert set(estado) >= {"estado", "jugadores", "bots", "proyectiles", "muros", "segundos_restantes"}
    assert len(estado["jugadores"]) == 2
    assert len(estado["bots"]) == CANTIDAD_BOTS
    assert estado["muros"][0]["ancho"] > 0


def test_el_jugador_puede_dejar_de_esperar_y_arrancar():
    _, (sala,) = _registro_con("a")

    iniciar(sala)

    assert sala.estado == "jugando"
    assert len(sala.ronda.bots) == CANTIDAD_BOTS


def test_una_ronda_con_rival_humano_deja_pase_a_los_dos():
    """Jugar acompañado no debe gastar el cooldown: si lo gastara, coordinarse
    con un compañero costaría el doble de espera que jugar solo."""
    registro = RegistroSalas()
    pases = RegistroPases()
    sala = registro.entrar("7", "Ana", "🙂", AHORA)
    registro.entrar("9", "Beto", "🦉", AHORA)

    otorgar_pases_si_hubo_rival(sala, pases)

    assert pases.consumir("7") is True
    assert pases.consumir("9") is True


def test_una_ronda_a_solas_no_deja_pase():
    registro = RegistroSalas()
    pases = RegistroPases()
    sala = registro.entrar("7", "Ana", "🙂", AHORA)

    otorgar_pases_si_hubo_rival(sala, pases)

    assert pases.consumir("7") is False


def test_el_pase_se_usa_una_sola_vez():
    pases = RegistroPases()
    pases.otorgar("7")

    assert pases.consumir("7") is True
    assert pases.consumir("7") is False


def test_consumir_pase_de_alguien_sin_pase_no_truena():
    assert RegistroPases().consumir("fantasma") is False


def test_el_estado_de_una_sala_esperando_no_trae_bots():
    _, (sala,) = _registro_con("a")

    estado = estado_para_cliente(sala)

    assert estado["estado"] == "esperando"
    assert estado["bots"] == []
