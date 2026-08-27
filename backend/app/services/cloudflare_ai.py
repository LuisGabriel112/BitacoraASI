import io
import json
import re

import httpx
from PIL import Image, UnidentifiedImageError

from app.config import settings

_URL_BASE = "https://api.cloudflare.com/client/v4/accounts/{cuenta}/ai/run/{modelo}"
_MAX_TOKENS_EXTRACCION = 768
# response_format:json_schema no se respeta siempre con este modelo -- a veces
# devuelve puro texto sin nada de JSON (confirmado empíricamente: con imágenes
# reales de captura la falla es más frecuente que con una imagen trivial de
# prueba). Es una falla de contenido, no de red, así que vale la pena
# reintentar con una llamada nueva en vez de fallar de una vez.
_REINTENTOS_JSON = 3
_INSTRUCCION_JSON = (
    "IMPORTANTE: responde ÚNICAMENTE con un objeto JSON válido, empezando en '{' y "
    "terminando en '}'. No escribas explicaciones, comentarios, listas ni bloques de "
    "markdown (nada de ```) antes o después del JSON.\n\n"
)


class CloudflareAIError(Exception):
    pass


def cloudflare_configurado() -> bool:
    return bool(settings.cloudflare_account_id and settings.cloudflare_api_token)


def _normalizar_imagen(imagen: bytes) -> bytes:
    try:
        with Image.open(io.BytesIO(imagen)) as img:
            if img.mode not in ("RGB", "RGBA"):
                img = img.convert("RGBA" if "A" in img.getbands() else "RGB")
            buf = io.BytesIO()
            img.save(buf, format="PNG")
            return buf.getvalue()
    except UnidentifiedImageError as exc:
        cabecera = imagen[:12].hex()
        raise CloudflareAIError(f"El archivo no se pudo leer como imagen ({len(imagen)} bytes, cabecera {cabecera})") from exc


def _lista(titulo: str, items: list) -> str:
    filas = "\n".join(f"{item.id}: {item.nombre}" for item in items)
    return f"{titulo} disponibles (id: nombre):\n{filas}"


def _extraer_json_de_texto(texto: str) -> dict | None:
    # A veces el modelo antepone prosa y envuelve el JSON en un fence de markdown
    # en vez de devolverlo ya parseado -- se recupera con una búsqueda simple.
    coincidencia = re.search(r"\{.*\}", texto, re.DOTALL)
    if not coincidencia:
        return None
    try:
        return json.loads(coincidencia.group(0))
    except json.JSONDecodeError:
        return None


async def _pedir(modelo: str, body: dict) -> httpx.Response:
    url = _URL_BASE.format(cuenta=settings.cloudflare_account_id, modelo=modelo)
    headers = {"Authorization": f"Bearer {settings.cloudflare_api_token}"}
    async with httpx.AsyncClient(timeout=30) as client:
        try:
            return await client.post(url, headers=headers, json=body)
        except httpx.RequestError as exc:
            raise CloudflareAIError(f"No se pudo conectar con Cloudflare Workers AI: {exc}") from exc


async def _pedir_json(modelo: str, body: dict) -> dict | None:
    """Un intento. Devuelve None (en vez de lanzar) cuando la respuesta no trae
    JSON aprovechable, para que el llamador decida si vale la pena reintentar."""
    resp = await _pedir(modelo, body)
    if resp.status_code >= 400:
        raise CloudflareAIError(f"Cloudflare Workers AI respondió {resp.status_code}: {resp.text[:300]}")

    data = resp.json()
    if not data.get("success", True):
        raise CloudflareAIError(f"Cloudflare Workers AI reportó error: {data.get('errors')}")

    resultado = data.get("result", {}).get("response")
    if isinstance(resultado, str):
        resultado = _extraer_json_de_texto(resultado)
    return resultado if isinstance(resultado, dict) else None


