-- Personaje 3D: color de piel/cuerpo y accesorio para el modelo procedural
-- (Personaje3D.svelte, Three.js) que se muestra en /personaje y /login. El
-- emoji "avatar" se queda igual — sigue siendo lo que se ve en Nav/hub/chat/
-- ranking, esto es aditivo para la ficha grande del personaje.

alter table usuarios add column if not exists color_piel text not null default '#f2c9a1';
alter table usuarios add column if not exists color_cuerpo text not null default '#3b82f6';
alter table usuarios add column if not exists accesorio text not null default 'ninguno';
