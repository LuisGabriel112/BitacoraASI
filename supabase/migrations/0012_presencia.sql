-- Hub de "quién está en línea": el frontend manda un heartbeat periódico
-- (POST /auth/heartbeat) mientras la app está abierta; "en línea" = última
-- actividad dentro de un umbral corto (ver esta_en_linea en auth.py).

alter table usuarios add column if not exists ultima_actividad timestamptz;
