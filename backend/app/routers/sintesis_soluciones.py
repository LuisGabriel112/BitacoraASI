import asyncio
from datetime import datetime, timezone

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.dialects.postgresql import insert as pg_insert
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.database import get_session
from app.models import Mesa, SintesisSolucion
from app.schemas import ResumenGeneracionSintesis, SintesisSolucionOut
from app.services.auth import get_usuario_actual
from app.services.gemini import GeminiError, gemini_configurado, sintetizar_solucion
from app.services.sintesis_soluciones import agrupar_por_categoria_y_tipo, muestra_representativa

router = APIRouter(prefix="/mesas/sintesis", tags=["sintesis"], dependencies=[Depends(get_usuario_actual)])

_CONCURRENCIA = 1


@router.get("", response_model=list[SintesisSolucionOut])
async def listar_sintesis(session: AsyncSession = Depends(get_session)):
    stmt = (
        select(SintesisSolucion)
        .options(selectinload(SintesisSolucion.categoria))
        .order_by(SintesisSolucion.cantidad_mesas.desc())
    )
    return (await session.execute(stmt)).scalars().all()


async def _mesas_con_solucion(session: AsyncSession) -> list[Mesa]:
    stmt = select(Mesa).where(Mesa.solucion.isnot(None)).where(Mesa.solucion != "")
    return (await session.execute(stmt)).scalars().all()


async def _generar_uno(categoria_nombre: str, tipo_solucion: str | None, mesas: list[Mesa]) -> dict | None:
    ejemplos = muestra_representativa([m.solucion for m in mesas])
    try:
        return await sintetizar_solucion(categoria_nombre, tipo_solucion, ejemplos)
    except GeminiError:
        return None


async def _generar_todas(grupos: dict[tuple[int, str | None], list[Mesa]]) -> list[dict | None]:
    semaforo = asyncio.Semaphore(_CONCURRENCIA)

    async def limitado(mesas: list[Mesa], tipo_solucion: str | None) -> dict | None:
        async with semaforo:
            return await _generar_uno(mesas[0].categoria.nombre, tipo_solucion, mesas)

    return await asyncio.gather(*(limitado(mesas, tipo) for (_, tipo), mesas in grupos.items()))


async def _guardar_sintesis(
    session: AsyncSession, categoria_id: int, tipo_solucion: str | None, resultado: dict, cantidad: int
) -> None:
    valores = {
        # cadena vacía en vez de NULL: Postgres no considera NULL=NULL en un
        # unique constraint, así que dos grupos "sin tipo_solucion" nunca
        # chocarían en el ON CONFLICT y se duplicarían en cada regeneración.
        "categoria_id": categoria_id, "tipo_solucion": tipo_solucion or "",
        "titulo": resultado["titulo"], "texto": resultado["texto"], "cantidad_mesas": cantidad,
        "generado_en": datetime.now(timezone.utc),
    }
    stmt = pg_insert(SintesisSolucion).values(**valores)
    columnas_actualizables = {k: v for k, v in valores.items() if k not in ("categoria_id", "tipo_solucion")}
    stmt = stmt.on_conflict_do_update(index_elements=["categoria_id", "tipo_solucion"], set_=columnas_actualizables)
    await session.execute(stmt)


@router.post("/generar", response_model=ResumenGeneracionSintesis)
async def generar_sintesis(session: AsyncSession = Depends(get_session)):
    if not gemini_configurado():
        raise HTTPException(400, "Gemini no está configurado (falta GEMINI_API_KEY en el backend)")

    mesas = await _mesas_con_solucion(session)
    grupos = agrupar_por_categoria_y_tipo(mesas)
    resultados = await _generar_todas(grupos)

    generadas = 0
    mesas_cubiertas = 0
    for ((categoria_id, tipo_solucion), lista_mesas), resultado in zip(grupos.items(), resultados):
        if resultado is None:
            continue
        await _guardar_sintesis(session, categoria_id, tipo_solucion, resultado, len(lista_mesas))
        generadas += 1
        mesas_cubiertas += len(lista_mesas)

    await session.commit()
    return ResumenGeneracionSintesis(grupos_generados=generadas, mesas_cubiertas=mesas_cubiertas)
