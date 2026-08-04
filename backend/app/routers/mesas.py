import csv
import io
from datetime import date, datetime, timedelta
from types import SimpleNamespace

from fastapi import APIRouter, Depends, File, HTTPException, Query, UploadFile
from fastapi.responses import StreamingResponse
from openpyxl import Workbook
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils import get_column_letter
from sqlalchemy import Row, func, select
from sqlalchemy.exc import IntegrityError, NoResultFound
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.database import get_session
from app.models import CategoriaMesa, Mesa, ResolutorMesa, SolicitanteMesa, VentanaMesa
from app.schemas import (
    ExtraccionMesa,
    GrupoSoporte,
    MesaCerrar,
    MesaCreate,
    MesaOut,
    MesaUpdate,
    PaginaMesas,
    PanelMesasKPIs,
    ReporteMesasSemanal,
)
from app.services.clustering import agrupar_por_similitud, tema_representativo
from app.services.embeddings import asegurar_embeddings
from app.services.excel_resumen import agregar_hoja_resumen
from app.services.gemini import GeminiError, extraer_mesa, gemini_configurado
from app.services.semanas import semana_de

router = APIRouter(prefix="/mesas", tags=["mesas"])

_RELACIONES = (
    selectinload(Mesa.ventana),
    selectinload(Mesa.categoria),
    selectinload(Mesa.solicitante),
    selectinload(Mesa.resolutor),
)


async def _obtener_mesa(session: AsyncSession, mesa_id: int) -> Mesa:
    stmt = select(Mesa).options(*_RELACIONES).where(Mesa.id == mesa_id)
    return (await session.execute(stmt)).scalar_one()


def _ya_cerrada(mesa) -> bool:
    return mesa.fecha_cierre_real is not None


def _resolver_catalogo(catalogo: list, id_elegido: int | None):
    if not id_elegido:
        return None
    return next((c for c in catalogo if c.id == id_elegido), None)


@router.post("", response_model=MesaOut, status_code=201)
async def crear_mesa(payload: MesaCreate, session: AsyncSession = Depends(get_session)):
    mesa = Mesa(**payload.model_dump())
    session.add(mesa)
    try:
        await session.commit()
    except IntegrityError:
        await session.rollback()
        raise HTTPException(409, f"Código '{payload.codigo}' ya existe")
    mesa = await _obtener_mesa(session, mesa.id)
    return MesaOut.model_validate(mesa)


@router.post("/extraer-imagen", response_model=ExtraccionMesa)
async def extraer_imagen_mesa(imagen: UploadFile = File(...), session: AsyncSession = Depends(get_session)):
    if not gemini_configurado():
        raise HTTPException(400, "Gemini no está configurado (falta GEMINI_API_KEY en el backend)")
    if not imagen.content_type or not imagen.content_type.startswith("image/"):
        raise HTTPException(400, "El archivo debe ser una imagen")

    contenido = await imagen.read()
    if len(contenido) > 10_000_000:
        raise HTTPException(400, "Imagen demasiado grande (máx 10MB)")

    solicitantes = (await session.execute(select(SolicitanteMesa).order_by(SolicitanteMesa.nombre))).scalars().all()

    try:
        extraido = await extraer_mesa(contenido, {"solicitantes": solicitantes})
    except GeminiError as exc:
        raise HTTPException(502, str(exc)) from exc

    fecha_carga = None
    if extraido.get("fecha_carga"):
        try:
            fecha_carga = datetime.fromisoformat(extraido["fecha_carga"])
        except ValueError:
            fecha_carga = None

    return ExtraccionMesa(
        codigo=extraido.get("codigo"),
        titulo=extraido.get("titulo"),
        fecha_carga=fecha_carga,
        descripcion=extraido.get("descripcion"),
        solicitante=_resolver_catalogo(solicitantes, extraido.get("solicitante_id")),
    )


@router.post("/{mesa_id}/cerrar", response_model=MesaOut)
async def cerrar_mesa(mesa_id: int, payload: MesaCerrar, session: AsyncSession = Depends(get_session)):
    mesa = await session.get(Mesa, mesa_id)
    if mesa is None:
        raise HTTPException(404, "Mesa no encontrada")
    if _ya_cerrada(mesa):
        raise HTTPException(400, "La mesa ya está cerrada")

    mesa.solucion = payload.solucion
    mesa.tipo_solucion = payload.tipo_solucion
    mesa.fecha_cierre_real = payload.fecha_cierre_real
    await session.commit()
    mesa = await _obtener_mesa(session, mesa_id)
    return MesaOut.model_validate(mesa)


