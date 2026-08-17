# language: es
Característica: Reacción rápida que daña al jefe semanal
  Como usuario de la bitácora
  Quiero reaccionar a una señal en pantalla cada cierto tiempo
  Para bajarle vida al jefe si mi tiempo de reacción es plausible, sin permitir bots ni valores absurdos

  Escenario: Iniciar intento en cooldown se rechaza
    Dado que el último intento fue hace 1 minuto
    Cuando intento iniciar un nuevo intento
    Entonces se rechaza por estar en cooldown

  Escenario: Un tiempo de reacción humano cuenta como acierto
    Dado un intento sin resolver
    Cuando reporto un tiempo de reacción de 350 ms
    Entonces el intento queda resuelto con acierto
    Y se le baja vida al jefe semanal

  Escenario: Un tiempo demasiado rápido para ser humano no cuenta
    Dado un intento sin resolver
    Cuando reporto un tiempo de reacción de 50 ms
    Entonces el intento queda resuelto sin acierto
    Y no se le baja vida al jefe

  Escenario: Un tiempo absurdamente lento tampoco cuenta (probable manipulación)
    Dado un intento sin resolver
    Cuando reporto un tiempo de reacción de 10000 ms
    Entonces el intento queda resuelto sin acierto

  Escenario: No se puede resolver el intento de otro usuario
    Dado un intento que pertenece a otro usuario
    Cuando intento resolverlo
    Entonces se rechaza

  Escenario: No se puede resolver un intento dos veces
    Dado un intento que ya fue resuelto
    Cuando intento resolverlo de nuevo
    Entonces se rechaza
