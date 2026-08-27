# language: es
Característica: Los paneles agregan en SQL, no cargando toda la semana en Python
  Como responsable de rendimiento de la bitácora
  Quiero que /registros/panel y /mesas/panel calculen sus conteos con
  GROUP BY en la base de datos en vez de traer todas las filas de la
  semana y sumarlas en un loop de Python
  Para que el panel (visitado seguido y con refresco automático) no cargue
  cada vez más filas conforme crece el histórico

  Escenario: El panel de registros agrupa por sistema, día y módulo en SQL
    Dado la semana actual con registros de varios sistemas y módulos
    Cuando pido el panel de registros
    Entonces por_sistema, volumen_diario y distribucion_modulo vienen de
    consultas agregadas, no de iterar todos los registros en Python
    Y "recientes" trae como máximo 10 registros

  Escenario: El panel de mesas agrupa por ventana y tipo de solución en SQL
    Dado la semana actual con mesas cerradas de varias ventanas
    Cuando pido el panel de mesas
    Entonces volumen_diario, distribucion_ventana y
    distribucion_categoria_solucion vienen de consultas agregadas
    Y "recientes" trae como máximo 10 mesas
