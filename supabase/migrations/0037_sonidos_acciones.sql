-- Un sonido ya no es "de éxito" o "de error": puede sonar en varias acciones
-- (error, éxito, compra en la tienda, victoria y derrota en los minijuegos),
-- cada una con su propio interruptor en el catálogo. `acciones` reemplaza a
-- `categoria` + `activo`: un sonido sin acciones marcadas no suena para nadie
-- (lo que antes era "deshabilitado").

alter table sonidos add column if not exists acciones text[] not null default '{}';

-- Pasar lo que ya estaba al modelo nuevo. Va en un bloque condicional para que
-- volver a correr la migración no truene: la segunda vez `categoria` ya no existe.
do $$
begin
    if exists (
        select 1 from information_schema.columns
         where table_name = 'sonidos' and column_name = 'categoria'
    ) then
        -- La categoría anterior, solo si el sonido estaba habilitado.
        update sonidos set acciones = array[categoria] where activo and acciones = '{}';

        -- El nombre pasa a ser único en todo el catálogo (antes lo era por categoría):
        -- si alguien subió el mismo nombre en éxito y en error, se distinguen con un sufijo.
        update sonidos s
           set nombre = s.nombre || ' (' || s.categoria || ')'
         where exists (select 1 from sonidos o where o.id <> s.id and lower(o.nombre) = lower(s.nombre));

        alter table sonidos drop constraint if exists sonidos_categoria_nombre_key;
        alter table sonidos drop column categoria;
        alter table sonidos drop column activo;
    end if;
end $$;

alter table sonidos drop constraint if exists sonidos_acciones_validas;
alter table sonidos add constraint sonidos_acciones_validas
    check (acciones <@ array['error', 'exito', 'compra', 'victoria', 'derrota']::text[]);

alter table sonidos drop constraint if exists sonidos_nombre_key;
alter table sonidos add constraint sonidos_nombre_key unique (nombre);

-- Las preferencias por usuario admiten las acciones nuevas como eventos.
alter table sonidos_preferencias drop constraint if exists sonidos_preferencias_evento_check;
alter table sonidos_preferencias add constraint sonidos_preferencias_evento_check
    check (evento in ('guardar_mesa', 'cerrar_mesa', 'error', 'compra', 'victoria', 'derrota'));

-- Sonidos de fábrica para las acciones nuevas, sintetizados con Web Audio en el
-- frontend (esquema "sintetizado:", igual que la fanfarria mariachi).
insert into sonidos (nombre, url, acciones) values
    ('victoria', 'sintetizado:victoria', '{victoria}'),
    ('derrota', 'sintetizado:derrota', '{derrota}'),
    ('caja-registradora', 'sintetizado:caja-registradora', '{compra}'),
    ('monedas', 'sintetizado:monedas', '{compra}')
on conflict (nombre) do nothing;

-- La fanfarria mariachi sonaba al ganar la Arena 3D; sigue siendo opción de victoria.
update sonidos
   set acciones = acciones || '{victoria}'
 where url = 'sintetizado:fanfarria-mexicana' and not ('victoria' = any(acciones));
