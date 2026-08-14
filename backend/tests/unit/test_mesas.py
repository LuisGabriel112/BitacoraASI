from datetime import date, datetime
from types import SimpleNamespace
from unittest.mock import AsyncMock, MagicMock

import pytest
from fastapi import HTTPException
from sqlalchemy.exc import IntegrityError

from app.routers import mesas
from app.routers.mesas import router as mesas_router
from app.schemas import MesaCerrar, MesaCreate, MesaUpdate


def _mesa(id_: int = 1, fecha_cierre_real: date | None = None) -> SimpleNamespace:
    return SimpleNamespace(id=id_, fecha_cierre_real=fecha_cierre_real)


def test_get_por_id_no_tapa_las_rutas_get_estaticas():
    """Mismo riesgo que en registros.py: GET /{mesa_id} sin tipar como int
    matchea cualquier segmento — debe quedar al final entre los GET."""
    rutas_get = [r.path for r in mesas_router.routes if "GET" in r.methods]
    indice_dinamica = rutas_get.index("/mesas/{mesa_id}")

    for estatica in (
        "/mesas", "/mesas/panel", "/mesas/reporte", "/mesas/reporte/exportar",
        "/mesas/temas-frecuentes", "/mesas/export",
    ):
        assert rutas_get.index(estatica) < indice_dinamica


def _catalogo_item(id_: int, nombre: str, usuario_id: int | None = None) -> SimpleNamespace:
    return SimpleNamespace(id=id_, nombre=nombre, usuario_id=usuario_id)


def _session_sin_bono() -> AsyncMock:
    """Sesión sin reglas de bono activas y sin actividad en el día — para que
    _otorgar_xp_cierre no sume bono ni golpe crítico y el XP sea el base."""
    session = AsyncMock()
    resultado_reglas = MagicMock()
    resultado_reglas.scalars.return_value.all.return_value = []
    session.execute.return_value = resultado_reglas
    session.scalar = AsyncMock(return_value=0)
    return session


def _mesa_create(codigo: str = "TCK-001") -> MesaCreate:
    return MesaCreate(
        codigo=codigo,
        titulo="Falla login",
        fecha_carga=date(2026, 8, 3),
        descripcion="No entra al portal",
        categoria_id=1,
        solicitante_id=1,
        resolutor_id=1,
        fecha_estimada_resolucion=date(2026, 8, 5),
    )


def test_ya_cerrada_es_falso_sin_fecha_cierre_real():
    assert mesas._ya_cerrada(_mesa(fecha_cierre_real=None)) is False


def test_ya_cerrada_es_verdadero_con_fecha_cierre_real():
    assert mesas._ya_cerrada(_mesa(fecha_cierre_real=date(2026, 8, 3))) is True


def test_resolver_catalogo_encuentra_por_id():
    catalogo = [_catalogo_item(1, "Ana"), _catalogo_item(2, "Beto")]

    assert mesas._resolver_catalogo(catalogo, 2).nombre == "Beto"


def test_resolver_catalogo_sin_id_devuelve_none():
    catalogo = [_catalogo_item(1, "Ana")]

    assert mesas._resolver_catalogo(catalogo, None) is None


def test_resolver_catalogo_id_inexistente_devuelve_none():
    catalogo = [_catalogo_item(1, "Ana")]

    assert mesas._resolver_catalogo(catalogo, 99) is None


@pytest.mark.asyncio
async def test_crear_mesa_traduce_codigo_duplicado_a_409():
    session = AsyncMock()
    session.add = MagicMock()  # session.add() es síncrono en SQLAlchemy, no debe quedar como coroutine sin await
    session.commit.side_effect = IntegrityError("insert", {}, Exception("duplicate key"))

    with pytest.raises(HTTPException) as info:
        await mesas.crear_mesa(_mesa_create(), session)

    assert info.value.status_code == 409
    session.rollback.assert_awaited_once()


@pytest.mark.asyncio
async def test_cerrar_mesa_inexistente_da_404():
    session = AsyncMock()
    session.get.return_value = None
    payload = MesaCerrar(ventana_id=1, solucion="...", tipo_solucion="Modificación en BD", fecha_cierre_real=date(2026, 8, 3))

    with pytest.raises(HTTPException) as info:
        await mesas.cerrar_mesa(1, payload, session)

    assert info.value.status_code == 404


