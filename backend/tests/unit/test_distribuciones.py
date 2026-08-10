from types import SimpleNamespace

from app.services.distribuciones import distribucion_por_categoria_solucion, distribucion_por_ventana


def _mesa(ventana_nombre: str | None, tipo_solucion: str | None):
    ventana = SimpleNamespace(nombre=ventana_nombre) if ventana_nombre else None
    return SimpleNamespace(ventana=ventana, tipo_solucion=tipo_solucion)


def test_distribucion_por_ventana_cuenta_y_ordena_descendente():
    mesas = [_mesa("Mañana", None), _mesa("Mañana", None), _mesa("Tarde", None)]

    resultado = distribucion_por_ventana(mesas)

    assert resultado == [("Mañana", 2), ("Tarde", 1)]


def test_distribucion_por_ventana_ignora_mesas_sin_ventana():
    mesas = [_mesa(None, None), _mesa("Tarde", None)]

    resultado = distribucion_por_ventana(mesas)

    assert resultado == [("Tarde", 1)]


def test_distribucion_por_categoria_solucion_cuenta_y_ordena_descendente():
    mesas = [
        _mesa(None, "Modificación en BD"),
        _mesa(None, "Seguimiento de proceso"),
        _mesa(None, "Modificación en BD"),
    ]

    resultado = distribucion_por_categoria_solucion(mesas)

    assert resultado == [("Modificación en BD", 2), ("Seguimiento de proceso", 1)]


def test_distribucion_por_categoria_solucion_ignora_mesas_sin_tipo():
    mesas = [_mesa(None, None), _mesa(None, "Seguimiento de proceso")]

    resultado = distribucion_por_categoria_solucion(mesas)

    assert resultado == [("Seguimiento de proceso", 1)]
