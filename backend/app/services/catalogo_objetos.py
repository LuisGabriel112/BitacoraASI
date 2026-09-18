"""Catálogo de objetos de la tienda semanal.

Tres niveles: básicos, combinados de dos básicos y combinados de dos
combinados. Los ids nunca se renombran ni se borran — InventarioItem.item_id
guarda ids de semanas pasadas y objeto_por_id() reventaría al leerlos.
"""

from dataclasses import dataclass


@dataclass(frozen=True)
class Objeto:
    id: str
    nombre: str
    descripcion: str
    costo: int
    danio_pct: int = 0
    critico_pct: int = 0
    cooldown_pct: int = 0
    xp_pct: int = 0
    requiere: tuple[str, str] | None = None


BASICOS: tuple[Objeto, ...] = (
    Objeto("guante_estatico", "Guante Estático", "+4% de daño al jefe.", 25, danio_pct=4),
    Objeto("lente_analitico", "Lente Analítico", "+5% de probabilidad de crítico.", 28, critico_pct=5),
    Objeto("bateria_fria", "Batería Fría", "-10% de cooldown en los minijuegos.", 26, cooldown_pct=10),
    Objeto("libreta_turno", "Libreta de Turno", "+6% de XP ganado.", 22, xp_pct=6),
    Objeto("daga_oxidada", "Daga Oxidada", "+5% de daño al jefe.", 40, danio_pct=5),
    Objeto(
        "nucleo_inestable", "Núcleo Inestable",
        "+8% de probabilidad de golpe crítico (x2 daño).", 40, critico_pct=8,
    ),
    Objeto("chip_overclock", "Chip Overclock", "-15% de cooldown en los minijuegos.", 35, cooldown_pct=15),
    Objeto("manual_pirata", "Manual Pirata", "+10% de XP ganado.", 30, xp_pct=10),
    Objeto("martillo_ticket", "Martillo de Tickets", "+7% de daño al jefe.", 50, danio_pct=7),
    Objeto("dado_cargado", "Dado Cargado", "+10% de probabilidad de crítico.", 55, critico_pct=10),
    Objeto("macro_silenciosa", "Macro Silenciosa", "-20% de cooldown en los minijuegos.", 55, cooldown_pct=20),
    Objeto("cafe_triple", "Café Triple", "+12% de XP ganado.", 45, xp_pct=12),
)

COMBINADOS: tuple[Objeto, ...] = (
    Objeto(
        "filo_sangriento", "Filo Sangriento",
        "Combina Daga Oxidada + Núcleo Inestable. +12% de daño, +15% de crítico.",
        60, danio_pct=12, critico_pct=15, requiere=("daga_oxidada", "nucleo_inestable"),
    ),
    Objeto(
        "terminal_hackeada", "Terminal Hackeada",
        "Combina Chip Overclock + Manual Pirata. -25% de cooldown, +15% de XP.",
        50, cooldown_pct=25, xp_pct=15, requiere=("chip_overclock", "manual_pirata"),
    ),
    Objeto(
        "punio_ionizado", "Puño Ionizado",
        "Combina Guante Estático + Lente Analítico. +10% de daño, +9% de crítico.",
        45, danio_pct=10, critico_pct=9, requiere=("guante_estatico", "lente_analitico"),
    ),
    Objeto(
        "turno_optimo", "Turno Óptimo",
        "Combina Batería Fría + Libreta de Turno. -18% de cooldown, +12% de XP.",
        40, cooldown_pct=18, xp_pct=12, requiere=("bateria_fria", "libreta_turno"),
    ),
    Objeto(
        "mazo_probabilidad", "Mazo de Probabilidad",
        "Combina Martillo de Tickets + Dado Cargado. +14% de daño, +16% de crítico.",
        70, danio_pct=14, critico_pct=16, requiere=("martillo_ticket", "dado_cargado"),
    ),
    Objeto(
        "script_de_guardia", "Script de Guardia",
        "Combina Macro Silenciosa + Café Triple. -30% de cooldown, +20% de XP.",
        65, cooldown_pct=30, xp_pct=20, requiere=("macro_silenciosa", "cafe_triple"),
    ),
    Objeto(
        "bisturi_estatico", "Bisturí Estático",
        "Combina Daga Oxidada + Guante Estático. +12% de daño.",
        50, danio_pct=12, requiere=("daga_oxidada", "guante_estatico"),
    ),
    Objeto(
        "ojo_critico", "Ojo Crítico",
        "Combina Núcleo Inestable + Lente Analítico. +16% de crítico.",
        50, critico_pct=16, requiere=("nucleo_inestable", "lente_analitico"),
    ),
    Objeto(
        "reloj_roto", "Reloj Roto",
        "Combina Chip Overclock + Batería Fría. -28% de cooldown.",
        48, cooldown_pct=28, requiere=("chip_overclock", "bateria_fria"),
    ),
    Objeto(
        "biblia_del_turno", "Biblia del Turno",
        "Combina Manual Pirata + Libreta de Turno. +20% de XP.",
        42, xp_pct=20, requiere=("manual_pirata", "libreta_turno"),
    ),
)

LEGENDARIOS: tuple[Objeto, ...] = (
    Objeto(
        "guadania_del_sla", "Guadaña del SLA",
        "Combina Filo Sangriento + Mazo de Probabilidad. +32% de daño, +30% de crítico.",
        110, danio_pct=32, critico_pct=30, requiere=("filo_sangriento", "mazo_probabilidad"),
    ),
    Objeto(
        "consola_fantasma", "Consola Fantasma",
        "Combina Terminal Hackeada + Script de Guardia. -55% de cooldown, +40% de XP.",
        100, cooldown_pct=55, xp_pct=40, requiere=("terminal_hackeada", "script_de_guardia"),
    ),
    Objeto(
        "protocolo_carnicero", "Protocolo Carnicero",
        "Combina Bisturí Estático + Puño Ionizado. +26% de daño, +12% de crítico.",
        95, danio_pct=26, critico_pct=12, requiere=("bisturi_estatico", "punio_ionizado"),
    ),
    Objeto(
        "kernel_paciente", "Kernel Paciente",
        "Combina Reloj Roto + Biblia del Turno. -34% de cooldown, +26% de XP.",
        90, cooldown_pct=34, xp_pct=26, requiere=("reloj_roto", "biblia_del_turno"),
    ),
    Objeto(
        "juicio_final", "Juicio Final",
        "Combina Ojo Crítico + Guadaña del SLA. +45% de daño, +50% de crítico.",
        160, danio_pct=45, critico_pct=50, requiere=("ojo_critico", "guadania_del_sla"),
    ),
    Objeto(
        "turno_perfecto", "Turno Perfecto",
        "Combina Turno Óptimo + Consola Fantasma. -62% de cooldown, +70% de XP.",
        140, cooldown_pct=62, xp_pct=70, requiere=("turno_optimo", "consola_fantasma"),
    ),
)

OBJETOS: tuple[Objeto, ...] = BASICOS + COMBINADOS + LEGENDARIOS
