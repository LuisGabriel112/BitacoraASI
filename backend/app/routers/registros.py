import csv
import io
from datetime import date

from fastapi import APIRouter, Depends, HTTPException, Query
from fastapi.responses import StreamingResponse
from openpyxl import Workbook
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils import get_column_letter
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.database import get_session
from app.models import Agente, Empresa, Medio, Modulo, Registro, Sistema
from app.schemas import PanelKPIs, PaginaRegistros, RegistroCreadoOut, RegistroCreate, RegistroOut, ReporteSemanal
from app.services.trello import TrelloError, crear_tarjeta, trello_configurado

router = APIRouter(prefix="/registros", tags=["registros"])


def _semana_de(fecha: date) -> str:
    iso_year, iso_week, _ = fecha.isocalendar()
    return f"SEM {iso_week:02d} - {iso_year}"


async def _get_registro(session: AsyncSession, registro_id: int) -> Registro:
    stmt = (
        select(Registro)
        .options(
            selectinload(Registro.empresa),
            selectinload(Registro.sistema),
            selectinload(Registro.medio),
            selectinload(Registro.modulo),
            selectinload(Registro.atendio),
        )
        .where(Registro.id == registro_id)
    )
    result = await session.execute(stmt)
    return result.scalar_one()


@router.post("", response_model=RegistroCreadoOut, status_code=201)
async def crear_registro(payload: RegistroCreate, session: AsyncSession = Depends(get_session)):
    registro = Registro(
        fecha=payload.fecha,
        empresa_id=payload.empresa_id,
        sistema_id=payload.sistema_id,
        medio_id=payload.medio_id,
        modulo_id=payload.modulo_id,
        atendio_id=payload.atendio_id,
        descripcion=payload.descripcion,
    )
    session.add(registro)
    await session.commit()
    registro = await _get_registro(session, registro.id)

    trello_ok = False
    trello_error = None
    if trello_configurado():
        try:
            titulo = f"{registro.empresa.nombre} · {registro.sistema.nombre} · {registro.modulo.nombre}"
            card_id = await crear_tarjeta(titulo, registro.descripcion)
            registro.trello_card_id = card_id
            await session.commit()
            registro = await _get_registro(session, registro.id)
            trello_ok = True
        except TrelloError as exc:
            trello_error = str(exc)

    return RegistroCreadoOut(registro=RegistroOut.model_validate(registro), trello_ok=trello_ok, trello_error=trello_error)


@router.post("/{registro_id}/reintentar-trello", response_model=RegistroCreadoOut)
async def reintentar_trello(registro_id: int, session: AsyncSession = Depends(get_session)):
    registro = await _get_registro(session, registro_id)
    trello_ok = False
    trello_error = None
    try:
        titulo = f"{registro.empresa.nombre} · {registro.sistema.nombre} · {registro.modulo.nombre}"
        card_id = await crear_tarjeta(titulo, registro.descripcion)
        registro.trello_card_id = card_id
        await session.commit()
        registro = await _get_registro(session, registro.id)
        trello_ok = True
    except TrelloError as exc:
        trello_error = str(exc)
    return RegistroCreadoOut(registro=RegistroOut.model_validate(registro), trello_ok=trello_ok, trello_error=trello_error)


@router.delete("/{registro_id}", status_code=204)
async def eliminar_registro(registro_id: int, session: AsyncSession = Depends(get_session)):
    registro = await session.get(Registro, registro_id)
    if registro is None:
        raise HTTPException(404, "Registro no encontrado")
    await session.delete(registro)
    await session.commit()


def _aplicar_filtros(stmt, *, empresa_id, sistema_id, medio_id, modulo_id, atendio_id, semana, fecha_desde, fecha_hasta, buscar):
    if empresa_id:
        stmt = stmt.where(Registro.empresa_id == empresa_id)
    if sistema_id:
        stmt = stmt.where(Registro.sistema_id == sistema_id)
    if medio_id:
        stmt = stmt.where(Registro.medio_id == medio_id)
    if modulo_id:
        stmt = stmt.where(Registro.modulo_id == modulo_id)
    if atendio_id:
        stmt = stmt.where(Registro.atendio_id == atendio_id)
    if semana:
        stmt = stmt.where(Registro.semana == semana)
    if fecha_desde:
        stmt = stmt.where(Registro.fecha >= fecha_desde)
    if fecha_hasta:
        stmt = stmt.where(Registro.fecha <= fecha_hasta)
    if buscar:
        like = f"%{buscar}%"
        stmt = (
            stmt.join(Empresa)
            .join(Sistema)
            .join(Medio)
            .join(Modulo)
            .join(Agente)
            .where(
                Registro.descripcion.ilike(like)
                | Empresa.nombre.ilike(like)
                | Sistema.nombre.ilike(like)
                | Medio.nombre.ilike(like)
                | Modulo.nombre.ilike(like)
                | Agente.nombre.ilike(like)
            )
        )
    return stmt


