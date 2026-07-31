from types import SimpleNamespace
from unittest.mock import AsyncMock

import httpx
import pytest

from app.services import embeddings as embeddings_module
from app.services.gemini import GeminiError


class _ClienteFalso:
    """Sustituye httpx.AsyncClient: entrega las respuestas dadas, en orden, por cada .post()."""

    def __init__(self, respuestas):
        self._respuestas = iter(respuestas)
        self.llamadas = 0

    async def post(self, *_args, **_kwargs):
        self.llamadas += 1
        return next(self._respuestas)

    async def __aenter__(self):
        return self

    async def __aexit__(self, *_exc):
        return False


def _registro(id_: int, descripcion: str, embedding: list[float] | None = None) -> SimpleNamespace:
    return SimpleNamespace(id=id_, descripcion=descripcion, embedding=embedding)


def _respuesta_ok(valores: list[float]) -> httpx.Response:
    return httpx.Response(200, json={"embedding": {"values": valores}})


def _respuesta_429() -> httpx.Response:
    return httpx.Response(429, json={"error": {"message": "cuota excedida"}})


async def _sin_espera(*_args, **_kwargs) -> None:
    return None


@pytest.fixture(autouse=True)
def _gemini_configurado(monkeypatch):
    monkeypatch.setattr(embeddings_module.settings, "gemini_api_key", "clave-de-prueba")


@pytest.fixture(autouse=True)
def _sin_esperas_reales(monkeypatch):
    monkeypatch.setattr(embeddings_module.asyncio, "sleep", _sin_espera)


def _usar_cliente_falso(monkeypatch, respuestas: list[httpx.Response]) -> _ClienteFalso:
    cliente = _ClienteFalso(respuestas)
    monkeypatch.setattr(embeddings_module.httpx, "AsyncClient", lambda **_kwargs: cliente)
    return cliente


@pytest.mark.asyncio
async def test_falla_si_gemini_no_esta_configurado(monkeypatch):
    monkeypatch.setattr(embeddings_module.settings, "gemini_api_key", "")

    with pytest.raises(GeminiError, match="no está configurado"):
        await embeddings_module.obtener_embeddings(["texto"])


@pytest.mark.asyncio
async def test_error_de_red_se_traduce_a_gemini_error(monkeypatch):
    class _ClienteQueFalla:
        async def post(self, *_args, **_kwargs):
            raise httpx.RequestError("timeout de red")

        async def __aenter__(self):
            return self

        async def __aexit__(self, *_exc):
            return False

    monkeypatch.setattr(embeddings_module.httpx, "AsyncClient", lambda **_kwargs: _ClienteQueFalla())

    with pytest.raises(GeminiError, match="No se pudo conectar"):
        await embeddings_module.obtener_embeddings(["texto"])


@pytest.mark.asyncio
async def test_reintenta_ante_429_y_finalmente_obtiene_embedding(monkeypatch):
    cliente = _usar_cliente_falso(monkeypatch, [_respuesta_429(), _respuesta_429(), _respuesta_ok([0.1, 0.2])])

    resultado = await embeddings_module.obtener_embeddings(["texto"])

    assert resultado == [[0.1, 0.2]]
    assert cliente.llamadas == 3


@pytest.mark.asyncio
async def test_lanza_error_cuando_se_agotan_los_reintentos(monkeypatch):
    total_intentos = embeddings_module._REINTENTOS_429 + 1
    cliente = _usar_cliente_falso(monkeypatch, [_respuesta_429() for _ in range(total_intentos)])

    with pytest.raises(GeminiError, match="429"):
        await embeddings_module.obtener_embeddings(["texto"])

    assert cliente.llamadas == total_intentos


@pytest.mark.asyncio
async def test_asegurar_embeddings_solo_pide_los_faltantes(monkeypatch):
    registros = [_registro(1, "a", [0.1]), _registro(2, "b", None), _registro(3, "c", [0.3])]
    obtener_mock = AsyncMock(return_value=[[0.2]])
    monkeypatch.setattr(embeddings_module, "obtener_embeddings", obtener_mock)
    session = AsyncMock()

    resultado = await embeddings_module.asegurar_embeddings(session, registros)

    obtener_mock.assert_awaited_once_with(["b"])
    assert resultado == [[0.1], [0.2], [0.3]]


@pytest.mark.asyncio
async def test_asegurar_embeddings_cachea_varios_faltantes_en_una_sola_sentencia(monkeypatch):
    """Con 2+ faltantes, debe haber un único UPDATE en bloque, no uno por registro (evita N round-trips)."""
    registros = [_registro(1, "a", None), _registro(2, "b", None), _registro(3, "c", [0.3])]
    obtener_mock = AsyncMock(return_value=[[0.1], [0.2]])
    monkeypatch.setattr(embeddings_module, "obtener_embeddings", obtener_mock)
    session = AsyncMock()

    resultado = await embeddings_module.asegurar_embeddings(session, registros)

    assert resultado == [[0.1], [0.2], [0.3]]
    session.execute.assert_awaited_once()
    session.commit.assert_awaited_once()


@pytest.mark.asyncio
async def test_asegurar_embeddings_no_llama_a_gemini_si_todo_esta_cacheado(monkeypatch):
    registros = [_registro(1, "a", [0.1]), _registro(2, "b", [0.2])]
    obtener_mock = AsyncMock()
    monkeypatch.setattr(embeddings_module, "obtener_embeddings", obtener_mock)
    session = AsyncMock()

    resultado = await embeddings_module.asegurar_embeddings(session, registros)

    obtener_mock.assert_not_awaited()
    session.execute.assert_not_awaited()
    session.commit.assert_not_awaited()
    assert resultado == [[0.1], [0.2]]
