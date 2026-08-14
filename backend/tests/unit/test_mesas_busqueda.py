from datetime import date

from sqlalchemy import select
from sqlalchemy.dialects import postgresql

from app.models import Mesa
from app.routers.mesas import _aplicar_filtros

_SIN_FILTROS = dict(
    categoria_id=None, solicitante_id=None, resolutor_id=None, ventana_id=None,
    semana=None, fecha_desde=None, fecha_hasta=None, buscar=None, estado=None,
)


def _sql(stmt) -> str:
    return str(stmt.compile(dialect=postgresql.dialect(), compile_kwargs={"literal_binds": True}))


def test_buscar_incluye_nombre_del_solicitante():
    stmt = _aplicar_filtros(select(Mesa), **{**_SIN_FILTROS, "buscar": "Contraloría"})

    sql = _sql(stmt)
    assert "EXISTS" in sql
    assert "solicitantes_mesa" in sql
    assert "ILIKE" in sql


def test_buscar_sigue_filtrando_codigo_titulo_descripcion_solucion():
    stmt = _aplicar_filtros(select(Mesa), **{**_SIN_FILTROS, "buscar": "x"})

    sql = _sql(stmt)
    for columna in ("mesas.codigo", "mesas.titulo", "mesas.descripcion", "mesas.solucion"):
        assert columna in sql


def test_buscar_vacio_no_agrega_condicion_de_texto():
    stmt = _aplicar_filtros(select(Mesa), **_SIN_FILTROS)

    sql = _sql(stmt)
    assert "ILIKE" not in sql
    assert "EXISTS" not in sql


def test_actividad_desde_filtra_por_carga_o_cierre():
    stmt = _aplicar_filtros(select(Mesa), **{**_SIN_FILTROS, "actividad_desde": date(2026, 8, 7)})

    sql = _sql(stmt)
    assert "mesas.fecha_carga >=" in sql
    assert "mesas.fecha_cierre_real >=" in sql


def test_sin_actividad_desde_no_agrega_ese_filtro():
    stmt = _aplicar_filtros(select(Mesa), **_SIN_FILTROS)

    sql = _sql(stmt)
    assert "fecha_cierre_real >=" not in sql
