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


def titulo_para_nivel(nivel: int) -> str:
    if nivel >= 10:
        return "Veterano"
    if nivel >= 5:
        return "Técnico"
    return "Aprendiz"
