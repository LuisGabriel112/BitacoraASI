from unittest.mock import AsyncMock, MagicMock

import pytest
from sqlalchemy.dialects import postgresql

from app.routers import registros


def _sql(stmt) -> str:
    return str(stmt.compile(dialect=postgresql.dialect(), compile_kwargs={"literal_binds": True}))


def _resultado(filas):
    m = MagicMock()
    m.all.return_value = filas
    return m


@pytest.mark.asyncio
async def test_kpis_registros_agrupa_por_sistema_con_join():
    session = AsyncMock()
    session.scalar.return_value = 3
    session.execute.side_effect = [_resultado([]), _resultado([]), _resultado([])]

    await registros._kpis_registros_de_semana(session, "SEM 34 - 2026")

    sql_sistema = _sql(session.execute.call_args_list[0][0][0])
    assert "JOIN sistemas" in sql_sistema
    assert "GROUP BY sistemas.nombre" in sql_sistema


@pytest.mark.asyncio
async def test_kpis_registros_agrupa_por_modulo_con_join():
    session = AsyncMock()
    session.scalar.return_value = 3
    session.execute.side_effect = [_resultado([]), _resultado([]), _resultado([])]

    await registros._kpis_registros_de_semana(session, "SEM 34 - 2026")

    sql_modulo = _sql(session.execute.call_args_list[2][0][0])
    assert "JOIN modulos" in sql_modulo
    assert "GROUP BY modulos.nombre" in sql_modulo


@pytest.mark.asyncio
async def test_kpis_registros_agrupa_por_dia():
    session = AsyncMock()
    session.scalar.return_value = 3
    session.execute.side_effect = [_resultado([]), _resultado([]), _resultado([])]

    await registros._kpis_registros_de_semana(session, "SEM 34 - 2026")

    sql_dia = _sql(session.execute.call_args_list[1][0][0])
    assert "GROUP BY registros.fecha" in sql_dia


@pytest.mark.asyncio
async def test_registros_recientes_limita_a_10_por_defecto():
    session = AsyncMock()
    session.execute.return_value = MagicMock(scalars=lambda: MagicMock(all=lambda: []))

    await registros._registros_recientes_de_semana(session, "SEM 34 - 2026")

    sql = _sql(session.execute.call_args[0][0])
    assert "LIMIT 10" in sql


@pytest.mark.asyncio
async def test_panel_arma_la_forma_correcta_de_salida(monkeypatch):
    from datetime import date

    session = AsyncMock()

    async def _kpis(session_, semana):
        return (
            7,
            [("Mediport", 5), ("Pis", 2)],
            [(date(2026, 8, 17), 4), (date(2026, 8, 18), 3)],
            [("Usuarios", 6), ("Vehículos", 1)],
        )

    async def _recientes(session_, semana, limite=10):
        return []

    monkeypatch.setattr(registros, "_kpis_registros_de_semana", _kpis)
    monkeypatch.setattr(registros, "_registros_recientes_de_semana", _recientes)

    resultado = await registros.panel(session)

    assert resultado.total_semana == 7
    assert resultado.por_sistema == {"Mediport": 5, "Pis": 2}
    assert resultado.volumen_diario == [
        {"fecha": "2026-08-17", "total": 4},
        {"fecha": "2026-08-18", "total": 3},
    ]
    assert resultado.distribucion_modulo == [
        {"modulo": "Usuarios", "total": 6},
        {"modulo": "Vehículos", "total": 1},
    ]
    assert resultado.recientes == []
