# language: es
Característica: Catálogo de sonidos con interruptores por acción y preferencia por usuario
  Como usuario de la bitácora
  Quiero elegir qué sonido escucho al guardar una mesa, cerrarla, recibir un error,
  comprar en la tienda o ganar y perder un minijuego, y que el equipo pueda cargar
  sonidos nuevos y marcar en qué acciones puede sonar cada uno
  Para que los avisos sonoros sean de cada quien sin dejar de ser un catálogo común

  Escenario: Cada acción del usuario suena con una acción del catálogo
    Dado las acciones guardar_mesa, cerrar_mesa, error, compra, victoria y derrota
    Cuando pregunto con qué acción del catálogo suena cada una
    Entonces guardar_mesa y cerrar_mesa son "exito", error es "error" y compra, victoria y derrota son ellas mismas

  Escenario: Un sonido puede estar marcado para varias acciones
    Dado un sonido marcado solo para victoria
    Cuando lo marco también para error
    Entonces queda marcado para error y victoria, en el orden fijo del catálogo, sin repetidos

  Escenario: Desmarcar todas las acciones equivale a deshabilitar el sonido
    Dado un sonido marcado solo para exito
    Cuando lo desmarco de exito
    Entonces se queda sin acciones y no suena para nadie

  Escenario: No se puede elegir un sonido que no está marcado para la acción
    Dado un sonido marcado solo para "error"
    Cuando intento asignarlo a la acción guardar_mesa
    Entonces se rechaza indicando la acción esperada

  Escenario: Elegir un sonido que no existe se rechaza
    Dado un id de sonido inexistente
    Cuando intento asignarlo a una acción
    Entonces se rechaza indicando que el sonido no existe

  Escenario: Silenciar una acción descarta el sonido elegido
    Dado que un usuario elige un sonido para cerrar_mesa
    Cuando además marca la acción como silenciada
    Entonces la preferencia queda silenciada y sin sonido, para volver al aleatorio al reactivarla

  Escenario: Guardar una preferencia dos veces actualiza la misma fila
    Dado que un usuario ya tiene preferencia para error
    Cuando la vuelve a guardar con otro sonido
    Entonces no se crea una fila nueva, se actualiza la existente

  Escenario: Subir un sonido exige al menos una acción
    Dado un archivo de audio con nombre
    Cuando intento darlo de alta sin marcar ninguna acción
    Entonces se rechaza; en el catálogo sí se pueden apagar todas después

  Escenario: Los sonidos nuevos se suben a una carpeta propia del bucket
    Dado que pido una URL de subida para un sonido
    Cuando el backend genera la key del archivo
    Entonces la key queda bajo la carpeta "sonidos/" y conserva la extensión

  Escenario: Sin almacenamiento configurado la subida avisa en vez de tronar
    Dado que SUPABASE_URL está vacío
    Cuando pido una URL de subida
    Entonces obtengo un error de almacenamiento con mensaje claro

  Escenario: No se duplica un sonido con el mismo nombre
    Dado que ya existe un sonido "pop-succes"
    Cuando intento crear otro "Pop-Succes" para cualquier acción
    Entonces se rechaza con conflicto
