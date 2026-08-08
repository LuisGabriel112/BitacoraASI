-- Chat interno del equipo: texto y/o archivo (subido directo a Supabase Storage
-- desde el navegador, ver app/services/storage.py — esta tabla solo guarda la
-- referencia, nunca los bytes).

create table if not exists mensajes_chat (
  id bigserial primary key,
  usuario_id bigint not null references usuarios(id),
  texto text,
  archivo_url text,
  archivo_nombre text,
  archivo_tipo text,
  created_at timestamptz not null default now()
);

create index if not exists idx_mensajes_chat_created_at on mensajes_chat(created_at);
