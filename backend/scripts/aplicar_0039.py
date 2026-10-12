import asyncio
from pathlib import Path
from sqlalchemy import text
from app.database import engine

async def main():
    sql = Path("../supabase/migrations/0039_sonidos_orden.sql").read_text(encoding="utf-8")
    async with engine.begin() as conn:
        for sentencia in sql.split(";"):
            if sentencia.strip():
                await conn.execute(text(sentencia))
    await engine.dispose()
    print("Migración 0039 aplicada")

asyncio.run(main())
