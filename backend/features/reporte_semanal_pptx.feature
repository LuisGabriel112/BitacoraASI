# language: es
Característica: Estilo y orden del reporte semanal en PowerPoint
  Como responsable de soporte administrativo
  Quiero un PPTX con portada de marca, gráficas visibles antes que las tablas
  y tablas legibles (título, encabezados compactos, filas con color y borde)
  Para compartir el resumen semanal sin tener que arreglarlo a mano

  Escenario: La portada usa la imagen de logo, no formas dibujadas
    Dado que genero el PPTX del reporte
    Cuando reviso la primera diapositiva (portada)
    Entonces contiene una imagen (el logo), no un rectángulo con texto simulando un logo

  Escenario: Las gráficas van en la segunda diapositiva, antes que las tablas
    Dado un reporte con datos de gráficas y al menos un bloque de incidencias
    Cuando genero el PPTX
    Entonces la diapositiva 2 contiene las gráficas
    Y las diapositivas de tabla de incidencias empiezan después, en la diapositiva 3

  Escenario: Sin datos de gráficas no se agrega esa diapositiva
    Dado un reporte cuyas gráficas están todas vacías
    Cuando genero el PPTX
    Entonces la diapositiva 2 ya es una tabla de incidencias, no una diapositiva de gráficas

  Escenario: Las gráficas tienen título de eje y etiquetas de dato
    Dado una gráfica con datos
    Cuando la agrego a la diapositiva
    Entonces el eje de valores tiene título "Cantidad"
    Y las barras muestran su valor como etiqueta de dato

  Escenario: La tabla de incidencias tiene una fila de título fusionada
    Dado un bloque de incidencias
    Cuando construyo la diapositiva de tabla
    Entonces la primera fila es un título fusionado a lo largo de las 4 columnas
    Y la segunda fila son los encabezados de columna

  Escenario: Las filas de datos alternan color para dar contraste
    Dado un bloque con al menos 2 incidencias
    Cuando construyo la diapositiva de tabla
    Entonces la primera fila de datos y la segunda tienen colores de fondo distintos

  Escenario: Las celdas tienen borde visible
    Dado cualquier celda de la tabla
    Cuando se escribe su contenido
    Entonces tiene los 4 bordes (izquierdo, derecho, superior, inferior) con color definido

  Escenario: La gráfica "Por ventana" es más grande que "Por categoría de solución"
    Dado las dos gráficas del reporte
    Cuando las agrego a la diapositiva
    Entonces "Por ventana" ocupa más ancho que "Por categoría de solución"

  Escenario: Las gráficas del PPTX son azules
    Dado una gráfica con datos
    Cuando la agrego a la diapositiva
    Entonces el color de las barras es azul, no naranja

  Escenario: Filas con soluciones cortas caben más por diapositiva
    Dado varias incidencias con soluciones cortas de una sola línea
    Cuando pagino las filas para las diapositivas de tabla
    Entonces todas caben en una sola diapositiva

  Escenario: Filas con soluciones largas caben menos por diapositiva
    Dado varias incidencias con soluciones largas de varias líneas
    Cuando pagino las filas para las diapositivas de tabla
    Entonces se reparten en más de una diapositiva

  Escenario: Una fila nunca se queda sin diapositiva aunque su solución sea enorme
    Dado una incidencia con una solución excepcionalmente larga
    Cuando pagino las filas
    Entonces esa fila ocupa su propia diapositiva, no se descarta

  Escenario: La altura de cada fila se ajusta a su contenido
    Dado una solución de una sola línea y otra de varias líneas
    Cuando calculo la altura de cada fila
    Entonces la fila con más líneas es más alta que la de una sola línea

  Escenario: El rango de fechas se muestra con nombre de mes en español
    Dado la semana "SEM 29 - 2026" (13 al 17 de julio de 2026)
    Cuando pido el texto del rango
    Entonces obtengo "13 Julio - 17 Julio 2026"

  Escenario: Cada diapositiva de tabla lleva el encabezado "Resumen de actividades"
    Dado un reporte con varios bloques de incidencias
    Cuando genero el PPTX
    Entonces cada diapositiva de tabla incluye el texto "Resumen de actividades (13 Julio - 17 Julio 2026)"

  Escenario: La diapositiva de gráficas también lleva el encabezado
    Dado un reporte con datos de gráficas
    Cuando genero el PPTX
    Entonces la diapositiva de gráficas incluye el texto "Resumen de actividades (13 Julio - 17 Julio 2026)"

  Escenario: Las gráficas usan el título largo descriptivo con el rango de fechas
    Dado las dos gráficas del reporte
    Cuando genero el PPTX
    Entonces el título de "Por categoría de solución" incluye
      "Categorías de solución de incidencias resueltas por la mesa de ayuda (13 Julio - 17 Julio 2026)"
    Y el título de "Por ventana" incluye
      "Ventana/Característica de incidencias resueltas por la mesa de ayuda (13 Julio - 17 Julio 2026)"

  Escenario: La paginación quedó más conservadora para no desbordar al imprimir
    Dado un bloque de filas que antes cabía justo en una diapositiva
    Cuando pagino las filas con la nueva tolerancia
    Entonces cabe menos contenido por diapositiva que antes, con más margen de sobra
