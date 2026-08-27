from datetime import datetime, timedelta, timezone
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.pelota import (
    CASILLAS_PELOTA,
    COOLDOWN_PELOTA,
    PelotaError,
    iniciar_intento,
    puede_jugar,
    resolver_intento,
    tiempo_restante_cooldown,
)

AHORA = datetime(2026, 8, 14, 12, 0, tzinfo=timezone.utc)


def test_primer_intento_siempre_puede_jugar():
    assert puede_jugar(None, AHORA) is True


def test_no_puede_jugar_si_intento_hace_menos_del_cooldown():
    hace_2_min = AHORA - timedelta(minutes=2)
    assert puede_jugar(hace_2_min, AHORA) is False


def test_tiempo_restante_correcto_a_los_2_minutos():
    hace_2_min = AHORA - timedelta(minutes=2)
    assert tiempo_restante_cooldown(hace_2_min, AHORA) == timedelta(minutes=3)


def test_puede_jugar_justo_al_cumplirse_el_cooldown():
    hace_exactamente_el_cooldown = AHORA - COOLDOWN_PELOTA
    assert puede_jugar(hace_exactamente_el_cooldown, AHORA) is True


def test_puede_jugar_despues_de_pasado_el_cooldown():
    hace_10_min = AHORA - timedelta(minutes=10)
    assert puede_jugar(hace_10_min, AHORA) is True


def test_tiempo_restante_nunca_es_negativo():
    hace_10_min = AHORA - timedelta(minutes=10)
    assert tiempo_restante_cooldown(hace_10_min, AHORA) == timedelta(0)


def _intento(**kwargs) -> SimpleNamespace:
    base = dict(id=1, usuario_id=1, posicion_correcta=1, resuelto=False, acierto=None, created_at=AHORA)
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

    with pytest.raises(PelotaError):
        await iniciar_intento(session, usuario_id=1, ahora=AHORA)


@pytest.mark.asyncio
async def test_iniciar_intento_permite_jugar_antes_con_bono_de_cooldown(monkeypatch):
    from app.services.tienda import BonoStats

    ultimo = _intento(created_at=AHORA - timedelta(minutes=4))  # normalmente seguiría en cooldown
    session = AsyncMock()
    session.add = MagicMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = ultimo
    session.execute.return_value = resultado_execute
    monkeypatch.setattr(
        "app.services.pelota.tienda.bono_de_usuario", AsyncMock(return_value=BonoStats(cooldown_pct=20))
    )

    await iniciar_intento(session, usuario_id=1, ahora=AHORA)  # 5min * (1-20%) = 4min, ya cumplidos

    session.add.assert_called_once()


@pytest.mark.asyncio
async def test_iniciar_intento_ok_crea_con_posicion_valida():
    session = AsyncMock()
    session.add = MagicMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado_execute

    await iniciar_intento(session, usuario_id=1, ahora=AHORA)

    session.add.assert_called_once()
    creado = session.add.call_args.args[0]
    assert creado.usuario_id == 1
    assert 0 <= creado.posicion_correcta < CASILLAS_PELOTA


@pytest.mark.asyncio
async def test_resolver_intento_acierto_dana_al_jefe(monkeypatch):
    intento = _intento(posicion_correcta=1)
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.pelota.danar_jefe", dano_llamado)

    resultado = await resolver_intento(session, intento_id=1, usuario_id=1, posicion=1, nombre="Ana")

    assert resultado.resuelto is True
    assert resultado.acierto is True
    dano_llamado.assert_awaited_once()


@pytest.mark.asyncio
async def test_resolver_intento_fallo_no_dana(monkeypatch):
    intento = _intento(posicion_correcta=1)
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.pelota.danar_jefe", dano_llamado)

    resultado = await resolver_intento(session, intento_id=1, usuario_id=1, posicion=0, nombre="Ana")

    assert resultado.acierto is False
    dano_llamado.assert_not_awaited()


@pytest.mark.asyncio
async def test_resolver_intento_ajeno_se_rechaza():
    intento = _intento(usuario_id=99)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(PelotaError):
        await resolver_intento(session, intento_id=1, usuario_id=1, posicion=0, nombre="Ana")


@pytest.mark.asyncio
async def test_resolver_intento_ya_resuelto_se_rechaza():
    intento = _intento(resuelto=True)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(PelotaError):
        await resolver_intento(session, intento_id=1, usuario_id=1, posicion=0, nombre="Ana")
