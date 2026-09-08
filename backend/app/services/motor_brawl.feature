# language: es
Característica: Motor de la arena del brawl, autoritativo en el servidor
  Como servidor del minijuego
  Quiero simular muros, bots y proyectiles de una ronda
  Para que todos los jugadores de la sala vean exactamente el mismo mundo

  Escenario: Un punto fuera de la arena se limita a sus bordes
    Dado un punto fuera de la arena
    Cuando lo limito
    Entonces queda dentro respetando su radio

  Escenario: Un punto encima de un muro se detecta como colisión
    Dado un punto en el centro de un muro
    Cuando reviso si toca muro
    Entonces el resultado es que sí toca

  Escenario: El punto de aparición del jugador está libre
    Dado el punto de aparición de un jugador
    Cuando reviso si toca muro
    Entonces el resultado es que no toca

  Escenario: Un muro bloquea el avance pero deja deslizarse por el eje libre
    Dado un personaje pegado a un muro por el eje X
    Cuando intenta moverse en diagonal contra el muro
    Entonces no atraviesa el muro pero sí avanza en el eje libre

  Escenario: Un bot lejos se acerca al jugador más cercano
    Dado un bot lejos del único jugador vivo
    Cuando avanzo un tick
    Entonces el bot queda más cerca del jugador

  Escenario: Un bot ya a tiro mantiene su distancia
    Dado un bot dentro de su distancia preferida
    Cuando avanzo un tick
    Entonces el bot no se acerca más

  Escenario: Un bot sin jugadores vivos no se mueve
    Dado que no queda ningún jugador vivo
    Cuando avanzo un tick
    Entonces los bots se quedan en su lugar

  Escenario: Los bots no disparan todos en el mismo tick
    Dado los bots de la ronda
    Cuando reviso un tick donde dispara el primero
    Entonces los demás no disparan en ese mismo tick

  Escenario: Un disparo de jugador baja vida al bot que toca
    Dado un proyectil de jugador encima de un bot
    Cuando avanzo un tick
    Entonces el bot pierde vida y el proyectil se consume

  Escenario: El jugador que elimina a un bot se lleva la baja
    Dado un bot con un punto de vida y un proyectil de un jugador encima
    Cuando avanzo un tick
    Entonces el bot queda eliminado y la baja se acredita a ese jugador

  Escenario: Un disparo enemigo baja vida al jugador
    Dado un proyectil de bot encima de un jugador
    Cuando avanzo un tick
    Entonces el jugador pierde vida y el proyectil se consume

  Escenario: Un jugador no puede dañar a otro jugador
    Dado un proyectil de un jugador encima de otro jugador
    Cuando avanzo un tick
    Entonces el otro jugador no pierde vida

  Escenario: Un proyectil que sale de la arena desaparece
    Dado un proyectil junto al borde apuntando hacia afuera
    Cuando avanzo un tick
    Entonces el proyectil ya no está en la ronda

  Escenario: La ronda termina cuando no queda ningún bot vivo
    Dado que todos los bots quedaron sin vida
    Cuando reviso si terminó
    Entonces el resultado es que sí

  Escenario: La ronda termina cuando no queda ningún jugador vivo
    Dado que todos los jugadores quedaron sin vida
    Cuando reviso si terminó
    Entonces el resultado es que sí

  Escenario: La ronda termina al agotarse el tiempo
    Dado que pasaron más ticks que la duración de la ronda
    Cuando reviso si terminó
    Entonces el resultado es que sí
