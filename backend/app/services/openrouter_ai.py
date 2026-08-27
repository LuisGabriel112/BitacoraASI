import asyncio
import base64
import io
import json
import re

import httpx
from PIL import Image, UnidentifiedImageError

from app.config import settings

_URL = "https://openrouter.ai/api/v1/chat/completions"
_MAX_TOKENS_EXTRACCION = 600
_ESPERA_BASE_SEGUNDOS = 5
_CODIGOS_REINTENTABLES = {429, 503}
# El modelo no siempre respeta response_format:json_schema -- a veces devuelve
# texto sin JSON aprovechable, o la capa gratuita responde 429 por saturación.
# Ninguno de los dos es un error del request, así que vale la pena reintentar.
_REINTENTOS = 3


class OpenRouterAIError(Exception):
    pass


def openrouter_configurado() -> bool:
    return bool(settings.openrouter_api_key)


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
        raise OpenRouterAIError(f"El archivo no se pudo leer como imagen ({len(imagen)} bytes, cabecera {cabecera})") from exc


def _lista(titulo: str, items: list) -> str:
    filas = "\n".join(f"{item.id}: {item.nombre}" for item in items)
    return f"{titulo} disponibles (id: nombre):\n{filas}"


def _extraer_json_de_texto(texto: str) -> dict | None:
    coincidencia = re.search(r"\{.*\}", texto, re.DOTALL)
    if not coincidencia:
        return None
    try:
        return json.loads(coincidencia.group(0))
    except json.JSONDecodeError:
        return None


async def _pedir(body: dict) -> httpx.Response:
    headers = {"Authorization": f"Bearer {settings.openrouter_api_key}"}
    async with httpx.AsyncClient(timeout=60) as client:
        try:
            return await client.post(_URL, headers=headers, json=body)
        except httpx.RequestError as exc:
            raise OpenRouterAIError(f"No se pudo conectar con OpenRouter: {exc}") from exc


async def _intentar(body: dict) -> dict | None:
    """Un intento. None = reintentable (429/503 o sin JSON aprovechable).
    Lanza de inmediato en errores duros (4xx/5xx que no son transitorios)."""
    resp = await _pedir(body)
    if resp.status_code in _CODIGOS_REINTENTABLES:
        return None
    if resp.status_code >= 400:
        raise OpenRouterAIError(f"OpenRouter respondió {resp.status_code}: {resp.text[:300]}")

    data = resp.json()
    try:
        contenido = data["choices"][0]["message"]["content"]
    except (KeyError, IndexError) as exc:
        raise OpenRouterAIError("Respuesta de OpenRouter sin contenido") from exc

    if not isinstance(contenido, str):
        return None
    return _extraer_json_de_texto(contenido)


async def _generar_json(imagen: bytes, prompt: str, schema: dict) -> dict:
    if not openrouter_configurado():
        raise OpenRouterAIError("OpenRouter no está configurado (falta OPENROUTER_API_KEY)")

    imagen_b64 = base64.b64encode(_normalizar_imagen(imagen)).decode()
    body = {
        "model": settings.openrouter_vision_model,
        "messages": [
            {
                "role": "user",
                "content": [
                    {"type": "text", "text": prompt},
                    {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{imagen_b64}"}},
                ],
            }
        ],
        "response_format": {
            "type": "json_schema",
            "json_schema": {"name": "extraccion", "schema": schema, "strict": True},
        },
        "max_tokens": _MAX_TOKENS_EXTRACCION,
    }

    for intento in range(_REINTENTOS + 1):
        if intento > 0:
            await asyncio.sleep(_ESPERA_BASE_SEGUNDOS * intento)
        resultado = await _intentar(body)
        if resultado is not None:
            return resultado

    raise OpenRouterAIError("OpenRouter no devolvió un JSON válido tras varios intentos")


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
    "required": ["fecha", "descripcion", "empresa_id", "sistema_id", "medio_id", "modulo_id", "atendio_id"],
}

_INSTRUCCION_JSON = (
    "IMPORTANTE: responde ÚNICAMENTE con un objeto JSON válido, empezando en '{' y "
    "terminando en '}'. No escribas explicaciones, comentarios, listas ni bloques de "
    "markdown (nada de ```) antes o después del JSON.\n\n"
)


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
    "required": ["codigo", "titulo", "fecha_carga", "descripcion", "solicitante_id"],
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
