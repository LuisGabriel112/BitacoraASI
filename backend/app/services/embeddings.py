import asyncio
from typing import Protocol

import httpx
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import DeclarativeBase

from app.config import settings
from app.services.gemini import GeminiError

_CONCURRENCIA = 3
_REINTENTOS_429 = 5
_ESPERA_BASE_SEGUNDOS = 20


class RegistroConDescripcion(Protocol):
    """Lo mínimo que necesita este módulo: no depende del ORM completo (DIP)."""

    id: int
    descripcion: str
    embedding: list[float] | None


def _url_embed_content() -> str:
    return f"https://generativelanguage.googleapis.com/v1beta/{settings.gemini_embed_model}:embedContent"


async def _pedir_embedding(client: httpx.AsyncClient, texto: str) -> httpx.Response:
    body = {"content": {"parts": [{"text": texto}]}}
    try:
        return await client.post(_url_embed_content(), params={"key": settings.gemini_api_key}, json=body)
    except httpx.RequestError as exc:
        raise GeminiError(f"No se pudo conectar con Gemini: {exc}") from exc


async def _con_reintento_en_cuota(client: httpx.AsyncClient, texto: str) -> list[float]:
    intento = 0
    while True:
        resp = await _pedir_embedding(client, texto)
        if resp.status_code != 429 or intento >= _REINTENTOS_429:
            break
        await asyncio.sleep(_ESPERA_BASE_SEGUNDOS * (intento + 1))
        intento += 1

    if resp.status_code >= 400:
        raise GeminiError(f"Gemini respondió {resp.status_code}: {resp.text[:300]}")
    return resp.json()["embedding"]["values"]


async def obtener_embeddings(textos: list[str]) -> list[list[float]]:
    """Devuelve un embedding por texto, en el mismo orden, usando la API de Gemini."""
    if not settings.gemini_api_key:
        raise GeminiError("Gemini no está configurado (falta GEMINI_API_KEY)")

    semaforo = asyncio.Semaphore(_CONCURRENCIA)

    async def _uno_limitado(client: httpx.AsyncClient, texto: str) -> list[float]:
        async with semaforo:
            return await _con_reintento_en_cuota(client, texto)

    async with httpx.AsyncClient(timeout=30) as client:
        return await asyncio.gather(*(_uno_limitado(client, t) for t in textos))


def _mapeo_actualizacion(faltantes: list[RegistroConDescripcion], nuevos: list[list[float]]) -> list[dict]:
    return [{"id": r.id, "embedding": emb} for r, emb in zip(faltantes, nuevos)]


async def asegurar_embeddings(
    session: AsyncSession, registros: list[RegistroConDescripcion], modelo: type[DeclarativeBase]
) -> list[list[float]]:
    """Devuelve el embedding de cada registro, calculando y cacheando en BD los que falten.

    `modelo` es la clase ORM real de `registros` (p.ej. `Registro` o `Mesa`):
    el UPDATE en bloque debe apuntar a esa tabla, nunca a una fija — de lo
    contrario reusar esta función para otro dominio corrompería silenciosamente
    filas de una tabla distinta cuyos ids coincidan por casualidad.

    El cacheo hace un único UPDATE en bloque (executemany), no uno por
    registro, y no muta los objetos ya cargados: usar `modelo.embedding = x`
    + commit expiraría `semana` (columna generada en servidor de Postgres).
    """
    por_id = {r.id: r.embedding for r in registros}
    faltantes = [r for r in registros if r.embedding is None]
    if faltantes:
        nuevos = await obtener_embeddings([r.descripcion for r in faltantes])
        mapeo = _mapeo_actualizacion(faltantes, nuevos)
        await session.execute(update(modelo), mapeo)
        await session.commit()
        por_id.update({fila["id"]: fila["embedding"] for fila in mapeo})

    return [por_id[r.id] for r in registros]
