# language: es
Característica: Los bonos de objetos equipados se aplican donde corresponde
  Como usuario con objetos equipados
  Quiero que mis bonos de daño, crítico, cooldown y XP se apliquen solos
  Para no tener que hacer nada extra además de haberlos comprado

  Escenario: El bono de daño% sube el daño que recibe el jefe
    Dado un usuario con un objeto de daño% equipado
    Cuando se le daña al jefe por esa acción
    Entonces el daño aplicado es mayor al daño base

  Escenario: El bono de crítico es un roll independiente del crítico existente
    Dado un usuario con un objeto de crítico% equipado
    Cuando el roll de crítico del objeto acierta
    Entonces el daño se duplica sobre lo que ya traía calculado

  Escenario: Sin cuenta vinculada al nombre capturado no hay bono
    Dado un nombre capturado que no matchea ninguna cuenta de usuario
    Cuando se daña al jefe por esa acción
    Entonces el daño queda igual al daño base, sin buscar objetos

  Escenario: El bono de cooldown% reduce la espera entre intentos de un minijuego
    Dado un usuario con un objeto de cooldown% equipado
    Cuando calcula si puede jugar de nuevo
    Entonces el cooldown efectivo es menor al cooldown base del minijuego

  Escenario: El bono de XP% aumenta el XP otorgado
    Dado un usuario con un objeto de XP% equipado
    Cuando se le otorga XP por una acción
    Entonces el XP acreditado es mayor al XP base
