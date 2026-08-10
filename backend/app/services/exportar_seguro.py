CARACTERES_FORMULA = ("=", "+", "-", "@", "\t", "\r")


def celda_segura(valor: str | None) -> str | None:
    """Neutraliza CSV/formula injection (CWE-1236): texto libre que empiece con
    estos caracteres, Excel/Sheets lo interpreta como formula al abrir el
    archivo (puede ejecutar comandos via DDE o exfiltrar datos con HYPERLINK).
    Anteponer comilla fuerza a que se trate como texto plano."""
    if isinstance(valor, str) and valor.startswith(CARACTERES_FORMULA):
        return "'" + valor
    return valor
