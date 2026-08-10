-- Marcar mesas como prioritarias (se muestran en el Panel de mesas mientras
-- estén abiertas) o destacadas (bookmark para consultar después, sin fecha
-- de vencimiento). Son independientes entre sí — una mesa puede ser ambas,
-- ninguna, o solo una.

alter table mesas add column if not exists prioridad boolean not null default false;
alter table mesas add column if not exists destacada boolean not null default false;

create index if not exists idx_mesas_prioridad on mesas(prioridad) where prioridad;
create index if not exists idx_mesas_destacada on mesas(destacada) where destacada;
