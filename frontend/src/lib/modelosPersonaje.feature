Característica: Piezas 3D del personaje
  Antes el personaje solo variaba en dos colores y cuatro accesorios. Ahora se
  arma por piezas independientes: complexión, cara, accesorio de cabeza y
  accesorio de espalda, más un color de detalle propio.

  Escenario: Cada complexión arma un cuerpo
    Dada una complexión del catálogo
    Cuando se construye el cuerpo
    Entonces el grupo queda con mallas

  Escenario: Cada cara dibuja rasgos
    Dada una cara del catálogo
    Cuando se agrega la cara
    Entonces el grupo queda con mallas

  Escenario: El accesorio "ninguno" no agrega nada
    Dado el accesorio "ninguno"
    Cuando se agrega el accesorio
    Entonces el grupo queda vacío

  Escenario: Cualquier otro accesorio agrega piezas
    Dado un accesorio distinto de "ninguno"
    Cuando se agrega el accesorio
    Entonces el grupo queda con mallas

  Escenario: La espalda "ninguna" no agrega nada
    Dada la espalda "ninguna"
    Cuando se agrega la espalda
    Entonces el grupo queda vacío

  Escenario: El accesorio usa el color de detalle elegido
    Dado el accesorio "gorra" y el color de detalle "#ff0000"
    Cuando se agrega el accesorio
    Entonces alguna malla usa ese color
