import pytest

from app.services.motor_brawl import (
    ALTO_ARENA,
    ANCHO_ARENA,
    CADENCIA_BOT_TICKS,
    CANTIDAD_BOTS,
    DISTANCIA_PREFERIDA_BOT,
    MUROS,
    RADIO_PERSONAJE,
    TICKS_RONDA,
    VIDA_BOT,
    VIDA_JUGADOR,
    Bot,
    Jugador,
    Proyectil,
    Ronda,
    avanzar,
    bot_debe_disparar,
    crear_bots,
    disparar_jugador,
    distancia,
    limitar_a_arena,
    mover_con_colision,
    mover_jugador,
    posicion_aparicion,
    ronda_terminada,
    toca_muro,
)


def _jugador(id_jugador="a", x=180.0, y=130.0, vida=VIDA_JUGADOR) -> Jugador:
    return Jugador(id=id_jugador, nombre="Ana", avatar="🙂", x=x, y=y, vida=vida)


def _ronda(jugadores=None, bots=None, proyectiles=None, tick=0) -> Ronda:
    return Ronda(
        jugadores={j.id: j for j in (jugadores or [_jugador()])},
        bots=list(bots or []),
        proyectiles=list(proyectiles or []),
        tick=tick,
    )


def _centro_muro():
    muro = MUROS[0]
    return muro.x + muro.ancho / 2, muro.y + muro.alto / 2


def _disparos_de_bot():
    """Bot a la izquierda del jugador, en línea horizontal despejada: apuntado a
    otro eje el disparo se estrella contra un muro y no se puede medir."""
    jugador = _jugador(x=180.0, y=130.0)
    bot = Bot(id=0, x=60.0, y=130.0, vida=VIDA_BOT)
    ronda = _ronda(jugadores=[jugador], bots=[bot], tick=CADENCIA_BOT_TICKS - 1)
    avanzar(ronda)
    return [p for p in ronda.proyectiles if p.de_jugador is None]


def test_limitar_a_arena_mantiene_el_punto_dentro():
    x, y = limitar_a_arena(-50.0, ALTO_ARENA + 999, RADIO_PERSONAJE)
    assert RADIO_PERSONAJE <= x <= ANCHO_ARENA - RADIO_PERSONAJE
    assert RADIO_PERSONAJE <= y <= ALTO_ARENA - RADIO_PERSONAJE


def test_toca_muro_detecta_el_centro_de_un_muro():
    assert toca_muro(*_centro_muro(), RADIO_PERSONAJE) is True


@pytest.mark.parametrize("indice", range(2))
def test_los_puntos_de_aparicion_estan_libres(indice):
    x, y = posicion_aparicion(indice)
    assert toca_muro(x, y, RADIO_PERSONAJE) is False


def test_un_muro_bloquea_pero_deja_deslizarse():
    muro = MUROS[0]
    x = muro.x - RADIO_PERSONAJE - 1
    y = muro.y + muro.alto / 2

    destino_x, destino_y = mover_con_colision(x, y, 1.0, -1.0, 4.0, RADIO_PERSONAJE)

    assert toca_muro(destino_x, destino_y, RADIO_PERSONAJE) is False
    assert destino_x <= x
    assert destino_y < y


def test_un_bot_lejos_se_acerca_al_jugador():
    jugador = _jugador(x=180.0, y=130.0)
    bot = Bot(id=0, x=30.0, y=30.0, vida=VIDA_BOT)
    ronda = _ronda(jugadores=[jugador], bots=[bot])
    antes = distancia(bot.x, bot.y, jugador.x, jugador.y)

    avanzar(ronda)

    assert distancia(ronda.bots[0].x, ronda.bots[0].y, jugador.x, jugador.y) < antes


def test_un_bot_a_tiro_mantiene_su_distancia():
    jugador = _jugador(x=180.0, y=130.0)
    bot = Bot(id=0, x=180.0 + DISTANCIA_PREFERIDA_BOT - 10, y=130.0, vida=VIDA_BOT)
    ronda = _ronda(jugadores=[jugador], bots=[bot])

    avanzar(ronda)

    assert ronda.bots[0].x == pytest.approx(bot.x)


def test_los_bots_no_se_mueven_sin_jugadores_vivos():
    bot = Bot(id=0, x=30.0, y=30.0, vida=VIDA_BOT)
    ronda = _ronda(jugadores=[_jugador(vida=0)], bots=[bot])

    avanzar(ronda)

    assert (ronda.bots[0].x, ronda.bots[0].y) == (30.0, 30.0)


def test_los_bots_no_disparan_todos_en_el_mismo_tick():
    for tick in range(1, CADENCIA_BOT_TICKS * 3):
        disparan = sum(bot_debe_disparar(tick, i) for i in range(CANTIDAD_BOTS))
        assert disparan < CANTIDAD_BOTS


def test_cada_bot_alcanza_a_disparar_en_una_vuelta():
    for indice in range(CANTIDAD_BOTS):
        assert any(bot_debe_disparar(t, indice) for t in range(CADENCIA_BOT_TICKS * 2))


def test_los_bots_no_apuntan_con_punteria_perfecta():
    """Tres bots apuntando exactamente al jugador lo mataban en menos de 4
    segundos: la dispersión es lo que vuelve la ronda esquivable."""
    direcciones = set()

    for _ in range(30):
        for disparo in _disparos_de_bot():
            direcciones.add(round(disparo.dy, 4))

    assert len(direcciones) > 1, "todos los disparos salieron con la misma dirección exacta"


