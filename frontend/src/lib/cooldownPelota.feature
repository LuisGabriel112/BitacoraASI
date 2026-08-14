Característica: Cooldown local de "Encuentra la pelota" (referencial, el servidor manda)

  Escenario: Nunca ha jugado
    Dado que no hay marca de tiempo del último intento
    Cuando pregunto el tiempo restante
    Entonces el restante es 0

  Escenario: Jugó hace menos de 5 minutos
    Dado que el último intento fue hace 2 minutos
    Cuando pregunto el tiempo restante
    Entonces el restante es de 3 minutos

  Escenario: Jugó hace más de 5 minutos
    Dado que el último intento fue hace 10 minutos
    Cuando pregunto el tiempo restante
    Entonces el restante es 0
