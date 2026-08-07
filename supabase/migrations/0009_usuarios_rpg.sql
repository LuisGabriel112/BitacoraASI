-- Login por PIN + modo RPG: cada agente/resolutor real que se registra tiene una
-- identidad de login y un personaje (nivel/XP derivados de xp acumulado en Python,
-- nunca persistidos como columna separada — evita dos fuentes de verdad).
-- El vínculo con los catálogos existentes (agentes, resolutores_mesa) es por
-- nombre, no por FK: agentes es catálogo cerrado y resolutores_mesa es creatable
-- desde el combobox, así que el nombre es la única opción sin fricción para ambos.

create table if not exists usuarios (
  id bigserial primary key,
  nombre text not null,
  pin_hash text not null,
  avatar text not null default '🙂',
  xp integer not null default 0,
  intentos_fallidos integer not null default 0,
  bloqueado_hasta timestamptz,
  created_at timestamptz not null default now()
);

-- único índice de unicidad de nombre: case-insensitive, para que "Juan" y "juan"
-- no puedan registrarse como cuentas distintas.
create unique index if not exists idx_usuarios_nombre_lower on usuarios (lower(nombre));

create table if not exists xp_eventos (
  id bigserial primary key,
  usuario_id bigint references usuarios(id),
  nombre_capturado text not null,
  cantidad integer not null,
  motivo text not null,
  created_at timestamptz not null default now()
);

-- usuario_id nullable a propósito: si el nombre del combo no matchea ningún
-- usuario registrado todavía, el evento se guarda igual (auditable/backfill
-- futuro) en vez de perderse silenciosamente.
create index if not exists idx_xp_eventos_usuario on xp_eventos(usuario_id);
