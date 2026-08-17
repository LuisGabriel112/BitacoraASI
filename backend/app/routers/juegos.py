from datetime import datetime, timezone

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import PartidaGato, PartidaRPS, Usuario
from app.schemas import (
    EleccionPelota,
    IntentoMemoramaOut,
    IntentoPelotaOut,
    IntentoReaccionOut,
    JugadaRPS,
    MovimientoGato,
    PartidaGatoOut,
    PartidaRPSOut,
    PreguntaTriviaOut,
    ReporteReaccion,
    RespuestaTrivia,
    ResultadoMemoramaOut,
    ResultadoPelotaOut,
    ResultadoReaccionOut,
    ResultadoRuletaOut,
    ResultadoTriviaOut,
)
from app.services.auth import get_usuario_actual
from app.services.gato import MovimientoInvalido, buscar_o_crear_partida, cancelar_espera, jugar_movimiento
from app.services.pelota import PelotaError, iniciar_intento, resolver_intento
from app.services import memorama as memorama_service
from app.services import reaccion as reaccion_service
from app.services import rps as rps_service
from app.services import ruleta as ruleta_service
from app.services import trivia as trivia_service

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


def _partida_rps_out(partida: PartidaRPS, usuario_id: int) -> PartidaRPSOut:
    """Oculta la jugada del rival hasta que ambos ya jugaron — si no, verla antes
    de elegir la propia sería hacer trampa."""
    revelar = partida.estado == "terminada"
    return PartidaRPSOut(
        id=partida.id,
        estado=partida.estado,
        resultado=partida.resultado,
        jugada_x=partida.jugada_x if (revelar or usuario_id == partida.jugador_x_id) else None,
        jugada_o=partida.jugada_o if (revelar or usuario_id == partida.jugador_o_id) else None,
        jugador_x=partida.jugador_x,
        jugador_o=partida.jugador_o,
    )


@router.post("/rps/buscar", response_model=PartidaRPSOut)
async def buscar_partida_rps(
    usuario: Usuario = Depends(get_usuario_actual), session: AsyncSession = Depends(get_session)
):
    partida = await rps_service.buscar_o_crear_partida(session, usuario.id)
    return _partida_rps_out(partida, usuario.id)


@router.get("/rps/{partida_id}", response_model=PartidaRPSOut)
async def obtener_partida_rps(
    partida_id: int,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    partida = await session.get(PartidaRPS, partida_id)
    if partida is None:
        raise HTTPException(404, "Partida no encontrada")
    return _partida_rps_out(partida, usuario.id)


@router.post("/rps/{partida_id}/jugar", response_model=PartidaRPSOut)
async def jugar_rps_endpoint(
    partida_id: int,
    payload: JugadaRPS,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    try:
        partida = await rps_service.jugar_rps(session, partida_id, usuario.id, payload.jugada)
    except rps_service.JugadaInvalida as e:
        raise HTTPException(400, str(e))
    return _partida_rps_out(partida, usuario.id)


@router.post("/rps/{partida_id}/salir", status_code=204)
async def salir_rps(
    partida_id: int,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    await rps_service.cancelar_espera_rps(session, partida_id, usuario.id)


@router.post("/trivia/iniciar", response_model=PreguntaTriviaOut)
async def iniciar_trivia(
    usuario: Usuario = Depends(get_usuario_actual), session: AsyncSession = Depends(get_session)
):
    try:
        intento, pregunta = await trivia_service.iniciar_intento(session, usuario.id, datetime.now(timezone.utc))
    except trivia_service.TriviaError as e:
        raise HTTPException(429, str(e))
    return PreguntaTriviaOut(
        intento_id=intento.id, pregunta_id=pregunta.id, texto=pregunta.texto, opciones=list(pregunta.opciones)
    )


@router.post("/trivia/{intento_id}/responder", response_model=ResultadoTriviaOut)
async def responder_trivia(
    intento_id: int,
    payload: RespuestaTrivia,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    try:
        intento = await trivia_service.resolver_intento(session, intento_id, usuario.id, payload.opcion, usuario.nombre)
    except trivia_service.TriviaError as e:
        raise HTTPException(400, str(e))
    pregunta = trivia_service.pregunta_por_id(intento.pregunta_id)
    return ResultadoTriviaOut(acierto=intento.acierto, respuesta_correcta=pregunta.respuesta_correcta)


@router.post("/memorama/iniciar", response_model=IntentoMemoramaOut)
async def iniciar_memorama(
    usuario: Usuario = Depends(get_usuario_actual), session: AsyncSession = Depends(get_session)
):
    try:
        return await memorama_service.iniciar_intento(session, usuario.id, datetime.now(timezone.utc))
    except memorama_service.MemoramaError as e:
        raise HTTPException(429, str(e))


@router.post("/memorama/{intento_id}/completar", response_model=ResultadoMemoramaOut)
async def completar_memorama(
    intento_id: int,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    try:
        intento = await memorama_service.completar_intento(
            session, intento_id, usuario.id, datetime.now(timezone.utc), usuario.nombre
        )
    except memorama_service.MemoramaError as e:
        raise HTTPException(400, str(e))
    return ResultadoMemoramaOut(acierto=intento.acierto)


@router.post("/reaccion/iniciar", response_model=IntentoReaccionOut)
async def iniciar_reaccion(
    usuario: Usuario = Depends(get_usuario_actual), session: AsyncSession = Depends(get_session)
):
    try:
        return await reaccion_service.iniciar_intento(session, usuario.id, datetime.now(timezone.utc))
    except reaccion_service.ReaccionError as e:
        raise HTTPException(429, str(e))


@router.post("/reaccion/{intento_id}/reportar", response_model=ResultadoReaccionOut)
async def reportar_reaccion(
    intento_id: int,
    payload: ReporteReaccion,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    try:
        intento = await reaccion_service.resolver_intento(
            session, intento_id, usuario.id, payload.tiempo_ms, usuario.nombre
        )
    except reaccion_service.ReaccionError as e:
        raise HTTPException(400, str(e))
    return ResultadoReaccionOut(acierto=intento.acierto)


@router.post("/ruleta/jugar", response_model=ResultadoRuletaOut)
async def jugar_ruleta_endpoint(
    usuario: Usuario = Depends(get_usuario_actual), session: AsyncSession = Depends(get_session)
):
    try:
        intento = await ruleta_service.jugar_ruleta(session, usuario.id, datetime.now(timezone.utc), usuario.nombre)
    except ruleta_service.RuletaError as e:
        raise HTTPException(429, str(e))
    return ResultadoRuletaOut(gano=intento.gano)
