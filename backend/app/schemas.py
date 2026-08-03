from datetime import date, datetime
from typing import Literal

from pydantic import BaseModel, ConfigDict


class CatalogoOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    nombre: str


class CatalogoCreate(BaseModel):
    nombre: str


class RegistroCreate(BaseModel):
    fecha: date
    empresa_id: int
    sistema_id: int
    medio_id: int
    modulo_id: int
    atendio_id: int
    descripcion: str


class RegistroOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    fecha: date
    semana: str
    descripcion: str
    trello_card_id: str | None
    created_at: datetime
    empresa: CatalogoOut
    sistema: CatalogoOut
    medio: CatalogoOut
    modulo: CatalogoOut
    atendio: CatalogoOut


class ExtraccionRegistro(BaseModel):
    fecha: date | None = None
    descripcion: str | None = None
    empresa: CatalogoOut | None = None
    sistema: CatalogoOut | None = None
    medio: CatalogoOut | None = None
    modulo: CatalogoOut | None = None
    atendio: CatalogoOut | None = None


class RegistroCreadoOut(BaseModel):
    registro: RegistroOut
    trello_ok: bool
    trello_error: str | None = None


class PaginaRegistros(BaseModel):
    total: int
    items: list[RegistroOut]


class PanelKPIs(BaseModel):
    semana: str
    total_semana: int
    por_sistema: dict[str, int]
    volumen_diario: list[dict]
    distribucion_modulo: list[dict]
    recientes: list[RegistroOut]


class ReporteSemanal(BaseModel):
    semana: str
    total: int
    por_sistema: dict[str, int]
    por_empresa: dict[str, int]
    por_medio: dict[str, int]
    registros: list[RegistroOut]


class GrupoSoporte(BaseModel):
    tema: str
    cantidad: int


TipoSolucion = Literal["Modificación en BD", "Seguimiento de proceso"]


class MesaCreate(BaseModel):
    enlace: str | None = None
    codigo: str
    titulo: str
    fecha_carga: date
    descripcion: str
    ventana_id: int
    categoria_id: int
    solicitante_id: int
    resolutor_id: int
    fecha_estimada_resolucion: date


class MesaCerrar(BaseModel):
    solucion: str
    tipo_solucion: TipoSolucion
    fecha_cierre_real: date


class MesaOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    enlace: str | None
    codigo: str
    titulo: str
    fecha_carga: date
    semana: str
    descripcion: str
    fecha_estimada_resolucion: date
    solucion: str | None
    tipo_solucion: str | None
    fecha_cierre_real: date | None
    created_at: datetime
    ventana: CatalogoOut
    categoria: CatalogoOut
    solicitante: CatalogoOut
    resolutor: CatalogoOut


class PaginaMesas(BaseModel):
    total: int
    items: list[MesaOut]


class ExtraccionMesa(BaseModel):
    codigo: str | None = None
    titulo: str | None = None
    fecha_carga: date | None = None
    descripcion: str | None = None
    solicitante: CatalogoOut | None = None


class PanelMesasKPIs(BaseModel):
    semana: str
    total_semana: int
    por_categoria: dict[str, int]
    volumen_diario: list[dict]
    distribucion_resolutor: list[dict]
    recientes: list[MesaOut]


class ReporteMesasSemanal(BaseModel):
    semana: str
    total: int
    por_categoria: dict[str, int]
    por_solicitante: dict[str, int]
    por_resolutor: dict[str, int]
    mesas: list[MesaOut]
