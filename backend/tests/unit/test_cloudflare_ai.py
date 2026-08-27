from types import SimpleNamespace
from unittest.mock import AsyncMock

import pytest

from app.services import cloudflare_ai
from app.services.cloudflare_ai import CloudflareAIError, _generar_json


def _resp(status_code: int, cuerpo: dict, texto: str = "") -> SimpleNamespace:
    respuesta = SimpleNamespace(status_code=status_code, text=texto or str(cuerpo))
    respuesta.json = lambda: cuerpo
    return respuesta


@pytest.fixture(autouse=True)
def _configurado(monkeypatch):
    monkeypatch.setattr(cloudflare_ai.settings, "cloudflare_account_id", "cuenta-de-prueba")
    monkeypatch.setattr(cloudflare_ai.settings, "cloudflare_api_token", "token-de-prueba")
    monkeypatch.setattr(cloudflare_ai, "_normalizar_imagen", lambda imagen: imagen)


@pytest.mark.asyncio
async def test_devuelve_el_json_ya_parseado_de_la_respuesta(monkeypatch):
    esperado = {"titulo": "Falla de red", "descripcion": "Se perdió la conexión"}
    pedir = AsyncMock(return_value=_resp(200, {"success": True, "result": {"response": esperado}}))
    monkeypatch.setattr(cloudflare_ai, "_pedir", pedir)

    resultado = await _generar_json(b"png-falso", "prompt", {"type": "object"})

    assert resultado == esperado
    pedir.assert_awaited_once()


@pytest.mark.asyncio
async def test_error_http_lanza_cloudflare_ai_error(monkeypatch):
    pedir = AsyncMock(return_value=_resp(500, {}, texto="internal error"))
    monkeypatch.setattr(cloudflare_ai, "_pedir", pedir)

    with pytest.raises(CloudflareAIError, match="500"):
        await _generar_json(b"png-falso", "prompt", {"type": "object"})


@pytest.mark.asyncio
async def test_success_false_lanza_cloudflare_ai_error_con_detalle(monkeypatch):
    cuerpo = {"success": False, "errors": [{"message": "modelo no disponible"}]}
    pedir = AsyncMock(return_value=_resp(200, cuerpo))
    monkeypatch.setattr(cloudflare_ai, "_pedir", pedir)

    with pytest.raises(CloudflareAIError, match="modelo no disponible"):
        await _generar_json(b"png-falso", "prompt", {"type": "object"})


@pytest.mark.asyncio
async def test_respuesta_con_texto_y_json_en_fence_markdown_se_recupera(monkeypatch):
    cuerpo = {"success": True, "result": {"response": "Aquí tienes:\n\n```json\n{\"a\": 1}\n```"}}
    pedir = AsyncMock(return_value=_resp(200, cuerpo))
    monkeypatch.setattr(cloudflare_ai, "_pedir", pedir)

    resultado = await _generar_json(b"png-falso", "prompt", {"type": "object"})

    assert resultado == {"a": 1}


@pytest.mark.asyncio
async def test_respuesta_de_puro_texto_sin_json_agota_reintentos_y_lanza_error(monkeypatch):
    cuerpo = {"success": True, "result": {"response": "No pude leer la imagen."}}
    pedir = AsyncMock(return_value=_resp(200, cuerpo))
    monkeypatch.setattr(cloudflare_ai, "_pedir", pedir)

    with pytest.raises(CloudflareAIError, match="JSON válido"):
        await _generar_json(b"png-falso", "prompt", {"type": "object"})

    assert pedir.await_count == cloudflare_ai._REINTENTOS_JSON + 1


@pytest.mark.asyncio
async def test_reintenta_cuando_el_primer_intento_no_trae_json_y_el_segundo_si(monkeypatch):
    esperado = {"titulo": "ok"}
    pedir = AsyncMock(
        side_effect=[
            _resp(200, {"success": True, "result": {"response": "No pude leer la imagen."}}),
            _resp(200, {"success": True, "result": {"response": esperado}}),
        ]
    )
    monkeypatch.setattr(cloudflare_ai, "_pedir", pedir)

    resultado = await _generar_json(b"png-falso", "prompt", {"type": "object"})

    assert resultado == esperado
    assert pedir.await_count == 2


@pytest.mark.asyncio
async def test_sin_credenciales_lanza_error_de_configuracion(monkeypatch):
    monkeypatch.setattr(cloudflare_ai.settings, "cloudflare_account_id", "")

    with pytest.raises(CloudflareAIError, match="no está configurado"):
        await _generar_json(b"png-falso", "prompt", {"type": "object"})
