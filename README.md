# Bitácora ASIPONA

App interna de bitácora de soporte operativo (terminales, aduanas, naviera, control de accesos).
Reemplaza el Excel semanal entregado al cliente portuario.

Stack: FastAPI + PostgreSQL (Supabase) + SvelteKit/Svelte 5 + Docker.

## Estructura

```
backend/          FastAPI, SQLAlchemy async, servicio Trello
frontend/          SvelteKit, Svelte 5, design tokens propios (no template genérico)
supabase/migrations/  esquema SQL (aplicar también en el proyecto Supabase de producción)
docker-compose.yml     backend + frontend + Postgres local para desarrollo
```

## Levantar con Docker (desarrollo local)

```
cp .env.example .env
# rellenar DATABASE_URL (Supabase o local), TRELLO_API_KEY, TRELLO_TOKEN, TRELLO_LIST_ID
docker compose up --build backend frontend
```

- Frontend: http://localhost:3000
- Backend: http://localhost:8000/health
- `db` (Postgres local) está detrás del profile `local-db` y NO se levanta por defecto — solo hace
  falta si `DATABASE_URL` en `.env` apunta a `localhost` en vez de Supabase:
  `docker compose --profile local-db up --build`

## Producción con Supabase

1. Crear proyecto en Supabase.
2. Aplicar `supabase/migrations/0001_init.sql` en el SQL Editor del proyecto (o vía `supabase db push` si usas su CLI).
3. En `.env` del backend, apuntar `DATABASE_URL` al connection string de Supabase (modo `asyncpg`, puerto 5432 o el pooler `6543` según corresponda).
4. Desplegar `backend/` y `frontend/` con sus Dockerfile en el hosting que uses; `frontend` necesita `BACKEND_URL` apuntando a la URL pública del backend.

## Desarrollo sin Docker

Backend:
```
cd backend
python -m venv .venv && .venv\Scripts\activate
pip install -r requirements.txt
# .env con DATABASE_URL apuntando a Postgres local o Supabase
uvicorn app.main:app --reload
```

Frontend:
```
cd frontend
npm install
npm run dev
```
El proxy de Vite (`vite.config.ts`) reenvía `/api/*` a `http://localhost:8000` en desarrollo.

## Trello

Cada registro nuevo crea una tarjeta en la lista `TRELLO_LIST_ID`. Si Trello falla, el registro
igual queda guardado en Postgres — la pantalla de Nuevo Registro ofrece reintentar la creación
de la tarjeta sin perder el registro.

## Catálogo de módulos

La tabla `modulos` arranca vacía a propósito: crece por uso real desde el combobox creatable
del formulario de Nuevo Registro (autocompletado + opción "Crear módulo"), nunca por texto libre
duplicable ni por una lista precargada inventada.
