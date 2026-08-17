# language: es
Característica: Ruleta rusa de daño — riesgo entre dañar al jefe o perder XP
  Como usuario de la bitácora
  Quiero arriesgarme cada cierto tiempo
  Para dañar bastante al jefe si gano, a costa de perder algo de XP si pierdo

  Escenario: Jugar en cooldown se rechaza
    Dado que el último intento fue hace 1 minuto
    Cuando intento jugar de nuevo
    Entonces se rechaza por estar en cooldown

  Escenario: Ganar daña al jefe con más fuerza que un minijuego normal
    Dado que el resultado del azar es ganar
    Cuando juego
    Entonces se le baja una cantidad mayor de vida al jefe semanal
    Y no se le resta XP a nadie

  Escenario: Perder resta XP en vez de dañar al jefe
    Dado que el resultado del azar es perder
    Cuando juego
    Entonces no se le baja vida al jefe
    Y se le resta XP al usuario

  Escenario: El XP nunca baja de cero por perder
    Dado un usuario con XP menor a la penalización de la ruleta
    Cuando pierde
    Entonces su XP queda en cero, no en negativo
