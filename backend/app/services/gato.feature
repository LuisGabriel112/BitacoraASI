# language: es
Característica: Reglas del gato (tic-tac-toe)
  Como dos usuarios en línea
  Quiero jugar gato en tiempo real
  Para pasar el rato mientras estamos conectados

  Escenario: Fila ganadora horizontal
    Dado un tablero con "X" en las 3 casillas de una fila
    Cuando verifico si hay ganador
    Entonces el ganador es "X"

  Escenario: Columna ganadora vertical
    Dado un tablero con "O" en las 3 casillas de una columna
    Cuando verifico si hay ganador
    Entonces el ganador es "O"

  Escenario: Diagonal ganadora
    Dado un tablero con "X" en una diagonal completa
    Cuando verifico si hay ganador
    Entonces el ganador es "X"

  Escenario: Tablero sin ninguna línea completa
    Dado un tablero sin 3 en línea de ningún jugador
    Cuando verifico si hay ganador
    Entonces no hay ganador

  Escenario: Tablero lleno sin ganador es empate
    Dado un tablero completamente lleno sin 3 en línea
    Cuando calculo el resultado de la partida
    Entonces el resultado es "empate"

  Escenario: Tablero con casillas vacías y sin ganador sigue en juego
    Dado un tablero con casillas vacías y sin 3 en línea
    Cuando calculo el resultado de la partida
    Entonces no hay resultado todavía (la partida sigue)

  Escenario: Aplicar un movimiento coloca el símbolo en la posición exacta
    Dado un tablero vacío
    Cuando aplico el movimiento del símbolo "X" en la posición 4
    Entonces esa posición tiene "X" y las demás siguen vacías

  Escenario: El turno alterna entre X y O
    Cuando pido el símbolo contrario a "X"
    Entonces obtengo "O"
    Cuando pido el símbolo contrario a "O"
    Entonces obtengo "X"

  Escenario: Buscar partida vuelve a mi propia partida en espera si ya tengo una
    Dado que ya tengo una partida en espera creada por mí
    Cuando busco partida de nuevo
    Entonces me devuelve la misma partida, sin crear otra

  Escenario: Buscar partida se une a la partida en espera más antigua de otro usuario
    Dado que otro usuario tiene una partida en espera
    Cuando busco partida
    Entonces me uno como jugador O y la partida pasa a "jugando"

  Escenario: Buscar partida crea una nueva si no hay ninguna disponible
    Dado que no hay ninguna partida en espera
    Cuando busco partida
    Entonces se crea una partida nueva conmigo como jugador X, en espera

  Escenario: Jugar un movimiento actualiza el tablero y cambia el turno
    Dado una partida en juego, mi turno
    Cuando juego en una casilla vacía
    Entonces el tablero se actualiza y el turno pasa al otro jugador

  Escenario: Jugar un movimiento que gana la partida la marca como terminada
    Dado una partida en juego donde mi jugada completa una línea
    Cuando juego esa casilla
    Entonces la partida queda "terminada" con mi símbolo como ganador

  Escenario: No se puede jugar si no es tu turno
    Dado una partida en juego, turno del otro jugador
    Cuando intento jugar
    Entonces se rechaza el movimiento

  Escenario: No se puede jugar una casilla ocupada
    Dado una partida en juego con una casilla ya ocupada
    Cuando intento jugar esa casilla
    Entonces se rechaza el movimiento

  Escenario: Cancelar espera borra la partida solo si sigue esperando y es mía
    Dado una partida en espera creada por mí
    Cuando cancelo la espera
    Entonces la partida se elimina

  Escenario: Cancelar espera no hace nada si la partida ya no está esperando
    Dado una partida que ya está en juego
    Cuando intento cancelar la espera
    Entonces la partida no se elimina
