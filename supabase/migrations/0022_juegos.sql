-- Gato (tic-tac-toe) entre 2 usuarios en linea: fila con jugador_o_id nulo y
-- estado 'esperando' actua como la propia cola de emparejamiento (el siguiente
-- que busca partida se une a la mas antigua disponible, sin tabla de cola aparte).
create table if not exists partidas_gato (
    id serial primary key,
    jugador_x_id integer not null references usuarios(id),
    jugador_o_id integer references usuarios(id),
    tablero text not null default '         ',
    turno text not null default 'X',
    estado text not null default 'esperando' check (estado in ('esperando', 'jugando', 'terminada')),
    ganador text,
    created_at timestamptz not null default now(),
    actualizado_en timestamptz not null default now()
);

create index if not exists idx_partidas_gato_esperando on partidas_gato(created_at) where estado = 'esperando';

-- "Encuentra la pelota": posicion_correcta se guarda al iniciar el intento (antes
-- de que el usuario elija), para que el servidor sea el unico que sabe donde esta
-- la pelota y no se pueda hacer trampa mandando el resultado desde el cliente.
create table if not exists intentos_pelota (
    id serial primary key,
    usuario_id integer not null references usuarios(id),
    posicion_correcta integer not null,
    resuelto boolean not null default false,
    acierto boolean,
    created_at timestamptz not null default now()
);

create index if not exists idx_intentos_pelota_usuario on intentos_pelota(usuario_id, created_at desc);
