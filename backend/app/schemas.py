from datetime import date, datetime

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
