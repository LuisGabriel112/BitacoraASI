-- Jefes bonus: al derrotar al jefe semanal aparecen 2 jefes mas chicos
-- (25% de su vida maxima). Derrotarlos da XP extra, no alargan la semana.

create table if not exists jefes_bonus (
	id bigint generated always as identity primary key,
	jefe_id bigint not null references jefes_semanales(id),
	nombre text not null,
	vida_max integer not null,
	vida_actual integer not null,
	created_at timestamptz not null default now()
);

create index if not exists idx_jefes_bonus_jefe_id on jefes_bonus(jefe_id);
