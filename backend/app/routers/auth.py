from datetime import datetime, timezone

from fastapi import APIRouter, Depends, HTTPException, Request, Response
from sqlalchemy import func, select, update
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import Usuario, XpEvento
from app.schemas import EventoXpOut, PersonajeOut, RankingItemOut, UsuarioLogin, UsuarioRegistro
from app.services.auth import (
    NOMBRE_COOKIE,
    calcular_bloqueo_hasta,
    crear_token,
    debe_bloquear,
    esta_en_linea,
    get_usuario_actual,
    hash_pin,
    normalizar_nombre,
    sigue_bloqueado,
    verificar_pin,
)
from app.services.rpg import nivel_y_progreso, titulo_para_nivel

router = APIRouter(prefix="/auth", tags=["auth"])

SEGUNDOS_EXPIRACION_COOKIE = 30 * 24 * 60 * 60


def _personaje_de(usuario: Usuario) -> PersonajeOut:
    info = nivel_y_progreso(usuario.xp)
    return PersonajeOut(
        id=usuario.id,
        nombre=usuario.nombre,
        avatar=usuario.avatar,
        xp=usuario.xp,
        nivel=info.nivel,
        xp_en_nivel_actual=info.xp_en_nivel_actual,
        xp_para_siguiente_nivel=info.xp_para_siguiente_nivel,
        titulo=titulo_para_nivel(info.nivel),
    )


def _fijar_cookie_sesion(response: Response, request: Request, usuario_id: int) -> None:
    response.set_cookie(
        NOMBRE_COOKIE,
        crear_token(usuario_id),
        max_age=SEGUNDOS_EXPIRACION_COOKIE,
        httponly=True,
        samesite="lax",
        secure=request.url.scheme == "https",
    )


async def _buscar_por_nombre(session: AsyncSession, nombre: str) -> Usuario | None:
    stmt = select(Usuario).where(func.lower(Usuario.nombre) == normalizar_nombre(nombre))
    return (await session.execute(stmt)).scalar_one_or_none()


@router.post("/registro", response_model=PersonajeOut, status_code=201)
async def registro(
    payload: UsuarioRegistro,
    request: Request,
    response: Response,
    session: AsyncSession = Depends(get_session),
):
    nombre_limpio = " ".join(payload.nombre.split())
    if not nombre_limpio:
        raise HTTPException(400, "Nombre vacío")
    if await _buscar_por_nombre(session, nombre_limpio) is not None:
        raise HTTPException(409, f"Ya existe una cuenta con el nombre '{nombre_limpio}'")

    usuario = Usuario(nombre=nombre_limpio, pin_hash=hash_pin(payload.pin), avatar=payload.avatar)
    session.add(usuario)
    try:
        await session.commit()
    except IntegrityError:
        await session.rollback()
        raise HTTPException(409, f"Ya existe una cuenta con el nombre '{nombre_limpio}'")
    await session.refresh(usuario)

    _fijar_cookie_sesion(response, request, usuario.id)
    return _personaje_de(usuario)


@router.post("/login", response_model=PersonajeOut)
async def login(
    payload: UsuarioLogin,
    request: Request,
    response: Response,
    session: AsyncSession = Depends(get_session),
):
    usuario = await _buscar_por_nombre(session, payload.nombre)
    if usuario is None:
        raise HTTPException(401, "Nombre o PIN incorrecto")

    ahora = datetime.now(timezone.utc)
    if sigue_bloqueado(usuario.bloqueado_hasta, ahora):
        raise HTTPException(429, "Cuenta bloqueada temporalmente por demasiados intentos fallidos")

    if not verificar_pin(payload.pin, usuario.pin_hash):
        usuario.intentos_fallidos += 1
        if debe_bloquear(usuario.intentos_fallidos):
            usuario.bloqueado_hasta = calcular_bloqueo_hasta(ahora)
        await session.commit()
        raise HTTPException(401, "Nombre o PIN incorrecto")

    usuario.intentos_fallidos = 0
    usuario.bloqueado_hasta = None
    await session.commit()

    _fijar_cookie_sesion(response, request, usuario.id)
    return _personaje_de(usuario)


@router.post("/logout", status_code=204)
async def logout(response: Response):
    response.delete_cookie(NOMBRE_COOKIE)


@router.get("/me", response_model=PersonajeOut)
async def me(usuario: Usuario = Depends(get_usuario_actual)):
    return _personaje_de(usuario)


@router.get("/historial", response_model=list[EventoXpOut])
async def historial(
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    stmt = (
        select(XpEvento)
        .where(XpEvento.usuario_id == usuario.id)
        .order_by(XpEvento.created_at.desc())
        .limit(20)
    )
    eventos = (await session.execute(stmt)).scalars().all()
    return [EventoXpOut.model_validate(e) for e in eventos]


@router.get("/ranking", response_model=list[RankingItemOut])
async def ranking(session: AsyncSession = Depends(get_session)):
    stmt = select(Usuario).order_by(Usuario.xp.desc()).limit(10)
    usuarios = (await session.execute(stmt)).scalars().all()
    return [
        RankingItemOut(nombre=u.nombre, avatar=u.avatar, nivel=nivel_y_progreso(u.xp).nivel, xp=u.xp)
        for u in usuarios
    ]


@router.post("/heartbeat", status_code=204)
async def heartbeat(
    usuario: Usuario = Depends(get_usuario_actual),
    session: AsyncSession = Depends(get_session),
):
    await session.execute(
        update(Usuario).where(Usuario.id == usuario.id).values(ultima_actividad=datetime.now(timezone.utc))
    )
    await session.commit()


@router.get("/en-linea", response_model=list[RankingItemOut])
async def en_linea(session: AsyncSession = Depends(get_session)):
    ahora = datetime.now(timezone.utc)
    stmt = select(Usuario).order_by(Usuario.xp.desc())
    usuarios = (await session.execute(stmt)).scalars().all()
    return [
        RankingItemOut(nombre=u.nombre, avatar=u.avatar, nivel=nivel_y_progreso(u.xp).nivel, xp=u.xp)
        for u in usuarios
        if esta_en_linea(u.ultima_actividad, ahora)
    ]
