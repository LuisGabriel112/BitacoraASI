from typing import Protocol

UMBRAL_MINIMO_GRUPO = 3
MUESTRA_MAXIMA = 12


class MesaConSolucion(Protocol):
    """Lo mínimo que necesita el agrupador (DIP): no depende del ORM completo."""

    categoria_id: int
    tipo_solucion: str | None
    solucion: str | None


def agrupar_por_categoria_y_tipo(mesas: list[MesaConSolucion]) -> dict[tuple[int, str | None], list]:
    """Agrupa por (categoria_id, tipo_solucion); descarta grupos con menos
    de UMBRAL_MINIMO_GRUPO mesas — sintetizar un patrón de 1-2 casos no
    aporta más que leer la mesa original."""
    grupos: dict[tuple[int, str | None], list] = {}
    for mesa in mesas:
        clave = (mesa.categoria_id, mesa.tipo_solucion)
        grupos.setdefault(clave, []).append(mesa)
    return {clave: lista for clave, lista in grupos.items() if len(lista) >= UMBRAL_MINIMO_GRUPO}


def muestra_representativa(soluciones: list[str], limite: int = MUESTRA_MAXIMA) -> list[str]:
    """Textos únicos (sin repetidos exactos), limitados a `limite`, para no
    mandarle a Gemini un prompt gigante ni puro texto duplicado."""
    unicas = list(dict.fromkeys(s.strip() for s in soluciones if s and s.strip()))
    return unicas[:limite]
