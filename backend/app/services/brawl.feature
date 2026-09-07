# language: es
Característica: Minijuego tipo Brawl Stars que daña al jefe semanal
  Como usuario de la bitácora
  Quiero eliminar bots en una arena en tiempo real cada cierto tiempo
  Para bajarle vida al jefe si mi resultado es plausible, sin permitir bots ni valores absurdos

  Escenario: Iniciar intento en cooldown se rechaza
    Dado que el último intento fue hace 1 minuto
    Cuando intento iniciar un nuevo intento
    Entonces se rechaza por estar en cooldown

  Escenario: Eliminar al menos 2 de 3 bots cuenta como acierto
    Dado un intento sin resolver
    Cuando reporto 2 enemigos eliminados
    Entonces el intento queda resuelto con acierto
    Y se le baja vida al jefe semanal

  Escenario: Eliminar 3 de 3 bots también cuenta como acierto
    Dado un intento sin resolver
    Cuando reporto 3 enemigos eliminados
    Entonces el intento queda resuelto con acierto

  Escenario: Eliminar menos de 2 bots no cuenta como acierto
    Dado un intento sin resolver
    Cuando reporto 1 enemigo eliminado
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
