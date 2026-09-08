from datetime import datetime, timedelta, timezone
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.brawl import (
    UMBRAL_ACIERTO,
    BrawlError,
    es_resultado_plausible,
    iniciar_intento,
    resolver_intento,
)

AHORA = datetime(2026, 8, 14, 12, 0, tzinfo=timezone.utc)


@pytest.mark.parametrize(
    "enemigos_eliminados,esperado",
    [
        (0, False),
        (UMBRAL_ACIERTO - 1, False),
        (UMBRAL_ACIERTO, True),
        (3, True),
    ],
)
def test_es_resultado_plausible(enemigos_eliminados, esperado):
    assert es_resultado_plausible(enemigos_eliminados) is esperado


def _intento(**kwargs) -> SimpleNamespace:
    base = dict(id=1, usuario_id=1, enemigos_eliminados=None, resuelto=False, acierto=None, created_at=AHORA)
    base.update(kwargs)
    return SimpleNamespace(**base)


@pytest.mark.asyncio
async def test_iniciar_intento_rechaza_en_cooldown():
    ultimo = _intento(created_at=AHORA - timedelta(minutes=1))
    session = AsyncMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = ultimo
    resultado_execute.scalars.return_value.all.return_value = []
    session.execute.return_value = resultado_execute

    with pytest.raises(BrawlError):
        await iniciar_intento(session, usuario_id=1, ahora=AHORA)


@pytest.mark.asyncio
async def test_un_pase_salta_el_cooldown():
    """Jugar acompañado no gasta espera: si la gastara, coordinarse con un
    compañero costaría el doble que jugar solo contra los bots."""
    ultimo = _intento(created_at=AHORA - timedelta(minutes=1))
    session = AsyncMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = ultimo
    resultado_execute.scalars.return_value.all.return_value = []
    session.execute.return_value = resultado_execute

    await iniciar_intento(session, usuario_id=1, ahora=AHORA, ignorar_cooldown=True)

    session.add.assert_called_once()


@pytest.mark.asyncio
async def test_resolver_dos_de_tres_dana_al_jefe(monkeypatch):
    intento = _intento()
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.brawl.danar_jefe", dano_llamado)

    resultado = await resolver_intento(session, intento_id=1, usuario_id=1, enemigos_eliminados=2, nombre="Ana")

    assert resultado.acierto is True
    dano_llamado.assert_awaited_once()


@pytest.mark.asyncio
async def test_resolver_menos_de_dos_no_dana(monkeypatch):
    intento = _intento()
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.brawl.danar_jefe", dano_llamado)

    resultado = await resolver_intento(session, intento_id=1, usuario_id=1, enemigos_eliminados=1, nombre="Ana")

    assert resultado.resuelto is True
    assert resultado.acierto is False
    dano_llamado.assert_not_awaited()


@pytest.mark.asyncio
async def test_resolver_intento_ajeno_se_rechaza():
    intento = _intento(usuario_id=99)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(BrawlError):
        await resolver_intento(session, intento_id=1, usuario_id=1, enemigos_eliminados=3, nombre="Ana")


@pytest.mark.asyncio
async def test_resolver_intento_ya_resuelto_se_rechaza():
    intento = _intento(resuelto=True)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(BrawlError):
        await resolver_intento(session, intento_id=1, usuario_id=1, enemigos_eliminados=3, nombre="Ana")
