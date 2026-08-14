# language: es
Característica: Minijuego "Encuentra la pelota" con daño al jefe semanal
  Como usuario de la bitácora
  Quiero intentar adivinar dónde está la pelota cada cierto tiempo
  Para bajarle vida al jefe semanal si acierto, sin poder farmear daño a punta de clicks

  Escenario: Primer intento, nunca ha jugado
    Dado que el usuario nunca ha intentado el juego
    Cuando pregunto si puede jugar ahora
    Entonces puede jugar

  Escenario: Intentó hace menos de 5 minutos
    Dado que el usuario intentó hace 2 minutos
    Cuando pregunto si puede jugar ahora
    Entonces no puede jugar
    Y el tiempo restante de espera es de 3 minutos

  Escenario: Intentó hace exactamente 5 minutos
    Dado que el usuario intentó hace exactamente 5 minutos
    Cuando pregunto si puede jugar ahora
    Entonces puede jugar

  Escenario: Intentó hace más de 5 minutos
    Dado que el usuario intentó hace 10 minutos
    Cuando pregunto si puede jugar ahora
    Entonces puede jugar

  Escenario: Iniciar intento en cooldown se rechaza
    Dado que el último intento fue hace 1 minuto
    Cuando intento iniciar un nuevo intento
    Entonces se rechaza por estar en cooldown

  Escenario: Iniciar intento fuera de cooldown crea uno nuevo con posición oculta
    Dado que no hay intento previo o pasó el cooldown
    Cuando inicio un intento
    Entonces se crea un intento con una posición correcta entre 0 y 2

  Escenario: Resolver con la posición correcta cuenta como acierto y daña al jefe
    Dado un intento sin resolver cuya posición correcta es 1
    Cuando elijo la posición 1
    Entonces el intento queda resuelto con acierto
    Y se le baja vida al jefe semanal

  Escenario: Resolver con la posición incorrecta cuenta como fallo, sin dañar
    Dado un intento sin resolver cuya posición correcta es 1
    Cuando elijo la posición 0
    Entonces el intento queda resuelto sin acierto
    Y no se le baja vida al jefe

  Escenario: No se puede resolver el intento de otro usuario
    Dado un intento que pertenece a otro usuario
    Cuando intento resolverlo
    Entonces se rechaza

  Escenario: No se puede resolver un intento dos veces
    Dado un intento que ya fue resuelto
    Cuando intento resolverlo de nuevo
    Entonces se rechaza
