from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import func, select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.models import (
    Agente,
    CategoriaMesa,
    Empresa,
    Medio,
    Mesa,
    Modulo,
    ResolutorMesa,
    Sistema,
    SolicitanteMesa,
    VentanaMesa,
)
from app.models import Usuario
from app.schemas import CatalogoCreate, CatalogoOut
from app.services.auth import get_usuario_actual

router = APIRouter(tags=["catalogos"], dependencies=[Depends(get_usuario_actual)])


def _consulta_nombre_existente(model, nombre: str):
    """Case-insensitive: sin esto, "Tramites E." y "tramites E." se guardan
    como dos filas distintas cuando el catálogo en caché del frontend no
    atrapa la coincidencia (p. ej. carga desactualizada) -- el backend es
    la última línea de defensa contra el duplicado real."""
    return select(model).where(func.lower(model.nombre) == nombre.lower())


def _catalogo_router(prefix: str, model, creatable: bool, vinculable: bool = False, columna_uso=None):
    sub = APIRouter(prefix=prefix)

    @sub.get("", response_model=list[CatalogoOut])
    async def listar(q: str = "", limit: int = 20, session: AsyncSession = Depends(get_session)):
        stmt = select(model).order_by(model.nombre)
        if q:
            stmt = stmt.where(model.nombre.ilike(f"{q}%"))
        result = await session.execute(stmt.limit(min(max(limit, 1), 500)))
        return result.scalars().all()

    if creatable:
        @sub.post("", response_model=CatalogoOut, status_code=201)
        async def crear(payload: CatalogoCreate, session: AsyncSession = Depends(get_session)):
            nombre = payload.nombre.strip()
            if not nombre:
                raise HTTPException(400, "Nombre vacío")
            existente = await session.execute(_consulta_nombre_existente(model, nombre))
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

    if vinculable:
        @sub.post("/{item_id}/vincular", response_model=CatalogoOut)
        async def vincular(
            item_id: int,
            usuario: Usuario = Depends(get_usuario_actual),
            session: AsyncSession = Depends(get_session),
        ):
            item = await session.get(model, item_id)
            if item is None:
                raise HTTPException(404, "No encontrado")
            item.usuario_id = usuario.id
            await session.commit()
            await session.refresh(item)
            return item

        @sub.post("/{item_id}/desvincular", response_model=CatalogoOut)
        async def desvincular(
            item_id: int,
            usuario: Usuario = Depends(get_usuario_actual),
            session: AsyncSession = Depends(get_session),
        ):
            item = await session.get(model, item_id)
            if item is None:
                raise HTTPException(404, "No encontrado")
            if item.usuario_id == usuario.id:
                item.usuario_id = None
                await session.commit()
                await session.refresh(item)
            return item

    if columna_uso is not None:
        @sub.delete("/{item_id}", status_code=204)
        async def eliminar(item_id: int, session: AsyncSession = Depends(get_session)):
            item = await session.get(model, item_id)
            if item is None:
                raise HTTPException(404, "No encontrado")
            en_uso = await session.execute(select(func.count()).select_from(Mesa).where(columna_uso == item_id))
            if en_uso.scalar_one() > 0:
                raise HTTPException(409, "No se puede eliminar: está en uso por alguna mesa")
            await session.delete(item)
            await session.commit()

    return sub


router.include_router(_catalogo_router("/empresas", Empresa, creatable=True))
router.include_router(_catalogo_router("/modulos", Modulo, creatable=True))
router.include_router(_catalogo_router("/sistemas", Sistema, creatable=False))
router.include_router(_catalogo_router("/medios", Medio, creatable=False))
router.include_router(_catalogo_router("/agentes", Agente, creatable=False, vinculable=True))
router.include_router(
    _catalogo_router("/categorias-mesa", CategoriaMesa, creatable=True, columna_uso=Mesa.categoria_id)
)
router.include_router(
    _catalogo_router("/solicitantes-mesa", SolicitanteMesa, creatable=True, columna_uso=Mesa.solicitante_id)
)
router.include_router(
    _catalogo_router(
        "/resolutores-mesa", ResolutorMesa, creatable=True, vinculable=True, columna_uso=Mesa.resolutor_id
    )
)
router.include_router(_catalogo_router("/ventanas-mesa", VentanaMesa, creatable=True, columna_uso=Mesa.ventana_id))
