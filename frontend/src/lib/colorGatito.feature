Característica: Color de pelaje determinista para el gatito de cada mascota

  Escenario: La misma semilla siempre da el mismo color
    Dado una semilla "SEM 32 - 2026-El SLA Vencido"
    Cuando pido el color de gatito dos veces con esa semilla
    Entonces obtengo el mismo color las dos veces

  Escenario: El color siempre es uno de la paleta de pelajes
    Dado varias semillas distintas
    Cuando pido el color de gatito de cada una
    Entonces cada color pertenece a la paleta definida

  Escenario: Semillas distintas pueden dar colores distintos
    Dado dos semillas distintas
    Cuando pido el color de gatito de cada una
    Entonces no estan forzadas al mismo color
