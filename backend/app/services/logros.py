from datetime import date, datetime, time, timedelta

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import Mesa, Registro

INICIO_JORNADA = time(9, 0)
FIN_JORNADA = time(18, 0)
INICIO_RECTA_FINAL = time(17, 0)
ULTIMOS_MINUTOS_DIA = time(23, 50)

VIERNES = 4
SABADO = 5


def _reglas_de_horario(momento: datetime, sufijo: str = "") -> list[str]:
    logros: list[str] = []
    hora = momento.time()
    dia_semana = momento.weekday()

    if hora < INICIO_JORNADA:
        logros.append(f"antes_de_jornada{sufijo}")
    if INICIO_RECTA_FINAL <= hora < FIN_JORNADA:
        logros.append(f"ultimas_del_dia{sufijo}")
        if dia_semana == VIERNES:
            logros.append(f"ultima_hora_viernes{sufijo}")
    if hora >= FIN_JORNADA:
        logros.append(f"despues_de_hora{sufijo}")
    if hora >= ULTIMOS_MINUTOS_DIA:
        logros.append(f"ultimos_10_min_dia{sufijo}")
    if dia_semana == SABADO:
        logros.append(f"sabado_guardia{sufijo}")

    return logros


def reglas_de_horario(cierre: datetime) -> list[str]:
    """Logros que dependen solo de la hora/día de cierre — sin tocar la base de datos,
    para poder probarlos de forma aislada."""
    return _reglas_de_horario(cierre)


def reglas_de_horario_soporte(momento: datetime) -> list[str]:
    """Igual que reglas_de_horario pero con claves propias (sufijo _soporte), para que
    el mensaje mostrado no diga "cerrada" (lenguaje de mesas) sobre un soporte."""
    return _reglas_de_horario(momento, sufijo="_soporte")


def _inicio_semana(dia: date) -> datetime:
    lunes = dia - timedelta(days=dia.weekday())
    return datetime.combine(lunes, time.min)


async def evaluar_logros(session: AsyncSession, mesa: Mesa) -> list[str]:
    """Logros de una mesa recién cerrada: reglas de horario + conteos (primera del día
    por resolutor, décima del día entre todos, primera de la semana) contra la BD."""
    if mesa.fecha_cierre_real is None:
        return []

    logros = reglas_de_horario(mesa.fecha_cierre_real)

    dia = mesa.fecha_cierre_real.date()
    inicio_dia = datetime.combine(dia, time.min)
    fin_dia = datetime.combine(dia, time.max)
    inicio_semana = _inicio_semana(dia)
    fin_semana = inicio_semana + timedelta(days=7)

    total_dia_resolutor = await session.scalar(
        select(func.count())
        .select_from(Mesa)
        .where(
            Mesa.resolutor_id == mesa.resolutor_id,
            Mesa.fecha_cierre_real.between(inicio_dia, fin_dia),
        )
    )
    if total_dia_resolutor == 1:
        logros.append("primera_dia_resolutor")

    total_dia = await session.scalar(
        select(func.count()).select_from(Mesa).where(Mesa.fecha_cierre_real.between(inicio_dia, fin_dia))
    )
    if total_dia == 10:
        logros.append("decima_dia")

    total_semana = await session.scalar(
        select(func.count())
        .select_from(Mesa)
        .where(Mesa.fecha_cierre_real >= inicio_semana, Mesa.fecha_cierre_real < fin_semana)
    )
    if total_semana == 1:
        logros.append("primera_semana")

    return logros


async def evaluar_logros_registro(session: AsyncSession, registro: Registro) -> list[str]:
    """Logros de un soporte recién creado: reglas de horario + conteos (primero del día
    por agente, décimo del día entre todos, primero de la semana) contra la BD."""
    logros = reglas_de_horario_soporte(registro.created_at)

    dia = registro.created_at.date()
    inicio_dia = datetime.combine(dia, time.min)
    fin_dia = datetime.combine(dia, time.max)
    inicio_semana = _inicio_semana(dia)
    fin_semana = inicio_semana + timedelta(days=7)

    total_dia_agente = await session.scalar(
        select(func.count())
        .select_from(Registro)
        .where(
            Registro.atendio_id == registro.atendio_id,
            Registro.created_at.between(inicio_dia, fin_dia),
        )
    )
    if total_dia_agente == 1:
        logros.append("primer_soporte_dia_agente")

    total_dia = await session.scalar(
        select(func.count()).select_from(Registro).where(Registro.created_at.between(inicio_dia, fin_dia))
    )
    if total_dia == 10:
        logros.append("decimo_soporte_dia")

    total_semana = await session.scalar(
        select(func.count())
        .select_from(Registro)
        .where(Registro.created_at >= inicio_semana, Registro.created_at < fin_semana)
    )
    if total_semana == 1:
        logros.append("primer_soporte_semana")

    return logros
