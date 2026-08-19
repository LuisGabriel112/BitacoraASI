Característica: Hash determinista de texto para elegir variantes visuales

  Escenario: El mismo texto siempre da el mismo hash
    Dado un texto "El SLA Vencido"
    Cuando calculo su hash dos veces
    Entonces obtengo el mismo numero las dos veces

  Escenario: El hash siempre es un entero no negativo
    Dado varios textos distintos, incluido uno vacio
    Cuando calculo su hash
    Entonces cada resultado es un entero mayor o igual a cero
