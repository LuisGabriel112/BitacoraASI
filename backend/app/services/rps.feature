# language: es
Característica: Piedra, papel o tijera entre 2 usuarios en línea
  Como dos usuarios en línea
  Quiero jugar piedra-papel-tijera en tiempo real
  Para pasar el rato mientras esperamos, sin afectar al jefe semanal

  Escenario: Piedra gana a tijera
    Cuando comparo piedra contra tijera
    Entonces gana el jugador con piedra

  Escenario: Tijera gana a papel
    Cuando comparo tijera contra papel
    Entonces gana el jugador con tijera

  Escenario: Papel gana a piedra
    Cuando comparo papel contra piedra
    Entonces gana el jugador con papel

  Escenario: Misma jugada es empate
    Cuando ambos jugadores eligen lo mismo
    Entonces el resultado es empate

  Escenario: Buscar partida reusa cola de emparejamiento igual que el gato
    Dado que ya tengo una partida en espera creada por mí
    Cuando busco partida de nuevo
    Entonces me devuelve la misma partida, sin crear otra

  Escenario: Al unirse un segundo jugador la partida pasa a jugando
    Dado que otro usuario tiene una partida en espera
    Cuando busco partida
    Entonces me uno como jugador O y la partida pasa a "jugando"

  Escenario: Jugar registra mi jugada sin revelar la del rival
    Dado una partida en juego donde aún no he jugado
    Cuando elijo "piedra"
    Entonces mi jugada queda registrada
    Y la partida sigue "jugando" si el rival no ha jugado todavía

  Escenario: Cuando ambos ya jugaron se resuelve el resultado
    Dado una partida donde el rival ya jugó "tijera"
    Cuando elijo "piedra"
    Entonces la partida queda "terminada" con resultado a mi favor

  Escenario: No puedo jugar dos veces la misma ronda
    Dado una partida donde ya jugué esta ronda
    Cuando intento jugar de nuevo
    Entonces se rechaza

  Escenario: No puedo jugar una jugada inválida
    Dado una partida en juego
    Cuando intento jugar "lagarto"
    Entonces se rechaza
