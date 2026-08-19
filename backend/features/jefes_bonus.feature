# language: es
Característica: Jefes bonus al derrotar al jefe semanal
  Como equipo de soporte
  Quiero que al derrotar al jefe semanal aparezcan jefes bonus mas chicos
  Para tener un objetivo extra que dé XP de recompensa

  Escenario: El nombre del jefe bonus es determinista
    Dado la semana "SEM 32 - 2026" y el indice 0
    Cuando pido el nombre del jefe bonus dos veces
    Entonces obtengo el mismo nombre las dos veces

  Escenario: El nombre del jefe bonus sale de su propia lista
    Dado la semana "SEM 32 - 2026" y el indice 1
    Cuando pido el nombre del jefe bonus
    Entonces esta en la lista de nombres de jefe bonus

  Escenario: La vida de un jefe bonus es una fraccion de la vida del jefe principal
    Dado que el jefe principal tiene 1000 de vida maxima
    Cuando calculo la vida de un jefe bonus
    Entonces es el 25% de esa vida, redondeada

  Escenario: La vida de un jefe bonus nunca es cero
    Dado que el jefe principal tiene 2 de vida maxima
    Cuando calculo la vida de un jefe bonus
    Entonces es al menos 1

  Escenario: Se elige el primer jefe bonus que sigue con vida
    Dado una lista de jefes bonus donde el primero ya esta derrotado
    Cuando busco el siguiente jefe bonus activo
    Entonces obtengo el segundo, que sigue con vida

  Escenario: Sin jefes bonus con vida, no hay objetivo
    Dado una lista de jefes bonus todos derrotados
    Cuando busco el siguiente jefe bonus activo
    Entonces no obtengo ninguno

  Escenario: Un golpe que cruza de vida a cero cuenta como derrota
    Dado vida antes en 5 y vida despues en 0
    Cuando reviso si cruzo a derrotado
    Entonces si cruzo a derrotado

  Escenario: Un golpe sobre un jefe ya derrotado no cuenta de nuevo
    Dado vida antes en 0 y vida despues en 0
    Cuando reviso si cruzo a derrotado
    Entonces no cruzo a derrotado
