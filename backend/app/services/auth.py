from datetime import datetime, timedelta, timezone

import bcrypt
import jwt
from fastapi import Cookie, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import settings
from app.database import get_session
from app.models import Usuario

NOMBRE_COOKIE = "bitacora_sesion"
ALGORITMO = "HS256"
DIAS_EXPIRACION_TOKEN = 30
MAX_INTENTOS_FALLIDOS = 5
MINUTOS_BLOQUEO = 5


def hash_pin(pin: str) -> str:
    return bcrypt.hashpw(pin.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")


def verificar_pin(pin: str, pin_hash: str) -> bool:
    return bcrypt.checkpw(pin.encode("utf-8"), pin_hash.encode("utf-8"))


def crear_token(usuario_id: int) -> str:
    expira = datetime.now(timezone.utc) + timedelta(days=DIAS_EXPIRACION_TOKEN)
    return jwt.encode({"usuario_id": usuario_id, "exp": expira}, settings.secret_key, algorithm=ALGORITMO)


def leer_token(token: str) -> int | None:
    try:
        payload = jwt.decode(token, settings.secret_key, algorithms=[ALGORITMO])
    except jwt.PyJWTError:
        return None
    return payload.get("usuario_id")


def debe_bloquear(intentos_fallidos: int) -> bool:
    return intentos_fallidos >= MAX_INTENTOS_FALLIDOS


def calcular_bloqueo_hasta(ahora: datetime) -> datetime:
    return ahora + timedelta(minutes=MINUTOS_BLOQUEO)


def sigue_bloqueado(bloqueado_hasta: datetime | None, ahora: datetime) -> bool:
    return bloqueado_hasta is not None and ahora < bloqueado_hasta


def normalizar_nombre(nombre: str) -> str:
    return " ".join(nombre.split()).casefold()


async def get_usuario_actual(
    bitacora_sesion: str | None = Cookie(default=None),
    session: AsyncSession = Depends(get_session),
) -> Usuario:
    usuario_id = leer_token(bitacora_sesion) if bitacora_sesion else None
    if usuario_id is None:
        raise HTTPException(401, "No hay sesión activa")
    usuario = await session.get(Usuario, usuario_id)
    if usuario is None:
        raise HTTPException(401, "No hay sesión activa")
    return usuario
