Característica: Matemática de la presentación 3D del brawl

  Escenario: La arena se centra en el origen del mundo 3D
    Dado el centro de la arena
    Cuando lo convierto a coordenadas del mundo
    Entonces cae en el origen

  Escenario: El eje vertical de la arena se convierte en profundidad
    Dado un punto más abajo en la arena
    Cuando lo convierto a coordenadas del mundo
    Entonces su profundidad aumenta

  Escenario: La sacudida se apaga sola
    Dada una sacudida recién disparada
    Cuando pasa su duración completa
    Entonces la intensidad queda en cero

  Escenario: La sacudida es más fuerte al principio
    Dada una sacudida recién disparada
    Cuando comparo el arranque contra la mitad
    Entonces al arranque sacude más

  Escenario: Una sacudida vencida no reaparece
    Dada una sacudida vieja
    Cuando pido su intensidad
    Entonces es cero y nunca negativa

  Escenario: El color de la barra de vida avisa el peligro
    Dada vida completa
    Cuando pido su color
    Entonces es verde
    Y con poca vida es rojo

  Escenario: Las partículas caen y se desvanecen
    Dada una partícula recién creada
    Cuando avanza el tiempo
    Entonces baja su altura y su opacidad

  Escenario: Una partícula vencida se descarta
    Dada una partícula que agotó su vida
    Cuando reviso si sigue viva
    Entonces el resultado es que no

  Escenario: El rebote de la caminata sigue el reloj
    Dado un personaje en movimiento
    Cuando avanza el tiempo
    Entonces su altura oscila alrededor de su reposo