def _campos_a_actualizar(payload: MesaUpdate) -> dict:
    return payload.model_dump(exclude_unset=True)


@router.post("/{mesa_id}/editar", response_model=MesaOut)
async def editar_mesa(mesa_id: int, payload: MesaUpdate, session: AsyncSession = Depends(get_session)):
    mesa = await session.get(Mesa, mesa_id)
    if mesa is None:
        raise HTTPException(404, "Mesa no encontrada")

    for campo, valor in _campos_a_actualizar(payload).items():
        setattr(mesa, campo, valor)

    try:
        await session.commit()
    except IntegrityError:
        await session.rollback()
        raise HTTPException(409, f"Código '{payload.codigo}' ya existe")

    mesa = await _obtener_mesa(session, mesa_id)
    return MesaOut.model_validate(mesa)


@router.delete("/{mesa_id}", status_code=204)
async def eliminar_mesa(mesa_id: int, session: AsyncSession = Depends(get_session)):
    mesa = await session.get(Mesa, mesa_id)
    if mesa is None:
        raise HTTPException(404, "Mesa no encontrada")
    await session.delete(mesa)
    await session.commit()


def _aplicar_filtros(stmt, *, categoria_id, solicitante_id, resolutor_id, ventana_id, semana, fecha_desde, fecha_hasta, buscar, estado):
    if categoria_id:
        stmt = stmt.where(Mesa.categoria_id == categoria_id)
    if solicitante_id:
        stmt = stmt.where(Mesa.solicitante_id == solicitante_id)
    if resolutor_id:
        stmt = stmt.where(Mesa.resolutor_id == resolutor_id)
    if ventana_id:
        stmt = stmt.where(Mesa.ventana_id == ventana_id)
    if semana:
        stmt = stmt.where(Mesa.semana == semana)
    if fecha_desde:
        stmt = stmt.where(Mesa.fecha_carga >= fecha_desde)
    if fecha_hasta:
        # fecha_carga ahora incluye hora: <= fecha_hasta excluiría cualquier mesa
        # cargada después de medianoche de ese mismo día. Se compara contra el
        # inicio del día siguiente para incluir el día completo.
        stmt = stmt.where(Mesa.fecha_carga < fecha_hasta + timedelta(days=1))
    if estado == "abierta":
        stmt = stmt.where(Mesa.fecha_cierre_real.is_(None))
    elif estado == "cerrada":
        stmt = stmt.where(Mesa.fecha_cierre_real.isnot(None))
    if buscar:
        like = f"%{buscar}%"
        stmt = stmt.where(Mesa.descripcion.ilike(like) | Mesa.titulo.ilike(like) | Mesa.codigo.ilike(like))
    return stmt


@router.get("", response_model=PaginaMesas)
async def listar_mesas(
    session: AsyncSession = Depends(get_session),
    page: int = Query(1, ge=1),
    page_size: int = Query(50, ge=1, le=500),
    categoria_id: int | None = None,
    solicitante_id: int | None = None,
    resolutor_id: int | None = None,
    ventana_id: int | None = None,
    semana: str | None = None,
    fecha_desde: date | None = None,
    fecha_hasta: date | None = None,
    buscar: str | None = None,
    estado: str | None = None,
):
    base = _aplicar_filtros(
        select(Mesa),
        categoria_id=categoria_id, solicitante_id=solicitante_id, resolutor_id=resolutor_id,
        ventana_id=ventana_id, semana=semana, fecha_desde=fecha_desde, fecha_hasta=fecha_hasta,
        buscar=buscar, estado=estado,
    )
    total = (await session.execute(select(func.count()).select_from(base.subquery()))).scalar_one()

    stmt = (
        base.options(*_RELACIONES)
        .order_by(Mesa.fecha_carga.desc(), Mesa.id.desc())
        .offset((page - 1) * page_size)
        .limit(page_size)
    )
    items = (await session.execute(stmt)).scalars().all()
    return PaginaMesas(total=total, items=[MesaOut.model_validate(i) for i in items])


async def _mesas_de_semana(session: AsyncSession, semana: str) -> list[Mesa]:
    stmt = (
        select(Mesa)
        .options(*_RELACIONES)
        .where(Mesa.semana == semana)
        .order_by(Mesa.fecha_carga.desc(), Mesa.id.desc())
    )
    return (await session.execute(stmt)).scalars().all()


