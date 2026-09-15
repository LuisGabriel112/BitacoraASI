-- Preferencia de sonido por usuario y por acción (guardar mesa, cerrar mesa,
-- mensaje de error). Sin fila para una acción = "aleatorio" entre los sonidos
-- activos de la categoría que le corresponde; silenciado = no suena nada.
-- El "activo" general sigue viviendo en sonidos.activo (migración 0020): un
-- sonido deshabilitado ahí no suena para nadie, aunque alguien lo tuviera
-- elegido -- en ese caso el frontend cae al aleatorio.

create table if not exists sonidos_preferencias (
    id serial primary key,
    usuario_id integer not null references usuarios(id) on delete cascade,
    evento text not null check (evento in ('guardar_mesa', 'cerrar_mesa', 'error')),
    sonido_id integer references sonidos(id) on delete set null,
    silenciado boolean not null default false,
    updated_at timestamptz not null default now(),
    unique (usuario_id, evento)
);

-- Completar el catálogo con lo que el frontend ya reproducía pero no estaba
-- en la tabla: los dos .mp4 del pool fijo y la fanfarria mariachi sintetizada
-- (Web Audio, sin archivo: el esquema "sintetizado:" lo resuelve el frontend).
insert into sonidos (categoria, nombre, url) values
    ('exito', 'success-5', '/sonidos/success-5.mp4'),
    ('error', 'denied-5', '/sonidos/denied-5.mp4'),
    ('exito', 'fanfarria-mexicana', 'sintetizado:fanfarria-mexicana')
on conflict (categoria, nombre) do nothing;
