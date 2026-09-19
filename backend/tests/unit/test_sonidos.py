from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest
from fastapi import HTTPException
from pydantic import ValidationError
from sqlalchemy.dialects import postgresql

from app.models import SonidoPreferencia
from app.routers import sonidos as router_sonidos
from app.schemas import PreferenciaSonidoUpdate, SolicitudUrlSubida, SonidoCreate
from app.services import sonidos as servicio
from app.services.storage import StorageError


def _sql(stmt) -> str:
    return str(stmt.compile(dialect=postgresql.dialect(), compile_kwargs={"literal_binds": True}))


def _sonido(id: int = 1, acciones: list[str] | None = None) -> SimpleNamespace:
    return SimpleNamespace(
        id=id, nombre=f"sonido-{id}", url=f"/sonidos/{id}.ogg", acciones=["exito"] if acciones is None else acciones
    )


def _session_con_preferencia(existente: SonidoPreferencia | None) -> AsyncMock:
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = existente
    session.execute.return_value = resultado
    session.add = MagicMock()
    return session


# --- acción por evento ----------------------------------------------------


def test_guardar_y_cerrar_mesa_suenan_a_exito_y_error_a_error():
    assert servicio.accion_de_evento("guardar_mesa") == "exito"
    assert servicio.accion_de_evento("cerrar_mesa") == "exito"
    assert servicio.accion_de_evento("error") == "error"


def test_compra_victoria_y_derrota_suenan_con_su_propia_accion():
    assert servicio.accion_de_evento("compra") == "compra"
    assert servicio.accion_de_evento("victoria") == "victoria"
    assert servicio.accion_de_evento("derrota") == "derrota"


def test_todo_evento_apunta_a_una_accion_del_catalogo():
    assert set(servicio.ACCION_POR_EVENTO.values()) == set(servicio.ACCIONES)


def test_evento_desconocido_se_rechaza():
    with pytest.raises(servicio.SonidoError):
        servicio.accion_de_evento("bailar")


def test_sonido_sin_la_accion_marcada_se_rechaza_indicando_la_esperada():
    with pytest.raises(servicio.SonidoError) as info:
        servicio.validar_sonido_para_evento(_sonido(acciones=["error"]), "guardar_mesa")

    assert "'exito'" in str(info.value)


def test_sonido_inexistente_se_rechaza():
    with pytest.raises(servicio.SonidoError) as info:
        servicio.validar_sonido_para_evento(None, "error")

    assert "no existe" in str(info.value)


def test_sonido_con_la_accion_marcada_pasa_aunque_tenga_otras():
    servicio.validar_sonido_para_evento(_sonido(acciones=["exito", "victoria"]), "victoria")


# --- interruptores por acción --------------------------------------------


def test_marcar_una_accion_la_agrega_en_orden_canonico():
    assert servicio.con_accion(["victoria"], "error", True) == ["error", "victoria"]


def test_marcar_una_accion_ya_marcada_no_la_duplica():
    assert servicio.con_accion(["exito"], "exito", True) == ["exito"]


def test_desmarcar_quita_la_accion_y_puede_dejar_la_lista_vacia():
    assert servicio.con_accion(["exito", "compra"], "compra", False) == ["exito"]
    assert servicio.con_accion(["exito"], "exito", False) == []


def test_desmarcar_una_accion_que_no_estaba_no_cambia_nada():
    assert servicio.con_accion(["exito"], "derrota", False) == ["exito"]


def test_accion_desconocida_se_rechaza_al_marcar_y_al_normalizar():
    with pytest.raises(servicio.SonidoError):
        servicio.con_accion([], "bailar", True)
    with pytest.raises(servicio.SonidoError):
        servicio.normalizar_acciones(["exito", "bailar"])


def test_normalizar_ordena_y_quita_repetidos():
    assert servicio.normalizar_acciones(["derrota", "error", "derrota", "compra"]) == ["error", "compra", "derrota"]


# --- upsert de preferencia ------------------------------------------------


@pytest.mark.asyncio
async def test_preferencia_nueva_se_agrega_a_la_sesion():
    session = _session_con_preferencia(None)
    session.get.return_value = _sonido(id=3, acciones=["exito"])

    preferencia = await servicio.guardar_preferencia(
        session, usuario_id=7, evento="cerrar_mesa", sonido_id=3, silenciado=False
    )

    session.add.assert_called_once()
    assert preferencia.usuario_id == 7
    assert preferencia.evento == "cerrar_mesa"
    assert preferencia.sonido_id == 3
    assert preferencia.silenciado is False
    session.commit.assert_awaited_once()


