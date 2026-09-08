"""Simulación autoritativa de una ronda del minijuego tipo Brawl Stars.

El servidor es dueño de los bots, los proyectiles y los impactos; el cliente
solo manda su propia posición y sus disparos. Así los dos jugadores de una sala
ven exactamente el mismo mundo, sin que la simulación se desincronice entre
navegadores.
"""

import math
import random
from dataclasses import dataclass, field

TICKS_POR_SEGUNDO = 20

ANCHO_ARENA = 360.0
ALTO_ARENA = 260.0
RADIO_PERSONAJE = 11.0
RADIO_PROYECTIL = 4.0
RADIO_IMPACTO = 13.0

VIDA_JUGADOR = 8
VIDA_BOT = 4
CANTIDAD_BOTS = 3
MAX_JUGADORES = 2

VELOCIDAD_BOT = 3.5
# Los disparos vuelan a 180 u/s en una arena de 360 de ancho: a 300 u/s cruzaban
# la arena tan rápido que no daba tiempo de esquivarlos ni de verlos en 3D.
VELOCIDAD_PROYECTIL = 9.0
DISTANCIA_PREFERIDA_BOT = 110.0
CADENCIA_BOT_TICKS = 45
CADENCIA_JUGADOR_TICKS = 5
# Dispersión de los bots. Sin ella los tres apuntaban al punto exacto del
# jugador y lo mataban en menos de 4 segundos aunque estuviera esquivando.
DISPERSION_BOT_RAD = 0.22
TICKS_RONDA = TICKS_POR_SEGUNDO * 30


@dataclass(frozen=True)
class Muro:
    x: float
    y: float
    ancho: float
    alto: float


MUROS: tuple[Muro, ...] = (
    Muro(60.0, 170.0, 40.0, 44.0),
    Muro(160.0, 40.0, 40.0, 40.0),
    Muro(260.0, 160.0, 40.0, 44.0),
)

_APARICIONES = ((150.0, 210.0), (210.0, 210.0))
_ESQUINAS_BOT = ((30.0, 30.0), (330.0, 30.0), (330.0, 230.0))


@dataclass
class Jugador:
    id: str
    nombre: str
    avatar: str
    x: float
    y: float
    vida: int = VIDA_JUGADOR
    bajas: int = 0
    ultimo_disparo_tick: int = -CADENCIA_JUGADOR_TICKS


@dataclass
class Bot:
    id: int
    x: float
    y: float
    vida: int = VIDA_BOT


@dataclass
class Proyectil:
    id: int
    x: float
    y: float
    dx: float
    dy: float
    de_jugador: str | None


@dataclass
class Ronda:
    jugadores: dict[str, Jugador] = field(default_factory=dict)
    bots: list[Bot] = field(default_factory=list)
    proyectiles: list[Proyectil] = field(default_factory=list)
    tick: int = 0
    siguiente_proyectil_id: int = 1


def distancia(x1: float, y1: float, x2: float, y2: float) -> float:
    return math.hypot(x1 - x2, y1 - y2)


def direccion_hacia(x1: float, y1: float, x2: float, y2: float) -> tuple[float, float]:
    dist = distancia(x1, y1, x2, y2) or 1.0
    return (x2 - x1) / dist, (y2 - y1) / dist


def limitar_a_arena(x: float, y: float, radio: float) -> tuple[float, float]:
    return (
        min(ANCHO_ARENA - radio, max(radio, x)),
        min(ALTO_ARENA - radio, max(radio, y)),
    )


def _invade(x: float, y: float, muro: Muro, radio: float) -> bool:
    return (
        muro.x - radio < x < muro.x + muro.ancho + radio
        and muro.y - radio < y < muro.y + muro.alto + radio
    )


def toca_muro(x: float, y: float, radio: float) -> bool:
    return any(_invade(x, y, muro, radio) for muro in MUROS)


def dentro_de_arena(x: float, y: float) -> bool:
    return 0.0 <= x <= ANCHO_ARENA and 0.0 <= y <= ALTO_ARENA


def mover_con_colision(
    x: float, y: float, dx: float, dy: float, velocidad: float, radio: float
) -> tuple[float, float]:
    """Prueba el movimiento completo y, si un muro lo bloquea, cada eje por
    separado, para que el personaje se deslice pegado al muro en vez de trabarse."""
    candidatos = (
        (x + dx * velocidad, y + dy * velocidad),
        (x + dx * velocidad, y),
        (x, y + dy * velocidad),
    )
    for candidato_x, candidato_y in candidatos:
        destino = limitar_a_arena(candidato_x, candidato_y, radio)
        if not toca_muro(destino[0], destino[1], radio):
            return destino
    return x, y


def posicion_aparicion(indice: int) -> tuple[float, float]:
    return _APARICIONES[indice % len(_APARICIONES)]


def crear_bots(cantidad: int) -> list[Bot]:
    return [
        Bot(id=i, x=_ESQUINAS_BOT[i % len(_ESQUINAS_BOT)][0], y=_ESQUINAS_BOT[i % len(_ESQUINAS_BOT)][1])
        for i in range(cantidad)
    ]


