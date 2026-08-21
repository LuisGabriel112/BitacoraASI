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

Característica: Filtrar sugerencias de solución según el texto que se va escribiendo
  Como usuario capturando el cierre de una mesa
  Quiero que las sugerencias se acoten a lo que ya escribí en Solución
  Para encontrar más rápido una solución anterior parecida

  Escenario: El texto escrito coincide con el título de una síntesis
    Dado sugerencias con títulos "Reinicio de servicio" y "Cambio de contraseña"
    Cuando escribo "reinicio" en Solución
    Entonces solo aparece la sugerencia de título "Reinicio de servicio"

  Escenario: El texto escrito coincide con el cuerpo de una síntesis
    Dado una sugerencia con texto "Se reinició el servicio de impresión"
    Cuando escribo "impresión" en Solución
    Entonces esa sugerencia aparece

  Escenario: El texto escrito no coincide con ninguna síntesis
    Dado sugerencias con títulos "Reinicio de servicio" y "Cambio de contraseña"
    Cuando escribo "xyz" en Solución
    Entonces no aparece ninguna sugerencia

  Escenario: Todavía no se ha escrito nada en Solución
    Dado sugerencias con títulos "Reinicio de servicio" y "Cambio de contraseña"
    Cuando el campo Solución está vacío
    Entonces aparecen todas las sugerencias sin filtrar
