# language: es
Característica: Extracción de datos de imagen vía OpenRouter
  Como usuario que sube una captura de pantalla
  Quiero que la extracción de datos use OpenRouter (minimax-m3:free) en vez de Cloudflare
  Para obtener una lectura más precisa de la imagen

  Escenario: OpenRouter responde con JSON válido y se devuelve tal cual
    Dado que OpenRouter está configurado
    Y OpenRouter responde 200 con un mensaje cuyo contenido es un objeto JSON
    Cuando pido que se extraiga la información de una imagen
    Entonces se devuelve el objeto JSON del contenido

  Escenario: OpenRouter responde con error HTTP duro
    Dado que OpenRouter está configurado
    Y OpenRouter responde 400 por un request inválido
    Cuando pido que se extraiga la información de una imagen
    Entonces se lanza un error indicando la respuesta 400 de inmediato, sin reintentar

  Escenario: OpenRouter está saturado (429) y luego responde bien
    Dado que OpenRouter está configurado
    Y OpenRouter responde 429 por límite de la capa gratuita la primera vez
    Y OpenRouter responde 200 con un objeto JSON la segunda vez
    Cuando pido que se extraiga la información de una imagen
    Entonces se reintenta automáticamente
    Y se devuelve el objeto JSON del segundo intento

  Escenario: OpenRouter envuelve el JSON en prosa o markdown
    Dado que OpenRouter está configurado
    Y OpenRouter responde 200 con texto que contiene un bloque ```json``` con el objeto
    Cuando pido que se extraiga la información de una imagen
    Entonces se recupera el objeto JSON de dentro del texto

  Escenario: OpenRouter nunca trae JSON, ni tras reintentar
    Dado que OpenRouter está configurado
    Y OpenRouter responde 200 con puro texto sin JSON en todos los intentos
    Cuando pido que se extraiga la información de una imagen
    Entonces se agota el número de reintentos
    Y se lanza un error de JSON inválido

  Escenario: OpenRouter no está configurado
    Dado que OpenRouter no tiene API key
    Cuando pido que se extraiga la información de una imagen
    Entonces se lanza un error indicando que falta configuración
