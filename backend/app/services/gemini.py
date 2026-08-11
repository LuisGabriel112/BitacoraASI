import asyncio
import base64
import io
import json

import httpx
from PIL import Image, UnidentifiedImageError

from app.config import settings

_REINTENTOS_429 = 5
_ESPERA_BASE_SEGUNDOS = 20


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
        cabecera = imagen[:12].hex()
        raise GeminiError(f"El archivo no se pudo leer como imagen ({len(imagen)} bytes, cabecera {cabecera})") from exc


def gemini_configurado() -> bool:
    return bool(settings.gemini_api_key)


def _lista(titulo: str, items: list) -> str:
    filas = "\n".join(f"{item.id}: {item.nombre}" for item in items)
    return f"{titulo} disponibles (id: nombre):\n{filas}"


async def _pedir_generate_content(url: str, body: dict) -> httpx.Response:
    async with httpx.AsyncClient(timeout=30) as client:
        try:
            return await client.post(url, params={"key": settings.gemini_api_key}, json=body)
        except httpx.RequestError as exc:
            raise GeminiError(f"No se pudo conectar con Gemini: {exc}") from exc


async def _llamar_generate_content(body: dict) -> str:
    """Reintenta en 429 (cuota por minuto excedida): con varios grupos
    llamando a Gemini casi al mismo tiempo (síntesis de soluciones), es
    normal chocar con el límite de solicitudes por minuto del plan gratuito."""
    if not gemini_configurado():
        raise GeminiError("Gemini no está configurado (falta GEMINI_API_KEY)")

    url = f"https://generativelanguage.googleapis.com/v1beta/models/{settings.gemini_model}:generateContent"
    intento = 0
    while True:
        resp = await _pedir_generate_content(url, body)
        if resp.status_code != 429 or intento >= _REINTENTOS_429:
            break
        await asyncio.sleep(_ESPERA_BASE_SEGUNDOS * (intento + 1))
        intento += 1

    if resp.status_code >= 400:
        raise GeminiError(f"Gemini respondió {resp.status_code}: {resp.text[:300]}")

    data = resp.json()
    try:
        return data["candidates"][0]["content"]["parts"][0]["text"]
    except (KeyError, IndexError) as exc:
        raise GeminiError("Respuesta de Gemini sin contenido") from exc


async def _generar_json(imagen: bytes, prompt: str, schema: dict) -> dict:
    imagen_png = _normalizar_imagen(imagen)
    body = {
        "contents": [
            {
                "parts": [
                    {"text": prompt},
                    {"inline_data": {"mime_type": "image/png", "data": base64.b64encode(imagen_png).decode()}},
                ]
            }
        ],
        "generationConfig": {"responseMimeType": "application/json", "responseSchema": schema},
    }
    texto = await _llamar_generate_content(body)
    try:
        return json.loads(texto)
    except json.JSONDecodeError as exc:
        raise GeminiError("Gemini no devolvió JSON válido") from exc


async def _generar_json_desde_texto(prompt: str, schema: dict) -> dict:
    body = {
        "contents": [{"parts": [{"text": prompt}]}],
        "generationConfig": {"responseMimeType": "application/json", "responseSchema": schema},
    }
    texto = await _llamar_generate_content(body)
    try:
        return json.loads(texto)
    except json.JSONDecodeError as exc:
        raise GeminiError("Gemini no devolvió JSON válido") from exc


_SCHEMA_REGISTRO = {
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
    "type": "OBJECT",
    "properties": {
        "codigo": {"type": "STRING", "nullable": True},
        "titulo": {"type": "STRING", "nullable": True},
        "fecha_carga": {"type": "STRING", "nullable": True},
        "descripcion": {"type": "STRING", "nullable": True},
        "solicitante_id": {"type": "INTEGER", "nullable": True},
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


_SCHEMA_SINTESIS = {
    "type": "OBJECT",
    "properties": {
        "titulo": {"type": "STRING"},
        "texto": {"type": "STRING"},
    },
    "required": ["titulo", "texto"],
}


def _prompt_sintesis(categoria: str, tipo_solucion: str | None, ejemplos: list[str]) -> str:
    lista = "\n".join(f"- {e}" for e in ejemplos)
    contexto_tipo = f" (tipo de solución: {tipo_solucion})" if tipo_solucion else ""
    return (
        "Eres soporte técnico interno. Estas son soluciones reales aplicadas a incidencias de la "
        f"categoría \"{categoria}\"{contexto_tipo}. Sintetiza UNA sola guía de solución genérica y "
        "clara, en español, que cubra el patrón común entre estos ejemplos. No inventes datos que no "
        "estén en los ejemplos. Responde SOLO con JSON.\n\n"
        "titulo: nombre corto (máximo 8 palabras) que describa el tipo de incidencia.\n"
        "texto: la guía de solución sintetizada, 2-5 frases.\n\n"
        f"Ejemplos de soluciones reales:\n{lista}"
    )


async def sintetizar_solucion(categoria: str, tipo_solucion: str | None, ejemplos: list[str]) -> dict:
    return await _generar_json_desde_texto(_prompt_sintesis(categoria, tipo_solucion, ejemplos), _SCHEMA_SINTESIS)
