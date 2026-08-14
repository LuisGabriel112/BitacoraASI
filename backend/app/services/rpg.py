from dataclasses import dataclass

XP_POR_ACCION = 5
XP_POR_LOGRO = 25


@dataclass(frozen=True)
class NivelInfo:
    nivel: int
    xp_en_nivel_actual: int
    xp_para_siguiente_nivel: int


def _xp_requerido_para_avanzar(nivel: int) -> int:
    return 50 * nivel * (nivel + 1)


def nivel_y_progreso(xp_total: int) -> NivelInfo:
    xp_restante = max(0, xp_total)
    nivel = 1
    while xp_restante >= _xp_requerido_para_avanzar(nivel):
        xp_restante -= _xp_requerido_para_avanzar(nivel)
        nivel += 1
    return NivelInfo(
        nivel=nivel,
        xp_en_nivel_actual=xp_restante,
        xp_para_siguiente_nivel=_xp_requerido_para_avanzar(nivel),
    )


_TITULOS_POR_NIVEL: list[tuple[int, str]] = [
    (500, "Divino"),
    (300, "Trascendente"),
    (200, "Inmortal"),
    (150, "Mítico"),
    (100, "Leyenda"),
    (50, "Maestro"),
    (25, "Experto"),
    (10, "Veterano"),
    (5, "Técnico"),
]


def titulo_para_nivel(nivel: int) -> str:
    for umbral, titulo in _TITULOS_POR_NIVEL:
        if nivel >= umbral:
            return titulo
    return "Aprendiz"
