from unittest.mock import AsyncMock, MagicMock

import pytest
from sqlalchemy.dialects import postgresql

from app.routers import chat


def _sql(stmt) -> str:
    return str(stmt.compile(dialect=postgresql.dialect(), compile_kwargs={"literal_binds": True}))


def _session_vacia() -> AsyncMock:
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalars.return_value.all.return_value = []
    session.execute.return_value = resultado
    return session


@pytest.mark.asyncio
async def test_listar_mensajes_con_despues_de_aplica_el_limite():
    session = _session_vacia()

    await chat.listar_mensajes(despues_de=100, limite=10, session=session)

    stmt = session.execute.call_args[0][0]
    assert "LIMIT 10" in _sql(stmt)


@pytest.mark.asyncio
async def test_listar_mensajes_sin_despues_de_sigue_aplicando_el_limite():
    session = _session_vacia()

    await chat.listar_mensajes(despues_de=None, limite=10, session=session)

    stmt = session.execute.call_args[0][0]
    assert "LIMIT 10" in _sql(stmt)
