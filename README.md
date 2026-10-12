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

## Sonidos

Los avisos sonoros salen del catálogo en la tabla `sonidos` (migraciones `0020`, `0034`,
`0037` y `0038`), administrable desde **Modo RPG → Sonidos**. Cada sonido tiene cinco
interruptores — **Error**, **Éxito** (guardar mesa o registro), **Compra** (tienda),
**Victoria** y **Derrota** (minijuegos) — que dicen en qué acciones puede sonar
(`sonidos.acciones`); un sonido sin ninguna marcada no suena para nadie. El catálogo es
igual para todo el equipo: no hay preferencia por usuario.

Dentro de cada acción el sorteo es proporcional al **peso** de cada sonido
(`sonidos.pesos`, un `{accion: 1..10}`): con peso 3 suena el triple de seguido que uno
con peso 1, y el mismo sonido puede pesar distinto en cada acción. Lo que nadie ajustó
pesa 1, así que por defecto todos compiten parejo. El peso se ajusta con una barra que
muestra el porcentaje moviéndose en vivo, y el catálogo se puede filtrar por acción.
Cargar un sonido nuevo abre un modal desde el botón **Cargar sonido**.

Las dos bitácoras suenan igual: guardar o editar una **mesa** (administrativa) y guardar
o editar un **registro** (operativa) usan los sonidos de Éxito; cerrar una mesa también.
Los errores de validación y de guardado de ambas usan los de Error.

`sonidos_preferencias` (migración `0034`) ya no se captura desde la app — el panel "Mis
sonidos" se quitó — pero la tabla, sus filas y sus endpoints se conservan por si el
sonido por usuario regresa.

- Los archivos nuevos se suben directo a Supabase Storage con el mismo flujo del chat,
  dentro de la carpeta `sonidos/` del bucket `CHAT_BUCKET` (no hace falta otro bucket).
  Sin `SUPABASE_URL`/`SUPABASE_SERVICE_KEY` la subida avisa que el almacenamiento no
  está configurado; el resto del catálogo funciona igual.
- Los sonidos "de fábrica" viven en `frontend/static/sonidos/`. Los de compra (caja
  registradora, monedas), victoria y derrota, igual que la fanfarria mariachi, son
  sintetizados con Web Audio (`frontend/src/lib/sonidosSintetizados.ts`) y están en el
  catálogo con URL `sintetizado:<nombre>`.
- La ruleta de casino de la Ruleta rusa y los vasos de Encuentra la pelota también son
  sintetizados, pero son ambientación del minijuego: no pasan por el catálogo.
- Si el catálogo no carga (backend caído), el frontend cae al pool fijo de
  `frontend/src/lib/notificaciones.ts` para que el aviso siga sonando.

## Catálogo de módulos

La tabla `modulos` arranca vacía a propósito: crece por uso real desde el combobox creatable
del formulario de Nuevo Registro (autocompletado + opción "Crear módulo"), nunca por texto libre
duplicable ni por una lista precargada inventada.
