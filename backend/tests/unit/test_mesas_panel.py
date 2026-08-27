from datetime import date
from unittest.mock import AsyncMock, MagicMock

import pytest
from sqlalchemy.dialects import postgresql

from app.routers import mesas


def _sql(stmt) -> str:
    return str(stmt.compile(dialect=postgresql.dialect(), compile_kwargs={"literal_binds": True}))


def _resultado(filas):
    m = MagicMock()
    m.all.return_value = filas
    return m


@pytest.mark.asyncio
async def test_kpis_mesas_agrupa_por_ventana_con_join_no_nulo():
    session = AsyncMock()
    session.scalar.return_value = 3
    session.execute.side_effect = [_resultado([]), _resultado([]), _resultado([])]

    await mesas._kpis_mesas_cerradas_de_semana(session, "SEM 34 - 2026")

    sql_ventana = _sql(session.execute.call_args_list[1][0][0])
    assert "JOIN ventanas_mesa" in sql_ventana
    assert "GROUP BY ventanas_mesa.nombre" in sql_ventana


@pytest.mark.asyncio
async def test_kpis_mesas_excluye_tipo_solucion_vacio_o_nulo():
    session = AsyncMock()
    session.scalar.return_value = 3
    session.execute.side_effect = [_resultado([]), _resultado([]), _resultado([])]

    await mesas._kpis_mesas_cerradas_de_semana(session, "SEM 34 - 2026")

    sql_categoria = _sql(session.execute.call_args_list[2][0][0])
    assert "mesas.tipo_solucion IS NOT NULL" in sql_categoria
    assert "mesas.tipo_solucion != ''" in sql_categoria


@pytest.mark.asyncio
async def test_mesas_recientes_limita_a_10_por_defecto():
    session = AsyncMock()
    session.execute.return_value = MagicMock(scalars=lambda: MagicMock(all=lambda: []))

    await mesas._mesas_recientes_cerradas_de_semana(session, "SEM 34 - 2026")

    sql = _sql(session.execute.call_args[0][0])
    assert "LIMIT 10" in sql


@pytest.mark.asyncio
async def test_panel_mesas_arma_la_forma_correcta_de_salida(monkeypatch):
    session = AsyncMock()

    async def _kpis(session_, semana):
        return (
            5,
            [(date(2026, 8, 17), 3), (date(2026, 8, 18), 2)],
            [("RECEPCION DE CFDI", 3), ("PEDIDOS", 2)],
            [("Modificación en BD", 4), ("Seguimiento de proceso", 1)],
        )

    async def _recientes(session_, semana, limite=10):
        return []

    monkeypatch.setattr(mesas, "_kpis_mesas_cerradas_de_semana", _kpis)
    monkeypatch.setattr(mesas, "_mesas_recientes_cerradas_de_semana", _recientes)

    resultado = await mesas.panel_mesas(fecha=None, session=session)

    assert resultado.total_semana == 5
    assert resultado.volumen_diario == [
        {"fecha": "2026-08-17", "total": 3},
        {"fecha": "2026-08-18", "total": 2},
    ]
    assert resultado.distribucion_ventana == [
        {"ventana": "RECEPCION DE CFDI", "total": 3},
        {"ventana": "PEDIDOS", "total": 2},
    ]
    assert resultado.distribucion_categoria_solucion == [
        {"categoria_solucion": "Modificación en BD", "total": 4},
        {"categoria_solucion": "Seguimiento de proceso", "total": 1},
    ]
    assert resultado.recientes == []
