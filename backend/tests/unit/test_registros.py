from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest
from fastapi import HTTPException
from sqlalchemy.exc import IntegrityError

from app.routers import registros
from app.routers.registros import router as registros_router
from app.schemas import RegistroUpdate


def _registro(id_: int = 1) -> SimpleNamespace:
    return SimpleNamespace(id=id_)


def test_get_por_id_no_tapa_las_rutas_get_estaticas():
    """GET /{registro_id} sin tipar como int matchea cualquier segmento
    (incluido "panel", "reporte", etc): si se registra antes que esas rutas
    estáticas, Starlette la intercepta primero y devuelve 422 en vez de
    ejecutar el endpoint real. Debe ir siempre al final entre los GET."""
    rutas_get = [r.path for r in registros_router.routes if "GET" in r.methods]
    indice_dinamica = rutas_get.index("/registros/{registro_id}")

    for estatica in ("/registros", "/registros/panel", "/registros/reporte", "/registros/soportes-frecuentes", "/registros/export"):
        assert rutas_get.index(estatica) < indice_dinamica


def test_campos_a_actualizar_solo_incluye_lo_enviado():
    payload = RegistroUpdate(descripcion="Nueva descripción")

    assert registros._campos_a_actualizar(payload) == {"descripcion": "Nueva descripción"}


def test_campos_a_actualizar_vacio_si_nada_se_envia():
    assert registros._campos_a_actualizar(RegistroUpdate()) == {}


@pytest.mark.asyncio
async def test_obtener_registro_inexistente_da_404():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado

    with pytest.raises(HTTPException) as info:
        await registros.obtener_registro(1, session)

    assert info.value.status_code == 404


@pytest.mark.asyncio
async def test_editar_registro_inexistente_da_404():
    session = AsyncMock()
    session.get.return_value = None

    with pytest.raises(HTTPException) as info:
        await registros.editar_registro(1, RegistroUpdate(descripcion="X"), session)

    assert info.value.status_code == 404


@pytest.mark.asyncio
async def test_editar_registro_con_catalogo_invalido_da_400():
    session = AsyncMock()
    session.get.return_value = _registro()
    session.commit.side_effect = IntegrityError("update", {}, Exception("violates foreign key constraint"))

    with pytest.raises(HTTPException) as info:
        await registros.editar_registro(1, RegistroUpdate(empresa_id=999), session)

    assert info.value.status_code == 400
    session.rollback.assert_awaited_once()