@router.get("", response_model=PaginaRegistros)
async def listar_registros(
    session: AsyncSession = Depends(get_session),
    page: int = Query(1, ge=1),
    page_size: int = Query(50, ge=1, le=500),
    empresa_id: int | None = None,
    sistema_id: int | None = None,
    medio_id: int | None = None,
    modulo_id: int | None = None,
    atendio_id: int | None = None,
    semana: str | None = None,
    fecha_desde: date | None = None,
    fecha_hasta: date | None = None,
    buscar: str | None = None,
):
    base = _aplicar_filtros(
        select(Registro),
        empresa_id=empresa_id, sistema_id=sistema_id, medio_id=medio_id,
        modulo_id=modulo_id, atendio_id=atendio_id, semana=semana,
        fecha_desde=fecha_desde, fecha_hasta=fecha_hasta, buscar=buscar,
    )
    total = (await session.execute(select(func.count()).select_from(base.subquery()))).scalar_one()

    stmt = (
        base.options(
            selectinload(Registro.empresa), selectinload(Registro.sistema),
            selectinload(Registro.medio), selectinload(Registro.modulo), selectinload(Registro.atendio),
        )
        .order_by(Registro.fecha.desc(), Registro.id.desc())
        .offset((page - 1) * page_size)
        .limit(page_size)
    )
    items = (await session.execute(stmt)).scalars().all()
    return PaginaRegistros(total=total, items=[RegistroOut.model_validate(i) for i in items])


async def _registros_de_semana(session: AsyncSession, semana: str) -> list[Registro]:
    stmt = (
        select(Registro)
        .options(
            selectinload(Registro.empresa), selectinload(Registro.sistema),
            selectinload(Registro.medio), selectinload(Registro.modulo), selectinload(Registro.atendio),
        )
        .where(Registro.semana == semana)
        .order_by(Registro.fecha.desc(), Registro.id.desc())
    )
    return (await session.execute(stmt)).scalars().all()


@router.get("/panel", response_model=PanelKPIs)
async def panel(session: AsyncSession = Depends(get_session)):
    semana = _semana_de(date.today())
    registros = await _registros_de_semana(session, semana)

    por_sistema: dict[str, int] = {}
    por_dia: dict[str, int] = {}
    por_modulo: dict[str, int] = {}
    for r in registros:
        por_sistema[r.sistema.nombre] = por_sistema.get(r.sistema.nombre, 0) + 1
        dia = r.fecha.isoformat()
        por_dia[dia] = por_dia.get(dia, 0) + 1
        por_modulo[r.modulo.nombre] = por_modulo.get(r.modulo.nombre, 0) + 1

    volumen_diario = [{"fecha": k, "total": v} for k, v in sorted(por_dia.items())]
    distribucion_modulo = [{"modulo": k, "total": v} for k, v in sorted(por_modulo.items(), key=lambda x: -x[1])]

    return PanelKPIs(
        semana=semana,
        total_semana=len(registros),
        por_sistema=por_sistema,
        volumen_diario=volumen_diario,
        distribucion_modulo=distribucion_modulo,
        recientes=[RegistroOut.model_validate(r) for r in registros[:10]],
    )


