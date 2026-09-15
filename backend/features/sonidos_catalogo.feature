# language: es
Característica: Catálogo de sonidos con preferencia por usuario y por acción
  Como usuario de la bitácora
  Quiero elegir qué sonido escucho al guardar una mesa, cerrarla o recibir
  un error, y que el equipo pueda cargar sonidos nuevos o deshabilitarlos
  Para que los avisos sonoros sean de cada quien sin dejar de ser un catálogo común

  Escenario: Cada acción tiene una categoría de sonido fija
    Dado las acciones guardar_mesa, cerrar_mesa y error
    Cuando pregunto la categoría de cada una
    Entonces guardar_mesa y cerrar_mesa son de "exito" y error es de "error"

  Escenario: No se puede elegir un sonido de la categoría equivocada
    Dado un sonido de categoría "error"
    Cuando intento asignarlo a la acción guardar_mesa
    Entonces se rechaza indicando la categoría esperada

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

  Escenario: Los sonidos nuevos se suben a una carpeta propia del bucket
    Dado que pido una URL de subida para un sonido
    Cuando el backend genera la key del archivo
    Entonces la key queda bajo la carpeta "sonidos/" y conserva la extensión

  Escenario: Sin almacenamiento configurado la subida avisa en vez de tronar
    Dado que SUPABASE_URL está vacío
    Cuando pido una URL de subida
    Entonces obtengo un error de almacenamiento con mensaje claro

  Escenario: No se duplica un sonido con el mismo nombre en la misma categoría
    Dado que ya existe un sonido "pop-succes" de éxito
    Cuando intento crear otro "Pop-Succes" de éxito
    Entonces se rechaza con conflicto
