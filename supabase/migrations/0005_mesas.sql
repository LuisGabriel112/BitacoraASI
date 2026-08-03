-- Bitácora administrativa (mesas Proactivanet) — dominio separado de registros.

create table if not exists categorias_mesa (id serial primary key, nombre text not null unique);
create table if not exists solicitantes_mesa (id serial primary key, nombre text not null unique);
create table if not exists resolutores_mesa (id serial primary key, nombre text not null unique);
create table if not exists ventanas_mesa (id serial primary key, nombre text not null unique);

create table if not exists mesas (
  id bigserial primary key,
  enlace text,
  codigo text not null unique,
  titulo text not null,
  fecha_carga date not null,
  semana text generated always as (
    'SEM ' || lpad(extract(week from fecha_carga)::text, 2, '0')
    || ' - ' || extract(isoyear from fecha_carga)::text
  ) stored,
  descripcion text not null,
  ventana_id int not null references ventanas_mesa(id),
  categoria_id int not null references categorias_mesa(id),
  solicitante_id int not null references solicitantes_mesa(id),
  resolutor_id int not null references resolutores_mesa(id),
  fecha_estimada_resolucion date not null,
  solucion text,
  tipo_solucion text check (tipo_solucion in ('Modificación en BD', 'Seguimiento de proceso')),
  fecha_cierre_real date,
  embedding double precision[],
  created_at timestamptz not null default now()
);

create index if not exists idx_mesas_fecha_carga on mesas(fecha_carga);
create index if not exists idx_mesas_semana on mesas(semana);
create index if not exists idx_mesas_categoria on mesas(categoria_id);
create index if not exists idx_mesas_solicitante on mesas(solicitante_id);

-- los 4 catálogos arrancan vacíos: crecen desde comboboxes creatable del frontend
