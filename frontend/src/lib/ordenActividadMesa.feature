Característica: Ordenar mesas recientes por su última actividad

  Escenario: Una mesa recién cerrada sube por encima de una abierta más nueva
    Dado una mesa abierta cargada hoy y una mesa cerrada hace unos minutos
    Cuando ordeno por actividad reciente
    Entonces la mesa recién cerrada aparece primero

  Escenario: Entre dos mesas cerradas, la más reciente en cerrarse va primero
    Dado dos mesas cerradas en momentos distintos
    Cuando ordeno por actividad reciente
    Entonces la que se cerró más tarde aparece primero

  Escenario: Una mesa sin cerrar usa su fecha de carga como referencia
    Dado una mesa sin fecha de cierre real
    Cuando ordeno por actividad reciente junto con otras
    Entonces se ordena usando su fecha de carga

  Escenario: No modifica el arreglo original
    Dado una lista de mesas en un orden dado
    Cuando ordeno por actividad reciente
    Entonces la lista original conserva su orden original
