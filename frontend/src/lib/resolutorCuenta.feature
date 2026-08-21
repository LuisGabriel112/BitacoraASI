Característica: Sugerir como Resolutor por defecto el vinculado a la cuenta actual
  Como usuario que registra sus propias mesas
  Quiero que el campo Resolutor arranque con el resolutor vinculado a mi cuenta
  Para no tener que buscarme y seleccionarme en cada mesa nueva

  Escenario: La cuenta actual está vinculada a un resolutor del catálogo
    Dado un catálogo de resolutores donde el resolutor "Reyes Cicero, Sergio" (id 7) está vinculado al usuario 42
    Cuando pregunto por el resolutor vinculado al usuario 42
    Entonces obtengo el resolutor "Reyes Cicero, Sergio" (id 7)

  Escenario: La cuenta actual no está vinculada a ningún resolutor
    Dado un catálogo de resolutores donde ninguno está vinculado al usuario 99
    Cuando pregunto por el resolutor vinculado al usuario 99
    Entonces no obtengo ningún resolutor

  Escenario: No hay usuario identificado todavía
    Dado un catálogo de resolutores con vínculos
    Cuando pregunto por el resolutor vinculado sin un usuario identificado
    Entonces no obtengo ningún resolutor
