Característica: Jefe semanal compartido
  Como equipo de soporte y mesas
  Quiero un jefe semanal cuya vida baje con nuestras acciones
  Para tener un objetivo compartido entre ambas bitácoras

  Escenario: El nombre del jefe es consistente dentro de la misma semana
    Dado la semana "SEM 32 - 2026"
    Cuando se pide el nombre del jefe dos veces
    Entonces el nombre es el mismo las dos veces

  Escenario: El nombre del jefe puede variar entre semanas distintas
    Dado dos semanas distintas
    Cuando se pide el nombre del jefe de cada una
    Entonces no hay garantía de que sean iguales, pero ambos son nombres válidos de la lista

  Escenario: Dañar al jefe nunca debe tumbar la acción principal
    Dado que la base de datos falla al intentar dañar al jefe
    Cuando se intenta dañar al jefe
    Entonces la función no lanza ninguna excepción

  Escenario: Las constantes de daño están desacopladas de las de XP
    Dado las constantes de daño del jefe
    Cuando se comparan con las constantes de XP
    Entonces son valores propios, no una referencia a las mismas constantes de XP
