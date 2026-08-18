# language: es
Característica: Adjuntar cualquier tipo de archivo en el chat de la bitácora
  Como usuario del chat
  Quiero poder subir cualquier tipo de archivo, no solo imágenes/pdf/office/texto
  Para compartir logs, zips u otros formatos sin que el backend lo rechace

  Escenario: Un content-type fuera de la lista anterior ya no se rechaza
    Dado que pido una URL de subida para un archivo con content-type "text/html"
    Cuando el backend genera la URL firmada
    Entonces no se lanza ningún error de tipo no permitido

  Escenario: Un content-type típico sigue funcionando igual que antes
    Dado que pido una URL de subida para un archivo con content-type "image/png"
    Cuando el backend genera la URL firmada
    Entonces obtengo la URL de subida y la URL pública
