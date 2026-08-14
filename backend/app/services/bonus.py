from datetime import date, datetime, time

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import BonusRegla, Mesa, Registro
from app.services.logros import INICIO_RECTA_FINAL, ULTIMOS_MINUTOS_DIA, limites_del_dia_utc

UMBRAL_VOLUMEN_ALTO_DIA = 10
MULTIPLO_CRITICO_SOPORTES = 5
FACTOR_CRITICO = 2.0

CLAVE_HORA_CIERRE_TARDIO = "hora_cierre_tardio"
CLAVE_VOLUMEN_ALTO_DIA = "volumen_alto_dia"


async def reglas_activas(session: AsyncSession) -> dict[str, BonusRegla]:
    filas = (await session.execute(select(BonusRegla))).scalars().all()
    return {r.clave: r for r in filas}


async def contar_actividad_dia(session: AsyncSession, dia: date) -> int:
    """Mesas cerradas + soportes registrados ese día, para el bono de volumen alto."""
    inicio_dia_naive = datetime.combine(dia, time.min)
    fin_dia_naive = datetime.combine(dia, time.max)
    mesas_cerradas = await session.scalar(
        select(func.count()).select_from(Mesa).where(Mesa.fecha_cierre_real.between(inicio_dia_naive, fin_dia_naive))
    )
    inicio_utc, fin_utc = limites_del_dia_utc(dia)
    soportes_creados = await session.scalar(
        select(func.count()).select_from(Registro).where(Registro.created_at.between(inicio_utc, fin_utc))
    )
    return (mesas_cerradas or 0) + (soportes_creados or 0)


async def contar_soportes_dia(session: AsyncSession, dia: date) -> int:
    inicio_utc, fin_utc = limites_del_dia_utc(dia)
    total = await session.scalar(
        select(func.count()).select_from(Registro).where(Registro.created_at.between(inicio_utc, fin_utc))
    )
    return total or 0


def es_critico_por_horario(momento_local: datetime) -> bool:
    return momento_local.time() >= ULTIMOS_MINUTOS_DIA


def es_critico_por_soportes(numero_soporte_del_dia: int) -> bool:
    return numero_soporte_del_dia > 0 and numero_soporte_del_dia % MULTIPLO_CRITICO_SOPORTES == 0


def calcular_bono(
    momento_local: datetime, conteo_actividad_dia: int, reglas: dict[str, BonusRegla]
) -> tuple[int, list[str]]:
    """Porcentaje total aplicable (solo de reglas activas) y sus nombres, según la
    hora del cierre/registro y el volumen de actividad del día."""
    porcentaje_total = 0
    etiquetas: list[str] = []

    regla_hora = reglas.get(CLAVE_HORA_CIERRE_TARDIO)
    if regla_hora and regla_hora.activo and momento_local.time() >= INICIO_RECTA_FINAL:
        porcentaje_total += regla_hora.porcentaje
        etiquetas.append(regla_hora.nombre)

    regla_volumen = reglas.get(CLAVE_VOLUMEN_ALTO_DIA)
    if regla_volumen and regla_volumen.activo and conteo_actividad_dia >= UMBRAL_VOLUMEN_ALTO_DIA:
        porcentaje_total += regla_volumen.porcentaje
        etiquetas.append(regla_volumen.nombre)

    return porcentaje_total, etiquetas


def aplicar_bono_y_critico(cantidad_base: int, porcentaje_bono: int, es_critico: bool) -> int:
    factor = 1 + porcentaje_bono / 100
    if es_critico:
        factor *= FACTOR_CRITICO
    return max(1, round(cantidad_base * factor))


async def porcentaje_bono_del_momento(session: AsyncSession, momento_local: datetime) -> tuple[int, list[str]]:
    """Porcentaje de bono (y las reglas que lo componen) aplicable a un evento de
    XP/daño en `momento_local`, según reglas activas y actividad del día."""
    reglas = await reglas_activas(session)
    conteo = await contar_actividad_dia(session, momento_local.date())
    return calcular_bono(momento_local, conteo, reglas)


async def es_critico_soporte(session: AsyncSession, momento_local: datetime) -> bool:
    """Golpe crítico si cae en los últimos minutos del día o si es múltiplo de
    MULTIPLO_CRITICO_SOPORTES en el conteo de soportes del día."""
    numero_del_dia = await contar_soportes_dia(session, momento_local.date())
    return es_critico_por_horario(momento_local) or es_critico_por_soportes(numero_del_dia)
