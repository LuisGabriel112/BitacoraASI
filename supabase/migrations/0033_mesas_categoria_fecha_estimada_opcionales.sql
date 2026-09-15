-- Categoría y fecha estimada de resolución dejan de ser obligatorias al abrir
-- la mesa: solo se exigen si se cierra en el mismo momento (igual que ventana,
-- ver 0008_mesas_ventana_opcional.sql). Se siguen exigiendo al cerrar la mesa
-- (vía /editar o /cerrar), aplicado en el backend.

alter table mesas alter column categoria_id drop not null;
alter table mesas alter column fecha_estimada_resolucion drop not null;
