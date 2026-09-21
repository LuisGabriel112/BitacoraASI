-- Tiempo de atención del soporte (llamada o mesa) en minutos.
-- Nullable: los registros históricos no tienen este dato capturado.
alter table registros
  add column if not exists minutos_atencion integer
  check (minutos_atencion is null or (minutos_atencion between 1 and 1440));
