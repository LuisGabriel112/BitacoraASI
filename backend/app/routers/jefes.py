from datetime import date

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_session
from app.schemas import JefeOut
from app.services.auth import get_usuario_actual
from app.services.jefes import nombre_del_jefe, obtener_o_crear_jefe
from app.services.semanas import semana_de

router = APIRouter(prefix="/jefes", tags=["jefes"], dependencies=[Depends(get_usuario_actual)])


@router.get("/actual", response_model=JefeOut)
async def jefe_actual(session: AsyncSession = Depends(get_session)):
    semana = semana_de(date.today())
    jefe = await obtener_o_crear_jefe(session, semana)
    return JefeOut(
        semana=jefe.semana,
        nombre=nombre_del_jefe(jefe.semana),
        vida_max=jefe.vida_max,
        vida_actual=jefe.vida_actual,
        derrotado=jefe.vida_actual <= 0,
    )
