"""WebSocket del brawl multijugador.

Cada sala corre un bucle a 20 ticks/segundo que simula bots y proyectiles y
transmite el mundo a los jugadores conectados. El cliente solo manda su propia
posición y sus disparos: mover su personaje en local es lo que hace que se
sienta inmediato aunque el servidor esté a 100 ms de distancia.
"""

import asyncio
import contextlib
import time

from fastapi import APIRouter, Depends, WebSocket, WebSocketDisconnect
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import Usuario
from app.services import sala_brawl
from app.services.auth import crear_ticket_ws, get_usuario_actual, leer_ticket_ws
from app.services.motor_brawl import (
    TICKS_POR_SEGUNDO,
    avanzar,
    disparar_jugador,
    mover_jugador,
    ronda_terminada,
)

router = APIRouter(prefix="/juegos/brawl", tags=["juegos"])

SEGUNDOS_POR_TICK = 1 / TICKS_POR_SEGUNDO
CODIGO_NO_AUTORIZADO = 4401

_registro = sala_brawl.RegistroSalas()
_conexiones: dict[str, WebSocket] = {}
_bucles: dict[str, asyncio.Task] = {}


@router.post("/ticket")
async def emitir_ticket(usuario: Usuario = Depends(get_usuario_actual)) -> dict:
    return {"ticket": crear_ticket_ws(usuario.id)}


async def _emitir_estado(sala: sala_brawl.Sala) -> None:
    estado = sala_brawl.estado_para_cliente(sala)
    for jugador_id in list(sala.ronda.jugadores):
        ws = _conexiones.get(jugador_id)
        if ws is None:
            continue
        with contextlib.suppress(Exception):
            await ws.send_json({"tipo": "estado", **estado})


async def _bucle_sala(sala: sala_brawl.Sala) -> None:
    """Un bucle por sala. Se apaga solo cuando la ronda acaba o la sala se vacía,
    para no dejar tareas corriendo por cada partida jugada en el día."""
    try:
        while sala.id in _registro.salas:
            _registro.revisar_arranque(sala, time.monotonic())
            if sala.estado == sala_brawl.ESTADO_JUGANDO:
                avanzar(sala.ronda)
                if ronda_terminada(sala.ronda):
                    sala.estado = sala_brawl.ESTADO_TERMINADA
            await _emitir_estado(sala)
            if sala.estado == sala_brawl.ESTADO_TERMINADA:
                return
            await asyncio.sleep(SEGUNDOS_POR_TICK)
    finally:
        _bucles.pop(sala.id, None)


def _asegurar_bucle(sala: sala_brawl.Sala) -> None:
    if sala.id not in _bucles:
        _bucles[sala.id] = asyncio.create_task(_bucle_sala(sala))


def _aplicar_mensaje(sala: sala_brawl.Sala, jugador_id: str, mensaje: dict) -> None:
    tipo = mensaje.get("tipo")
    if tipo == "mover":
        mover_jugador(sala.ronda, jugador_id, float(mensaje.get("x", 0)), float(mensaje.get("y", 0)))
    elif tipo == "disparar":
        disparar_jugador(sala.ronda, jugador_id, float(mensaje.get("x", 0)), float(mensaje.get("y", 0)))


async def _autenticar(websocket: WebSocket, session: AsyncSession) -> Usuario | None:
    usuario_id = leer_ticket_ws(websocket.query_params.get("ticket") or "")
    if usuario_id is None:
        return None
    return await session.get(Usuario, usuario_id)


@router.websocket("/ws")
async def ws_brawl(websocket: WebSocket, session: AsyncSession = Depends(get_session)) -> None:
    await websocket.accept()
    usuario = await _autenticar(websocket, session)
    if usuario is None:
        await websocket.close(code=CODIGO_NO_AUTORIZADO)
        return

    jugador_id = str(usuario.id)
    sala = _registro.entrar(jugador_id, usuario.nombre, usuario.avatar, time.monotonic())
    _conexiones[jugador_id] = websocket
    _asegurar_bucle(sala)
    await websocket.send_json({"tipo": "bienvenida", "jugador_id": jugador_id, "sala_id": sala.id})

    try:
        while True:
            _aplicar_mensaje(sala, jugador_id, await websocket.receive_json())
    except (WebSocketDisconnect, ValueError, KeyError, TypeError):
        pass
    finally:
        _conexiones.pop(jugador_id, None)
        _registro.salir(jugador_id)
