from datetime import datetime, timezone
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest
from sqlalchemy.dialects import postgresql

from app.routers import auth


def _sql(stmt) -> str:
    return str(stmt.compile(dialect=postgresql.dialect(), compile_kwargs={"literal_binds": True}))


def _usuario(nombre: str) -> SimpleNamespace:
    return SimpleNamespace(nombre=nombre, avatar="🙂", xp=10, ultima_actividad=datetime.now(timezone.utc))


@pytest.mark.asyncio
async def test_en_linea_filtra_en_sql_no_en_python():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalars.return_value.all.return_value = [_usuario("Ana"), _usuario("Beto")]
    session.execute.return_value = resultado

    items = await auth.en_linea(session)

    assert {i.nombre for i in items} == {"Ana", "Beto"}


@pytest.mark.asyncio
async def test_en_linea_la_condicion_de_umbral_esta_en_el_where():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalars.return_value.all.return_value = []
    session.execute.return_value = resultado

    await auth.en_linea(session)

    stmt = session.execute.call_args[0][0]
    assert "usuarios.ultima_actividad >" in _sql(stmt)
