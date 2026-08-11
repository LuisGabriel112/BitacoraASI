-- Guias sintetizadas (por IA) que agrupan soluciones repetidas de mesas,
-- una por combinacion categoria + tipo de solucion. Se regeneran a demanda
-- desde el Manual (POST /mesas/sintesis/generar), no en cada carga de pagina.

create table if not exists sintesis_soluciones (
    id serial primary key,
    categoria_id integer not null references categorias_mesa(id),
    tipo_solucion text,
    titulo text not null,
    texto text not null,
    cantidad_mesas integer not null,
    generado_en timestamptz not null default now(),
    unique (categoria_id, tipo_solucion)
);
