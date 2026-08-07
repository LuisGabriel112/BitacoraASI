Característica: Otorgar XP por acciones y logros
  Como sistema que registra el trabajo del equipo
  Quiero acreditar XP al nombre seleccionado en el combo (agente o resolutor)
  Para que el personaje de esa persona avance sin bloquear la captura si algo falla

  Escenario: El nombre coincide con un usuario registrado
    Dado que existe un usuario con ese nombre (sin distinguir mayúsculas/espacios)
    Cuando se otorga XP a ese nombre
    Entonces el XP del usuario se incrementa de forma atómica
    Y se guarda un evento de XP con el usuario_id correspondiente

  Escenario: El nombre no coincide con ningún usuario registrado todavía
    Dado que ningún usuario tiene ese nombre
    Cuando se otorga XP a ese nombre
    Entonces no se incrementa el XP de nadie
    Y se guarda igual un evento de XP con usuario_id nulo, para poder auditarlo después

  Escenario: Un fallo al otorgar XP nunca debe tumbar la acción principal
    Dado que la base de datos falla al intentar otorgar XP
    Cuando se otorga XP
    Entonces la función no lanza ninguna excepción
    Y la sesión se revierte para no dejarla en un estado inconsistente

  Escenario: El XP de cerrar una mesa es el mismo sin importar el endpoint usado
    Dado que una mesa se cierra con N logros detectados
    Cuando se calcula el XP de cierre
    Entonces el XP otorgado es XP_POR_ACCION + XP_POR_LOGRO * N
    Y es igual sin importar si se cerró vía /cerrar o vía /editar
