"""Salas en memoria del brawl multijugador.

Viven en el proceso, no en Postgres: son estado de una partida de 30 segundos a
20 ticks por segundo, y escribir eso en la base sería absurdo. Esto obliga a
correr el backend con un solo worker (el Dockerfile ya lo hace: `uvicorn` sin
`--workers`), porque dos procesos no compartirían el diccionario de salas.
"""

import uuid
from dataclasses import dataclass, field

from app.services.motor_brawl import (
    CANTIDAD_BOTS,
    MAX_JUGADORES,
    MUROS,
    TICKS_POR_SEGUNDO,
    TICKS_RONDA,
    Jugador,
    Ronda,
    crear_bots,
    posicion_aparicion,
)

# Con 6 segundos el multijugador jamás se activaba: dos personas tendrían que
# darle "Jugar" casi al mismo instante. La espera larga (con opción de arrancar
# antes) es lo que hace que coincidir sea posible en un equipo de cinco.
SEGUNDOS_ESPERA_EMPAREJAMIENTO = 75.0

ESTADO_ESPERANDO = "esperando"
ESTADO_JUGANDO = "jugando"
ESTADO_TERMINADA = "terminada"


@dataclass
class Sala:
    id: str
    creada_en: float
    ronda: Ronda = field(default_factory=Ronda)
    estado: str = ESTADO_ESPERANDO


class RegistroSalas:
    def __init__(self) -> None:
        self.salas: dict[str, Sala] = {}
        self._sala_por_jugador: dict[str, str] = {}

    def sala_de(self, jugador_id: str) -> Sala | None:
        sala_id = self._sala_por_jugador.get(jugador_id)
        return self.salas.get(sala_id) if sala_id else None

    def _sala_abierta(self) -> Sala | None:
        return next(
            (
                s
                for s in self.salas.values()
                if s.estado == ESTADO_ESPERANDO and len(s.ronda.jugadores) < MAX_JUGADORES
            ),
            None,
        )

    def _crear_sala(self, ahora: float) -> Sala:
        sala = Sala(id=uuid.uuid4().hex, creada_en=ahora)
        self.salas[sala.id] = sala
        return sala

    def entrar(self, jugador_id: str, nombre: str, avatar: str, ahora: float) -> Sala:
        sala = self._sala_abierta() or self._crear_sala(ahora)
        x, y = posicion_aparicion(len(sala.ronda.jugadores))
        sala.ronda.jugadores[jugador_id] = Jugador(id=jugador_id, nombre=nombre, avatar=avatar, x=x, y=y)
        self._sala_por_jugador[jugador_id] = sala.id
        if len(sala.ronda.jugadores) >= MAX_JUGADORES:
            iniciar(sala)
        return sala

    def salir(self, jugador_id: str) -> Sala | None:
        sala = self.sala_de(jugador_id)
        self._sala_por_jugador.pop(jugador_id, None)
        if sala is None:
            return None
        sala.ronda.jugadores.pop(jugador_id, None)
        if not sala.ronda.jugadores:
            self.salas.pop(sala.id, None)
        return sala

    def revisar_arranque(self, sala: Sala, ahora: float) -> None:
        """Con 5 personas en el equipo y turnos distintos, casi nunca hay alguien
        más conectado: tras la espera la sala arranca sola contra los bots."""
        if sala.estado != ESTADO_ESPERANDO:
            return
        if ahora - sala.creada_en >= SEGUNDOS_ESPERA_EMPAREJAMIENTO:
            iniciar(sala)


def iniciar(sala: Sala) -> None:
    sala.estado = ESTADO_JUGANDO
    sala.ronda.bots = crear_bots(CANTIDAD_BOTS)


class RegistroPases:
    """Pases de una sola ronda que saltan el cooldown.

    Viven en memoria como las salas. Se otorgan desde el servidor, nunca los
    pide el cliente: si el cliente pudiera declarar "jugué acompañado", saltarse
    la espera sería trivial.
    """

    def __init__(self) -> None:
        self._con_pase: set[str] = set()

    def otorgar(self, jugador_id: str) -> None:
        self._con_pase.add(jugador_id)

    def consumir(self, jugador_id: str) -> bool:
        if jugador_id not in self._con_pase:
            return False
        self._con_pase.discard(jugador_id)
        return True


def otorgar_pases_si_hubo_rival(sala: Sala, pases: RegistroPases) -> None:
    if len(sala.ronda.jugadores) < 2:
        return
    for jugador_id in sala.ronda.jugadores:
        pases.otorgar(jugador_id)


def _muros_para_cliente() -> list[dict]:
    return [{"x": m.x, "y": m.y, "ancho": m.ancho, "alto": m.alto} for m in MUROS]


def _jugadores_para_cliente(sala: Sala) -> list[dict]:
    return [
        {
            "id": j.id,
            "nombre": j.nombre,
            "avatar": j.avatar,
            "x": round(j.x, 1),
            "y": round(j.y, 1),
            "vida": j.vida,
            "bajas": j.bajas,
        }
        for j in sala.ronda.jugadores.values()
    ]


def estado_para_cliente(sala: Sala) -> dict:
    ticks_restantes = max(0, TICKS_RONDA - sala.ronda.tick)
    return {
        "estado": sala.estado,
        "tick": sala.ronda.tick,
        "segundos_restantes": round(ticks_restantes / TICKS_POR_SEGUNDO, 1),
        "muros": _muros_para_cliente(),
        "jugadores": _jugadores_para_cliente(sala),
        "bots": [{"id": b.id, "x": round(b.x, 1), "y": round(b.y, 1), "vida": b.vida} for b in sala.ronda.bots],
        "proyectiles": [
            {"id": p.id, "x": round(p.x, 1), "y": round(p.y, 1), "aliado": p.de_jugador is not None}
            for p in sala.ronda.proyectiles
        ],
    }
