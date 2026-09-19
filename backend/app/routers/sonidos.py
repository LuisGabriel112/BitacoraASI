from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import func, select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import Sonido, SonidoPreferencia, Usuario
from app.schemas import (
    AccionSonido,
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
    guardar_preferencia,
    normalizar_acciones,
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
