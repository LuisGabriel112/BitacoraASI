# language: es
Característica: Cooldown genérico entre intentos de un minijuego
  Como cualquier minijuego que daña al jefe (pelota, trivia, memorama, reacción, ruleta)
  Quiero un tiempo mínimo de espera entre intentos por usuario
  Para que nadie pueda farmear daño a punta de clicks

  Escenario: Primer intento, nunca ha jugado
    Dado que el usuario nunca ha intentado el juego
    Cuando pregunto si puede jugar ahora
    Entonces puede jugar

  Escenario: Intentó hace menos del cooldown configurado
    Dado un cooldown de 5 minutos y un intento hace 2 minutos
    Cuando pregunto si puede jugar ahora
    Entonces no puede jugar
    Y el tiempo restante es de 3 minutos

  Escenario: Intentó hace exactamente el cooldown configurado
    Dado un cooldown de 5 minutos y un intento hace exactamente 5 minutos
    Cuando pregunto si puede jugar ahora
    Entonces puede jugar

  Escenario: Intentó hace más que el cooldown configurado
    Dado un cooldown de 5 minutos y un intento hace 10 minutos
    Cuando pregunto si puede jugar ahora
    Entonces puede jugar

  Escenario: El tiempo restante nunca es negativo
    Dado un intento hace mucho más tiempo que el cooldown
    Cuando pregunto el tiempo restante
    Entonces el restante es 0