async def _generar_json(imagen: bytes, prompt: str, schema: dict) -> dict:
    if not cloudflare_configurado():
        raise CloudflareAIError("Cloudflare Workers AI no está configurado (falta CLOUDFLARE_ACCOUNT_ID/CLOUDFLARE_API_TOKEN)")

    imagen_png = _normalizar_imagen(imagen)
    body = {
        "prompt": prompt,
        "image": list(imagen_png),
        "max_tokens": _MAX_TOKENS_EXTRACCION,
        "response_format": {"type": "json_schema", "json_schema": schema},
    }
    for _ in range(_REINTENTOS_JSON + 1):
        resultado = await _pedir_json(settings.cloudflare_vision_model, body)
        if resultado is not None:
            return resultado

    raise CloudflareAIError("Cloudflare Workers AI no devolvió un JSON válido tras varios intentos")


_SCHEMA_REGISTRO = {
    "type": "object",
    "properties": {
        "fecha": {"type": "string"},
        "descripcion": {"type": "string"},
        "empresa_id": {"type": "integer"},
        "sistema_id": {"type": "integer"},
        "medio_id": {"type": "integer"},
        "modulo_id": {"type": "integer"},
        "atendio_id": {"type": "integer"},
    },
}


def _prompt_registro(catalogos: dict[str, list]) -> str:
    return (
        _INSTRUCCION_JSON
        + "Analiza esta captura de pantalla de un reporte o ticket de soporte técnico. "
        "Extrae la información para llenar un formulario de bitácora de soporte.\n\n"
        "Para empresa_id, sistema_id, medio_id, modulo_id y atendio_id: elige el id EXACTO de la lista "
        "correspondiente que mejor coincida con lo que aparece en la imagen. Si no hay una coincidencia "
        "razonable, usa 0 — nunca inventes un id que no esté en la lista.\n\n"
        "fecha: formato YYYY-MM-DD si aparece en la imagen, si no usa cadena vacía.\n"
        "descripcion: resume en español, en 1-3 frases, qué se reportó y qué se hizo (si aparece).\n\n"
        + _lista("Empresas", catalogos["empresas"]) + "\n\n"
        + _lista("Sistemas", catalogos["sistemas"]) + "\n\n"
        + _lista("Medios", catalogos["medios"]) + "\n\n"
        + _lista("Módulos", catalogos["modulos"]) + "\n\n"
        + _lista("Agentes (quién atendió)", catalogos["agentes"])
    )


async def extraer_registro(imagen: bytes, catalogos: dict[str, list]) -> dict:
    return await _generar_json(imagen, _prompt_registro(catalogos), _SCHEMA_REGISTRO)


_SCHEMA_MESA = {
    "type": "object",
    "properties": {
        "codigo": {"type": "string"},
        "titulo": {"type": "string"},
        "fecha_carga": {"type": "string"},
        "descripcion": {"type": "string"},
        "solicitante_id": {"type": "integer"},
    },
}


def _prompt_mesa(catalogos: dict[str, list]) -> str:
    return (
        _INSTRUCCION_JSON
        + "Analiza esta captura de pantalla de una mesa de ayuda de Proactivanet. "
        "Extrae la información para abrir una mesa en la bitácora administrativa.\n\n"
        "Para solicitante_id: elige el id EXACTO de la lista correspondiente que mejor coincida con quién "
        "levantó la mesa. Si no hay una coincidencia razonable, usa 0 — nunca inventes un id que no esté "
        "en la lista.\n\n"
        "codigo: el código o folio de la mesa tal como aparece.\n"
        "titulo: el título de la mesa.\n"
        "fecha_carga: formato YYYY-MM-DD HH:MM (24 horas) si aparece fecha y hora en la imagen; "
        "si solo aparece la fecha, usa HH:MM = 00:00; si no aparece nada, usa cadena vacía.\n"
        "descripcion: resume en español, en 1-3 frases, qué se reportó.\n\n"
        + _lista("Solicitantes", catalogos["solicitantes"])
    )


async def extraer_mesa(imagen: bytes, catalogos: dict[str, list]) -> dict:
    return await _generar_json(imagen, _prompt_mesa(catalogos), _SCHEMA_MESA)
