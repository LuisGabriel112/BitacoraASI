-- Permite vincular explícitamente un agente/resolutor a una cuenta (usuario),
-- para cuando el nombre del catálogo no coincide con el nombre de login
-- (apodos, nombres cortos, etc.) — otorgar_xp usa este vínculo si existe,
-- y solo si no existe cae de vuelta al match por nombre (comportamiento actual).

alter table agentes add column if not exists usuario_id bigint references usuarios(id);
alter table resolutores_mesa add column if not exists usuario_id bigint references usuarios(id);
