# language: es
Característica: Columna de medidas para disminuir el impacto en el reporte semanal
  Como responsable de soporte administrativo
  Quiero que la última columna se llame "Medidas realizadas para disminuir el impacto"
  y que en Excel sea una lista desplegable con las 2 opciones reales que usamos
  Para no tener que escribir el mismo texto largo a mano cada semana

  Escenario: La columna ya no se llama "Observaciones"
    Dado los encabezados del reporte
    Cuando reviso la última columna
    Entonces se llama "Medidas realizadas para disminuir el impacto"

  Escenario: En Excel, esa columna es una lista desplegable
    Dado que genero el XLSX del reporte con al menos una incidencia
    Cuando reviso la validación de datos de la hoja
    Entonces la columna de medidas tiene una lista desplegable
    Y las opciones son exactamente "Ninguna." y el texto largo de seguimiento de validación

  Escenario: La lista desplegable cubre todas las filas de datos, no solo la primera
    Dado que genero el XLSX del reporte con varias incidencias
    Cuando reviso el rango de celdas de la validación
    Entonces cubre desde la primera hasta la última fila de datos

  Escenario: Sin incidencias no se agrega ninguna validación
    Dado que genero el XLSX del reporte sin incidencias
    Cuando reviso la validación de datos de la hoja
    Entonces no hay ninguna lista desplegable agregada

  Escenario: Mesa sin el checkbox "Medidas para disminuir el impacto" marcado
    Dado que una mesa cerrada no tiene marcado "Medidas para disminuir el impacto"
    Cuando se arma su fila para el reporte
    Entonces el valor de la columna de medidas es "Ninguna."

  Escenario: Mesa con el checkbox "Medidas para disminuir el impacto" marcado
    Dado que una mesa cerrada tiene marcado "Medidas para disminuir el impacto"
    Cuando se arma su fila para el reporte
    Entonces el valor de la columna de medidas es el texto largo de seguimiento de validación

  Escenario: El valor ya viene escrito en la celda del XLSX, no solo como opción de la lista
    Dado que genero el XLSX del reporte con una mesa marcada y otra sin marcar
    Cuando reviso el contenido de la columna de medidas
    Entonces cada fila muestra el texto correspondiente a su checkbox

  Escenario: La columna de medidas usa una fuente más chica que el resto
    Dado que genero el XLSX del reporte con al menos una incidencia
    Cuando reviso la fuente de la columna de medidas
    Entonces su tamaño es 9, mientras el resto de columnas usa tamaño 10
