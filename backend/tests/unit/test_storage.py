import httpx
import pytest

from app.services import storage as storage_module
from app.services.storage import StorageError, crear_url_subida, generar_key_archivo


class _ClienteFalso:
    def __init__(self, respuesta: httpx.Response):
        self._respuesta = respuesta
        self.llamadas = 0

    async def post(self, *_args, **_kwargs):
        self.llamadas += 1
        return self._respuesta

    async def __aenter__(self):
        return self

    async def __aexit__(self, *_exc):
        return False


@pytest.fixture(autouse=True)
def _config_supabase(monkeypatch):
    monkeypatch.setattr(storage_module.settings, "supabase_url", "https://proyecto.supabase.co")
    monkeypatch.setattr(storage_module.settings, "supabase_service_key", "clave-de-prueba")
    monkeypatch.setattr(storage_module.settings, "chat_bucket", "chat-adjuntos")


def test_key_conserva_la_extension_original():
    key = generar_key_archivo("captura de pantalla áéí.PNG")
    assert key.endswith(".PNG")
    assert " " not in key


def test_dos_keys_del_mismo_nombre_no_colisionan():
    assert generar_key_archivo("captura.png") != generar_key_archivo("captura.png")


@pytest.mark.asyncio
async def test_cualquier_content_type_genera_url_de_subida(monkeypatch):
    respuesta = httpx.Response(200, json={"url": "/object/upload/sign/chat-adjuntos/abc123.html?token=xyz"})
    cliente = _ClienteFalso(respuesta)
    monkeypatch.setattr(storage_module.httpx, "AsyncClient", lambda **_kwargs: cliente)

    url_subida, url_publica = await crear_url_subida("notas.html", "text/html")

    assert url_subida.endswith("abc123.html?token=xyz")
    assert cliente.llamadas == 1


@pytest.mark.asyncio
async def test_content_type_permitido_genera_url_de_subida_y_publica(monkeypatch):
    respuesta = httpx.Response(200, json={"url": "/object/upload/sign/chat-adjuntos/abc123.png?token=xyz"})
    cliente = _ClienteFalso(respuesta)
    monkeypatch.setattr(storage_module.httpx, "AsyncClient", lambda **_kwargs: cliente)

    url_subida, url_publica = await crear_url_subida("captura.png", "image/png")

    assert url_subida == "https://proyecto.supabase.co/storage/v1/object/upload/sign/chat-adjuntos/abc123.png?token=xyz"
    assert url_publica.startswith("https://proyecto.supabase.co/storage/v1/object/public/chat-adjuntos/")
    assert url_publica.endswith(".png")
    assert cliente.llamadas == 1


@pytest.mark.asyncio
async def test_error_de_supabase_se_traduce_a_storage_error(monkeypatch):
    cliente = _ClienteFalso(httpx.Response(403, text="forbidden"))
    monkeypatch.setattr(storage_module.httpx, "AsyncClient", lambda **_kwargs: cliente)

    with pytest.raises(StorageError):
        await crear_url_subida("captura.png", "image/png")
