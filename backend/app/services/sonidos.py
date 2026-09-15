from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import Sonido, SonidoPreferencia

# Cada acción del usuario suena con una categoría del catálogo: las dos de
# mesa con un sonido de éxito, el aviso de error con uno de error. El
# frontend replica este mapa (lib/sonidos.ts) para resolver qué reproducir.
CATEGORIA_POR_EVENTO: dict[str, str] = {
    "guardar_mesa": "exito",
    "cerrar_mesa": "exito",
    "error": "error",
}

CARPETA_STORAGE = "sonidos"


class SonidoError(Exception):
    pass


def categoria_de_evento(evento: str) -> str:
    try:
        return CATEGORIA_POR_EVENTO[evento]
    except KeyError:
        raise SonidoError(f"Evento desconocido: {evento}") from None


def validar_sonido_para_evento(sonido: Sonido | None, evento: str) -> None:
    """Un usuario solo puede elegir para una acción un sonido de la categoría
    que le toca: no tiene sentido que "cerrar mesa" suene a error."""
    if sonido is None:
        raise SonidoError("El sonido no existe")
    esperada = categoria_de_evento(evento)
    if sonido.categoria != esperada:
        raise SonidoError(f"El sonido es de la categoría '{sonido.categoria}' y la acción espera '{esperada}'")


async def guardar_preferencia(
    session: AsyncSession,
    usuario_id: int,
    evento: str,
    sonido_id: int | None,
    silenciado: bool,
) -> SonidoPreferencia:
    """Upsert por (usuario, evento). Silenciar gana sobre el sonido elegido: se
    guarda sonido_id=None para que al reactivar vuelva al aleatorio."""
    categoria_de_evento(evento)
    if silenciado:
        sonido_id = None
    if sonido_id is not None:
        validar_sonido_para_evento(await session.get(Sonido, sonido_id), evento)

    stmt = select(SonidoPreferencia).where(
        SonidoPreferencia.usuario_id == usuario_id, SonidoPreferencia.evento == evento
    )
    preferencia = (await session.execute(stmt)).scalar_one_or_none()
    if preferencia is None:
        preferencia = SonidoPreferencia(usuario_id=usuario_id, evento=evento)
        session.add(preferencia)
    preferencia.sonido_id = sonido_id
    preferencia.silenciado = silenciado
    await session.commit()
    await session.refresh(preferencia)
    return preferencia
