Característica: Sugerir soluciones frecuentes al capturar el cierre de una mesa

  Escenario: Hay síntesis para la categoría seleccionada
    Dado una lista de síntesis con categorías 5, 8 y 5
    Cuando pido las sugerencias para la categoría 5
    Entonces obtengo las síntesis de esa categoría, en el mismo orden

  Escenario: No hay síntesis para la categoría seleccionada
    Dado una lista de síntesis con categorías 5 y 8
    Cuando pido las sugerencias para la categoría 99
    Entonces no obtengo ninguna sugerencia

  Escenario: Todavía no se ha elegido categoría
    Dado una lista de síntesis con categorías 5 y 8
    Cuando pido las sugerencias sin categoría seleccionada
    Entonces no obtengo ninguna sugerencia

  Escenario: No hay síntesis generada
    Dado una lista de síntesis vacía
    Cuando pido las sugerencias para la categoría 5
    Entonces no obtengo ninguna sugerencia
