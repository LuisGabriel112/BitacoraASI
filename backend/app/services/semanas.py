from datetime import date, timedelta


def semana_de(fecha: date) -> str:
    iso_year, iso_week, _ = fecha.isocalendar()
    return f"SEM {iso_week:02d} - {iso_year}"


def rango_semana(semana: str) -> tuple[date, date]:
    """Lunes y viernes de una etiqueta 'SEM NN - AAAA'."""
    numero, anio = semana.replace("SEM", "").split("-")
    lunes = date.fromisocalendar(int(anio.strip()), int(numero.strip()), 1)
    return lunes, lunes + timedelta(days=4)
