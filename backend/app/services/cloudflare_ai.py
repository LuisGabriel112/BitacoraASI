import io

import httpx
from PIL import Image, UnidentifiedImageError

from app.config import settings

_URL_BASE = "https://api.cloudflare.com/client/v4/accounts/{cuenta}/ai/run/{modelo}"
_MAX_TOKENS_EXTRACCION = 512


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


async def _pedir(modelo: str, body: dict) -> httpx.Response:
    url = _URL_BASE.format(cuenta=settings.cloudflare_account_id, modelo=modelo)
    headers = {"Authorization": f"Bearer {settings.cloudflare_api_token}"}
    async with httpx.AsyncClient(timeout=30) as client:
        try:
            return await client.post(url, headers=headers, json=body)
        except httpx.RequestError as exc:
            raise CloudflareAIError(f"No se pudo conectar con Cloudflare Workers AI: {exc}") from exc


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
    resp = await _pedir(settings.cloudflare_vision_model, body)
    if resp.status_code >= 400:
        raise CloudflareAIError(f"Cloudflare Workers AI respondió {resp.status_code}: {resp.text[:300]}")

    data = resp.json()
    if not data.get("success", True):
        raise CloudflareAIError(f"Cloudflare Workers AI reportó error: {data.get('errors')}")

    resultado = data.get("result", {}).get("response")
    if not isinstance(resultado, dict):
        raise CloudflareAIError("Cloudflare Workers AI no devolvió un JSON válido")
    return resultado


_SCHEMA_REGISTRO = {
    "type": "object",
    "properties": {
        "fecha": {"type": ["string", "null"]},
        "descripcion": {"type": ["string", "null"]},
        "empresa_id": {"type": ["integer", "null"]},
        "sistema_id": {"type": ["integer", "null"]},
        "medio_id": {"type": ["integer", "null"]},
        "modulo_id": {"type": ["integer", "null"]},
        "atendio_id": {"type": ["integer", "null"]},
    },
}


def _prompt_registro(catalogos: dict[str, list]) -> str:
    return (
        "Analiza esta captura de pantalla de un reporte o ticket de soporte técnico. "
        "Extrae la información para llenar un formulario de bitácora de soporte. Responde SOLO con JSON.\n\n"
        "Para empresa_id, sistema_id, medio_id, modulo_id y atendio_id: elige el id EXACTO de la lista "
        "correspondiente que mejor coincida con lo que aparece en la imagen. Si no hay una coincidencia "
        "razonable, usa null — nunca inventes un id que no esté en la lista.\n\n"
        "fecha: formato YYYY-MM-DD si aparece en la imagen, si no null.\n"
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
        "codigo": {"type": ["string", "null"]},
        "titulo": {"type": ["string", "null"]},
        "fecha_carga": {"type": ["string", "null"]},
        "descripcion": {"type": ["string", "null"]},
        "solicitante_id": {"type": ["integer", "null"]},
    },
}


def _prompt_mesa(catalogos: dict[str, list]) -> str:
    return (
        "Analiza esta captura de pantalla de una mesa de ayuda de Proactivanet. "
        "Extrae la información para abrir una mesa en la bitácora administrativa. Responde SOLO con JSON.\n\n"
        "Para solicitante_id: elige el id EXACTO de la lista correspondiente que mejor coincida con quién "
        "levantó la mesa. Si no hay una coincidencia razonable, usa null — nunca inventes un id que no esté "
        "en la lista.\n\n"
        "codigo: el código o folio de la mesa tal como aparece.\n"
        "titulo: el título de la mesa.\n"
        "fecha_carga: formato YYYY-MM-DD HH:MM (24 horas) si aparece fecha y hora en la imagen; "
        "si solo aparece la fecha, usa HH:MM = 00:00; si no aparece nada, usa null.\n"
        "descripcion: resume en español, en 1-3 frases, qué se reportó.\n\n"
        + _lista("Solicitantes", catalogos["solicitantes"])
    )


async def extraer_mesa(imagen: bytes, catalogos: dict[str, list]) -> dict:
    return await _generar_json(imagen, _prompt_mesa(catalogos), _SCHEMA_MESA)
