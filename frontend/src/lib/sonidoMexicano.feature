Característica: Secuencia de fanfarria mariachi sintetizada

  Escenario: La fanfarria tiene 4 notas
    Dado que pido la secuencia de la fanfarria
    Cuando genero las notas
    Entonces obtengo 4 notas

  Escenario: Las frecuencias son ascendentes (arpegio de trompeta)
    Dado que pido la secuencia de la fanfarria
    Cuando genero las notas
    Entonces cada frecuencia es mayor que la anterior

  Escenario: Cada nota empieza justo cuando termina la anterior
    Dado que pido la secuencia de la fanfarria
    Cuando genero las notas
    Entonces el inicio de cada nota es igual al inicio más la duración de la nota previa

  Escenario: La última nota se sostiene más que las demás
    Dado que pido la secuencia de la fanfarria
    Cuando genero las notas
    Entonces la duración de la última nota es mayor que la de las demás