def test_la_dispersion_del_bot_sigue_apuntando_hacia_el_jugador():
    for _ in range(30):
        for disparo in _disparos_de_bot():
            assert disparo.dx > 0.9, "el disparo debe seguir yendo hacia el jugador"


def test_un_disparo_de_jugador_baja_vida_al_bot():
    bot = Bot(id=0, x=200.0, y=130.0, vida=VIDA_BOT)
    disparo = Proyectil(id=1, x=200.0, y=130.0, dx=0.0, dy=0.0, de_jugador="a")
    ronda = _ronda(bots=[bot], proyectiles=[disparo])

    avanzar(ronda)

    assert ronda.bots[0].vida == VIDA_BOT - 1
    assert ronda.proyectiles == []


def test_la_baja_se_acredita_al_jugador_que_disparo():
    bot = Bot(id=0, x=200.0, y=130.0, vida=1)
    disparo = Proyectil(id=1, x=200.0, y=130.0, dx=0.0, dy=0.0, de_jugador="a")
    ronda = _ronda(bots=[bot], proyectiles=[disparo])

    avanzar(ronda)

    assert ronda.bots[0].vida == 0
    assert ronda.jugadores["a"].bajas == 1


def test_un_disparo_de_bot_baja_vida_al_jugador():
    jugador = _jugador(x=180.0, y=130.0)
    disparo = Proyectil(id=1, x=180.0, y=130.0, dx=0.0, dy=0.0, de_jugador=None)
    ronda = _ronda(jugadores=[jugador], proyectiles=[disparo])

    avanzar(ronda)

    assert ronda.jugadores["a"].vida == VIDA_JUGADOR - 1
    assert ronda.proyectiles == []


def test_un_jugador_no_puede_danar_a_otro_jugador():
    otro = _jugador(id_jugador="b", x=180.0, y=130.0)
    disparo = Proyectil(id=1, x=180.0, y=130.0, dx=0.0, dy=0.0, de_jugador="a")
    ronda = _ronda(jugadores=[_jugador(x=10.0, y=10.0), otro], proyectiles=[disparo])

    avanzar(ronda)

    assert ronda.jugadores["b"].vida == VIDA_JUGADOR


def test_un_proyectil_que_sale_de_la_arena_desaparece():
    disparo = Proyectil(id=1, x=ANCHO_ARENA - 1, y=130.0, dx=1.0, dy=0.0, de_jugador="a")
    ronda = _ronda(proyectiles=[disparo])

    avanzar(ronda)

    assert ronda.proyectiles == []


def test_la_ronda_termina_sin_bots_vivos():
    ronda = _ronda(bots=[Bot(id=0, x=30.0, y=30.0, vida=0)])
    assert ronda_terminada(ronda) is True


def test_la_ronda_termina_sin_jugadores_vivos():
    ronda = _ronda(jugadores=[_jugador(vida=0)], bots=crear_bots(CANTIDAD_BOTS))
    assert ronda_terminada(ronda) is True


def test_la_ronda_termina_al_agotarse_el_tiempo():
    ronda = _ronda(bots=crear_bots(CANTIDAD_BOTS), tick=TICKS_RONDA + 1)
    assert ronda_terminada(ronda) is True


def test_la_ronda_sigue_con_bots_y_jugadores_vivos():
    ronda = _ronda(bots=crear_bots(CANTIDAD_BOTS))
    assert ronda_terminada(ronda) is False


def test_mover_jugador_acepta_una_posicion_libre():
    ronda = _ronda()

    mover_jugador(ronda, "a", 200.0, 120.0)

    assert (ronda.jugadores["a"].x, ronda.jugadores["a"].y) == (200.0, 120.0)


def test_mover_jugador_rechaza_meterse_en_un_muro():
    ronda = _ronda()
    antes = (ronda.jugadores["a"].x, ronda.jugadores["a"].y)

    mover_jugador(ronda, "a", *_centro_muro())

    assert (ronda.jugadores["a"].x, ronda.jugadores["a"].y) == antes


def test_mover_jugador_limita_una_posicion_fuera_de_la_arena():
    """El cliente manda su propia posición: sin límite podría teletransportarse
    fuera del mapa o a coordenadas absurdas."""
    ronda = _ronda()

    mover_jugador(ronda, "a", 99999.0, -99999.0)

    assert ronda.jugadores["a"].x <= ANCHO_ARENA
    assert ronda.jugadores["a"].y >= 0


def test_disparar_jugador_crea_un_proyectil_suyo():
    ronda = _ronda()

    disparar_jugador(ronda, "a", 300.0, 130.0)

    assert len(ronda.proyectiles) == 1
    assert ronda.proyectiles[0].de_jugador == "a"
    assert ronda.proyectiles[0].dx == pytest.approx(1.0)


def test_un_jugador_muerto_no_dispara():
    ronda = _ronda(jugadores=[_jugador(vida=0)])

    disparar_jugador(ronda, "a", 300.0, 130.0)

    assert ronda.proyectiles == []


def test_la_cadencia_limita_los_disparos_seguidos():
    ronda = _ronda()

    disparar_jugador(ronda, "a", 300.0, 130.0)
    disparar_jugador(ronda, "a", 300.0, 130.0)

    assert len(ronda.proyectiles) == 1
