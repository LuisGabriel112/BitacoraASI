from datetime import date, datetime

from sqlalchemy import ARRAY, Computed, Date, DateTime, Float, ForeignKey, Text, func
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.database import Base


class Empresa(Base):
    __tablename__ = "empresas"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)


class Sistema(Base):
    __tablename__ = "sistemas"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)


class Medio(Base):
    __tablename__ = "medios"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)


class Modulo(Base):
    __tablename__ = "modulos"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)


class Agente(Base):
    __tablename__ = "agentes"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)
    usuario_id: Mapped[int | None] = mapped_column(ForeignKey("usuarios.id"), nullable=True)


class Usuario(Base):
    __tablename__ = "usuarios"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text)
    pin_hash: Mapped[str] = mapped_column(Text)
    avatar: Mapped[str] = mapped_column(Text, default="🙂")
    xp: Mapped[int] = mapped_column(default=0)
    intentos_fallidos: Mapped[int] = mapped_column(default=0)
    bloqueado_hasta: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())


class XpEvento(Base):
    __tablename__ = "xp_eventos"
    id: Mapped[int] = mapped_column(primary_key=True)
    usuario_id: Mapped[int | None] = mapped_column(ForeignKey("usuarios.id"), nullable=True)
    nombre_capturado: Mapped[str] = mapped_column(Text)
    cantidad: Mapped[int] = mapped_column()
    motivo: Mapped[str] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())


class Registro(Base):
    __tablename__ = "registros"

    id: Mapped[int] = mapped_column(primary_key=True)
    fecha: Mapped[date] = mapped_column(Date)
    semana: Mapped[str] = mapped_column(
        Text,
        Computed(
            "'SEM ' || lpad(extract(week from fecha)::text, 2, '0') "
            "|| ' - ' || extract(isoyear from fecha)::text",
            persisted=True,
        ),
    )
    empresa_id: Mapped[int] = mapped_column(ForeignKey("empresas.id"))
    sistema_id: Mapped[int] = mapped_column(ForeignKey("sistemas.id"))
    medio_id: Mapped[int] = mapped_column(ForeignKey("medios.id"))
    modulo_id: Mapped[int] = mapped_column(ForeignKey("modulos.id"))
    atendio_id: Mapped[int] = mapped_column(ForeignKey("agentes.id"))
    descripcion: Mapped[str] = mapped_column(Text)
    embedding: Mapped[list[float] | None] = mapped_column(ARRAY(Float), nullable=True)
    trello_card_id: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    empresa: Mapped[Empresa] = relationship(lazy="joined")
    sistema: Mapped[Sistema] = relationship(lazy="joined")
    medio: Mapped[Medio] = relationship(lazy="joined")
    modulo: Mapped[Modulo] = relationship(lazy="joined")
    atendio: Mapped[Agente] = relationship(lazy="joined")


class CategoriaMesa(Base):
    __tablename__ = "categorias_mesa"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)


class SolicitanteMesa(Base):
    __tablename__ = "solicitantes_mesa"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)


class ResolutorMesa(Base):
    __tablename__ = "resolutores_mesa"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)
    usuario_id: Mapped[int | None] = mapped_column(ForeignKey("usuarios.id"), nullable=True)


class VentanaMesa(Base):
    __tablename__ = "ventanas_mesa"
    id: Mapped[int] = mapped_column(primary_key=True)
    nombre: Mapped[str] = mapped_column(Text, unique=True)


class Mesa(Base):
    __tablename__ = "mesas"

    id: Mapped[int] = mapped_column(primary_key=True)
    enlace: Mapped[str | None] = mapped_column(Text, nullable=True)
    codigo: Mapped[str] = mapped_column(Text, unique=True)
    titulo: Mapped[str] = mapped_column(Text)
    fecha_carga: Mapped[datetime] = mapped_column(DateTime)
    semana: Mapped[str] = mapped_column(
        Text,
        Computed(
            "'SEM ' || lpad(extract(week from fecha_carga)::text, 2, '0') "
            "|| ' - ' || extract(isoyear from fecha_carga)::text",
            persisted=True,
        ),
    )
    descripcion: Mapped[str] = mapped_column(Text)
    ventana_id: Mapped[int | None] = mapped_column(ForeignKey("ventanas_mesa.id"), nullable=True)
    categoria_id: Mapped[int] = mapped_column(ForeignKey("categorias_mesa.id"))
    solicitante_id: Mapped[int] = mapped_column(ForeignKey("solicitantes_mesa.id"))
    resolutor_id: Mapped[int] = mapped_column(ForeignKey("resolutores_mesa.id"))
    fecha_estimada_resolucion: Mapped[datetime] = mapped_column(DateTime)
    solucion: Mapped[str | None] = mapped_column(Text, nullable=True)
    tipo_solucion: Mapped[str | None] = mapped_column(Text, nullable=True)
    fecha_cierre_real: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    embedding: Mapped[list[float] | None] = mapped_column(ARRAY(Float), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    ventana: Mapped[VentanaMesa | None] = relationship(lazy="joined")
    categoria: Mapped[CategoriaMesa] = relationship(lazy="joined")
    solicitante: Mapped[SolicitanteMesa] = relationship(lazy="joined")
    resolutor: Mapped[ResolutorMesa] = relationship(lazy="joined")
