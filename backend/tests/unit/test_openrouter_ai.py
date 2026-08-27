from types import SimpleNamespace
from unittest.mock import AsyncMock

import pytest

from app.services import openrouter_ai
from app.services.openrouter_ai import OpenRouterAIError, _generar_json


def _resp(status_code: int, contenido: str = "", texto: str = "") -> SimpleNamespace:
    cuerpo = {"choices": [{"message": {"content": contenido}}]}
    respuesta = SimpleNamespace(status_code=status_code, text=texto or contenido)
    respuesta.json = lambda: cuerpo
    return respuesta


@pytest.fixture(autouse=True)
def _configurado(monkeypatch):
    monkeypatch.setattr(openrouter_ai.settings, "openrouter_api_key", "clave-de-prueba")
    monkeypatch.setattr(openrouter_ai, "_normalizar_imagen", lambda imagen: imagen)
    monkeypatch.setattr(openrouter_ai, "_ESPERA_BASE_SEGUNDOS", 0)


@pytest.mark.asyncio
async def test_devuelve_el_json_del_contenido(monkeypatch):
    pedir = AsyncMock(return_value=_resp(200, contenido='{"titulo": "ok"}'))
    monkeypatch.setattr(openrouter_ai, "_pedir", pedir)

    resultado = await _generar_json(b"png-falso", "prompt", {"type": "object"})

    assert resultado == {"titulo": "ok"}
    pedir.assert_awaited_once()


@pytest.mark.asyncio
async def test_error_http_duro_lanza_de_inmediato_sin_reintentar(monkeypatch):
    pedir = AsyncMock(return_value=_resp(400, texto="bad request"))
    monkeypatch.setattr(openrouter_ai, "_pedir", pedir)

    with pytest.raises(OpenRouterAIError, match="400"):
        await _generar_json(b"png-falso", "prompt", {"type": "object"})

    pedir.assert_awaited_once()


@pytest.mark.asyncio
async def test_429_se_reintenta_y_el_segundo_intento_responde_bien(monkeypatch):
    pedir = AsyncMock(
        side_effect=[
            _resp(429, texto="rate limited"),
            _resp(200, contenido='{"titulo": "ok"}'),
        ]
    )
    monkeypatch.setattr(openrouter_ai, "_pedir", pedir)

    resultado = await _generar_json(b"png-falso", "prompt", {"type": "object"})

    assert resultado == {"titulo": "ok"}
    assert pedir.await_count == 2


@pytest.mark.asyncio
async def test_json_envuelto_en_fence_markdown_se_recupera(monkeypatch):
    pedir = AsyncMock(return_value=_resp(200, contenido='Aquí tienes:\n\n```json\n{"a": 1}\n```'))
    monkeypatch.setattr(openrouter_ai, "_pedir", pedir)

    resultado = await _generar_json(b"png-falso", "prompt", {"type": "object"})

    assert resultado == {"a": 1}


@pytest.mark.asyncio
async def test_puro_texto_sin_json_agota_reintentos_y_lanza_error(monkeypatch):
    pedir = AsyncMock(return_value=_resp(200, contenido="No pude leer la imagen."))
    monkeypatch.setattr(openrouter_ai, "_pedir", pedir)

    with pytest.raises(OpenRouterAIError, match="JSON válido"):
        await _generar_json(b"png-falso", "prompt", {"type": "object"})

    assert pedir.await_count == openrouter_ai._REINTENTOS + 1


@pytest.mark.asyncio
async def test_sin_credenciales_lanza_error_de_configuracion(monkeypatch):
    monkeypatch.setattr(openrouter_ai.settings, "openrouter_api_key", "")

    with pytest.raises(OpenRouterAIError, match="no está configurado"):
        await _generar_json(b"png-falso", "prompt", {"type": "object"})
