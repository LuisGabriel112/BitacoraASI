-- Agrega "Abraham" al catálogo de agentes
insert into agentes (nombre) values ('Abraham')
  on conflict (nombre) do nothing;
