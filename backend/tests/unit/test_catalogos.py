from app.models import Modulo
from app.routers.catalogos import _consulta_nombre_existente


def test_consulta_nombre_existente_compara_en_minusculas():
    stmt = _consulta_nombre_existente(Modulo, "tramites e.")

    sql = str(stmt.compile(compile_kwargs={"literal_binds": True})).lower()

    assert "lower(modulos.nombre) = 'tramites e.'" in sql


def test_consulta_nombre_existente_usa_la_tabla_del_modelo():
    stmt = _consulta_nombre_existente(Modulo, "valor nuevo")

    sql = str(stmt.compile(compile_kwargs={"literal_binds": True})).lower()

    assert "from modulos" in sql
