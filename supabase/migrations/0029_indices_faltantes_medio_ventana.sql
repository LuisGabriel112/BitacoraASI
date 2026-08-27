-- registros.medio_id (filtrado en /registros) y mesas.ventana_id (filtrado en
-- /mesas) no tenian indice -- mismo patron que 0024_indices_faltantes.sql.
-- usuarios.ultima_actividad ahora se filtra en /auth/en-linea (polling cada
-- 10s desde /hub), tampoco tenia indice.

create index if not exists idx_registros_medio_id on registros(medio_id);
create index if not exists idx_mesas_ventana_id on mesas(ventana_id);
create index if not exists idx_usuarios_ultima_actividad on usuarios(ultima_actividad);
