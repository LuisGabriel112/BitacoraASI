from types import SimpleNamespace
from unittest.mock import AsyncMock

import pytest
from fastapi import HTTPException

from app.routers import tienda
from app.services.tienda import OBJETOS, TiendaError, objeto_por_id


@pytest.mark.asyncio
async def test_catalogo_devuelve_todos_los_objetos():
    resultado = await tienda.catalogo()

    assert len(resultado) == len(OBJETOS)
    assert {o.id for o in resultado} == {o.id for o in OBJETOS}


@pytest.mark.asyncio
async def test_catalogo_expone_los_requisitos_de_los_combinados():
    resultado = await tienda.catalogo()

    filo = next(o for o in resultado if o.id == "filo_sangriento")
    assert filo.requiere == ["daga_oxidada", "nucleo_inestable"]


@pytest.mark.asyncio
async def test_mi_tienda_devuelve_creditos_y_equipados(monkeypatch):
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=55))
    monkeypatch.setattr(tienda, "objetos_equipados", AsyncMock(return_value=[objeto_por_id("daga_oxidada")]))
    usuario = SimpleNamespace(id=7)
    session = AsyncMock()

    resultado = await tienda.mi_tienda(usuario, session)

    assert resultado.creditos_disponibles == 55
    assert [o.id for o in resultado.equipados] == ["daga_oxidada"]


@pytest.mark.asyncio
async def test_comprar_devuelve_el_estado_actualizado(monkeypatch):
    monkeypatch.setattr(tienda, "comprar_objeto", AsyncMock())
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=15))
    monkeypatch.setattr(tienda, "objetos_equipados", AsyncMock(return_value=[objeto_por_id("daga_oxidada")]))
    usuario = SimpleNamespace(id=7)
    session = AsyncMock()

    resultado = await tienda.comprar("daga_oxidada", usuario, session)

    assert resultado.creditos_disponibles == 15


@pytest.mark.asyncio
async def test_comprar_error_de_tienda_se_traduce_a_400(monkeypatch):
    monkeypatch.setattr(tienda, "comprar_objeto", AsyncMock(side_effect=TiendaError("Créditos insuficientes")))
    usuario = SimpleNamespace(id=7)
    session = AsyncMock()

    with pytest.raises(HTTPException) as info:
        await tienda.comprar("daga_oxidada", usuario, session)

    assert info.value.status_code == 400
    assert info.value.detail == "Créditos insuficientes"
