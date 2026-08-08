from datetime import datetime, timedelta, timezone

import jwt

from app.config import settings
from app.services.auth import (
    ALGORITMO,
    crear_token,
    debe_bloquear,
    esta_en_linea,
    hash_pin,
    leer_token,
    normalizar_nombre,
    sigue_bloqueado,
    verificar_pin,
)


def test_pin_correcto_verifica_contra_su_hash():
    hash_guardado = hash_pin("1234")
    assert verificar_pin("1234", hash_guardado) is True


def test_pin_incorrecto_no_verifica():
    hash_guardado = hash_pin("1234")
    assert verificar_pin("9999", hash_guardado) is False


def test_token_recien_creado_se_lee_de_vuelta():
    token = crear_token(42)
    assert leer_token(token) == 42


def test_token_vencido_no_es_valido():
    payload = {"usuario_id": 1, "exp": datetime.now(timezone.utc) - timedelta(days=1)}
    token = jwt.encode(payload, settings.secret_key, algorithm=ALGORITMO)
    assert leer_token(token) is None


def test_token_con_firma_invalida_no_es_valido():
    assert leer_token("esto.no es.un token valido") is None


def test_cinco_intentos_fallidos_debe_bloquear():
    assert debe_bloquear(5) is True


def test_menos_de_cinco_intentos_no_debe_bloquear():
    assert debe_bloquear(4) is False


def test_sigue_bloqueado_mientras_no_pase_el_tiempo():
    ahora = datetime.now(timezone.utc)
    bloqueado_hasta = ahora + timedelta(minutes=5)
    assert sigue_bloqueado(bloqueado_hasta, ahora) is True


def test_ya_no_sigue_bloqueado_cuando_el_bloqueo_vencio():
    ahora = datetime.now(timezone.utc)
    bloqueado_hasta = ahora - timedelta(seconds=1)
    assert sigue_bloqueado(bloqueado_hasta, ahora) is False


def test_sin_bloqueo_previo_no_esta_bloqueado():
    assert sigue_bloqueado(None, datetime.now(timezone.utc)) is False


def test_normalizar_nombre_ignora_espacios_y_mayusculas():
    assert normalizar_nombre("  Juan Pérez  ") == normalizar_nombre("juan   pérez")


def test_actividad_reciente_esta_en_linea():
    ahora = datetime.now(timezone.utc)
    ultima_actividad = ahora - timedelta(seconds=10)
    assert esta_en_linea(ultima_actividad, ahora) is True


def test_actividad_vieja_no_esta_en_linea():
    ahora = datetime.now(timezone.utc)
    ultima_actividad = ahora - timedelta(minutes=5)
    assert esta_en_linea(ultima_actividad, ahora, umbral_segundos=90) is False


def test_justo_en_el_umbral_ya_no_esta_en_linea():
    ahora = datetime.now(timezone.utc)
    ultima_actividad = ahora - timedelta(seconds=90)
    assert esta_en_linea(ultima_actividad, ahora, umbral_segundos=90) is False


def test_sin_actividad_nunca_no_esta_en_linea():
    assert esta_en_linea(None, datetime.now(timezone.utc)) is False
