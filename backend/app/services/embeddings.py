import asyncio

import httpx
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import settings
from app.models import Registro
from app.services.gemini import GeminiError

_CONCURRENCIA = 3
_REINTENTOS_429 = 5


async def obtener_embeddings(textos: list[str]) -> list[list[float]]:
    """Devuelve un embedding por texto, en el mismo orden, usando la API de Gemini."""
    if not settings.gemini_api_key:
        raise GeminiError("Gemini no está configurado (falta GEMINI_API_KEY)")

    url = f"https://generativelanguage.googleapis.com/v1beta/{settings.gemini_embed_model}:embedContent"
    semaforo = asyncio.Semaphore(_CONCURRENCIA)

    async def _uno(client: httpx.AsyncClient, texto: str) -> list[float]:
        body = {"content": {"parts": [{"text": texto}]}}
        for intento in range(_REINTENTOS_429 + 1):
            async with semaforo:
                try:
                    resp = await client.post(url, params={"key": settings.gemini_api_key}, json=body)
                except httpx.RequestError as exc:
                    raise GeminiError(f"No se pudo conectar con Gemini: {exc}") from exc
            if resp.status_code == 429 and intento < _REINTENTOS_429:
                await asyncio.sleep(20 * (intento + 1))
                continue
            if resp.status_code >= 400:
                raise GeminiError(f"Gemini respondió {resp.status_code}: {resp.text[:300]}")
            return resp.json()["embedding"]["values"]
        raise GeminiError("Gemini: cuota excedida tras varios reintentos")

    async with httpx.AsyncClient(timeout=30) as client:
        return await asyncio.gather(*(_uno(client, t) for t in textos))


async def asegurar_embeddings(session: AsyncSession, registros: list[Registro]) -> list[list[float]]:
    """Devuelve el embedding de cada registro, calculando y cacheando en BD los que falten.

    Actualiza vía UPDATE de Core (no mutando los objetos ORM ya cargados) para
    no disparar la expiración de `semana`, columna generada en servidor.
    """
    por_id = {r.id: r.embedding for r in registros}
    faltantes = [r for r in registros if r.embedding is None]
    if faltantes:
        nuevos = await obtener_embeddings([r.descripcion for r in faltantes])
        for r, emb in zip(faltantes, nuevos):
            await session.execute(update(Registro).where(Registro.id == r.id).values(embedding=emb))
            por_id[r.id] = emb
        await session.commit()
    return [por_id[r.id] for r in registros]
