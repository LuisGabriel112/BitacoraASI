from datetime import date, datetime
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field, model_validator


AccesorioTipo = Literal["ninguno", "gorra", "casco", "antenas"]


class PersonajeOut(BaseModel):
    id: int
    nombre: str
    avatar: str
    color_piel: str
    color_cuerpo: str
    accesorio: AccesorioTipo
    xp: int
    nivel: int
    xp_en_nivel_actual: int
    xp_para_siguiente_nivel: int
    titulo: str


class UsuarioRegistro(BaseModel):
    nombre: str
    pin: str = Field(min_length=4, max_length=72)
    avatar: str = "🙂"
    color_piel: str = Field(default="#f2c9a1", pattern=r"^#[0-9a-fA-F]{6}$")
    color_cuerpo: str = Field(default="#3b82f6", pattern=r"^#[0-9a-fA-F]{6}$")
    accesorio: AccesorioTipo = "ninguno"


class AparienciaUpdate(BaseModel):
    color_piel: str = Field(pattern=r"^#[0-9a-fA-F]{6}$")
    color_cuerpo: str = Field(pattern=r"^#[0-9a-fA-F]{6}$")
    accesorio: AccesorioTipo


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


class JefeOut(BaseModel):
    semana: str
    nombre: str
    vida_max: int
    vida_actual: int
    derrotado: bool


class JefeBonusOut(BaseModel):
    nombre: str
    vida_max: int
    vida_actual: int
    derrotado: bool


class MascotaOut(BaseModel):
    semana: str
    nombre: str
    vida_max: int


class DanioJefeEventoOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    nombre_capturado: str
    cantidad: int
    motivo: str
    created_at: datetime


class JugadorGatoOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    nombre: str
    avatar: str


class PartidaGatoOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    tablero: str
    turno: str
    estado: str
    ganador: str | None
    jugador_x: JugadorGatoOut
    jugador_o: JugadorGatoOut | None


class MovimientoGato(BaseModel):
    posicion: int = Field(ge=0, le=8)


class IntentoPelotaOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    resuelto: bool
    acierto: bool | None


class EleccionPelota(BaseModel):
    posicion: int = Field(ge=0, le=2)


class ResultadoPelotaOut(BaseModel):
    acierto: bool
    posicion_correcta: int


class JugadorRPSOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    nombre: str
    avatar: str


class PartidaRPSOut(BaseModel):
    id: int
    estado: str
    resultado: str | None
    jugada_x: str | None
    jugada_o: str | None
    jugador_x: JugadorRPSOut
    jugador_o: JugadorRPSOut | None


class JugadaRPS(BaseModel):
    jugada: Literal["piedra", "papel", "tijera"]


class PreguntaTriviaOut(BaseModel):
    intento_id: int
    pregunta_id: int
    texto: str
    opciones: list[str]


class RespuestaTrivia(BaseModel):
    opcion: int = Field(ge=0, le=3)


class ResultadoTriviaOut(BaseModel):
    acierto: bool
    respuesta_correcta: int


class IntentoMemoramaOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    resuelto: bool
    acierto: bool | None


class ResultadoMemoramaOut(BaseModel):
    acierto: bool


class IntentoReaccionOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    resuelto: bool
    acierto: bool | None


class ReporteReaccion(BaseModel):
    tiempo_ms: int = Field(ge=0, le=60_000)


class ResultadoReaccionOut(BaseModel):
    acierto: bool


class ResultadoRuletaOut(BaseModel):
    gano: bool


class AutorChatOut(BaseModel):
    nombre: str
    avatar: str


class MensajeChatOut(BaseModel):
    id: int
    autor: AutorChatOut
    texto: str | None
    archivo_url: str | None
    archivo_nombre: str | None
    archivo_tipo: str | None
    created_at: datetime


class MensajeChatCreate(BaseModel):
    texto: str | None = None
    archivo_url: str | None = None
    archivo_nombre: str | None = None
    archivo_tipo: str | None = None

    @model_validator(mode="after")
    def _texto_o_archivo(self) -> "MensajeChatCreate":
        if not (self.texto or "").strip() and not self.archivo_url:
            raise ValueError("El mensaje necesita texto o un archivo adjunto")
        return self


class CatalogoOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    nombre: str
    usuario_id: int | None = None


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


class RegistroUpdate(BaseModel):
    fecha: date | None = None
    empresa_id: int | None = None
    sistema_id: int | None = None
    medio_id: int | None = None
    modulo_id: int | None = None
    atendio_id: int | None = None
    descripcion: str | None = None


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
    logros: list[str] = []


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
    medidas_impacto: bool = False

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
    medidas_impacto: bool = False


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
    medidas_impacto: bool | None = None
    prioridad: bool | None = None
    destacada: bool | None = None


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
    medidas_impacto: bool
    prioridad: bool
    destacada: bool
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


class SintesisSolucionOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    categoria: CatalogoOut
    tipo_solucion: str | None
    titulo: str
    texto: str
    cantidad_mesas: int
    generado_en: datetime


class ResumenGeneracionSintesis(BaseModel):
    grupos_generados: int
    mesas_cubiertas: int
