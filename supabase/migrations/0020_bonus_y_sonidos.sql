-- Reglas fijas de bonus de XP/daño (el admin solo ajusta porcentaje y activo).
create table if not exists bonus_reglas (
    id serial primary key,
    clave text not null unique,
    nombre text not null,
    descripcion text not null,
    porcentaje integer not null,
    activo boolean not null default true
);

insert into bonus_reglas (clave, nombre, descripcion, porcentaje, activo) values
    ('hora_cierre_tardio', 'Cierre en horario tardío',
     'Bono cuando una mesa se cierra o un soporte se registra a partir de las 5pm.', 20, true),
    ('volumen_alto_dia', 'Volumen alto en el día',
     'Bono cuando ya van 10 o más mesas cerradas + soportes registrados en el día.', 15, true)
on conflict (clave) do nothing;

-- Catálogo de sonidos usados en avisos de éxito/error: cargar, ocultar (activo)
-- y eliminar. Arranca con los que ya existían como pool fijo en el frontend.
create table if not exists sonidos (
    id serial primary key,
    categoria text not null check (categoria in ('exito', 'error')),
    nombre text not null,
    url text not null,
    activo boolean not null default true,
    created_at timestamptz not null default now(),
    unique (categoria, nombre)
);

insert into sonidos (categoria, nombre, url) values
    ('exito', 'pop-succes', '/sonidos/pop-succes.ogg'),
    ('exito', 'success-2', '/sonidos/success-2.ogg'),
    ('exito', 'success-3', '/sonidos/success-3.ogg'),
    ('exito', 'success-4', '/sonidos/success-4.ogg'),
    ('error', 'denied-ehh', '/sonidos/denied-ehh.ogg'),
    ('error', 'denied-2', '/sonidos/denied-2.ogg'),
    ('error', 'denied-3', '/sonidos/denied-3.ogg'),
    ('error', 'denied-4', '/sonidos/denied-4.ogg')
on conflict (categoria, nombre) do nothing;
