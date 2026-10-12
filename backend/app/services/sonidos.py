from collections.abc import Iterable

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import Sonido, SonidoPreferencia

# Interruptores que tiene cada sonido en el catálogo, en el orden en que se
# muestran. El frontend replica esta lista (lib/sonidos.ts).
ACCIONES: tuple[str, ...] = ("error", "exito", "compra", "victoria", "derrota")

# Cada acción del usuario suena con los sonidos marcados para una acción del
# catálogo: las dos de mesa con uno de éxito, el aviso de error con uno de
# error, y compra / victoria / derrota con los suyos. El frontend replica este
# mapa (lib/sonidos.ts) para resolver qué reproducir.
ACCION_POR_EVENTO: dict[str, str] = {
    "guardar_mesa": "exito",
    "cerrar_mesa": "exito",
    "guardar_registro": "exito",
    "error": "error",
    "compra": "compra",
    "victoria": "victoria",
    "derrota": "derrota",
}

# Cuánto pesa un sonido en el sorteo de su acción si nadie lo ajustó, y los
# límites de lo que se puede ajustar. Un peso 3 suena el triple de seguido que
# un peso 1 dentro de la misma acción. El tope es 10 porque la pantalla lo
# ajusta con una barra: de 1 a 100 no se podría arrastrar con precisión, y 10x
# ya es una diferencia enorme.
PESO_NORMAL = 1
PESO_MINIMO = 1
PESO_MAXIMO = 10

CARPETA_STORAGE = "sonidos"


class SonidoError(Exception):
    pass


def accion_de_evento(evento: str) -> str:
    try:
        return ACCION_POR_EVENTO[evento]
    except KeyError:
        raise SonidoError(f"Evento desconocido: {evento}") from None


def validar_sonido_para_evento(sonido: Sonido | None, evento: str) -> None:
    """Un usuario solo puede elegir para una acción un sonido que el catálogo
    tenga marcado para ella: no tiene sentido que "cerrar mesa" suene a error."""
    if sonido is None:
        raise SonidoError("El sonido no existe")
    esperada = accion_de_evento(evento)
    if esperada not in sonido.acciones:
        raise SonidoError(f"El sonido no está marcado para la acción '{esperada}'")


def normalizar_acciones(acciones: Iterable[str]) -> list[str]:
    """Sin repetidos y en el orden canónico de ACCIONES, para que el catálogo
    se vea igual para todos sin importar en qué orden se marcaron."""
    conjunto = set(acciones)
    desconocidas = conjunto - set(ACCIONES)
    if desconocidas:
        raise SonidoError(f"Acción desconocida: {', '.join(sorted(desconocidas))}")
    return [a for a in ACCIONES if a in conjunto]


def con_accion(acciones: Iterable[str], accion: str, marcada: bool) -> list[str]:
    """Lista de acciones con `accion` puesta o quitada."""
    if accion not in ACCIONES:
        raise SonidoError(f"Acción desconocida: {accion}")
    conjunto = set(acciones)
    if marcada:
        conjunto.add(accion)
    else:
        conjunto.discard(accion)
    return normalizar_acciones(conjunto)


def con_peso(pesos: dict[str, int], accion: str, peso: int) -> dict[str, int]:
    """Pesos con `accion` ajustada. El peso normal no se guarda: así el JSON
    solo lista lo que alguien cambió a propósito."""
    if accion not in ACCIONES:
        raise SonidoError(f"Acción desconocida: {accion}")
    if not PESO_MINIMO <= peso <= PESO_MAXIMO:
        raise SonidoError(f"El peso debe estar entre {PESO_MINIMO} y {PESO_MAXIMO}")
    nuevos = {a: p for a, p in pesos.items() if a != accion}
    if peso != PESO_NORMAL:
        nuevos[accion] = peso
    return {a: nuevos[a] for a in ACCIONES if a in nuevos}


def sin_pesos_huerfanos(pesos: dict[str, int], acciones: Iterable[str]) -> dict[str, int]:
    """Quita el peso de las acciones que ya no están marcadas: un peso sin su
    acción no se usa para nada y confundiría si alguien la vuelve a marcar."""
    marcadas = set(acciones)
    return {a: p for a, p in pesos.items() if a in marcadas}


async def guardar_preferencia(
    session: AsyncSession,
    usuario_id: int,
    evento: str,
    sonido_id: int | None,
    silenciado: bool,
) -> SonidoPreferencia:
    """Upsert por (usuario, evento). Silenciar gana sobre el sonido elegido: se
    guarda sonido_id=None para que al reactivar vuelva al aleatorio."""
    accion_de_evento(evento)
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
