from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.config import settings
from app.routers import catalogos, registros

app = FastAPI(title="Bitácora ASIPONA API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origin_list,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(catalogos.router)
app.include_router(registros.router)


@app.get("/health")
async def health():
    return {"status": "ok"}
