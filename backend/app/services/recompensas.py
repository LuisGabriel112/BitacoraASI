"""Tarifa de créditos por tipo de evento.

Soporte administrativo solo registra mesas (creada + cerrada) y su volumen es
mucho menor al de los soportes que atiende soporte operativo, pero pagar tarifa
completa por cada evento hacía que una mesa rindiera más que varios soportes.
Una mesa completa ahora paga, como máximo, lo mismo que un soporte.
"""

CREDITOS_POR_ACCION = 8

CREDITOS_POR_MOTIVO = {
    "mesa_creada": 2,
    "mesa_cerrada": 3,
}


def creditos_de(motivo: str) -> int:
    return CREDITOS_POR_MOTIVO.get(motivo, CREDITOS_POR_ACCION)
