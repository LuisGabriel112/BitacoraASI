-- Probabilidad por sonido Y por acción: el mismo sonido puede sonar seguido en
-- Éxito y casi nunca en Victoria. `pesos` guarda {accion: peso} solo para las
-- acciones con peso distinto del normal; una acción marcada en `acciones` que
-- no aparezca aquí vale 1. El sorteo reparte proporcionalmente entre los
-- sonidos de esa acción, así que el porcentaje sale de comparar pesos.
--
-- Es aditiva a propósito: el backend viejo ignora la columna y sigue
-- funcionando, para que esta migración se pueda correr antes de desplegar sin
-- dejar la app rota en medio (lo que sí pasó con la 0037).

alter table sonidos add column if not exists pesos jsonb not null default '{}'::jsonb;

-- Las claves tienen que ser acciones conocidas: restarle las válidas al objeto
-- debe dejarlo vacío. (Postgres no admite subconsultas en un CHECK, así que el
-- rango de cada peso -- entero de 1 a 100 -- lo valida el backend, que es el
-- único que escribe aquí.)
alter table sonidos drop constraint if exists sonidos_pesos_validos;
alter table sonidos add constraint sonidos_pesos_validos check (
    jsonb_typeof(pesos) = 'object'
    and pesos - array['error', 'exito', 'compra', 'victoria', 'derrota'] = '{}'::jsonb
);

-- La bitácora operativa (registros) empieza a sonar como la administrativa, así
-- que sus acciones también son eventos válidos. Las preferencias por usuario ya
-- no se capturan desde la app, pero la tabla y sus filas se conservan.
alter table sonidos_preferencias drop constraint if exists sonidos_preferencias_evento_check;
alter table sonidos_preferencias add constraint sonidos_preferencias_evento_check
    check (evento in (
        'guardar_mesa', 'cerrar_mesa', 'error', 'compra', 'victoria', 'derrota',
        'guardar_registro'
    ));
