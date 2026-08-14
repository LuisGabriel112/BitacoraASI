from types import SimpleNamespace
from unittest.mock import AsyncMock

import pytest
from fastapi import HTTPException

from app.routers import juegos
from app.schemas import EleccionPelota, MovimientoGato


def _usuario(id_: int = 1, nombre: str = "Ana") -> SimpleNamespace:
    return SimpleNamespace(id=id_, nombre=nombre)


@pytest.mark.asyncio
async def test_obtener_partida_gato_404_si_no_existe():
    session = AsyncMock()
    session.get.return_value = None

    with pytest.raises(HTTPException) as info:
        await juegos.obtener_partida_gato(1, session)

    assert info.value.status_code == 404


@pytest.mark.asyncio
async def test_jugar_gato_traduce_movimiento_invalido_a_400(monkeypatch):
    async def falla(*args, **kwargs):
        raise juegos.MovimientoInvalido("no es tu turno")

    monkeypatch.setattr(juegos, "jugar_movimiento", falla)

    with pytest.raises(HTTPException) as info:
        await juegos.jugar_gato(1, MovimientoGato(posicion=0), _usuario(), AsyncMock())

    assert info.value.status_code == 400


@pytest.mark.asyncio
async def test_iniciar_pelota_traduce_cooldown_a_429(monkeypatch):
    async def falla(*args, **kwargs):
        raise juegos.PelotaError("en cooldown")

    monkeypatch.setattr(juegos, "iniciar_intento", falla)

    with pytest.raises(HTTPException) as info:
        await juegos.iniciar_pelota(_usuario(), AsyncMock())

    assert info.value.status_code == 429


@pytest.mark.asyncio
async def test_elegir_pelota_traduce_error_a_400(monkeypatch):
    async def falla(*args, **kwargs):
        raise juegos.PelotaError("intento ajeno")

    monkeypatch.setattr(juegos, "resolver_intento", falla)

    with pytest.raises(HTTPException) as info:
        await juegos.elegir_pelota(1, EleccionPelota(posicion=0), _usuario(), AsyncMock())

    assert info.value.status_code == 400


@pytest.mark.asyncio
async def test_elegir_pelota_devuelve_acierto_y_posicion_correcta(monkeypatch):
    intento = SimpleNamespace(acierto=True, posicion_correcta=1)

    async def resuelve(*args, **kwargs):
        return intento

    monkeypatch.setattr(juegos, "resolver_intento", resuelve)

    resultado = await juegos.elegir_pelota(1, EleccionPelota(posicion=1), _usuario(), AsyncMock())

    assert resultado.acierto is True
    assert resultado.posicion_correcta == 1
