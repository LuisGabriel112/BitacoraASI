from datetime import datetime, timedelta


def tiempo_restante(ultimo_intento: datetime | None, ahora: datetime, cooldown: timedelta) -> timedelta:
    if ultimo_intento is None:
        return timedelta(0)
    return max(timedelta(0), cooldown - (ahora - ultimo_intento))


def puede_jugar(ultimo_intento: datetime | None, ahora: datetime, cooldown: timedelta) -> bool:
    return tiempo_restante(ultimo_intento, ahora, cooldown) <= timedelta(0)


REDUCCION_COOLDOWN_MAX_PCT = 90


def cooldown_efectivo(base: timedelta, reduccion_pct: int) -> timedelta:
    """Objetos de la tienda con bono de cooldown% reducen la espera base. El
    tope evita que varios objetos sumen 100% y dejen el minijuego sin espera."""
    return base * (1 - min(reduccion_pct, REDUCCION_COOLDOWN_MAX_PCT) / 100)
