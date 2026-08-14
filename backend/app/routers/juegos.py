from datetime import datetime, timezone

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import PartidaGato, Usuario
from app.schemas import (
    EleccionPelota,
    IntentoPelotaOut,
    MovimientoGato,
    PartidaGatoOut,
    ResultadoPelotaOut,
)
from app.services.auth import get_usuario_actual
from app.services.gato import MovimientoInvalido, buscar_o_crear_partida, cancelar_espera, jugar_movimiento
from app.services.pelota import PelotaError, iniciar_intento, resolver_intento

router = APIRouter(prefix="/juegos", tags=["juegos"], dependencies=[Depends(get_usuario_actual)])


@router.post("/gato/buscar", response_model=PartidaGatoOut)
async def buscar_partida_gato(
    usuario: Usuario = Depends(get_usuario_actual), session: AsyncSession = Depends(get_session)
):
    return await buscar_o_crear_partida(session, usuario.id)


@router.get("/gato/{partida_id}", response_model=PartidaGatoOut)
async def obtener_partida_gato(partida_id: int, session: AsyncSession = Depends(get_session)):
    partida = await session.get(PartidaGato, partida_id)
    if partida is None:
        raise HTTPException(404, "Partida no encontrada")
    return partida


@router.post("/gato/{partida_id}/jugar", response_model=PartidaGatoOut)
async def jugar_gato(
    partida_id: int,
    payload: MovimientoGato,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    try:
        return await jugar_movimiento(session, partida_id, usuario.id, payload.posicion)
    except MovimientoInvalido as e:
        raise HTTPException(400, str(e))


@router.post("/gato/{partida_id}/salir", status_code=204)
async def salir_gato(
    partida_id: int,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    await cancelar_espera(session, partida_id, usuario.id)


@router.post("/pelota/iniciar", response_model=IntentoPelotaOut)
async def iniciar_pelota(
    usuario: Usuario = Depends(get_usuario_actual), session: AsyncSession = Depends(get_session)
):
    try:
        return await iniciar_intento(session, usuario.id, datetime.now(timezone.utc))
    except PelotaError as e:
        raise HTTPException(429, str(e))


@router.post("/pelota/{intento_id}/elegir", response_model=ResultadoPelotaOut)
async def elegir_pelota(
    intento_id: int,
    payload: EleccionPelota,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    try:
        intento = await resolver_intento(session, intento_id, usuario.id, payload.posicion, usuario.nombre)
    except PelotaError as e:
        raise HTTPException(400, str(e))
    return ResultadoPelotaOut(acierto=intento.acierto, posicion_correcta=intento.posicion_correcta)
