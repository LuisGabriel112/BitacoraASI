-- Cache de embeddings de descripcion (Gemini) para detectar soportes recurrentes sin recalcular en cada consulta.
alter table registros add column if not exists embedding double precision[];
