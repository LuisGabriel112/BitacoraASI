from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services import tienda
from app.services.tienda import (
    MAX_SLOTS_INVENTARIO,
    OBJETOS,
    BonoStats,
    Objeto,
    TiendaError,
    _delta_slots,
    bono_stats,
    comprar_objeto,
    objeto_por_id,
)

SEMANA = "SEM 34 - 2026"


def test_todos_los_ids_del_catalogo_son_unicos():
    ids = [o.id for o in OBJETOS]
    assert len(ids) == len(set(ids))


def test_los_combinados_solo_requieren_ids_que_existen_en_el_catalogo():
    ids = {o.id for o in OBJETOS}
    for objeto in OBJETOS:
        if objeto.requiere:
            assert set(objeto.requiere) <= ids


def test_objeto_por_id_devuelve_el_objeto_correspondiente():
    assert objeto_por_id("daga_oxidada").nombre == "Daga Oxidada"


def test_bono_stats_sin_objetos_es_todo_cero():
    assert bono_stats([]) == BonoStats()


def test_bono_stats_suma_los_stats_de_varios_objetos():
    a = Objeto("a", "A", "", 10, danio_pct=5, critico_pct=2)
    b = Objeto("b", "B", "", 10, danio_pct=3, xp_pct=10)

    resultado = bono_stats([a, b])

    assert resultado == BonoStats(danio_pct=8, critico_pct=2, cooldown_pct=0, xp_pct=10)


def test_delta_slots_basico_ocupa_un_slot():
    basico = Objeto("x", "X", "", 10, danio_pct=1)
    assert _delta_slots(basico) == 1


def test_delta_slots_combinado_libera_un_slot():
    combinado = Objeto("x", "X", "", 10, requiere=("a", "b"))
    assert _delta_slots(combinado) == -1


@pytest.mark.asyncio
async def test_comprar_objeto_basico_lo_equipa_y_descuenta_creditos(monkeypatch):
    session = AsyncMock()
    session.add = MagicMock()
    monkeypatch.setattr(tienda, "objetos_equipados", AsyncMock(side_effect=[[], [objeto_por_id("daga_oxidada")]]))
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=100))

    resultado = await comprar_objeto(session, usuario_id=1, semana=SEMANA, item_id="daga_oxidada")

    inventario_agregado = next(c.args[0] for c in session.add.call_args_list if hasattr(c.args[0], "item_id"))
    credito_agregado = next(c.args[0] for c in session.add.call_args_list if hasattr(c.args[0], "cantidad"))
    assert inventario_agregado.item_id == "daga_oxidada"
    assert credito_agregado.cantidad == -40
    session.commit.assert_awaited()
    assert resultado == [objeto_por_id("daga_oxidada")]


@pytest.mark.asyncio
async def test_comprar_combinado_consume_las_partes_y_cobra_solo_el_extra(monkeypatch):
    session = AsyncMock()
    session.add = MagicMock()
    equipados_antes = [objeto_por_id("chip_overclock"), objeto_por_id("manual_pirata")]
    monkeypatch.setattr(
        tienda, "objetos_equipados", AsyncMock(side_effect=[equipados_antes, [objeto_por_id("terminal_hackeada")]])
    )
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=200))

    await comprar_objeto(session, usuario_id=1, semana=SEMANA, item_id="terminal_hackeada")

    stmt_delete = next(c.args[0] for c in session.execute.call_args_list)
    assert "DELETE" in str(stmt_delete)
    credito_agregado = next(c.args[0] for c in session.add.call_args_list if hasattr(c.args[0], "cantidad"))
    assert credito_agregado.cantidad == -50


@pytest.mark.asyncio
async def test_no_se_puede_comprar_sin_creditos_suficientes(monkeypatch):
    session = AsyncMock()
    session.add = MagicMock()
    monkeypatch.setattr(tienda, "objetos_equipados", AsyncMock(return_value=[]))
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=10))

    with pytest.raises(TiendaError):
        await comprar_objeto(session, usuario_id=1, semana=SEMANA, item_id="daga_oxidada")
    session.add.assert_not_called()


@pytest.mark.asyncio
async def test_no_se_puede_comprar_combinado_sin_las_partes(monkeypatch):
    session = AsyncMock()
    session.add = MagicMock()
    monkeypatch.setattr(tienda, "objetos_equipados", AsyncMock(return_value=[]))
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=1000))

    with pytest.raises(TiendaError):
        await comprar_objeto(session, usuario_id=1, semana=SEMANA, item_id="filo_sangriento")
    session.add.assert_not_called()


@pytest.mark.asyncio
async def test_no_se_puede_comprar_el_mismo_objeto_dos_veces(monkeypatch):
    session = AsyncMock()
    session.add = MagicMock()
    monkeypatch.setattr(tienda, "objetos_equipados", AsyncMock(return_value=[objeto_por_id("daga_oxidada")]))
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=1000))

    with pytest.raises(TiendaError):
        await comprar_objeto(session, usuario_id=1, semana=SEMANA, item_id="daga_oxidada")
    session.add.assert_not_called()


@pytest.mark.asyncio
async def test_no_se_puede_comprar_un_objeto_inexistente(monkeypatch):
    session = AsyncMock()
    monkeypatch.setattr(tienda, "objetos_equipados", AsyncMock(return_value=[]))
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=1000))

    with pytest.raises(TiendaError):
        await comprar_objeto(session, usuario_id=1, semana=SEMANA, item_id="objeto_que_no_existe")


@pytest.mark.asyncio
async def test_inventario_lleno_rechaza_comprar_un_basico_mas(monkeypatch):
    session = AsyncMock()
    session.add = MagicMock()
    llenos = [Objeto(f"o{i}", f"O{i}", "", 1, danio_pct=1) for i in range(MAX_SLOTS_INVENTARIO)]
    monkeypatch.setattr(tienda, "objetos_equipados", AsyncMock(return_value=llenos))
    monkeypatch.setattr(tienda, "creditos_disponibles", AsyncMock(return_value=1000))

    with pytest.raises(TiendaError):
        await comprar_objeto(session, usuario_id=1, semana=SEMANA, item_id="daga_oxidada")
    session.add.assert_not_called()


@pytest.mark.asyncio
async def test_creditos_disponibles_suma_el_ledger():
    session = AsyncMock()
    session.scalar.return_value = 37

    total = await tienda.creditos_disponibles(session, usuario_id=1, semana=SEMANA)

    assert total == 37


@pytest.mark.asyncio
async def test_creditos_disponibles_sin_eventos_es_cero():
    session = AsyncMock()
    session.scalar.return_value = None

    total = await tienda.creditos_disponibles(session, usuario_id=1, semana=SEMANA)

    assert total == 0


@pytest.mark.asyncio
async def test_objetos_equipados_mapea_los_item_id_guardados():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalars.return_value.all.return_value = ["daga_oxidada", "manual_pirata"]
    session.execute.return_value = resultado

    equipados = await tienda.objetos_equipados(session, usuario_id=1, semana=SEMANA)

    assert [o.id for o in equipados] == ["daga_oxidada", "manual_pirata"]
