import base64
import io
import json

import httpx
from PIL import Image, UnidentifiedImageError

from app.config import settings


class GeminiError(Exception):
    pass


def _normalizar_imagen(imagen: bytes) -> bytes:
    try:
        with Image.open(io.BytesIO(imagen)) as img:
            if img.mode not in ("RGB", "RGBA"):
                img = img.convert("RGBA" if "A" in img.getbands() else "RGB")
            buf = io.BytesIO()
            img.save(buf, format="PNG")
            return buf.getvalue()
    except UnidentifiedImageError as exc:
        raise GeminiError("El archivo no se pudo leer como imagen") from exc


def gemini_configurado() -> bool:
    return bool(settings.gemini_api_key)


_SCHEMA = {
    "type": "OBJECT",
    "properties": {
        "fecha": {"type": "STRING", "nullable": True},
        "descripcion": {"type": "STRING", "nullable": True},
        "empresa_id": {"type": "INTEGER", "nullable": True},
        "sistema_id": {"type": "INTEGER", "nullable": True},
        "medio_id": {"type": "INTEGER", "nullable": True},
        "modulo_id": {"type": "INTEGER", "nullable": True},
        "atendio_id": {"type": "INTEGER", "nullable": True},
    },
}


def _lista(titulo: str, items: list) -> str:
    filas = "\n".join(f"{item.id}: {item.nombre}" for item in items)
    return f"{titulo} disponibles (id: nombre):\n{filas}"


def _prompt(catalogos: dict[str, list]) -> str:
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
    if not gemini_configurado():
        raise GeminiError("Gemini no está configurado (falta GEMINI_API_KEY)")

    imagen_png = _normalizar_imagen(imagen)

    body = {
        "contents": [
            {
                "parts": [
                    {"text": _prompt(catalogos)},
                    {"inline_data": {"mime_type": "image/png", "data": base64.b64encode(imagen_png).decode()}},
                ]
            }
        ],
        "generationConfig": {
            "responseMimeType": "application/json",
            "responseSchema": _SCHEMA,
        },
    }

    url = f"https://generativelanguage.googleapis.com/v1beta/models/{settings.gemini_model}:generateContent"
    async with httpx.AsyncClient(timeout=30) as client:
        try:
            resp = await client.post(url, params={"key": settings.gemini_api_key}, json=body)
        except httpx.RequestError as exc:
            raise GeminiError(f"No se pudo conectar con Gemini: {exc}") from exc

    if resp.status_code >= 400:
        raise GeminiError(f"Gemini respondió {resp.status_code}: {resp.text[:300]}")

    data = resp.json()
    try:
        texto = data["candidates"][0]["content"]["parts"][0]["text"]
    except (KeyError, IndexError) as exc:
        raise GeminiError("Respuesta de Gemini sin contenido") from exc

    try:
        return json.loads(texto)
    except json.JSONDecodeError as exc:
        raise GeminiError("Gemini no devolvió JSON válido") from exc
