from datetime import datetime, timedelta, timezone
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest

from app.services.trivia import (
    COOLDOWN_TRIVIA,
    PREGUNTAS,
    TriviaError,
    iniciar_intento,
    pregunta_por_id,
    resolver_intento,
)

AHORA = datetime(2026, 8, 14, 12, 0, tzinfo=timezone.utc)


def test_hay_mas_de_una_pregunta_en_el_banco():
    assert len(PREGUNTAS) > 1


@pytest.mark.parametrize("pregunta", PREGUNTAS)
def test_respuesta_correcta_esta_dentro_de_las_opciones(pregunta):
    assert 0 <= pregunta.respuesta_correcta < len(pregunta.opciones)


def test_pregunta_por_id_devuelve_la_pregunta_correspondiente():
    assert pregunta_por_id(0) is PREGUNTAS[0]


def _intento(**kwargs) -> SimpleNamespace:
    base = dict(id=1, usuario_id=1, pregunta_id=0, resuelto=False, acierto=None, created_at=AHORA)
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

    with pytest.raises(TriviaError):
        await iniciar_intento(session, usuario_id=1, ahora=AHORA)


@pytest.mark.asyncio
async def test_iniciar_intento_ok_crea_con_pregunta_del_banco():
    session = AsyncMock()
    session.add = MagicMock()
    resultado_execute = MagicMock()
    resultado_execute.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado_execute

    _, pregunta = await iniciar_intento(session, usuario_id=1, ahora=AHORA)

    session.add.assert_called_once()
    creado = session.add.call_args.args[0]
    assert creado.usuario_id == 1
    assert creado.pregunta_id == pregunta.id
    assert pregunta in PREGUNTAS


@pytest.mark.asyncio
async def test_resolver_intento_acierto_dana_al_jefe(monkeypatch):
    pregunta = PREGUNTAS[0]
    intento = _intento(pregunta_id=pregunta.id)
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.trivia.danar_jefe", dano_llamado)

    resultado = await resolver_intento(session, intento_id=1, usuario_id=1, opcion=pregunta.respuesta_correcta, nombre="Ana")

    assert resultado.resuelto is True
    assert resultado.acierto is True
    dano_llamado.assert_awaited_once()


@pytest.mark.asyncio
async def test_resolver_intento_fallo_no_dana(monkeypatch):
    pregunta = PREGUNTAS[0]
    opcion_incorrecta = (pregunta.respuesta_correcta + 1) % len(pregunta.opciones)
    intento = _intento(pregunta_id=pregunta.id)
    session = AsyncMock()
    session.get.return_value = intento
    dano_llamado = AsyncMock()
    monkeypatch.setattr("app.services.trivia.danar_jefe", dano_llamado)

    resultado = await resolver_intento(session, intento_id=1, usuario_id=1, opcion=opcion_incorrecta, nombre="Ana")

    assert resultado.acierto is False
    dano_llamado.assert_not_awaited()


@pytest.mark.asyncio
async def test_resolver_intento_ajeno_se_rechaza():
    intento = _intento(usuario_id=99)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(TriviaError):
        await resolver_intento(session, intento_id=1, usuario_id=1, opcion=0, nombre="Ana")


@pytest.mark.asyncio
async def test_resolver_intento_ya_resuelto_se_rechaza():
    intento = _intento(resuelto=True)
    session = AsyncMock()
    session.get.return_value = intento

    with pytest.raises(TriviaError):
        await resolver_intento(session, intento_id=1, usuario_id=1, opcion=0, nombre="Ana")
