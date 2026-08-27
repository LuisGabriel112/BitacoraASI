# language: es
Característica: Extracción de datos de imagen vía Cloudflare Workers AI
  Como usuario que sube una captura de pantalla
  Quiero que la extracción de datos use Cloudflare Workers AI en vez de Gemini
  Para evitar los 502 recurrentes por saturación del lado de Gemini

  Escenario: Cloudflare responde con JSON válido y se devuelve tal cual
    Dado que Cloudflare Workers AI está configurado
    Y Cloudflare responde 200 con un objeto JSON ya parseado
    Cuando pido que se extraiga la información de una imagen
    Entonces se devuelve el objeto JSON de la respuesta

  Escenario: Cloudflare responde con error HTTP
    Dado que Cloudflare Workers AI está configurado
    Y Cloudflare responde 500
    Cuando pido que se extraiga la información de una imagen
    Entonces se lanza un error indicando la respuesta 500

  Escenario: Cloudflare responde success=false
    Dado que Cloudflare Workers AI está configurado
    Y Cloudflare responde 200 con success en false
    Cuando pido que se extraiga la información de una imagen
    Entonces se lanza un error indicando el detalle reportado

  Escenario: Cloudflare envuelve el JSON en prosa y un fence de markdown
    Dado que Cloudflare Workers AI está configurado
    Y Cloudflare responde 200 con texto que contiene un bloque ```json``` con el objeto
    Cuando pido que se extraiga la información de una imagen
    Entonces se recupera el objeto JSON de dentro del texto

  Escenario: Cloudflare no trae JSON la primera vez pero sí la segunda
    Dado que Cloudflare Workers AI está configurado
    Y Cloudflare responde 200 con puro texto la primera vez
    Y Cloudflare responde 200 con un objeto JSON la segunda vez
    Cuando pido que se extraiga la información de una imagen
    Entonces se reintenta automáticamente
    Y se devuelve el objeto JSON del segundo intento

  Escenario: Cloudflare nunca trae JSON, ni tras reintentar
    Dado que Cloudflare Workers AI está configurado
    Y Cloudflare responde 200 con texto plano sin ningún JSON en todos los intentos
    Cuando pido que se extraiga la información de una imagen
    Entonces se agota el número de reintentos
    Y se lanza un error de JSON inválido

  Escenario: Cloudflare Workers AI no está configurado
    Dado que Cloudflare Workers AI no tiene credenciales
    Cuando pido que se extraiga la información de una imagen
    Entonces se lanza un error indicando que falta configuración
