from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.xp import otorgar_xp


def _session_con_busqueda(usuario_id: int | None) -> AsyncMock:
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = usuario_id
    session.execute.return_value = resultado
    session.add = MagicMock()
    return session


@pytest.mark.asyncio
async def test_incrementa_xp_y_registra_evento_cuando_el_nombre_matchea():
    session = _session_con_busqueda(usuario_id=7)

    await otorgar_xp(session, "Juan", 5, "prueba")

    assert session.execute.await_count == 2  # búsqueda por nombre + UPDATE atómico
    evento = session.add.call_args.args[0]
    assert evento.usuario_id == 7
    assert evento.cantidad == 5
    assert evento.motivo == "prueba"
    session.commit.assert_awaited()


@pytest.mark.asyncio
async def test_registra_evento_sin_usuario_si_el_nombre_no_matchea():
    session = _session_con_busqueda(usuario_id=None)

    await otorgar_xp(session, "Nombre Fantasma", 5, "prueba")

    assert session.execute.await_count == 1  # solo la búsqueda, ningún UPDATE
    evento = session.add.call_args.args[0]
    assert evento.usuario_id is None
    assert evento.nombre_capturado == "Nombre Fantasma"
    session.commit.assert_awaited()


@pytest.mark.asyncio
async def test_un_fallo_de_bd_nunca_propaga_excepcion():
    session = AsyncMock()
    session.execute.side_effect = Exception("boom")
    session.add = MagicMock()

    await otorgar_xp(session, "Juan", 5, "prueba")

    session.rollback.assert_awaited()


@pytest.mark.asyncio
async def test_normaliza_el_nombre_antes_de_buscar():
    session = _session_con_busqueda(usuario_id=1)

    await otorgar_xp(session, "  Juan   Pérez  ", 5, "prueba")

    session.commit.assert_awaited()


@pytest.mark.asyncio
async def test_usuario_id_directo_evita_buscar_por_nombre():
    session = AsyncMock()
    session.add = MagicMock()

    await otorgar_xp(session, "Nombre que no importa", 5, "prueba", usuario_id_directo=99)

    assert session.execute.await_count == 1  # solo el UPDATE, sin búsqueda por nombre
    evento = session.add.call_args.args[0]
    assert evento.usuario_id == 99
    session.commit.assert_awaited()


@pytest.mark.asyncio
async def test_sin_usuario_id_directo_cae_a_busqueda_por_nombre():
    session = _session_con_busqueda(usuario_id=7)

    await otorgar_xp(session, "Juan", 5, "prueba", usuario_id_directo=None)

    assert session.execute.await_count == 2  # búsqueda por nombre + UPDATE
    evento = session.add.call_args.args[0]
    assert evento.usuario_id == 7
