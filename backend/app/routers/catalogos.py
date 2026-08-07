from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import (
    Agente,
    CategoriaMesa,
    Empresa,
    Medio,
    Modulo,
    ResolutorMesa,
    Sistema,
    SolicitanteMesa,
    VentanaMesa,
)
from app.schemas import CatalogoCreate, CatalogoOut
from app.services.auth import get_usuario_actual

router = APIRouter(tags=["catalogos"], dependencies=[Depends(get_usuario_actual)])


def _catalogo_router(prefix: str, model, creatable: bool):
    sub = APIRouter(prefix=prefix)

    @sub.get("", response_model=list[CatalogoOut])
    async def listar(q: str = "", session: AsyncSession = Depends(get_session)):
        stmt = select(model).order_by(model.nombre)
        if q:
            stmt = stmt.where(model.nombre.ilike(f"{q}%"))
        result = await session.execute(stmt.limit(20))
        return result.scalars().all()

    if creatable:
        @sub.post("", response_model=CatalogoOut, status_code=201)
        async def crear(payload: CatalogoCreate, session: AsyncSession = Depends(get_session)):
            nombre = payload.nombre.strip()
            if not nombre:
                raise HTTPException(400, "Nombre vacío")
            existente = await session.execute(select(model).where(model.nombre == nombre))
            row = existente.scalar_one_or_none()
            if row:
                return row
            item = model(nombre=nombre)
            session.add(item)
            try:
                await session.commit()
            except IntegrityError:
                await session.rollback()
                raise HTTPException(409, f"'{nombre}' ya existe")
            await session.refresh(item)
            return item

    return sub


router.include_router(_catalogo_router("/empresas", Empresa, creatable=True))
router.include_router(_catalogo_router("/modulos", Modulo, creatable=True))
router.include_router(_catalogo_router("/sistemas", Sistema, creatable=False))
router.include_router(_catalogo_router("/medios", Medio, creatable=False))
router.include_router(_catalogo_router("/agentes", Agente, creatable=False))
router.include_router(_catalogo_router("/categorias-mesa", CategoriaMesa, creatable=True))
router.include_router(_catalogo_router("/solicitantes-mesa", SolicitanteMesa, creatable=True))
router.include_router(_catalogo_router("/resolutores-mesa", ResolutorMesa, creatable=True))
router.include_router(_catalogo_router("/ventanas-mesa", VentanaMesa, creatable=True))
