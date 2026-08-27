from types import SimpleNamespace
from unittest.mock import AsyncMock

import pytest

from app.services import gemini
from app.services.gemini import GeminiError, _llamar_generate_content


def _resp(status_code: int, texto: str = "ok", cuerpo_error: str = "") -> SimpleNamespace:
    respuesta = SimpleNamespace(status_code=status_code, text=cuerpo_error)
    respuesta.json = lambda: {"candidates": [{"content": {"parts": [{"text": texto}]}}]}
    return respuesta


@pytest.fixture(autouse=True)
def _configurado(monkeypatch):
    monkeypatch.setattr(gemini.settings, "gemini_api_key", "clave-de-prueba")
    monkeypatch.setattr(gemini, "_ESPERA_BASE_SEGUNDOS", 0)


@pytest.mark.asyncio
async def test_reintenta_en_503_y_devuelve_el_resultado_del_segundo_intento(monkeypatch):
    pedir = AsyncMock(side_effect=[_resp(503, cuerpo_error="overloaded"), _resp(200, texto="listo")])
    monkeypatch.setattr(gemini, "_pedir_generate_content", pedir)

    texto = await _llamar_generate_content({"contents": []})

    assert texto == "listo"
    assert pedir.await_count == 2


@pytest.mark.asyncio
async def test_sigue_reintentando_en_429_como_antes(monkeypatch):
    pedir = AsyncMock(side_effect=[_resp(429), _resp(200, texto="listo")])
    monkeypatch.setattr(gemini, "_pedir_generate_content", pedir)

    texto = await _llamar_generate_content({"contents": []})

    assert texto == "listo"
    assert pedir.await_count == 2


@pytest.mark.asyncio
async def test_503_persistente_agota_reintentos_y_lanza_error(monkeypatch):
    pedir = AsyncMock(return_value=_resp(503, cuerpo_error="overloaded"))
    monkeypatch.setattr(gemini, "_pedir_generate_content", pedir)

    with pytest.raises(GeminiError, match="503"):
        await _llamar_generate_content({"contents": []})

    assert pedir.await_count == gemini._REINTENTOS_429 + 1


@pytest.mark.asyncio
async def test_400_no_se_reintenta(monkeypatch):
    pedir = AsyncMock(return_value=_resp(400, cuerpo_error="bad request"))
    monkeypatch.setattr(gemini, "_pedir_generate_content", pedir)

    with pytest.raises(GeminiError, match="400"):
        await _llamar_generate_content({"contents": []})

    pedir.assert_awaited_once()