@pytest.mark.asyncio
async def test_preferencia_existente_se_actualiza_sin_crear_otra_fila():
    existente = SonidoPreferencia(usuario_id=7, evento="error", sonido_id=5, silenciado=False)
    session = _session_con_preferencia(existente)
    session.get.return_value = _sonido(id=6, acciones=["error"])

    preferencia = await servicio.guardar_preferencia(session, usuario_id=7, evento="error", sonido_id=6, silenciado=False)

    session.add.assert_not_called()
    assert preferencia is existente
    assert existente.sonido_id == 6


@pytest.mark.asyncio
async def test_silenciar_descarta_el_sonido_elegido():
    session = _session_con_preferencia(None)

    preferencia = await servicio.guardar_preferencia(
        session, usuario_id=7, evento="cerrar_mesa", sonido_id=3, silenciado=True
    )

    assert preferencia.silenciado is True
    assert preferencia.sonido_id is None
    session.get.assert_not_called()


@pytest.mark.asyncio
async def test_volver_a_aleatorio_guarda_sin_sonido_ni_silencio():
    existente = SonidoPreferencia(usuario_id=7, evento="guardar_mesa", sonido_id=2, silenciado=False)
    session = _session_con_preferencia(existente)

    await servicio.guardar_preferencia(session, usuario_id=7, evento="guardar_mesa", sonido_id=None, silenciado=False)

    assert existente.sonido_id is None
    assert existente.silenciado is False


@pytest.mark.asyncio
async def test_la_busqueda_de_preferencia_filtra_por_usuario_y_evento():
    session = _session_con_preferencia(None)

    await servicio.guardar_preferencia(session, usuario_id=7, evento="error", sonido_id=None, silenciado=False)

    sql = _sql(session.execute.call_args[0][0])
    assert "sonidos_preferencias.usuario_id = 7" in sql
    assert "sonidos_preferencias.evento = 'error'" in sql


@pytest.mark.asyncio
async def test_sonido_no_marcado_para_la_accion_no_se_guarda():
    session = _session_con_preferencia(None)
    session.get.return_value = _sonido(id=9, acciones=["error"])

    with pytest.raises(servicio.SonidoError):
        await servicio.guardar_preferencia(session, usuario_id=7, evento="guardar_mesa", sonido_id=9, silenciado=False)

    session.commit.assert_not_awaited()


@pytest.mark.asyncio
async def test_preferencia_de_victoria_acepta_un_sonido_marcado_para_victoria():
    session = _session_con_preferencia(None)
    session.get.return_value = _sonido(id=12, acciones=["victoria"])

    preferencia = await servicio.guardar_preferencia(
        session, usuario_id=7, evento="victoria", sonido_id=12, silenciado=False
    )

    assert preferencia.evento == "victoria"
    assert preferencia.sonido_id == 12


# --- schemas --------------------------------------------------------------


def test_crear_sonido_exige_al_menos_una_accion():
    with pytest.raises(ValidationError):
        SonidoCreate(nombre="tada", url="/x.ogg", acciones=[])


def test_crear_sonido_rechaza_acciones_fuera_del_catalogo():
    with pytest.raises(ValidationError):
        SonidoCreate(nombre="tada", url="/x.ogg", acciones=["bailar"])


def test_preferencia_acepta_los_eventos_nuevos():
    for evento in ("compra", "victoria", "derrota"):
        assert PreferenciaSonidoUpdate(evento=evento).evento == evento


# --- router ---------------------------------------------------------------


@pytest.mark.asyncio
async def test_listar_trae_todos_ordenados_por_id_sin_filtrar():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalars.return_value.all.return_value = [_sonido(1), _sonido(2, acciones=[])]
    session.execute.return_value = resultado

    lista = await router_sonidos.listar(session)

    assert [s.id for s in lista] == [1, 2]
    sql = _sql(session.execute.call_args[0][0])
    assert "ORDER BY sonidos.id" in sql
    assert "WHERE" not in sql


