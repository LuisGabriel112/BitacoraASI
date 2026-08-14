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
