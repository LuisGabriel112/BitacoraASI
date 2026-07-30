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
