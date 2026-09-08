# language: es
Característica: Salas del brawl multijugador
  Como servidor del minijuego
  Quiero emparejar jugadores en salas de hasta dos
  Para que jueguen juntos cuando coinciden y no se queden esperando cuando no

  Escenario: El primer jugador abre una sala nueva
    Dado que no hay salas abiertas
    Cuando entra un jugador
    Entonces se crea una sala con ese jugador esperando

  Escenario: El segundo jugador cae en la sala del primero
    Dado una sala esperando con un jugador
    Cuando entra otro jugador
    Entonces los dos quedan en la misma sala

  Escenario: Una sala llena ya no recibe más jugadores
    Dado una sala con dos jugadores
    Cuando entra un tercero
    Entonces el tercero abre una sala nueva

  Escenario: Cada jugador de la sala aparece en un punto distinto
    Dado una sala con dos jugadores
    Cuando reviso sus posiciones
    Entonces no coinciden

  Escenario: Una sala en juego no acepta jugadores nuevos
    Dado una sala que ya empezó
    Cuando entra otro jugador
    Entonces abre una sala nueva en vez de meterse a la que ya empezó

  Escenario: La sala arranca sola si nadie más llega
    Dado una sala esperando con un jugador
    Cuando se agota la espera de emparejamiento
    Entonces la sala empieza con los bots

  Escenario: La sala arranca de inmediato al llenarse
    Dado una sala esperando con un jugador
    Cuando entra el segundo jugador
    Entonces la sala empieza sin agotar la espera

  Escenario: Salir de una sala quita al jugador
    Dado una sala con dos jugadores
    Cuando uno se sale
    Entonces solo queda el otro en la sala

  Escenario: Una sala sin jugadores se descarta
    Dado una sala con un solo jugador
    Cuando ese jugador se sale
    Entonces la sala ya no existe

  Escenario: El estado enviado al cliente trae el mundo completo
    Dado una sala en juego
    Cuando serializo su estado
    Entonces incluye jugadores, bots, proyectiles, muros y el tiempo restante
