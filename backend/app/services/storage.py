import uuid
from pathlib import Path

import httpx

from app.config import settings

TIMEOUT_SUBIDA = httpx.Timeout(30.0)


class StorageError(Exception):
    pass


def generar_key_archivo(nombre_original: str) -> str:
    """uuid4 + extensión original — nunca el nombre tal cual (evita colisiones y
    problemas de espacios/acentos en la URL; el nombre original se muestra en la UI
    aparte, guardado como columna independiente)."""
    extension = Path(nombre_original).suffix
    return f"{uuid.uuid4()}{extension}"


async def crear_url_subida(nombre_archivo: str, content_type: str) -> tuple[str, str]:
    """Devuelve (url_de_subida_firmada, url_publica_final). El navegador sube el
    archivo directo a Supabase con la primera URL — el backend nunca ve los bytes.
    Sin whitelist de content-type: el chat acepta cualquier tipo de archivo."""
    key = generar_key_archivo(nombre_archivo)
    bucket = settings.chat_bucket

    async with httpx.AsyncClient(timeout=TIMEOUT_SUBIDA) as client:
        respuesta = await client.post(
            f"{settings.supabase_url}/storage/v1/object/upload/sign/{bucket}/{key}",
            headers={
                "Authorization": f"Bearer {settings.supabase_service_key}",
                "apikey": settings.supabase_service_key,
            },
        )

    if respuesta.status_code >= 400:
        raise StorageError(f"No se pudo generar la URL de subida: {respuesta.text}")

    ruta_firmada = respuesta.json()["url"]
    url_subida = f"{settings.supabase_url}/storage/v1{ruta_firmada}"
    url_publica = f"{settings.supabase_url}/storage/v1/object/public/{bucket}/{key}"
    return url_subida, url_publica
