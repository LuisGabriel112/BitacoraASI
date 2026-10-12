from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import func, select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import Sonido, SonidoPreferencia, Usuario
from app.schemas import (
    AccionSonido,
    PesoSonidoUpdate,
    PreferenciaSonidoOut,
    PreferenciaSonidoUpdate,
    SolicitudUrlSubida,
    SonidoCreate,
    SonidoOut,
    UrlSubidaOut,
)
from app.services.auth import get_usuario_actual
from app.services.sonidos import (
    CARPETA_STORAGE,
    SonidoError,
    con_accion,
    con_peso,
    guardar_preferencia,
    normalizar_acciones,
    sin_pesos_huerfanos,
)
from app.services.storage import StorageError, crear_url_subida

router = APIRouter(prefix="/sonidos", tags=["sonidos"], dependencies=[Depends(get_usuario_actual)])


@router.get("", response_model=list[SonidoOut])
async def listar(session: AsyncSession = Depends(get_session)):
    # Todos, tengan acciones marcadas o no: el catálogo los muestra con sus
    # interruptores; el frontend filtra por `acciones` al decidir qué reproducir.
    stmt = select(Sonido).order_by(Sonido.id)
    return (await session.execute(stmt)).scalars().all()


@router.post("/subir-url", response_model=UrlSubidaOut)
async def solicitar_url_subida(payload: SolicitudUrlSubida):
    # Mismo flujo que los adjuntos del chat (subida directa a Supabase), pero
    # en una carpeta propia del bucket para no mezclarlos.
    try:
        url_subida, url_publica = await crear_url_subida(
            payload.nombre_archivo, payload.content_type, carpeta=CARPETA_STORAGE
        )
    except StorageError as exc:
        raise HTTPException(400, str(exc))
    return UrlSubidaOut(url_subida=url_subida, url_publica=url_publica)


@router.post("", response_model=SonidoOut, status_code=201)
async def crear(payload: SonidoCreate, session: AsyncSession = Depends(get_session)):
    nombre = " ".join(payload.nombre.split())
    if not nombre:
        raise HTTPException(400, "Nombre vacío")
    existente = await session.execute(select(Sonido).where(func.lower(Sonido.nombre) == nombre.lower()))
    if existente.scalar_one_or_none() is not None:
        raise HTTPException(409, f"Ya hay un sonido llamado '{nombre}'")
    sonido = Sonido(nombre=nombre, url=payload.url.strip(), acciones=normalizar_acciones(payload.acciones))
    session.add(sonido)
    try:
        await session.commit()
    except IntegrityError:
        await session.rollback()
        raise HTTPException(409, f"Ya hay un sonido llamado '{nombre}'")
    await session.refresh(sonido)
    return sonido


async def _cambiar_accion(session: AsyncSession, sonido_id: int, accion: str, marcada: bool) -> Sonido:
    sonido = await session.get(Sonido, sonido_id)
    if sonido is None:
        raise HTTPException(404, "Sonido no encontrado")
    try:
        sonido.acciones = con_accion(sonido.acciones, accion, marcada)
    except SonidoError as exc:
        raise HTTPException(400, str(exc)) from exc
    # desmarcar también se lleva el peso que tenía en esa acción
    sonido.pesos = sin_pesos_huerfanos(sonido.pesos, sonido.acciones)
    await session.commit()
    await session.refresh(sonido)
    return sonido


@router.put("/{sonido_id}/acciones/{accion}", response_model=SonidoOut)
async def marcar_accion(sonido_id: int, accion: AccionSonido, session: AsyncSession = Depends(get_session)):
    """Marca el sonido para que pueda sonar en esa acción (para todo el equipo)."""
    return await _cambiar_accion(session, sonido_id, accion, True)


@router.delete("/{sonido_id}/acciones/{accion}", response_model=SonidoOut)
async def desmarcar_accion(sonido_id: int, accion: AccionSonido, session: AsyncSession = Depends(get_session)):
    """Lo quita de esa acción; sin ninguna marcada, el sonido no suena para nadie."""
    return await _cambiar_accion(session, sonido_id, accion, False)


@router.put("/{sonido_id}/acciones/{accion}/peso", response_model=SonidoOut)
async def ajustar_peso(
    sonido_id: int,
    accion: AccionSonido,
    payload: PesoSonidoUpdate,
    session: AsyncSession = Depends(get_session),
):
    """Cuánto pesa este sonido en el sorteo de esa acción (para todo el equipo).
    Solo tiene sentido en una acción marcada: el peso de una sin marcar no se
    usaría y se descarta al guardar."""
    sonido = await session.get(Sonido, sonido_id)
    if sonido is None:
        raise HTTPException(404, "Sonido no encontrado")
    if accion not in sonido.acciones:
        raise HTTPException(400, f"El sonido no está marcado para la acción '{accion}'")
    try:
        sonido.pesos = con_peso(sonido.pesos, accion, payload.peso)
    except SonidoError as exc:
        raise HTTPException(400, str(exc)) from exc
    await session.commit()
    await session.refresh(sonido)
    return sonido


@router.delete("/{sonido_id}", status_code=204)
async def eliminar(sonido_id: int, session: AsyncSession = Depends(get_session)):
    """Saca el sonido del catálogo para todo el equipo. Las preferencias que lo
    tuvieran elegido quedan en sonido_id=None (on delete set null, migración
    0034), o sea que esa acción vuelve a sonar al azar en vez de romperse."""
    sonido = await session.get(Sonido, sonido_id)
    if sonido is None:
        raise HTTPException(404, "Sonido no encontrado")
    await session.delete(sonido)
    await session.commit()


@router.get("/preferencias", response_model=list[PreferenciaSonidoOut])
async def mis_preferencias(
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    stmt = select(SonidoPreferencia).where(SonidoPreferencia.usuario_id == usuario.id)
    return (await session.execute(stmt)).scalars().all()


@router.post("/preferencias", response_model=PreferenciaSonidoOut)
async def guardar_mi_preferencia(
    payload: PreferenciaSonidoUpdate,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    try:
        return await guardar_preferencia(session, usuario.id, payload.evento, payload.sonido_id, payload.silenciado)
    except SonidoError as exc:
        raise HTTPException(400, str(exc)) from exc
