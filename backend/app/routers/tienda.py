from datetime import date

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import Usuario
from app.schemas import ObjetoOut, TiendaEstadoOut
from app.services.auth import get_usuario_actual
from app.services.semanas import semana_de
from app.services.tienda import (
    OBJETOS,
    Objeto,
    TiendaError,
    comprar_objeto,
    creditos_disponibles,
    objetos_equipados,
)

router = APIRouter(prefix="/tienda", tags=["tienda"], dependencies=[Depends(get_usuario_actual)])


def _objeto_out(objeto: Objeto) -> ObjetoOut:
    return ObjetoOut(
        id=objeto.id,
        nombre=objeto.nombre,
        descripcion=objeto.descripcion,
        costo=objeto.costo,
        danio_pct=objeto.danio_pct,
        critico_pct=objeto.critico_pct,
        cooldown_pct=objeto.cooldown_pct,
        xp_pct=objeto.xp_pct,
        requiere=list(objeto.requiere) if objeto.requiere else None,
    )


async def _estado_de(session: AsyncSession, usuario_id: int) -> TiendaEstadoOut:
    semana = semana_de(date.today())
    creditos = await creditos_disponibles(session, usuario_id, semana)
    equipados = await objetos_equipados(session, usuario_id, semana)
    return TiendaEstadoOut(creditos_disponibles=creditos, equipados=[_objeto_out(o) for o in equipados])


@router.get("/catalogo", response_model=list[ObjetoOut])
async def catalogo():
    return [_objeto_out(o) for o in OBJETOS]


@router.get("/mio", response_model=TiendaEstadoOut)
async def mi_tienda(
    usuario: Usuario = Depends(get_usuario_actual), session: AsyncSession = Depends(get_session)
):
    return await _estado_de(session, usuario.id)


@router.post("/comprar/{item_id}", response_model=TiendaEstadoOut)
async def comprar(
    item_id: str,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    try:
        await comprar_objeto(session, usuario.id, semana_de(date.today()), item_id)
    except TiendaError as exc:
        raise HTTPException(400, str(exc)) from exc
    return await _estado_de(session, usuario.id)
