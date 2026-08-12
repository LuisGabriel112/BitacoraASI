-- Historial de cada accion que le bajo vida al jefe semanal (mesa creada,
-- mesa cerrada, soporte creado), para mostrarlo en /jefe.

create table if not exists danio_jefe_eventos (
    id serial primary key,
    jefe_id integer not null references jefes_semanales(id),
    nombre_capturado text not null,
    cantidad integer not null,
    motivo text not null,
    created_at timestamptz not null default now()
);

create index if not exists idx_danio_jefe_eventos_jefe on danio_jefe_eventos(jefe_id, created_at desc);
