from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.config import settings
from app.routers import auth, catalogos, chat, jefes, mesas, registros

app = FastAPI(title="Bitácora ASIPONA API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origin_list,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(catalogos.router)
app.include_router(registros.router)
app.include_router(mesas.router)
app.include_router(jefes.router)
app.include_router(chat.router)


@app.get("/health")
async def health():
    return {"status": "ok"}
