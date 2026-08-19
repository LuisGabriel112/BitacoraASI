# language: es
Característica: Jefes derrotados quedan como mascota permanente
  Como equipo de soporte
  Quiero que cada jefe semanal que derrotamos quede guardado como mascota
  Para tener un trofeo visible de las semanas que ganamos

  Escenario: Un jefe con vida en cero es mascota
    Dado un jefe con vida_actual en 0
    Cuando se filtran los jefes derrotados
    Entonces ese jefe aparece en la lista de mascotas

  Escenario: Un jefe todavía con vida no es mascota
    Dado un jefe con vida_actual en 150
    Cuando se filtran los jefes derrotados
    Entonces ese jefe no aparece en la lista de mascotas

  Escenario: Varias semanas mezcladas, solo quedan las derrotadas
    Dado jefes de 3 semanas distintas, 2 derrotados y 1 con vida restante
    Cuando se filtran los jefes derrotados
    Entonces solo aparecen los 2 jefes derrotados
