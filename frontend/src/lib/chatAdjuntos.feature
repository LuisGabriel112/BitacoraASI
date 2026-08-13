Característica: Adjuntar captura de pantalla al chat vía pegar o arrastrar

  Escenario: Pegar una imagen copiada al portapapeles
    Dado que el portapapeles tiene un elemento de tipo archivo con MIME "image/png"
    Cuando se extrae la imagen del portapapeles
    Entonces se obtiene el archivo de imagen

  Escenario: Pegar texto normal no produce archivo
    Dado que el portapapeles solo tiene un elemento de tipo texto
    Cuando se extrae la imagen del portapapeles
    Entonces no se obtiene ningún archivo

  Escenario: Pegar sin ningún elemento no produce archivo
    Dado que el portapapeles está vacío
    Cuando se extrae la imagen del portapapeles
    Entonces no se obtiene ningún archivo

  Escenario: Portapapeles con varios elementos, uno es imagen
    Dado que el portapapeles tiene un elemento de texto y luego uno de imagen
    Cuando se extrae la imagen del portapapeles
    Entonces se obtiene el archivo de imagen encontrado

  Escenario: Soltar un archivo sobre el chat
    Dado que se arrastra un archivo sobre la zona del chat
    Cuando se extrae el primer archivo soltado
    Entonces se obtiene ese archivo

  Escenario: Soltar sin archivos no produce nada
    Dado que se suelta un evento sin archivos
    Cuando se extrae el primer archivo soltado
    Entonces no se obtiene ningún archivo

  Escenario: Soltar varios archivos toma solo el primero
    Dado que se arrastran dos archivos sobre la zona del chat
    Cuando se extrae el primer archivo soltado
    Entonces se obtiene únicamente el primer archivo
