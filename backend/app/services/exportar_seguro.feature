Característica: Neutralizar CSV/formula injection en exports

  Escenario: Texto normal se exporta sin cambios
    Dado un valor de celda "Se corrigió el importe en SIIP"
    Cuando se sanitiza para exportar
    Entonces el valor exportado es "Se corrigió el importe en SIIP"

  Escenario: Texto que empieza con "=" se neutraliza
    Dado un valor de celda "=HYPERLINK(\"http://evil.com\")"
    Cuando se sanitiza para exportar
    Entonces el valor exportado empieza con comilla y ya no es una fórmula

  Escenario: Texto que empieza con "+", "-" o "@" también se neutraliza
    Dado un valor de celda que empieza con "+", "-" o "@"
    Cuando se sanitiza para exportar
    Entonces el valor exportado empieza con comilla

  Escenario: Valores None o no-texto pasan sin cambios
    Dado un valor de celda None
    Cuando se sanitiza para exportar
    Entonces el valor exportado sigue siendo None
