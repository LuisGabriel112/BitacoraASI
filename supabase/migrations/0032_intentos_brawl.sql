-- Minijuego tipo Brawl Stars: arena en tiempo real resuelta en el cliente
-- (movimiento y disparo), el cliente reporta cuantos bots elimino y el
-- servidor valida el rango plausible (0-3) antes de dar por bueno el intento
-- y bajarle vida al jefe, igual que reaccion.py valida el tiempo reportado.
create table if not exists intentos_brawl (
    id serial primary key,
    usuario_id integer not null references usuarios(id),
    enemigos_eliminados integer,
    resuelto boolean not null default false,
    acierto boolean,
    created_at timestamptz not null default now()
);

create index if not exists idx_intentos_brawl_usuario on intentos_brawl(usuario_id, created_at desc);
