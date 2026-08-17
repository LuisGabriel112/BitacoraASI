from datetime import datetime, timedelta, timezone

from app.services.cooldown import puede_jugar, tiempo_restante

AHORA = datetime(2026, 8, 14, 12, 0, tzinfo=timezone.utc)
COOLDOWN = timedelta(minutes=5)


def test_primer_intento_siempre_puede_jugar():
    assert puede_jugar(None, AHORA, COOLDOWN) is True


def test_no_puede_jugar_si_intento_hace_menos_del_cooldown():
    hace_2_min = AHORA - timedelta(minutes=2)
    assert puede_jugar(hace_2_min, AHORA, COOLDOWN) is False


def test_tiempo_restante_correcto_a_los_2_minutos():
    hace_2_min = AHORA - timedelta(minutes=2)
    assert tiempo_restante(hace_2_min, AHORA, COOLDOWN) == timedelta(minutes=3)


def test_puede_jugar_justo_al_cumplirse_el_cooldown():
    hace_exactamente_el_cooldown = AHORA - COOLDOWN
    assert puede_jugar(hace_exactamente_el_cooldown, AHORA, COOLDOWN) is True


def test_puede_jugar_despues_de_pasado_el_cooldown():
    hace_10_min = AHORA - timedelta(minutes=10)
    assert puede_jugar(hace_10_min, AHORA, COOLDOWN) is True


def test_tiempo_restante_nunca_es_negativo():
    hace_10_min = AHORA - timedelta(minutes=10)
    assert tiempo_restante(hace_10_min, AHORA, COOLDOWN) == timedelta(0)


def test_cooldowns_distintos_son_independientes():
    hace_2_min = AHORA - timedelta(minutes=2)
    assert puede_jugar(hace_2_min, AHORA, timedelta(minutes=1)) is True
    assert puede_jugar(hace_2_min, AHORA, timedelta(minutes=10)) is False
