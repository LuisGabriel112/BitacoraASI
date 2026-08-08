Característica: Subida de archivos del chat a Supabase Storage
  Como usuario del chat interno
  Quiero adjuntar archivos sin que pasen por el backend/proxy
  Para no chocar con el límite de payload de las funciones serverless

  Escenario: Un tipo de archivo permitido genera una URL de subida
    Dado un nombre de archivo y un content-type permitido (ej. imagen)
    Cuando se pide crear la URL de subida
    Entonces se genera una URL de subida firmada y una URL pública final

  Escenario: Un tipo de archivo no permitido se rechaza antes de llamar a Supabase
    Dado un content-type no permitido (ej. "text/html")
    Cuando se pide crear la URL de subida
    Entonces se rechaza sin hacer ninguna llamada de red

  Escenario: La key interna del archivo nunca usa el nombre original
    Dado un nombre de archivo con espacios y acentos
    Cuando se genera la key de almacenamiento
    Entonces la key es un identificador único que conserva solo la extensión

  Escenario: Dos archivos con el mismo nombre nunca colisionan
    Dado que dos usuarios suben un archivo con el mismo nombre
    Cuando se genera la key de cada uno
    Entonces las keys son distintas
