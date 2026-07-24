-- Bitácora ASIPONA — esquema inicial
-- Catálogos: crecen solo por selección de valor existente o creación explícita (FK), nunca texto libre duplicable.

create table if not exists empresas (
  id serial primary key,
  nombre text not null unique
);

create table if not exists sistemas (
  id serial primary key,
  nombre text not null unique
);

create table if not exists medios (
  id serial primary key,
  nombre text not null unique
);

create table if not exists modulos (
  id serial primary key,
  nombre text not null unique
);

create table if not exists agentes (
  id serial primary key,
  nombre text not null unique
);

create table if not exists registros (
  id bigserial primary key,
  fecha date not null,
  semana text generated always as (
    'SEM ' || lpad(extract(week from fecha)::text, 2, '0')
    || ' - ' || extract(isoyear from fecha)::text
  ) stored,
  empresa_id int not null references empresas(id),
  sistema_id int not null references sistemas(id),
  medio_id int not null references medios(id),
  modulo_id int not null references modulos(id),
  atendio_id int not null references agentes(id),
  descripcion text not null,
  trello_card_id text,
  created_at timestamptz not null default now()
);

create index if not exists idx_registros_fecha on registros(fecha);
create index if not exists idx_registros_semana on registros(semana);
create index if not exists idx_registros_empresa on registros(empresa_id);
create index if not exists idx_registros_sistema on registros(sistema_id);
create index if not exists idx_registros_modulo on registros(modulo_id);

-- Seed: valores iniciales conocidos
insert into sistemas (nombre) values ('Mediport'), ('Pis'), ('Proactivanet')
  on conflict (nombre) do nothing;

insert into medios (nombre) values ('Llamada'), ('Correo'), ('Mesa de ayuda')
  on conflict (nombre) do nothing;

insert into agentes (nombre) values ('Atzimba Torres'), ('Luis Venegas')
  on conflict (nombre) do nothing;

-- empresas y modulos arrancan vacíos: crecen desde el combobox creatable del frontend
