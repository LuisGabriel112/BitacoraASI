-- fecha_cierre_real y created_at se filtran/ordenan en cada guardado (bono,
-- logros de "primera del dia/semana") y en el listado principal de mesas, pero
-- no tenian indice -- EXPLAIN confirmo Seq Scan (hasta 99ms) en mesas con
-- 2376 filas. Van a empeorar conforme crezca la tabla si no se corrige ahora.

create index if not exists idx_mesas_fecha_cierre_real on mesas(fecha_cierre_real);
create index if not exists idx_mesas_resolutor_cierre on mesas(resolutor_id, fecha_cierre_real);

create index if not exists idx_registros_created_at on registros(created_at);
create index if not exists idx_registros_atendio_created on registros(atendio_id, created_at);
