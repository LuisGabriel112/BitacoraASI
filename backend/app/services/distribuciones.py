from app.models import Mesa


def _contar_y_ordenar(conteos: dict[str, int]) -> list[tuple[str, int]]:
    return sorted(conteos.items(), key=lambda item: -item[1])


def distribucion_por_ventana(mesas: list[Mesa]) -> list[tuple[str, int]]:
    conteos: dict[str, int] = {}
    for m in mesas:
        if m.ventana:
            conteos[m.ventana.nombre] = conteos.get(m.ventana.nombre, 0) + 1
    return _contar_y_ordenar(conteos)


def distribucion_por_categoria_solucion(mesas: list[Mesa]) -> list[tuple[str, int]]:
    conteos: dict[str, int] = {}
    for m in mesas:
        if m.tipo_solucion:
            conteos[m.tipo_solucion] = conteos.get(m.tipo_solucion, 0) + 1
    return _contar_y_ordenar(conteos)