@pytest.mark.asyncio
async def test_crear_rechaza_nombre_duplicado_sin_distinguir_mayusculas():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = _sonido(1)
    session.execute.return_value = resultado

    with pytest.raises(HTTPException) as info:
        await router_sonidos.crear(SonidoCreate(nombre="Pop-Succes", url="/x.ogg", acciones=["exito"]), session)

    assert info.value.status_code == 409
    sql = _sql(session.execute.call_args[0][0])
    assert "lower(sonidos.nombre) = 'pop-succes'" in sql
    assert "categoria" not in sql


@pytest.mark.asyncio
async def test_crear_rechaza_nombre_en_blanco():
    session = AsyncMock()

    with pytest.raises(HTTPException) as info:
        await router_sonidos.crear(SonidoCreate(nombre="   ", url="/x.ogg", acciones=["exito"]), session)

    assert info.value.status_code == 400
    session.execute.assert_not_awaited()


@pytest.mark.asyncio
async def test_crear_guarda_nombre_normalizado_url_sin_espacios_y_acciones_en_orden():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado
    session.add = MagicMock()

    creado = await router_sonidos.crear(
        SonidoCreate(
            nombre="  buzzer   nuevo ", url=" https://x/sonidos/a.ogg ", acciones=["derrota", "error", "derrota"]
        ),
        session,
    )

    assert creado.nombre == "buzzer nuevo"
    assert creado.url == "https://x/sonidos/a.ogg"
    assert creado.acciones == ["error", "derrota"]
    session.add.assert_called_once_with(creado)


@pytest.mark.asyncio
async def test_marcar_y_desmarcar_una_accion_cambian_la_lista_del_sonido():
    session = AsyncMock()
    sonido = _sonido(4, acciones=["exito"])
    session.get.return_value = sonido

    await router_sonidos.marcar_accion(4, "victoria", session)
    assert sonido.acciones == ["exito", "victoria"]

    await router_sonidos.desmarcar_accion(4, "exito", session)
    assert sonido.acciones == ["victoria"]
    assert session.commit.await_count == 2


@pytest.mark.asyncio
async def test_marcar_accion_de_sonido_inexistente_da_404():
    session = AsyncMock()
    session.get.return_value = None

    with pytest.raises(HTTPException) as info:
        await router_sonidos.marcar_accion(99, "exito", session)

    assert info.value.status_code == 404


@pytest.mark.asyncio
async def test_subir_url_usa_la_carpeta_de_sonidos(monkeypatch):
    llamadas = {}

    async def _falsa(nombre, content_type, carpeta=""):
        llamadas.update(nombre=nombre, content_type=content_type, carpeta=carpeta)
        return ("https://sube", "https://publica")

    monkeypatch.setattr(router_sonidos, "crear_url_subida", _falsa)

    salida = await router_sonidos.solicitar_url_subida(
        SolicitudUrlSubida(nombre_archivo="tada.ogg", content_type="audio/ogg")
    )

    assert llamadas["carpeta"] == "sonidos"
    assert salida.url_publica == "https://publica"


@pytest.mark.asyncio
async def test_subir_url_traduce_error_de_storage_a_400(monkeypatch):
    async def _falla(*_args, **_kwargs):
        raise StorageError("Almacenamiento de archivos no configurado")

    monkeypatch.setattr(router_sonidos, "crear_url_subida", _falla)

    with pytest.raises(HTTPException) as info:
        await router_sonidos.solicitar_url_subida(SolicitudUrlSubida(nombre_archivo="tada.ogg", content_type="audio/ogg"))

    assert info.value.status_code == 400
    assert "no configurado" in info.value.detail


@pytest.mark.asyncio
async def test_guardar_mi_preferencia_traduce_error_de_dominio_a_400(monkeypatch):
    async def _falla(*_args, **_kwargs):
        raise servicio.SonidoError("El sonido no existe")

    monkeypatch.setattr(router_sonidos, "guardar_preferencia", _falla)

    with pytest.raises(HTTPException) as info:
        await router_sonidos.guardar_mi_preferencia(
            PreferenciaSonidoUpdate(evento="error", sonido_id=123), SimpleNamespace(id=7), AsyncMock()
        )

    assert info.value.status_code == 400
    assert info.value.detail == "El sonido no existe"


@pytest.mark.asyncio
async def test_mis_preferencias_filtra_por_el_usuario_de_la_sesion():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalars.return_value.all.return_value = []
    session.execute.return_value = resultado

    await router_sonidos.mis_preferencias(SimpleNamespace(id=7), session)

    assert "sonidos_preferencias.usuario_id = 7" in _sql(session.execute.call_args[0][0])
