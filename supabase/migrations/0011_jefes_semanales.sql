-- Jefe semanal compartido: pierde vida con las mesas/soportes que el equipo va
-- cerrando (registros.py/mesas.py llaman a danar_jefe junto a otorgar_xp). Se
-- crea perezosamente (obtener_o_crear_jefe) la primera vez que alguien hace daño
-- o consulta /jefes/actual en esa semana — no hace falta ningún cron de reseteo.

create table if not exists jefes_semanales (
  id bigserial primary key,
  semana text not null unique,
  vida_max integer not null,
  vida_actual integer not null,
  created_at timestamptz not null default now()
);
