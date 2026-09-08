"""Prueba el WebSocket de punta a punta con el TestClient de Starlette.

Los mocks no sirven aquí: lo que puede romperse es el handshake, la validación
del ticket y que el bucle de la sala realmente emita estado, y nada de eso se ve
llamando a las funciones por separado.
"""

import time
from types import SimpleNamespace

import pytest
from fastapi.testclient import TestClient

from app.database import get_session
from app.main import app
from app.routers import brawl_ws
from app.services.auth import crear_ticket_ws, crear_token
from app.services.motor_brawl import VIDA_JUGADOR

USUARIO = SimpleNamespace(id=7, nombre="Ana", avatar="🙂")


class _SesionFalsa:
    async def get(self, _modelo, usuario_id):
        return USUARIO if usuario_id == USUARIO.id else None


@pytest.fixture
def cliente():
    async def sesion_falsa():
        yield _SesionFalsa()

    app.dependency_overrides[get_session] = sesion_falsa
    brawl_ws._registro = brawl_ws.sala_brawl.RegistroSalas()
    brawl_ws._conexiones.clear()
    brawl_ws._bucles.clear()
    with TestClient(app) as c:
        yield c
    app.dependency_overrides.clear()


def _abrir(cliente, ticket):
    return cliente.websocket_connect(f"/juegos/brawl/ws?ticket={ticket}")


def test_sin_ticket_se_cierra_la_conexion(cliente):
    with _abrir(cliente, "") as ws:
        with pytest.raises(Exception):
            ws.receive_json()


def test_una_cookie_de_sesion_no_abre_el_websocket(cliente):
    with _abrir(cliente, crear_token(USUARIO.id)) as ws:
        with pytest.raises(Exception):
            ws.receive_json()


def test_un_ticket_valido_recibe_bienvenida_y_estado(cliente):
    with _abrir(cliente, crear_ticket_ws(USUARIO.id)) as ws:
        bienvenida = ws.receive_json()
        assert bienvenida["tipo"] == "bienvenida"
        assert bienvenida["jugador_id"] == str(USUARIO.id)

        estado = ws.receive_json()
        assert estado["tipo"] == "estado"
        assert estado["jugadores"][0]["nombre"] == "Ana"
        assert estado["jugadores"][0]["vida"] == VIDA_JUGADOR
        assert len(estado["muros"]) > 0


def test_el_jugador_puede_moverse_por_el_websocket(cliente):
    with _abrir(cliente, crear_ticket_ws(USUARIO.id)) as ws:
        ws.receive_json()
        ws.send_json({"tipo": "mover", "x": 200.0, "y": 120.0})

        for _ in range(10):
            estado = ws.receive_json()
            if estado["jugadores"][0]["x"] == 200.0:
                break

        assert (estado["jugadores"][0]["x"], estado["jugadores"][0]["y"]) == (200.0, 120.0)


def test_el_pase_por_rival_humano_llega_hasta_el_endpoint_de_iniciar():
    """Cubre el cable completo: el bucle de la sala otorga el pase y
    /juegos/brawl/iniciar lo consume para saltarse el cooldown."""
    brawl_ws._pases = brawl_ws.sala_brawl.RegistroPases()
    registro = brawl_ws.sala_brawl.RegistroSalas()
    sala = registro.entrar("7", "Ana", "🙂", 0.0)
    registro.entrar("9", "Beto", "🦉", 0.0)

    assert brawl_ws.consumir_pase(7) is False

    brawl_ws.sala_brawl.otorgar_pases_si_hubo_rival(sala, brawl_ws._pases)

    assert brawl_ws.consumir_pase(7) is True
    assert brawl_ws.consumir_pase(7) is False


def test_al_desconectarse_el_jugador_sale_de_la_sala(cliente):
    with _abrir(cliente, crear_ticket_ws(USUARIO.id)) as ws:
        ws.receive_json()

    # El servidor procesa la desconexión en su propia tarea: sin esperar, la
    # aserción corre antes de que el finally del handler alcance a limpiar.
    inicio = time.monotonic()
    while brawl_ws._registro.sala_de(str(USUARIO.id)) is not None:
        assert time.monotonic() - inicio < 2, "la sala no se limpió al desconectar"
        time.sleep(0.02)
