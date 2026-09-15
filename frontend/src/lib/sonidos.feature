Característica: Qué sonido se reproduce en cada acción según el catálogo y la preferencia del usuario
  Como usuario de la bitácora
  Quiero elegir el sonido de guardar mesa, cerrar mesa y mensaje de error
  Para que los avisos suenen como yo quiero sin dejar de usar el catálogo común

  Escenario: Cada acción tiene su categoría
    Dado las acciones guardar_mesa, cerrar_mesa y error
    Cuando pregunto su categoría
    Entonces las dos de mesa son de éxito y la de error es de error

  Escenario: Sin preferencia suena uno aleatorio de la categoría, solo entre los activos
    Dado un catálogo con sonidos de éxito activos e inactivos y sonidos de error
    Cuando resuelvo el sonido de guardar_mesa sin preferencia
    Entonces obtengo uno de los sonidos de éxito activos, nunca uno inactivo ni de error

  Escenario: El sonido elegido por el usuario suena siempre
    Dado que el usuario eligió un sonido activo para cerrar_mesa
    Cuando resuelvo el sonido de cerrar_mesa
    Entonces obtengo exactamente ese sonido, sin importar el azar

  Escenario: Un sonido elegido que fue deshabilitado en general cae al aleatorio
    Dado que el usuario eligió un sonido que después se deshabilitó
    Cuando resuelvo el sonido de esa acción
    Entonces obtengo otro sonido activo de la misma categoría

  Escenario: Silenciar una acción no reproduce nada
    Dado que el usuario silenció la acción error
    Cuando resuelvo el sonido de error
    Entonces no hay sonido que reproducir

  Escenario: Sin ningún sonido activo de la categoría no suena nada
    Dado un catálogo donde todos los sonidos de error están deshabilitados
    Cuando resuelvo el sonido de error
    Entonces no hay sonido que reproducir

  Escenario: Los sonidos sintetizados se reconocen por su esquema
    Dado un sonido con url "sintetizado:fanfarria-mexicana"
    Cuando pregunto si es sintetizado
    Entonces la respuesta es sí, y para una ruta de archivo es no

  Escenario: Si el catálogo no cargó se usa el pool fijo de respaldo
    Dado que el backend no respondió
    Cuando pido los sonidos de respaldo
    Entonces obtengo los sonidos de éxito y error que la app traía fijos, todos activos

  Escenario: Validación del archivo antes de subirlo
    Dado un archivo que no es audio o pesa más de 2 MB
    Cuando lo valido
    Entonces obtengo un mensaje de error; un ogg pequeño pasa sin error

  Escenario: Nombre sugerido a partir del archivo
    Dado un archivo "tada_final.ogg"
    Cuando sugiero un nombre
    Entonces obtengo "tada final"
