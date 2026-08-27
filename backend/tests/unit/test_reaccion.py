from datetime import datetime, timedelta, timezone
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.reaccion import (
    TIEMPO_MAXIMO_MS,
    TIEMPO_MINIMO_MS,
    ReaccionError,
    es_tiempo_plausible,
    iniciar_intento,
    resolver_intento,
)

AHORA = datetime(2026, 8, 14, 12, 0, tzinfo=timezone.utc)


@pytest.mark.parametrize(
    "tiempo_ms,esperado",
    [
        (TIEMPO_MINIMO_MS, True),
        (TIEMPO_MAXIMO_MS, True),
        (350, True),
        (TIEMPO_MINIMO_MS - 1, False),
        (TIEMPO_MAXIMO_MS + 1, False),
    ],
)
def test_es_tiempo_plausible(tiempo_ms, esperado):
    assert es_tiempo_plausible(tiempo_ms) is esperado


def _intento(**kwargs) -> SimpleNamespace:
    base = dict(id=1, usuario_id=1, tiempo_ms=None, resuelto=False, acierto=None, created_at=AHORA)
    base.update(kwargs)
    return SimpleNamespace(**base)


@pytest.mark.asyncio
async def test_iniciar_intento_rechaza_en_cooldown():
    ultimo = _intento(created_at=AHORA - timedelta(minutes=1))
    session = AsyncMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = ultimo
    resultado_execute.scalars.return_value.all.return_value = []  # sin objetos equipados
    session.execute.return_value = resultado_execute

    with pytest.raises(ReaccionError):
        await iniciar_intento(session, usuario_id=1, ahora=AHORA)


@pytest.mark.asyncio
async def test_resolver_tiempo_humano_dana_al_jefe(monkeypatch):
    intento = _intento()
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.reaccion.danar_jefe", dano_llamado)

    resultado = await resolver_intento(session, intento_id=1, usuario_id=1, tiempo_ms=350, nombre="Ana")

    assert resultado.acierto is True
    dano_llamado.assert_awaited_once()


@pytest.mark.asyncio
async def test_resolver_tiempo_muy_rapido_no_dana(monkeypatch):
    intento = _intento()
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.reaccion.danar_jefe", dano_llamado)

    resultado = await resolver_intento(session, intento_id=1, usuario_id=1, tiempo_ms=50, nombre="Ana")

    assert resultado.resuelto is True
    assert resultado.acierto is False
    dano_llamado.assert_not_awaited()


@pytest.mark.asyncio
async def test_resolver_intento_ajeno_se_rechaza():
    intento = _intento(usuario_id=99)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(ReaccionError):
        await resolver_intento(session, intento_id=1, usuario_id=1, tiempo_ms=300, nombre="Ana")


@pytest.mark.asyncio
async def test_resolver_intento_ya_resuelto_se_rechaza():
    intento = _intento(resuelto=True)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(ReaccionError):
        await resolver_intento(session, intento_id=1, usuario_id=1, tiempo_ms=300, nombre="Ana")