def bot_debe_disparar(tick: int, indice_bot: int) -> bool:
    """Cada bot dispara en su propio turno: si todos tiraran en el mismo tick, la
    salva simultánea vaciaba la vida del jugador de golpe y era inesquivable."""
    desfase = indice_bot * (CADENCIA_BOT_TICKS // CANTIDAD_BOTS)
    return tick > desfase and (tick - desfase) % CADENCIA_BOT_TICKS == 0


def jugadores_vivos(ronda: Ronda) -> list[Jugador]:
    return [j for j in ronda.jugadores.values() if j.vida > 0]


def bots_vivos(ronda: Ronda) -> list[Bot]:
    return [b for b in ronda.bots if b.vida > 0]


def _jugador_mas_cercano(ronda: Ronda, x: float, y: float) -> Jugador | None:
    vivos = jugadores_vivos(ronda)
    if not vivos:
        return None
    return min(vivos, key=lambda j: distancia(x, y, j.x, j.y))


def mover_jugador(ronda: Ronda, jugador_id: str, x: float, y: float) -> None:
    """El cliente es dueño de su propio movimiento (para que se sienta inmediato),
    pero el servidor limita la posición a la arena y rechaza meterse en un muro."""
    jugador = ronda.jugadores.get(jugador_id)
    if jugador is None or jugador.vida <= 0:
        return
    destino_x, destino_y = limitar_a_arena(x, y, RADIO_PERSONAJE)
    if toca_muro(destino_x, destino_y, RADIO_PERSONAJE):
        return
    jugador.x, jugador.y = destino_x, destino_y


def _nuevo_proyectil(ronda: Ronda, x: float, y: float, dx: float, dy: float, de: str | None) -> None:
    ronda.proyectiles.append(Proyectil(id=ronda.siguiente_proyectil_id, x=x, y=y, dx=dx, dy=dy, de_jugador=de))
    ronda.siguiente_proyectil_id += 1


def disparar_jugador(ronda: Ronda, jugador_id: str, hacia_x: float, hacia_y: float) -> None:
    jugador = ronda.jugadores.get(jugador_id)
    if jugador is None or jugador.vida <= 0:
        return
    if ronda.tick - jugador.ultimo_disparo_tick < CADENCIA_JUGADOR_TICKS:
        return
    jugador.ultimo_disparo_tick = ronda.tick
    dx, dy = direccion_hacia(jugador.x, jugador.y, hacia_x, hacia_y)
    _nuevo_proyectil(ronda, jugador.x, jugador.y, dx, dy, jugador_id)


def _mover_bots(ronda: Ronda) -> None:
    for bot in bots_vivos(ronda):
        objetivo = _jugador_mas_cercano(ronda, bot.x, bot.y)
        if objetivo is None or distancia(bot.x, bot.y, objetivo.x, objetivo.y) <= DISTANCIA_PREFERIDA_BOT:
            continue
        dx, dy = direccion_hacia(bot.x, bot.y, objetivo.x, objetivo.y)
        bot.x, bot.y = mover_con_colision(bot.x, bot.y, dx, dy, VELOCIDAD_BOT, RADIO_PERSONAJE)


def _direccion_con_dispersion(bot: Bot, objetivo: Jugador) -> tuple[float, float]:
    dx, dy = direccion_hacia(bot.x, bot.y, objetivo.x, objetivo.y)
    angulo = math.atan2(dy, dx) + random.uniform(-DISPERSION_BOT_RAD, DISPERSION_BOT_RAD)
    return math.cos(angulo), math.sin(angulo)


def _disparar_bots(ronda: Ronda) -> None:
    for bot in bots_vivos(ronda):
        if not bot_debe_disparar(ronda.tick, bot.id):
            continue
        objetivo = _jugador_mas_cercano(ronda, bot.x, bot.y)
        if objetivo is None:
            continue
        dx, dy = _direccion_con_dispersion(bot, objetivo)
        _nuevo_proyectil(ronda, bot.x, bot.y, dx, dy, None)


def _avanzar_proyectiles(ronda: Ronda) -> None:
    for p in ronda.proyectiles:
        p.x += p.dx * VELOCIDAD_PROYECTIL
        p.y += p.dy * VELOCIDAD_PROYECTIL
    ronda.proyectiles = [
        p for p in ronda.proyectiles if dentro_de_arena(p.x, p.y) and not toca_muro(p.x, p.y, RADIO_PROYECTIL)
    ]


def _acreditar_baja(ronda: Ronda, jugador_id: str) -> None:
    autor = ronda.jugadores.get(jugador_id)
    if autor is not None:
        autor.bajas += 1


def _impacto_en_bot(ronda: Ronda, p: Proyectil) -> bool:
    if p.de_jugador is None:
        return False
    objetivo = next((b for b in bots_vivos(ronda) if distancia(p.x, p.y, b.x, b.y) <= RADIO_IMPACTO), None)
    if objetivo is None:
        return False
    objetivo.vida -= 1
    if objetivo.vida <= 0:
        _acreditar_baja(ronda, p.de_jugador)
    return True


def _impacto_en_jugador(ronda: Ronda, p: Proyectil) -> bool:
    if p.de_jugador is not None:
        return False
    objetivo = next((j for j in jugadores_vivos(ronda) if distancia(p.x, p.y, j.x, j.y) <= RADIO_IMPACTO), None)
    if objetivo is None:
        return False
    objetivo.vida -= 1
    return True


def _resolver_impactos(ronda: Ronda) -> None:
    ronda.proyectiles = [
        p for p in ronda.proyectiles if not _impacto_en_bot(ronda, p) and not _impacto_en_jugador(ronda, p)
    ]


def avanzar(ronda: Ronda) -> None:
    ronda.tick += 1
    _mover_bots(ronda)
    _disparar_bots(ronda)
    _avanzar_proyectiles(ronda)
    _resolver_impactos(ronda)


def ronda_terminada(ronda: Ronda) -> bool:
    return not bots_vivos(ronda) or not jugadores_vivos(ronda) or ronda.tick > TICKS_RONDA
