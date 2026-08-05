-- fecha_cierre_real pasa a manejar hora y minuto: las celebraciones por
-- horario (antes de jornada, después de hora de salida, última hora del
-- viernes, etc.) necesitan saber a qué hora se cerró la mesa, no solo el día.
-- Los valores existentes solo tenían fecha; quedan con hora 00:00, lo cual es
-- correcto (no deben disparar retroactivamente ninguna celebración horaria).

alter table mesas alter column fecha_cierre_real type timestamp using fecha_cierre_real::timestamp;
