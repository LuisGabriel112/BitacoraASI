from datetime import datetime, timedelta


def tiempo_restante(ultimo_intento: datetime | None, ahora: datetime, cooldown: timedelta) -> timedelta:
    if ultimo_intento is None:
        return timedelta(0)
    return max(timedelta(0), cooldown - (ahora - ultimo_intento))


def puede_jugar(ultimo_intento: datetime | None, ahora: datetime, cooldown: timedelta) -> bool:
    return tiempo_restante(ultimo_intento, ahora, cooldown) <= timedelta(0)
