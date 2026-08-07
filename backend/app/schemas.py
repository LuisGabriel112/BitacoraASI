from datetime import date, datetime
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field, model_validator


class PersonajeOut(BaseModel):
    nombre: str
    avatar: str
    xp: int
    nivel: int
    xp_en_nivel_actual: int
    xp_para_siguiente_nivel: int
    titulo: str


class UsuarioRegistro(BaseModel):
    nombre: str
    pin: str = Field(min_length=4, max_length=72)
    avatar: str = "🙂"


class UsuarioLogin(BaseModel):
    nombre: str
    pin: str = Field(min_length=1, max_length=72)


class EventoXpOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    cantidad: int
    motivo: str
    created_at: datetime


class RankingItemOut(BaseModel):
    nombre: str
    avatar: str
    nivel: int
    xp: int


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
    fecha_carga: datetime
    descripcion: str
    categoria_id: int
    solicitante_id: int
    resolutor_id: int
    fecha_estimada_resolucion: datetime
    ventana_id: int | None = None
    solucion: str | None = None
    tipo_solucion: TipoSolucion | None = None
    fecha_cierre_real: datetime | None = None

    @model_validator(mode="after")
    def _cierre_todo_o_nada(self) -> "MesaCreate":
        # ventana se determina con criterio propio al resolver, no al abrir la mesa:
        # va junto con el resto de la información de cierre, todo o nada.
        campos_cierre = (self.solucion, self.tipo_solucion, self.fecha_cierre_real, self.ventana_id)
        if any(campos_cierre) and not all(campos_cierre):
            raise ValueError(
                "Para colocar la información de cierre al crear, se deben dar ventana, solución, "
                "tipo de solución y fecha real de cierre juntos"
            )
        return self


class MesaCerrar(BaseModel):
    ventana_id: int
    solucion: str
    tipo_solucion: TipoSolucion
    fecha_cierre_real: datetime


class MesaUpdate(BaseModel):
    enlace: str | None = None
    codigo: str | None = None
    titulo: str | None = None
    fecha_carga: datetime | None = None
    descripcion: str | None = None
    ventana_id: int | None = None
    categoria_id: int | None = None
    solicitante_id: int | None = None
    resolutor_id: int | None = None
    fecha_estimada_resolucion: datetime | None = None
    solucion: str | None = None
    tipo_solucion: TipoSolucion | None = None
    fecha_cierre_real: datetime | None = None


class MesaOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    enlace: str | None
    codigo: str
    titulo: str
    fecha_carga: datetime
    semana: str
    descripcion: str
    fecha_estimada_resolucion: datetime
    solucion: str | None
    tipo_solucion: str | None
    fecha_cierre_real: datetime | None
    created_at: datetime
    ventana: CatalogoOut | None
    categoria: CatalogoOut
    solicitante: CatalogoOut
    resolutor: CatalogoOut
    logros: list[str] = []


class PaginaMesas(BaseModel):
    total: int
    items: list[MesaOut]


class ExtraccionMesa(BaseModel):
    codigo: str | None = None
    titulo: str | None = None
    fecha_carga: datetime | None = None
    descripcion: str | None = None
    solicitante: CatalogoOut | None = None


class PanelMesasKPIs(BaseModel):
    semana: str
    total_semana: int
    volumen_diario: list[dict]
    distribucion_ventana: list[dict]
    distribucion_categoria_solucion: list[dict]
    recientes: list[MesaOut]


class ReporteMesasSemanal(BaseModel):
    semana: str
    total: int
    por_categoria: dict[str, int]
    por_solicitante: dict[str, int]
    mesas: list[MesaOut]
