"""
Agrupa registros por similitud de descripcion (embeddings de Gemini, cacheados
en la columna registros.embedding) y rankea los grupos por frecuencia.

Uso:
    cd backend
    python -m scripts.agrupar_soportes [--semana "SEM 30 - 2026"] [--umbral 0.86] [--top 15]

Nota: el endpoint /registros/soportes-frecuentes hace lo mismo desde la app;
este script es útil para explorar sin pasar por la API.
"""

import argparse
import asyncio

from sqlalchemy import select
from sqlalchemy.orm import selectinload

from app.database import async_session
from app.models import Registro
from app.services.clustering import agrupar_por_similitud
from app.services.embeddings import asegurar_embeddings


async def main(semana: str | None, umbral: float, top: int) -> None:
    async with async_session() as session:
        stmt = select(Registro).options(
            selectinload(Registro.empresa),
            selectinload(Registro.sistema),
        )
        if semana:
            stmt = stmt.where(Registro.semana == semana)
        registros = (await session.execute(stmt)).scalars().all()

        if not registros:
            print("Sin registros para los filtros dados.")
            return

        print(f"Calculando embeddings para {len(registros)} registros...")
        embeddings = await asegurar_embeddings(session, registros)

    grupos = agrupar_por_similitud(embeddings, umbral)

    print(f"\n{len(grupos)} grupos encontrados (umbral={umbral})\n")
    for idx in grupos[:top]:
        print(f"--- {len(idx)} ocurrencias ---")
        for i in idx[:3]:
            r = registros[i]
            print(f"  [{r.fecha}] {r.sistema.nombre}/{r.empresa.nombre}: {r.descripcion[:100]}")
        if len(idx) > 3:
            print(f"  ... y {len(idx) - 3} más")
        print()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--semana", default=None, help='Filtrar por semana, ej. "SEM 30 - 2026"')
    parser.add_argument("--umbral", type=float, default=0.86, help="Similitud coseno mínima para agrupar")
    parser.add_argument("--top", type=int, default=15, help="Cuántos grupos mostrar")
    args = parser.parse_args()

    asyncio.run(main(args.semana, args.umbral, args.top))
