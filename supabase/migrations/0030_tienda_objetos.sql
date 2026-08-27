-- Tienda de objetos estilo LoL: objetos equipados y ledger de creditos, ambos
-- delimitados por semana (mismo patron que jefes_semanales) -- una semana
-- nueva simplemente no tiene filas todavia, sin necesidad de un job de reset.
-- El catalogo de objetos vive hardcodeado en app/services/tienda.py, no en
-- una tabla (mismo patron que las preguntas de trivia o los nombres de jefe).

create table if not exists inventario_items (
	id bigint generated always as identity primary key,
	usuario_id bigint not null references usuarios(id),
	item_id text not null,
	semana text not null,
	created_at timestamptz not null default now()
);

create index if not exists idx_inventario_items_usuario_semana on inventario_items(usuario_id, semana);

create table if not exists credito_eventos (
	id bigint generated always as identity primary key,
	usuario_id bigint not null references usuarios(id),
	semana text not null,
	cantidad integer not null,
	motivo text not null,
	created_at timestamptz not null default now()
);

create index if not exists idx_credito_eventos_usuario_semana on credito_eventos(usuario_id, semana);
