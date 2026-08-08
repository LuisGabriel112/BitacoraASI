from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import MensajeChat, Usuario
from app.schemas import AutorChatOut, MensajeChatCreate, MensajeChatOut
from app.services.auth import get_usuario_actual
from app.services.storage import StorageError, crear_url_subida

router = APIRouter(prefix="/chat", tags=["chat"], dependencies=[Depends(get_usuario_actual)])


def _mensaje_out(m: MensajeChat) -> MensajeChatOut:
    return MensajeChatOut(
        id=m.id,
        autor=AutorChatOut(nombre=m.usuario.nombre, avatar=m.usuario.avatar),
        texto=m.texto,
        archivo_url=m.archivo_url,
        archivo_nombre=m.archivo_nombre,
        archivo_tipo=m.archivo_tipo,
        created_at=m.created_at,
    )


class SolicitudUrlSubida(BaseModel):
    nombre_archivo: str
    content_type: str


class UrlSubidaOut(BaseModel):
    url_subida: str
    url_publica: str


@router.post("/subir-url", response_model=UrlSubidaOut)
async def solicitar_url_subida(payload: SolicitudUrlSubida):
    try:
        url_subida, url_publica = await crear_url_subida(payload.nombre_archivo, payload.content_type)
    except StorageError as exc:
        raise HTTPException(400, str(exc))
    return UrlSubidaOut(url_subida=url_subida, url_publica=url_publica)


@router.post("/mensajes", response_model=MensajeChatOut, status_code=201)
async def crear_mensaje(
    payload: MensajeChatCreate,
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    mensaje = MensajeChat(
        usuario_id=usuario.id,
        texto=(payload.texto or "").strip() or None,
        archivo_url=payload.archivo_url,
        archivo_nombre=payload.archivo_nombre,
        archivo_tipo=payload.archivo_tipo,
    )
    session.add(mensaje)
    await session.commit()
    await session.refresh(mensaje, attribute_names=["usuario"])
    return _mensaje_out(mensaje)


@router.get("/mensajes", response_model=list[MensajeChatOut])
async def listar_mensajes(
    despues_de: int | None = Query(None),
    limite: int = Query(50, ge=1, le=200),
    session: AsyncSession = Depends(get_session),
):
    stmt = select(MensajeChat)
    if despues_de is not None:
        stmt = stmt.where(MensajeChat.id > despues_de).order_by(MensajeChat.id.asc())
    else:
        stmt = stmt.order_by(MensajeChat.id.desc()).limit(limite)

    mensajes = (await session.execute(stmt)).scalars().all()
    if despues_de is None:
        mensajes = list(reversed(mensajes))
    return [_mensaje_out(m) for m in mensajes]
