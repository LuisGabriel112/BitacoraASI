-- Checkbox "Medidas para disminuir el impacto" en el cierre de la mesa. Alimenta
-- la última columna del reporte semanal ("Medidas realizadas para disminuir el
-- impacto"), que antes se llenaba a mano en Excel con una de estas 2 opciones.

alter table mesas add column if not exists medidas_impacto boolean not null default false;