@router.get("/panel", response_model=PanelMesasKPIs)
async def panel_mesas(session: AsyncSession = Depends(get_session)):
    semana = semana_de(date.today())
    mesas_semana = await _mesas_de_semana(session, semana)

    por_categoria: dict[str, int] = {}
    por_dia: dict[str, int] = {}
    por_resolutor: dict[str, int] = {}
    for m in mesas_semana:
        por_categoria[m.categoria.nombre] = por_categoria.get(m.categoria.nombre, 0) + 1
        dia = m.fecha_carga.date().isoformat()
        por_dia[dia] = por_dia.get(dia, 0) + 1
        por_resolutor[m.resolutor.nombre] = por_resolutor.get(m.resolutor.nombre, 0) + 1

    volumen_diario = [{"fecha": k, "total": v} for k, v in sorted(por_dia.items())]
    distribucion_resolutor = [{"resolutor": k, "total": v} for k, v in sorted(por_resolutor.items(), key=lambda x: -x[1])]

    return PanelMesasKPIs(
        semana=semana,
        total_semana=len(mesas_semana),
        por_categoria=por_categoria,
        volumen_diario=volumen_diario,
        distribucion_resolutor=distribucion_resolutor,
        recientes=[MesaOut.model_validate(m) for m in mesas_semana[:10]],
    )


@router.get("/reporte", response_model=ReporteMesasSemanal)
async def reporte_mesas_semanal(semana: str = Query(...), session: AsyncSession = Depends(get_session)):
    mesas_semana = await _mesas_de_semana(session, semana)
    if not mesas_semana:
        return ReporteMesasSemanal(semana=semana, total=0, por_categoria={}, por_solicitante={}, por_resolutor={}, mesas=[])

    por_categoria: dict[str, int] = {}
    por_solicitante: dict[str, int] = {}
    por_resolutor: dict[str, int] = {}
    for m in mesas_semana:
        por_categoria[m.categoria.nombre] = por_categoria.get(m.categoria.nombre, 0) + 1
        por_solicitante[m.solicitante.nombre] = por_solicitante.get(m.solicitante.nombre, 0) + 1
        por_resolutor[m.resolutor.nombre] = por_resolutor.get(m.resolutor.nombre, 0) + 1

    return ReporteMesasSemanal(
        semana=semana, total=len(mesas_semana),
        por_categoria=por_categoria, por_solicitante=por_solicitante, por_resolutor=por_resolutor,
        mesas=[MesaOut.model_validate(m) for m in mesas_semana],
    )


async def _descripciones_de_semana(session: AsyncSession, semana: str) -> list[Row]:
    """Solo id/descripcion/embedding: temas-frecuentes no necesita categoría/solicitante/resolutor/ventana."""
    stmt = select(Mesa.id, Mesa.descripcion, Mesa.embedding).where(Mesa.semana == semana)
    return list((await session.execute(stmt)).all())


@router.get("/temas-frecuentes", response_model=list[GrupoSoporte])
async def temas_frecuentes_mesas(
    semana: str = Query(...),
    umbral: float = Query(0.86, ge=0.5, le=0.99),
    top: int = Query(10, ge=1, le=50),
    session: AsyncSession = Depends(get_session),
):
    if not gemini_configurado():
        raise HTTPException(400, "Gemini no está configurado (falta GEMINI_API_KEY en el backend)")

    filas = await _descripciones_de_semana(session, semana)
    if not filas:
        return []

    try:
        embeddings = await asegurar_embeddings(session, filas, Mesa)
    except GeminiError as exc:
        raise HTTPException(502, str(exc)) from exc

    grupos = [
        GrupoSoporte(tema=tema_representativo([filas[i].descripcion for i in idx]), cantidad=len(idx))
        for idx in agrupar_por_similitud(embeddings, umbral)
        if len(idx) >= 2
    ]
    return grupos[:top]


