# language: es
Característica: Trivia de soporte que daña al jefe semanal
  Como usuario de la bitácora
  Quiero responder una pregunta cada cierto tiempo
  Para bajarle vida al jefe si acierto, sin poder farmear daño

  Escenario: Cada pregunta tiene una única respuesta correcta entre sus opciones
    Dado el banco de preguntas
    Cuando reviso cada pregunta
    Entonces el índice de la respuesta correcta cae dentro de sus opciones

  Escenario: Iniciar intento en cooldown se rechaza
    Dado que el último intento fue hace 1 minuto
    Cuando intento iniciar un nuevo intento
    Entonces se rechaza por estar en cooldown

  Escenario: Iniciar intento fuera de cooldown crea uno con una pregunta
    Dado que no hay intento previo o pasó el cooldown
    Cuando inicio un intento
    Entonces se crea un intento con una pregunta del banco

  Escenario: Responder correctamente cuenta como acierto y daña al jefe
    Dado un intento sin resolver con una pregunta conocida
    Cuando respondo con la opción correcta
    Entonces el intento queda resuelto con acierto
    Y se le baja vida al jefe semanal

  Escenario: Responder incorrectamente cuenta como fallo, sin dañar
    Dado un intento sin resolver con una pregunta conocida
    Cuando respondo con una opción incorrecta
    Entonces el intento queda resuelto sin acierto
    Y no se le baja vida al jefe

  Escenario: No se puede responder el intento de otro usuario
    Dado un intento que pertenece a otro usuario
    Cuando intento responderlo
    Entonces se rechaza

  Escenario: No se puede responder un intento dos veces
    Dado un intento que ya fue resuelto
    Cuando intento responderlo de nuevo
    Entonces se rechaza
