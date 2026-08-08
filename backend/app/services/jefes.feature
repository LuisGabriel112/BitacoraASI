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

  Escenario: El primer jefe de todos usa la vida base
    Dado que no hay ningún jefe anterior
    Cuando se calcula la vida máxima del siguiente jefe
    Entonces usa la vida base (VIDA_MAX_SEMANAL)

  Escenario: La vida sube si el equipo derrotó al jefe anterior
    Dado que el jefe anterior llegó a 0 de vida (fue derrotado)
    Cuando se calcula la vida máxima del siguiente jefe
    Entonces sube un 20% respecto a la vida máxima del anterior

  Escenario: La vida se reinicia si el equipo NO derrotó al jefe anterior
    Dado que el jefe anterior terminó la semana con vida restante
    Cuando se calcula la vida máxima del siguiente jefe
    Entonces vuelve a la vida base, sin importar qué tan alta estaba

  Escenario: La dificultad tiene un tope máximo
    Dado que la vida máxima del jefe anterior ya alcanzó el tope
    Cuando se calcula la vida máxima del siguiente jefe (con victoria)
    Entonces no sobrepasa el tope
