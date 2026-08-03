-- fecha_carga y fecha_estimada_resolucion pasan a manejar hora y minuto
-- (llegan de Proactivanet en formato dd/mm/yyyy hh:mm). semana depende de
-- fecha_carga como columna generada, así que hay que quitarla y recrearla.

alter table mesas drop column semana;

alter table mesas alter column fecha_carga type timestamp using fecha_carga::timestamp;
alter table mesas alter column fecha_estimada_resolucion type timestamp using fecha_estimada_resolucion::timestamp;

alter table mesas add column semana text generated always as (
  'SEM ' || lpad(extract(week from fecha_carga)::text, 2, '0')
  || ' - ' || extract(isoyear from fecha_carga)::text
) stored;

create index if not exists idx_mesas_semana on mesas(semana);
