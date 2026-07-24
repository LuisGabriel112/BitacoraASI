-- Agrega "Ambos" al catálogo de agentes (para registros atendidos en conjunto)
insert into agentes (nombre) values ('Ambos')
  on conflict (nombre) do nothing;
