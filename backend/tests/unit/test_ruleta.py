from datetime import datetime, timedelta, timezone
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.ruleta import (
    DANIO_RULETA_GANA,
    PENALIZACION_RULETA_PIERDE,
    RuletaError,
    jugar_ruleta,
)

AHORA = datetime(2026, 8, 14, 12, 0, tzinfo=timezone.utc)


def _intento(**kwargs) -> SimpleNamespace:
    base = dict(id=1, usuario_id=1, gano=False, created_at=AHORA)
    base.update(kwargs)
    return SimpleNamespace(**base)


def _session_sin_historial() -> AsyncMock:
    session = AsyncMock()
    session.add = MagicMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado_execute
    return session


@pytest.mark.asyncio
async def test_jugar_rechaza_en_cooldown():
    ultimo = _intento(created_at=AHORA - timedelta(minutes=1))
    session = AsyncMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = ultimo
    resultado_execute.scalars.return_value.all.return_value = []  # sin objetos equipados
    session.execute.return_value = resultado_execute

    with pytest.raises(RuletaError):
        await jugar_ruleta(session, usuario_id=1, ahora=AHORA, nombre="Ana")


@pytest.mark.asyncio
async def test_ganar_dana_al_jefe_y_no_toca_xp(monkeypatch):
    monkeypatch.setattr("app.services.ruleta.random.random", lambda: 0.0)  # < probabilidad => gana
    session = _session_sin_historial()
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.ruleta.danar_jefe", dano_llamado)

    resultado = await jugar_ruleta(session, usuario_id=1, ahora=AHORA, nombre="Ana")

    assert resultado.gano is True
    dano_llamado.assert_awaited_once()
    cantidad = dano_llamado.await_args.args[2]
    assert cantidad == DANIO_RULETA_GANA


@pytest.mark.asyncio
async def test_perder_resta_xp_y_no_dana_al_jefe(monkeypatch):
    monkeypatch.setattr("app.services.ruleta.random.random", lambda: 0.999)  # >= probabilidad => pierde
    session = _session_sin_historial()
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.ruleta.danar_jefe", dano_llamado)

    resultado = await jugar_ruleta(session, usuario_id=1, ahora=AHORA, nombre="Ana")

    assert resultado.gano is False
    dano_llamado.assert_not_awaited()
    # dos llamadas a execute: la del historial (_ultimo_intento) y la del UPDATE de xp
    assert session.execute.await_count == 2


@pytest.mark.asyncio
async def test_perder_usa_greatest_para_no_bajar_de_cero(monkeypatch):
    monkeypatch.setattr("app.services.ruleta.random.random", lambda: 0.999)
    session = _session_sin_historial()
    monkeypatch.setattr("app.services.ruleta.danar_jefe", AsyncMock())

    await jugar_ruleta(session, usuario_id=1, ahora=AHORA, nombre="Ana")

    stmt_update = session.execute.await_args_list[-1].args[0]
    sql = str(stmt_update.compile(compile_kwargs={"literal_binds": True}))
    assert "greatest" in sql.lower()
    assert str(PENALIZACION_RULETA_PIERDE) in sql
