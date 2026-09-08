Característica: Cliente de red del brawl

  Escenario: En desarrollo el WebSocket va por el proxy del mismo origen
    Dado que no hay URL de backend configurada
    Cuando armo la URL del WebSocket
    Entonces apunta al mismo origen bajo /api

  Escenario: En producción va directo al backend
    Dado que hay una URL pública de backend configurada
    Cuando armo la URL del WebSocket
    Entonces apunta a ese backend, no al origen del frontend

  Escenario: Un origen seguro usa WebSocket seguro
    Dado un origen https
    Cuando armo la URL del WebSocket
    Entonces el esquema es wss

  Escenario: Un origen sin cifrar usa WebSocket sin cifrar
    Dado un origen http
    Cuando armo la URL del WebSocket
    Entonces el esquema es ws

  Escenario: El ticket viaja en la URL
    Dado un ticket
    Cuando armo la URL del WebSocket
    Entonces el ticket queda en la query string

  Escenario: Interpolar dos estados intermedios da la posición de en medio
    Dado un estado previo y uno nuevo del mismo bot
    Cuando interpolo a la mitad
    Entonces obtengo el punto intermedio

  Escenario: Interpolar sin estado previo devuelve la posición nueva
    Dado que no hay estado previo de esa entidad
    Cuando interpolo
    Entonces obtengo la posición nueva tal cual

  Escenario: La interpolación se limita al rango del tramo
    Dado un avance mayor a uno
    Cuando interpolo
    Entonces no me paso de la posición nueva

  Escenario: Separar mi jugador del resto
    Dado el estado con dos jugadores
    Cuando pido el mío y los demás
    Entonces obtengo mi jugador aparte de los otros
