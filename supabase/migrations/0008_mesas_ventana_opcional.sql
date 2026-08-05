-- Ventana deja de capturarse al abrir la mesa: se determina con criterio propio
-- al momento de resolverla (junto con solución/categoría de solución/fecha de
-- cierre), no siempre se sabe de entrada. La columna pasa a opcional; las 35
-- mesas ya cerradas conservan su ventana existente sin cambios.

alter table mesas alter column ventana_id drop not null;
