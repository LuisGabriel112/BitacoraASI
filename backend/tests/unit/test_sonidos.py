from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest
from fastapi import HTTPException
from sqlalchemy.dialects import postgresql

from app.models import SonidoPreferencia
from app.routers import sonidos as router_sonidos
from app.schemas import PreferenciaSonidoUpdate, SolicitudUrlSubida, SonidoCreate
from app.services import sonidos as servicio
from app.services.storage import StorageError


def _sql(stmt) -> str:
    return str(stmt.compile(dialect=postgresql.dialect(), compile_kwargs={"literal_binds": True}))


def _sonido(id: int = 1, categoria: str = "exito", activo: bool = True) -> SimpleNamespace:
    return SimpleNamespace(id=id, categoria=categoria, nombre=f"sonido-{id}", url=f"/sonidos/{id}.ogg", activo=activo)


def _session_con_preferencia(existente: SonidoPreferencia | None) -> AsyncMock:
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = existente
    session.execute.return_value = resultado
    session.add = MagicMock()
    return session


# --- categoría por acción -------------------------------------------------


def test_guardar_y_cerrar_mesa_suenan_a_exito_y_error_a_error():
    assert servicio.categoria_de_evento("guardar_mesa") == "exito"
    assert servicio.categoria_de_evento("cerrar_mesa") == "exito"
    assert servicio.categoria_de_evento("error") == "error"


def test_evento_desconocido_se_rechaza():
    with pytest.raises(servicio.SonidoError):
        servicio.categoria_de_evento("bailar")


def test_sonido_de_categoria_equivocada_se_rechaza_indicando_la_esperada():
    with pytest.raises(servicio.SonidoError) as info:
        servicio.validar_sonido_para_evento(_sonido(categoria="error"), "guardar_mesa")

    assert "'exito'" in str(info.value)


def test_sonido_inexistente_se_rechaza():
    with pytest.raises(servicio.SonidoError) as info:
        servicio.validar_sonido_para_evento(None, "error")

    assert "no existe" in str(info.value)


def test_sonido_de_la_categoria_correcta_pasa():
    servicio.validar_sonido_para_evento(_sonido(categoria="error"), "error")


# --- upsert de preferencia ------------------------------------------------


@pytest.mark.asyncio
async def test_preferencia_nueva_se_agrega_a_la_sesion():
    session = _session_con_preferencia(None)
    session.get.return_value = _sonido(id=3, categoria="exito")

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
    session.get.return_value = _sonido(id=6, categoria="error")

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
async def test_sonido_de_otra_categoria_no_se_guarda():
    session = _session_con_preferencia(None)
    session.get.return_value = _sonido(id=9, categoria="error")

    with pytest.raises(servicio.SonidoError):
        await servicio.guardar_preferencia(session, usuario_id=7, evento="guardar_mesa", sonido_id=9, silenciado=False)

    session.commit.assert_not_awaited()


# --- router ---------------------------------------------------------------


@pytest.mark.asyncio
async def test_listar_trae_activos_e_inactivos_ordenados_por_categoria():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalars.return_value.all.return_value = [_sonido(1), _sonido(2, activo=False)]
    session.execute.return_value = resultado

    lista = await router_sonidos.listar(session)

    assert [s.id for s in lista] == [1, 2]
    sql = _sql(session.execute.call_args[0][0])
    assert "ORDER BY sonidos.categoria, sonidos.id" in sql
    assert "WHERE" not in sql


@pytest.mark.asyncio
async def test_crear_rechaza_nombre_duplicado_sin_distinguir_mayusculas():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = _sonido(1)
    session.execute.return_value = resultado

    with pytest.raises(HTTPException) as info:
        await router_sonidos.crear(SonidoCreate(categoria="exito", nombre="Pop-Succes", url="/x.ogg"), session)

    assert info.value.status_code == 409
    sql = _sql(session.execute.call_args[0][0])
    assert "lower(sonidos.nombre) = 'pop-succes'" in sql
    assert "sonidos.categoria = 'exito'" in sql


@pytest.mark.asyncio
async def test_crear_rechaza_nombre_en_blanco():
    session = AsyncMock()

    with pytest.raises(HTTPException) as info:
        await router_sonidos.crear(SonidoCreate(categoria="exito", nombre="   ", url="/x.ogg"), session)

    assert info.value.status_code == 400
    session.execute.assert_not_awaited()


@pytest.mark.asyncio
async def test_crear_guarda_nombre_normalizado_y_url_sin_espacios():
    session = AsyncMock()
    resultado = MagicMock()
    resultado.scalar_one_or_none.return_value = None
    session.execute.return_value = resultado
    session.add = MagicMock()

    creado = await router_sonidos.crear(
        SonidoCreate(categoria="error", nombre="  buzzer   nuevo ", url=" https://x/sonidos/a.ogg "), session
    )

    assert creado.nombre == "buzzer nuevo"
    assert creado.url == "https://x/sonidos/a.ogg"
    assert creado.categoria == "error"
    session.add.assert_called_once_with(creado)


@pytest.mark.asyncio
async def test_activar_y_desactivar_cambian_el_flag():
    session = AsyncMock()
    sonido = _sonido(4, activo=True)
    session.get.return_value = sonido

    await router_sonidos.desactivar(4, session)
    assert sonido.activo is False

    await router_sonidos.activar(4, session)
    assert sonido.activo is True


@pytest.mark.asyncio
async def test_activar_sonido_inexistente_da_404():
    session = AsyncMock()
    session.get.return_value = None

    with pytest.raises(HTTPException) as info:
        await router_sonidos.activar(99, session)

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
