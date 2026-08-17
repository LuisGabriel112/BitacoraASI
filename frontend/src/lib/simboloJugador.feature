Característica: Saber qué símbolo soy en una partida de gato

  Escenario: Soy el jugador X
    Dado que mi nombre coincide con el del jugador X de la partida
    Cuando pido mi símbolo
    Entonces obtengo "X"

  Escenario: Soy el jugador O
    Dado que mi nombre coincide con el del jugador O de la partida
    Cuando pido mi símbolo
    Entonces obtengo "O"

  Escenario: No soy ninguno de los dos jugadores
    Dado que mi nombre no coincide con ningún jugador de la partida
    Cuando pido mi símbolo
    Entonces no obtengo símbolo

  Escenario: Todavía no hay jugador O
    Dado una partida esperando rival (jugador_o es nulo)
    Cuando pido mi símbolo y soy el jugador X
    Entonces obtengo "X"
