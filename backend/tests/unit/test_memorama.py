from datetime import datetime, timedelta, timezone
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.memorama import (
    DURACION_MINIMA_MEMORAMA,
    MemoramaError,
    completar_intento,
    iniciar_intento,
)

AHORA = datetime(2026, 8, 14, 12, 0, tzinfo=timezone.utc)


def _intento(**kwargs) -> SimpleNamespace:
    base = dict(id=1, usuario_id=1, resuelto=False, acierto=None, created_at=AHORA)
    base.update(kwargs)
    return SimpleNamespace(**base)


@pytest.mark.asyncio
async def test_iniciar_intento_rechaza_en_cooldown():
    ultimo = _intento(created_at=AHORA - timedelta(minutes=1))
    session = AsyncMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = ultimo
    session.execute.return_value = resultado_execute

    with pytest.raises(MemoramaError):
        await iniciar_intento(session, usuario_id=1, ahora=AHORA)


@pytest.mark.asyncio
async def test_iniciar_intento_ok_fuera_de_cooldown():
    session = AsyncMock()
    session.add = MagicMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado_execute

    await iniciar_intento(session, usuario_id=1, ahora=AHORA)

    session.add.assert_called_once()
    assert session.add.call_args.args[0].usuario_id == 1


@pytest.mark.asyncio
async def test_completar_demasiado_rapido_no_dana(monkeypatch):
    intento = _intento(created_at=AHORA)
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.memorama.danar_jefe", dano_llamado)
    ahora_completar = AHORA + timedelta(milliseconds=500)

    resultado = await completar_intento(session, intento_id=1, usuario_id=1, ahora=ahora_completar, nombre="Ana")

    assert resultado.resuelto is True
    assert resultado.acierto is False
    dano_llamado.assert_not_awaited()


@pytest.mark.asyncio
async def test_completar_despues_del_minimo_dana_al_jefe(monkeypatch):
    intento = _intento(created_at=AHORA)
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.memorama.danar_jefe", dano_llamado)
    ahora_completar = AHORA + DURACION_MINIMA_MEMORAMA + timedelta(seconds=1)

    resultado = await completar_intento(session, intento_id=1, usuario_id=1, ahora=ahora_completar, nombre="Ana")

    assert resultado.acierto is True
    dano_llamado.assert_awaited_once()


@pytest.mark.asyncio
async def test_completar_intento_ajeno_se_rechaza():
    intento = _intento(usuario_id=99)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(MemoramaError):
        await completar_intento(session, intento_id=1, usuario_id=1, ahora=AHORA, nombre="Ana")


@pytest.mark.asyncio
async def test_completar_intento_ya_resuelto_se_rechaza():
    intento = _intento(resuelto=True)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(MemoramaError):
        await completar_intento(session, intento_id=1, usuario_id=1, ahora=AHORA, nombre="Ana")
