Característica: Lógica de la arena del minijuego tipo Brawl Stars

  Escenario: Un punto nunca sale de los límites de la arena
    Dado un punto fuera de los límites
    Cuando lo limito a la arena
    Entonces queda dentro de los límites

  Escenario: Mover un punto lo desplaza en la dirección dada
    Dado un punto en el origen
    Cuando lo muevo con dirección (1, 0) y velocidad 4
    Entonces su x aumenta en 4 y su y no cambia

  Escenario: Un bot se mueve hacia el jugador
    Dado un bot y un jugador en posiciones distintas
    Cuando el bot se mueve hacia el jugador
    Entonces la distancia entre bot y jugador disminuye

  Escenario: Se crean bots iniciales vivos en posiciones distintas
    Dado que pido 3 bots iniciales
    Cuando los creo
    Entonces obtengo 3 bots vivos en posiciones distintas

  Escenario: Disparar elimina al bot vivo más cercano dentro de alcance
    Dado un jugador y dos bots vivos, uno más cerca que el otro
    Cuando disparo con alcance suficiente
    Entonces solo el bot más cercano queda eliminado

  Escenario: Disparar sin nada en alcance no elimina a nadie
    Dado un jugador y un bot vivo fuera de alcance
    Cuando disparo
    Entonces el bot sigue vivo

  Escenario: El jugador es golpeado si un bot vivo lo toca
    Dado un bot vivo a poca distancia del jugador
    Cuando reviso si el jugador fue golpeado
    Entonces el resultado es que sí fue golpeado

  Escenario: Contar enemigos eliminados
    Dado una lista de bots donde 2 de 3 están eliminados
    Cuando cuento los eliminados
    Entonces obtengo 2
