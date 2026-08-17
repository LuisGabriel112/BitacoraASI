-- Piedra, papel o tijera: mismo esquema de cola que partidas_gato (la fila
-- 'esperando' actua como la cola), pero sin turnos: cada jugador manda su
-- jugada una vez y se resuelve cuando ambas estan puestas.
create table if not exists partidas_rps (
    id serial primary key,
    jugador_x_id integer not null references usuarios(id),
    jugador_o_id integer references usuarios(id),
    jugada_x text,
    jugada_o text,
    estado text not null default 'esperando' check (estado in ('esperando', 'jugando', 'terminada')),
    resultado text,
    created_at timestamptz not null default now(),
    actualizado_en timestamptz not null default now()
);

create index if not exists idx_partidas_rps_esperando on partidas_rps(created_at) where estado = 'esperando';

-- Trivia: pregunta_id apunta al banco de preguntas hardcoded en trivia.py (no hay
-- tabla de preguntas, son fijas en codigo). La respuesta correcta nunca se manda
-- al cliente hasta resolver el intento.
create table if not exists intentos_trivia (
    id serial primary key,
    usuario_id integer not null references usuarios(id),
    pregunta_id integer not null,
    resuelto boolean not null default false,
    acierto boolean,
    created_at timestamptz not null default now()
);

create index if not exists idx_intentos_trivia_usuario on intentos_trivia(usuario_id, created_at desc);

-- Memorama: no hay nada que ocultar (no hay "respuesta correcta"), asi que el
-- anti-trampa es que el servidor mide el tiempo real entre iniciar y completar
-- en vez de confiar en un tiempo reportado por el cliente.
create table if not exists intentos_memorama (
    id serial primary key,
    usuario_id integer not null references usuarios(id),
    resuelto boolean not null default false,
    acierto boolean,
    created_at timestamptz not null default now()
);

create index if not exists idx_intentos_memorama_usuario on intentos_memorama(usuario_id, created_at desc);

-- Reaccion rapida: el tiempo lo reporta el cliente, el servidor solo valida que
-- caiga en un rango humano plausible (120ms-3s) antes de dar por bueno el intento.
create table if not exists intentos_reaccion (
    id serial primary key,
    usuario_id integer not null references usuarios(id),
    tiempo_ms integer,
    resuelto boolean not null default false,
    acierto boolean,
    created_at timestamptz not null default now()
);

create index if not exists idx_intentos_reaccion_usuario on intentos_reaccion(usuario_id, created_at desc);

-- Ruleta rusa: se resuelve en una sola llamada (no hay nada que ocultar entre
-- pasos, el azar se decide y aplica de inmediato).
create table if not exists intentos_ruleta (
    id serial primary key,
    usuario_id integer not null references usuarios(id),
    gano boolean not null,
    created_at timestamptz not null default now()
);

create index if not exists idx_intentos_ruleta_usuario on intentos_ruleta(usuario_id, created_at desc);
