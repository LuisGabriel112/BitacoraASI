# language: es
Característica: Memorama relámpago que daña al jefe semanal
  Como usuario de la bitácora
  Quiero resolver un memorama rápido cada cierto tiempo
  Para bajarle vida al jefe si lo completo de verdad, sin poder mandar el resultado sin jugar

  Escenario: Iniciar intento en cooldown se rechaza
    Dado que el último intento fue hace 1 minuto
    Cuando intento iniciar un nuevo intento
    Entonces se rechaza por estar en cooldown

  Escenario: Iniciar intento fuera de cooldown crea uno nuevo
    Dado que no hay intento previo o pasó el cooldown
    Cuando inicio un intento
    Entonces se crea un intento sin resolver

  Escenario: Completar demasiado rápido no cuenta como acierto
    Dado un intento iniciado hace menos del tiempo mínimo posible
    Cuando lo completo
    Entonces el intento queda resuelto sin acierto
    Y no se le baja vida al jefe

  Escenario: Completar después del tiempo mínimo cuenta como acierto
    Dado un intento iniciado hace más del tiempo mínimo posible
    Cuando lo completo
    Entonces el intento queda resuelto con acierto
    Y se le baja vida al jefe semanal

  Escenario: No se puede completar el intento de otro usuario
    Dado un intento que pertenece a otro usuario
    Cuando intento completarlo
    Entonces se rechaza

  Escenario: No se puede completar un intento dos veces
    Dado un intento que ya fue resuelto
    Cuando intento completarlo de nuevo
    Entonces se rechaza
