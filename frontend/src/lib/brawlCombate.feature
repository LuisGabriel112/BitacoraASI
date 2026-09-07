Característica: Combate del minijuego tipo Brawl Stars (proyectiles y vida)

  Escenario: Los bots iniciales nacen vivos y separados
    Dado que pido 3 bots
    Cuando los creo
    Entonces los 3 tienen vida completa y posiciones distintas

  Escenario: Un proyectil sale con dirección normalizada hacia el objetivo
    Dado un origen y un objetivo a la derecha
    Cuando creo un proyectil hacia el objetivo
    Entonces su dirección apunta a la derecha con magnitud 1

  Escenario: Los proyectiles avanzan en su dirección
    Dado un proyectil que apunta a la derecha
    Cuando avanzo los proyectiles
    Entonces su x aumenta

  Escenario: Un proyectil que sale de la arena desaparece
    Dado un proyectil junto al borde apuntando hacia afuera
    Cuando avanzo los proyectiles
    Entonces ese proyectil ya no está en la lista

  Escenario: Un proyectil que pega en un muro desaparece
    Dado un proyectil que va a entrar a un muro
    Cuando avanzo los proyectiles
    Entonces ese proyectil ya no está en la lista

  Escenario: Un disparo aliado baja vida al bot que toca
    Dado un proyectil aliado encima de un bot con vida completa
    Cuando resuelvo impactos en bots
    Entonces el bot pierde un punto de vida y el proyectil se consume

  Escenario: Un bot sin vida queda eliminado
    Dado un bot con un solo punto de vida y un proyectil aliado encima
    Cuando resuelvo impactos en bots
    Entonces el bot queda con vida 0 y cuenta como eliminado

  Escenario: Un disparo aliado no daña al jugador
    Dado un proyectil aliado encima del jugador
    Cuando resuelvo impactos en el jugador
    Entonces el jugador no recibe golpes

  Escenario: Un disparo enemigo golpea al jugador y se consume
    Dado un proyectil enemigo encima del jugador
    Cuando resuelvo impactos en el jugador
    Entonces el jugador recibe un golpe y el proyectil se consume

  Escenario: Un proyectil lejos no impacta a nadie
    Dado un proyectil enemigo lejos del jugador
    Cuando resuelvo impactos en el jugador
    Entonces el jugador no recibe golpes y el proyectil sigue en vuelo

  Escenario: Contar enemigos eliminados
    Dado una lista de bots donde 2 de 3 tienen vida 0
    Cuando cuento los eliminados
    Entonces obtengo 2

  Escenario: La ronda se gana cuando ya no queda ningún bot vivo
    Dado una lista de bots todos con vida 0
    Cuando reviso si están todos eliminados
    Entonces el resultado es que sí

  Escenario: Un bot dispara por cadencia, no en cada cuadro
    Dado el primer bot
    Cuando reviso el cuadro de su cadencia
    Entonces dispara
    Pero en el cuadro siguiente no dispara

  Escenario: Los bots no disparan todos en el mismo cuadro
    Dado los bots de la ronda
    Cuando reviso un cuadro donde dispara el primero
    Entonces los demás no disparan en ese mismo cuadro
    Y así ningún cuadro recibe una salva capaz de vaciar la vida del jugador de golpe

  Escenario: Un bot lejos se acerca al jugador
    Dado un bot más lejos que su distancia preferida
    Cuando calculo su dirección
    Entonces avanza hacia el jugador

  Escenario: Un bot ya a tiro mantiene su distancia
    Dado un bot dentro de su distancia preferida
    Cuando calculo su dirección
    Entonces se queda en su lugar en vez de perseguir al cuerpo a cuerpo
