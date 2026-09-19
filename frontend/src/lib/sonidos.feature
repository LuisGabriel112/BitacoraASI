Característica: Qué sonido se reproduce en cada acción según el catálogo y la preferencia del usuario
  Como usuario de la bitácora
  Quiero elegir el sonido de guardar mesa, cerrar mesa, mensaje de error, compra en la tienda
  y victoria o derrota en los minijuegos
  Para que los avisos suenen como yo quiero sin dejar de usar el catálogo común

  Escenario: Cada evento suena con una acción del catálogo
    Dado los eventos guardar_mesa, cerrar_mesa, error, compra, victoria y derrota
    Cuando pregunto con qué acción del catálogo suenan
    Entonces las dos de mesa son Éxito, error es Error y compra, victoria y derrota son ellas mismas

  Escenario: Un sonido puede estar marcado para varias acciones
    Dado un sonido marcado para Éxito y Victoria
    Cuando resuelvo el sonido de cerrar_mesa o de victoria
    Entonces ese sonido es candidato en ambos casos

  Escenario: Sin preferencia suena uno aleatorio entre los marcados para la acción
    Dado un catálogo con sonidos marcados para distintas acciones y uno sin ninguna
    Cuando resuelvo el sonido de guardar_mesa sin preferencia
    Entonces obtengo uno de los marcados para Éxito, nunca uno sin la marca

  Escenario: El sonido elegido por el usuario suena siempre
    Dado que el usuario eligió un sonido marcado para cerrar_mesa
    Cuando resuelvo el sonido de cerrar_mesa
    Entonces obtengo exactamente ese sonido, sin importar el azar

  Escenario: Un sonido elegido al que le quitaron la acción cae al aleatorio
    Dado que el usuario eligió un sonido que después se desmarcó de esa acción
    Cuando resuelvo el sonido de esa acción
    Entonces obtengo otro sonido que sí esté marcado

  Escenario: Silenciar una acción no reproduce nada
    Dado que el usuario silenció la acción error
    Cuando resuelvo el sonido de error
    Entonces no hay sonido que reproducir

  Escenario: Sin ningún sonido marcado para la acción no suena nada
    Dado un catálogo donde ningún sonido está marcado para Error
    Cuando resuelvo el sonido de error
    Entonces no hay sonido que reproducir

  Escenario: Los sonidos sintetizados se reconocen por su esquema
    Dado un sonido con url "sintetizado:victoria"
    Cuando pregunto si es sintetizado
    Entonces la respuesta es sí, y para una ruta de archivo es no

  Escenario: Si el catálogo no cargó se usa el pool fijo de respaldo
    Dado que el backend no respondió
    Cuando pido los sonidos de respaldo
    Entonces obtengo los de fábrica de cada acción, cada uno marcado solo para la suya

  Escenario: Validación del archivo antes de subirlo
    Dado un archivo que no es audio o pesa más de 2 MB
    Cuando lo valido
    Entonces obtengo un mensaje de error; un ogg pequeño pasa sin error

  Escenario: Nombre sugerido a partir del archivo
    Dado un archivo "tada_final.ogg"
    Cuando sugiero un nombre
    Entonces obtengo "tada final"

  Escenario: Los minijuegos avisan si gané o perdí
    Dado que termino un minijuego del jefe
    Cuando acierto, suena mi sonido de Victoria; cuando fallo, el de Derrota
    Entonces en Gato y Piedra-papel-tijera un empate no suena nada

  Escenario: La Ruleta rusa gira antes de revelar
    Dado que arriesgo en la Ruleta rusa
    Cuando suena la ruleta de casino (la bola frena y se asienta)
    Entonces el resultado se muestra al terminar el giro y suena Victoria o Derrota

  Escenario: Encuentra la pelota baraja los vasos
    Dado que empiezo Encuentra la pelota
    Cuando aparecen los vasos
    Entonces suenan cuatro vasos arrastrándose sobre la mesa

  Escenario: Comprar en la tienda suena a compra
    Dado que compro un objeto con mis créditos
    Cuando el servidor confirma la compra
    Entonces suena mi sonido de Compra (caja registradora o monedas si no elegí)