@pytest.mark.asyncio
async def test_cerrar_mesa_ya_cerrada_da_400():
    session = AsyncMock()
    session.get.return_value = _mesa(fecha_cierre_real=date(2026, 8, 1))
    payload = MesaCerrar(ventana_id=1, solucion="...", tipo_solucion="Modificación en BD", fecha_cierre_real=date(2026, 8, 3))

    with pytest.raises(HTTPException) as info:
        await mesas.cerrar_mesa(1, payload, session)

    assert info.value.status_code == 400


def test_campos_a_actualizar_solo_incluye_lo_enviado():
    payload = MesaUpdate(titulo="Nuevo título")

    assert mesas._campos_a_actualizar(payload) == {"titulo": "Nuevo título"}


def test_campos_a_actualizar_vacio_si_nada_se_envia():
    assert mesas._campos_a_actualizar(MesaUpdate()) == {}


@pytest.mark.asyncio
async def test_editar_mesa_inexistente_da_404():
    session = AsyncMock()
    session.get.return_value = None

    with pytest.raises(HTTPException) as info:
        await mesas.editar_mesa(1, MesaUpdate(titulo="X"), session)

    assert info.value.status_code == 404


@pytest.mark.asyncio
async def test_editar_mesa_traduce_codigo_duplicado_a_409():
    session = AsyncMock()
    session.get.return_value = _mesa()
    session.commit.side_effect = IntegrityError("update", {}, Exception("duplicate key"))

    with pytest.raises(HTTPException) as info:
        await mesas.editar_mesa(1, MesaUpdate(codigo="YA-EXISTE"), session)

    assert info.value.status_code == 409
    session.rollback.assert_awaited_once()


@pytest.mark.asyncio
async def test_otorgar_xp_cierre_da_accion_mas_logros(monkeypatch):
    llamadas = []

    async def falso_otorgar_xp(session, nombre, cantidad, motivo, usuario_id_directo=None):
        llamadas.append((nombre, cantidad, motivo, usuario_id_directo))

    monkeypatch.setattr(mesas, "otorgar_xp", falso_otorgar_xp)
    monkeypatch.setattr(mesas, "danar_jefe", AsyncMock())
    mesa = SimpleNamespace(resolutor=_catalogo_item(1, "Ana"), fecha_cierre_real=datetime(2026, 8, 3, 16, 0))

    await mesas._otorgar_xp_cierre(_session_sin_bono(), mesa, logros=["primera_dia_resolutor", "decima_dia"])

    nombre, cantidad, motivo, _ = llamadas[0]
    assert nombre == "Ana"
    assert cantidad == mesas.XP_POR_ACCION + mesas.XP_POR_LOGRO * 2
    assert motivo == "mesa_cerrada"


@pytest.mark.asyncio
async def test_otorgar_xp_cierre_sin_logros_solo_da_xp_de_accion(monkeypatch):
    llamadas = []

    async def falso_otorgar_xp(session, nombre, cantidad, motivo, usuario_id_directo=None):
        llamadas.append(cantidad)

    monkeypatch.setattr(mesas, "otorgar_xp", falso_otorgar_xp)
    monkeypatch.setattr(mesas, "danar_jefe", AsyncMock())
    mesa = SimpleNamespace(resolutor=_catalogo_item(1, "Ana"), fecha_cierre_real=datetime(2026, 8, 3, 16, 0))

    await mesas._otorgar_xp_cierre(_session_sin_bono(), mesa, logros=[])

    assert llamadas[0] == mesas.XP_POR_ACCION


@pytest.mark.asyncio
async def test_otorgar_xp_cierre_pasa_el_usuario_id_vinculado(monkeypatch):
    llamadas = []

    async def falso_otorgar_xp(session, nombre, cantidad, motivo, usuario_id_directo=None):
        llamadas.append(usuario_id_directo)

    monkeypatch.setattr(mesas, "otorgar_xp", falso_otorgar_xp)
    monkeypatch.setattr(mesas, "danar_jefe", AsyncMock())
    mesa = SimpleNamespace(
        resolutor=_catalogo_item(1, "Ana", usuario_id=42), fecha_cierre_real=datetime(2026, 8, 3, 16, 0)
    )

    await mesas._otorgar_xp_cierre(_session_sin_bono(), mesa, logros=[])

    assert llamadas[0] == 42
