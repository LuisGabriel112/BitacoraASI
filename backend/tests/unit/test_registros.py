from datetime import date, datetime
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest
from fastapi import HTTPException
from sqlalchemy.exc import IntegrityError

from app.routers import registros
from app.routers.registros import router as registros_router
from app.schemas import RegistroCreate, RegistroUpdate


def _registro(id_: int = 1) -> SimpleNamespace:
    return SimpleNamespace(id=id_)


def _catalogo_item(id_: int, nombre: str, usuario_id: int | None = None) -> SimpleNamespace:
    return SimpleNamespace(id=id_, nombre=nombre, usuario_id=usuario_id)


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


@pytest.mark.asyncio
async def test_crear_registro_da_creditos_de_tienda(monkeypatch):
    registro_creado = SimpleNamespace(
        id=1, fecha=date(2026, 8, 3), semana="SEM 32 - 2026", descripcion="No entra",
        trello_card_id=None, created_at=datetime(2026, 8, 3, 16, 0),
        empresa=_catalogo_item(1, "Emp"), sistema=_catalogo_item(1, "Sis"),
        medio=_catalogo_item(1, "Med"), modulo=_catalogo_item(1, "Mod"),
        atendio=_catalogo_item(1, "Ana", usuario_id=42),
    )
    monkeypatch.setattr(registros, "_get_registro", AsyncMock(return_value=registro_creado))
    monkeypatch.setattr(registros, "porcentaje_bono_del_momento", AsyncMock(return_value=(0, [])))
    monkeypatch.setattr(registros, "es_critico_soporte", AsyncMock(return_value=False))
    monkeypatch.setattr(registros, "otorgar_xp", AsyncMock())
    monkeypatch.setattr(registros, "danar_jefe", AsyncMock())
    creditos_otorgados = AsyncMock()
    monkeypatch.setattr(registros, "otorgar_creditos", creditos_otorgados)
    monkeypatch.setattr(registros, "evaluar_logros_registro", AsyncMock(return_value=[]))
    monkeypatch.setattr(registros, "trello_configurado", lambda: False)

    session = AsyncMock()
    session.add = MagicMock()
    payload = RegistroCreate(
        fecha=date(2026, 8, 3), empresa_id=1, sistema_id=1, medio_id=1, modulo_id=1, atendio_id=1,
        descripcion="No entra",
    )

    await registros.crear_registro(payload, session)

    creditos_otorgados.assert_awaited_once()
    args = creditos_otorgados.await_args.args
    kwargs = creditos_otorgados.await_args.kwargs
    assert args[1] == "Ana"
    assert args[2] == registros.CREDITOS_POR_ACCION
    assert args[3] == "registro_creado"
    assert kwargs["usuario_id_directo"] == 42
