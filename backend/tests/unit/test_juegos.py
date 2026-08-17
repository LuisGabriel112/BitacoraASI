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
def _jugador(nombre: str) -> SimpleNamespace:
    return SimpleNamespace(nombre=nombre, avatar="🙂")


def _partida_rps(**kwargs) -> SimpleNamespace:
    base = dict(
        id=1, jugador_x_id=1, jugador_o_id=2, jugada_x=None, jugada_o=None,
        estado="jugando", resultado=None, jugador_x=_jugador("Ana"), jugador_o=_jugador("Beto"),
    )
    base.update(kwargs)
    return SimpleNamespace(**base)


def test_partida_rps_out_oculta_jugada_del_rival_si_no_ha_terminado():
    partida = _partida_rps(jugada_x="piedra", jugada_o="tijera")

    vista_de_x = juegos._partida_rps_out(partida, usuario_id=1)

    assert vista_de_x.jugada_x == "piedra"
    assert vista_de_x.jugada_o is None


def test_partida_rps_out_revela_ambas_jugadas_si_termino():
    partida = _partida_rps(jugada_x="piedra", jugada_o="tijera", estado="terminada", resultado="X")

    vista_de_o = juegos._partida_rps_out(partida, usuario_id=2)

    assert vista_de_o.jugada_x == "piedra"
    assert vista_de_o.jugada_o == "tijera"


@pytest.mark.asyncio
async def test_jugar_rps_traduce_jugada_invalida_a_400(monkeypatch):
    async def falla(*args, **kwargs):
        raise juegos.rps_service.JugadaInvalida("ya jugaste")

    monkeypatch.setattr(juegos.rps_service, "jugar_rps", falla)

    from app.schemas import JugadaRPS

    with pytest.raises(HTTPException) as info:
        await juegos.jugar_rps_endpoint(1, JugadaRPS(jugada="piedra"), _usuario(), AsyncMock())

    assert info.value.status_code == 400


@pytest.mark.asyncio
async def test_iniciar_trivia_traduce_cooldown_a_429(monkeypatch):
    async def falla(*args, **kwargs):
        raise juegos.trivia_service.TriviaError("en cooldown")

    monkeypatch.setattr(juegos.trivia_service, "iniciar_intento", falla)

    with pytest.raises(HTTPException) as info:
        await juegos.iniciar_trivia(_usuario(), AsyncMock())

    assert info.value.status_code == 429


@pytest.mark.asyncio
async def test_responder_trivia_devuelve_acierto_y_respuesta_correcta(monkeypatch):
    intento = SimpleNamespace(acierto=True, pregunta_id=0)

    async def resuelve(*args, **kwargs):
        return intento

    monkeypatch.setattr(juegos.trivia_service, "resolver_intento", resuelve)

    from app.schemas import RespuestaTrivia

    resultado = await juegos.responder_trivia(1, RespuestaTrivia(opcion=0), _usuario(), AsyncMock())

    assert resultado.acierto is True
    assert resultado.respuesta_correcta == juegos.trivia_service.pregunta_por_id(0).respuesta_correcta


@pytest.mark.asyncio
async def test_iniciar_memorama_traduce_cooldown_a_429(monkeypatch):
    async def falla(*args, **kwargs):
        raise juegos.memorama_service.MemoramaError("en cooldown")

    monkeypatch.setattr(juegos.memorama_service, "iniciar_intento", falla)

    with pytest.raises(HTTPException) as info:
        await juegos.iniciar_memorama(_usuario(), AsyncMock())

    assert info.value.status_code == 429


@pytest.mark.asyncio
async def test_completar_memorama_devuelve_acierto(monkeypatch):
    intento = SimpleNamespace(acierto=True)

    async def completa(*args, **kwargs):
        return intento

    monkeypatch.setattr(juegos.memorama_service, "completar_intento", completa)

    resultado = await juegos.completar_memorama(1, _usuario(), AsyncMock())

    assert resultado.acierto is True


@pytest.mark.asyncio
async def test_iniciar_reaccion_traduce_cooldown_a_429(monkeypatch):
    async def falla(*args, **kwargs):
        raise juegos.reaccion_service.ReaccionError("en cooldown")

    monkeypatch.setattr(juegos.reaccion_service, "iniciar_intento", falla)

    with pytest.raises(HTTPException) as info:
        await juegos.iniciar_reaccion(_usuario(), AsyncMock())

    assert info.value.status_code == 429


@pytest.mark.asyncio
async def test_reportar_reaccion_devuelve_acierto(monkeypatch):
    intento = SimpleNamespace(acierto=True)

    async def resuelve(*args, **kwargs):
        return intento

    monkeypatch.setattr(juegos.reaccion_service, "resolver_intento", resuelve)

    from app.schemas import ReporteReaccion

    resultado = await juegos.reportar_reaccion(1, ReporteReaccion(tiempo_ms=300), _usuario(), AsyncMock())

    assert resultado.acierto is True


@pytest.mark.asyncio
async def test_jugar_ruleta_traduce_cooldown_a_429(monkeypatch):
    async def falla(*args, **kwargs):
        raise juegos.ruleta_service.RuletaError("en cooldown")

    monkeypatch.setattr(juegos.ruleta_service, "jugar_ruleta", falla)

    with pytest.raises(HTTPException) as info:
        await juegos.jugar_ruleta_endpoint(_usuario(), AsyncMock())

    assert info.value.status_code == 429


@pytest.mark.asyncio
async def test_jugar_ruleta_devuelve_gano(monkeypatch):
    intento = SimpleNamespace(gano=True)

    async def juega(*args, **kwargs):
        return intento

    monkeypatch.setattr(juegos.ruleta_service, "jugar_ruleta", juega)

    resultado = await juegos.jugar_ruleta_endpoint(_usuario(), AsyncMock())

    assert resultado.gano is True


@pytest.mark.asyncio
async def test_elegir_pelota_devuelve_acierto_y_posicion_correcta(monkeypatch):
    intento = SimpleNamespace(acierto=True, posicion_correcta=1)

    async def resuelve(*args, **kwargs):
        return intento

    monkeypatch.setattr(juegos, "resolver_intento", resuelve)

    resultado = await juegos.elegir_pelota(1, EleccionPelota(posicion=1), _usuario(), AsyncMock())

    assert resultado.acierto is True
    assert resultado.posicion_correcta == 1
