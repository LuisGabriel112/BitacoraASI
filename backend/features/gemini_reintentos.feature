# language: es
Característica: Reintentos ante fallas transitorias de Gemini
  Como usuario que extrae datos de una captura de pantalla
  Quiero que un 503 "modelo saturado" de Gemini se reintente solo
  Para no ver "no se pudo conectar" en algo que se resuelve reintentando

  Escenario: Un 503 se reintenta y la segunda vez sí responde
    Dado que Gemini responde 503 "overloaded" la primera vez
    Cuando pido que se extraiga la información
    Entonces se reintenta automáticamente
    Y si la segunda respuesta es exitosa, se devuelve el resultado

  Escenario: Un 429 se sigue reintentando igual que antes
    Dado que Gemini responde 429 por cuota excedida
    Cuando pido que se extraiga la información
    Entonces se reintenta automáticamente

  Escenario: Si el 503 persiste tras agotar los reintentos, se reporta el error
    Dado que Gemini responde 503 en todos los intentos
    Cuando pido que se extraiga la información
    Entonces se agota el número de reintentos
    Y se lanza un error indicando la respuesta 503

  Escenario: Un 400 no se reintenta, es un error del request
    Dado que Gemini responde 400 por un request inválido
    Cuando pido que se extraiga la información
    Entonces no se reintenta
    Y se lanza el error inmediatamente
