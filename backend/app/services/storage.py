import uuid
from pathlib import Path

import httpx

from app.config import settings

TIMEOUT_SUBIDA = httpx.Timeout(30.0)


class StorageError(Exception):
    pass


def generar_key_archivo(nombre_original: str, carpeta: str = "") -> str:
    """uuid4 + extensión original — nunca el nombre tal cual (evita colisiones y
    problemas de espacios/acentos en la URL; el nombre original se muestra en la UI
    aparte, guardado como columna independiente). `carpeta` agrupa dentro del
    bucket (p. ej. "sonidos/") para no mezclar con los adjuntos del chat."""
    extension = Path(nombre_original).suffix
    carpeta_limpia = carpeta.strip().strip("/")
    prefijo = f"{carpeta_limpia}/" if carpeta_limpia else ""
    return f"{prefijo}{uuid.uuid4()}{extension}"


async def crear_url_subida(nombre_archivo: str, content_type: str, carpeta: str = "") -> tuple[str, str]:
    """Devuelve (url_de_subida_firmada, url_publica_final). El navegador sube el
    archivo directo a Supabase con la primera URL — el backend nunca ve los bytes.
    Sin whitelist de content-type: el chat acepta cualquier tipo de archivo."""
    if not settings.supabase_url or not settings.supabase_service_key:
        raise StorageError("Almacenamiento de archivos no configurado (SUPABASE_URL / SUPABASE_SERVICE_KEY)")

    key = generar_key_archivo(nombre_archivo, carpeta)
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
