Característica: Geometría y movimiento de la arena tipo Brawl Stars

  Escenario: Un punto nunca sale de los límites de la arena
    Dado un punto fuera de los límites
    Cuando lo limito a la arena
    Entonces queda dentro de los límites, respetando su radio

  Escenario: Un punto sobre un muro se detecta como colisión
    Dado un punto en el centro de un muro
    Cuando reviso si toca muro
    Entonces el resultado es que sí toca

  Escenario: Un punto en zona libre no colisiona
    Dado un punto lejos de todo muro
    Cuando reviso si toca muro
    Entonces el resultado es que no toca

  Escenario: Moverse en zona libre desplaza normalmente
    Dado un personaje en zona libre
    Cuando se mueve hacia una dirección despejada
    Entonces avanza en esa dirección

  Escenario: Un muro bloquea el avance pero deja deslizarse
    Dado un personaje pegado a un muro por el eje X
    Cuando intenta moverse en diagonal contra el muro
    Entonces no atraviesa el muro pero sí se desplaza en el eje libre

  Escenario: La dirección hacia un objetivo está normalizada
    Dado un origen y un objetivo separados
    Cuando calculo la dirección hacia el objetivo
    Entonces el vector tiene magnitud 1

  Escenario: La dirección hacia el mismo punto no rompe el cálculo
    Dado un origen igual al objetivo
    Cuando calculo la dirección
    Entonces obtengo un vector finito, sin división entre cero