def _generar_xlsx_mesas(encabezados: list[str], mesas_filtradas: list[Mesa]) -> io.BytesIO:
    wb = Workbook()
    ws = wb.active
    ws.title = "Mesas"

    color_encabezado = "0F1B2D"
    color_fila_a = "16273D"
    color_fila_b = "1C3149"
    color_borde = "2A3F58"
    color_texto = "E8EDF2"

    fuente_encabezado = Font(name="Calibri", bold=True, color=color_texto, size=11)
    relleno_encabezado = PatternFill("solid", fgColor=color_encabezado)
    alineacion_encabezado = Alignment(horizontal="left", vertical="center")
    fuente_cuerpo = Font(name="Calibri", color=color_texto, size=11)
    borde_fino = Border(bottom=Side(style="thin", color=color_borde))

    ws.sheet_view.showGridLines = False

    ws.append(encabezados)
    for celda in ws[1]:
        celda.font = fuente_encabezado
        celda.fill = relleno_encabezado
        celda.alignment = alineacion_encabezado
    ws.row_dimensions[1].height = 20

    for i, m in enumerate(mesas_filtradas, start=2):
        ws.cell(i, 1, m.codigo)
        ws.cell(i, 2, m.titulo)
        ws.cell(i, 3, m.fecha_carga).number_format = "yyyy-mm-dd hh:mm"
        ws.cell(i, 4, m.categoria.nombre)
        ws.cell(i, 5, m.solicitante.nombre)
        ws.cell(i, 6, m.resolutor.nombre)
        ws.cell(i, 7, m.ventana.nombre)
        ws.cell(i, 8, m.descripcion)
        ws.cell(i, 9, "Cerrada" if m.fecha_cierre_real else "Abierta")
        ws.cell(i, 10, m.solucion or "—")
        relleno_fila = PatternFill("solid", fgColor=color_fila_b if i % 2 == 0 else color_fila_a)
        for col in range(1, len(encabezados) + 1):
            celda = ws.cell(i, col)
            celda.border = borde_fino
            celda.font = fuente_cuerpo
            celda.fill = relleno_fila
            celda.alignment = Alignment(vertical="center", wrap_text=col == 8)

    anchos = [12, 30, 14, 16, 18, 14, 14, 50, 10, 40]
    for col, ancho in enumerate(anchos, start=1):
        ws.column_dimensions[get_column_letter(col)].width = ancho

    ws.freeze_panes = "A2"
    ws.auto_filter.ref = f"A1:{get_column_letter(len(encabezados))}{max(len(mesas_filtradas) + 1, 1)}"

    filas_resumen = [
        SimpleNamespace(fecha=m.fecha_carga.date(), descripcion=m.descripcion, embedding=m.embedding)
        for m in mesas_filtradas
    ]
    agregar_hoja_resumen(wb, filas_resumen)

    out = io.BytesIO()
    wb.save(out)
    out.seek(0)
    return out


@router.get("/export")
async def exportar_mesas(
    formato: str = Query("csv", pattern="^(csv|xlsx)$"),
    session: AsyncSession = Depends(get_session),
    categoria_id: int | None = None,
    solicitante_id: int | None = None,
    resolutor_id: int | None = None,
    ventana_id: int | None = None,
    semana: str | None = None,
    fecha_desde: date | None = None,
    fecha_hasta: date | None = None,
    buscar: str | None = None,
    estado: str | None = None,
):
    stmt = _aplicar_filtros(
        select(Mesa),
        categoria_id=categoria_id, solicitante_id=solicitante_id, resolutor_id=resolutor_id,
        ventana_id=ventana_id, semana=semana, fecha_desde=fecha_desde, fecha_hasta=fecha_hasta,
        buscar=buscar, estado=estado,
    ).options(*_RELACIONES).order_by(Mesa.fecha_carga.desc())

    mesas_filtradas = (await session.execute(stmt)).scalars().all()
    encabezados = ["Código", "Título", "Fecha carga", "Categoría", "Solicitante", "Resolutor", "Ventana", "Descripción", "Estado", "Solución"]

    if formato == "csv":
        filas = [
            [
                m.codigo, m.titulo, m.fecha_carga.strftime("%Y-%m-%d %H:%M"), m.categoria.nombre, m.solicitante.nombre,
                m.resolutor.nombre, m.ventana.nombre, m.descripcion,
                "Cerrada" if m.fecha_cierre_real else "Abierta", m.solucion or "",
            ]
            for m in mesas_filtradas
        ]
        buf = io.StringIO()
        writer = csv.writer(buf)
        writer.writerow(encabezados)
        writer.writerows(filas)
        return StreamingResponse(
            iter([buf.getvalue()]),
            media_type="text/csv",
            headers={"Content-Disposition": "attachment; filename=mesas.csv"},
        )

    out = _generar_xlsx_mesas(encabezados, mesas_filtradas)
    return StreamingResponse(
        out,
        media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        headers={"Content-Disposition": "attachment; filename=mesas.xlsx"},
    )


@router.get("/{mesa_id}", response_model=MesaOut)
async def obtener_mesa(mesa_id: int, session: AsyncSession = Depends(get_session)):
    """Registrada al final: debe ir después de todas las rutas GET de path literal
    (/panel, /reporte, /temas-frecuentes, /export) para que Starlette no la use
    como match genérico antes de llegar a esas — mismo bug que causó un 405 en
    producción cuando /soportes-frecuentes no existía en el backend viejo."""
    try:
        mesa = await _obtener_mesa(session, mesa_id)
    except NoResultFound:
        raise HTTPException(404, "Mesa no encontrada") from None
    return MesaOut.model_validate(mesa)