@router.get("/reporte", response_model=ReporteSemanal)
async def reporte_semanal(semana: str = Query(...), session: AsyncSession = Depends(get_session)):
    registros = await _registros_de_semana(session, semana)
    if not registros:
        return ReporteSemanal(semana=semana, total=0, por_sistema={}, por_empresa={}, por_medio={}, registros=[])

    por_sistema: dict[str, int] = {}
    por_empresa: dict[str, int] = {}
    por_medio: dict[str, int] = {}
    for r in registros:
        por_sistema[r.sistema.nombre] = por_sistema.get(r.sistema.nombre, 0) + 1
        por_empresa[r.empresa.nombre] = por_empresa.get(r.empresa.nombre, 0) + 1
        por_medio[r.medio.nombre] = por_medio.get(r.medio.nombre, 0) + 1

    return ReporteSemanal(
        semana=semana, total=len(registros),
        por_sistema=por_sistema, por_empresa=por_empresa, por_medio=por_medio,
        registros=[RegistroOut.model_validate(r) for r in registros],
    )


@router.get("/export")
async def exportar(
    formato: str = Query("csv", pattern="^(csv|xlsx)$"),
    session: AsyncSession = Depends(get_session),
    empresa_id: int | None = None,
    sistema_id: int | None = None,
    medio_id: int | None = None,
    modulo_id: int | None = None,
    atendio_id: int | None = None,
    semana: str | None = None,
    fecha_desde: date | None = None,
    fecha_hasta: date | None = None,
    buscar: str | None = None,
):
    stmt = _aplicar_filtros(
        select(Registro),
        empresa_id=empresa_id, sistema_id=sistema_id, medio_id=medio_id,
        modulo_id=modulo_id, atendio_id=atendio_id, semana=semana,
        fecha_desde=fecha_desde, fecha_hasta=fecha_hasta, buscar=buscar,
    ).options(
        selectinload(Registro.empresa), selectinload(Registro.sistema),
        selectinload(Registro.medio), selectinload(Registro.modulo), selectinload(Registro.atendio),
    ).order_by(Registro.fecha.desc())

    registros = (await session.execute(stmt)).scalars().all()
    encabezados = ["Fecha", "Semana", "Empresa", "Sistema", "Medio", "Módulo", "Atendió", "Descripción", "Tarjeta Trello"]

    if formato == "csv":
        filas = [
            [r.fecha.isoformat(), r.semana, r.empresa.nombre, r.sistema.nombre, r.medio.nombre, r.modulo.nombre, r.atendio.nombre, r.descripcion, r.trello_card_id or ""]
            for r in registros
        ]
        buf = io.StringIO()
        writer = csv.writer(buf)
        writer.writerow(encabezados)
        writer.writerows(filas)
        return StreamingResponse(
            iter([buf.getvalue()]),
            media_type="text/csv",
            headers={"Content-Disposition": "attachment; filename=bitacora.csv"},
        )

    out = _generar_xlsx(encabezados, registros)
    return StreamingResponse(
        out,
        media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        headers={"Content-Disposition": "attachment; filename=bitacora.xlsx"},
    )


def _generar_xlsx(encabezados: list[str], registros: list[Registro]) -> io.BytesIO:
    wb = Workbook()
    ws = wb.active
    ws.title = "Bitácora"

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

    for i, r in enumerate(registros, start=2):
        ws.cell(i, 1, r.fecha).number_format = "yyyy-mm-dd"
        ws.cell(i, 2, r.semana)
        ws.cell(i, 3, r.empresa.nombre)
        ws.cell(i, 4, r.sistema.nombre)
        ws.cell(i, 5, r.medio.nombre)
        ws.cell(i, 6, r.modulo.nombre)
        ws.cell(i, 7, r.atendio.nombre)
        ws.cell(i, 8, r.descripcion)
        ws.cell(i, 9, r.trello_card_id or "—")
        relleno_fila = PatternFill("solid", fgColor=color_fila_b if i % 2 == 0 else color_fila_a)
        for col in range(1, len(encabezados) + 1):
            celda = ws.cell(i, col)
            celda.border = borde_fino
            celda.font = fuente_cuerpo
            celda.fill = relleno_fila
            celda.alignment = Alignment(vertical="center", wrap_text=col == 8)

    anchos = [12, 15, 22, 14, 14, 22, 18, 50, 16]
    for col, ancho in enumerate(anchos, start=1):
        ws.column_dimensions[get_column_letter(col)].width = ancho

    ws.freeze_panes = "A2"
    ws.auto_filter.ref = f"A1:{get_column_letter(len(encabezados))}{max(len(registros) + 1, 1)}"

    out = io.BytesIO()
    wb.save(out)
    out.seek(0)
    return out
