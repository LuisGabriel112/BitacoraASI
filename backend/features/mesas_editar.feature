# language: es
Característica: Editar una mesa ya creada
  Como responsable de soporte administrativo
  Quiero poder corregir cualquier campo de una mesa después de crearla
  Para arreglar errores de captura sin tener que borrar y recrear

  Escenario: Editar solo cambia los campos enviados
    Dado un MesaUpdate que solo trae el campo "titulo"
    Cuando extraigo los campos a actualizar
    Entonces el resultado es únicamente {"titulo": "..."}, sin tocar los demás

  Escenario: Editar una mesa inexistente
    Dado que no existe ninguna mesa con ese id
    Cuando intento editarla
    Entonces recibo un error 404

  Escenario: Editar el código a uno usado por otra mesa
    Dado que otra mesa ya usa el código "X"
    Cuando edito una mesa distinta poniéndole código "X"
    Entonces recibo un error 409 y no se guarda el cambio

  Escenario: Reenviar el mismo código no genera conflicto falso
    Dado una mesa con código "X"
    Cuando la edito reenviando código "X" (sin cambiarlo)
    Entonces se guarda sin error
