from app.main import app


def test_docs_ocultos_por_defecto():
    assert app.docs_url is None
    assert app.redoc_url is None
    assert app.openapi_url is None
