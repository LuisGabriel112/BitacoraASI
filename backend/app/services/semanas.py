from datetime import date


def semana_de(fecha: date) -> str:
    iso_year, iso_week, _ = fecha.isocalendar()
    return f"SEM {iso_week:02d} - {iso_year}"
