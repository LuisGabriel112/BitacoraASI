Característica: Limpiar el formulario de Nueva mesa tras guardar, conservando el Resolutor
  Como usuario que captura varias mesas seguidas asignadas al mismo resolutor
  Quiero que al guardar se limpien los demás campos pero no el Resolutor
  Para no tener que volver a buscarlo y seleccionarlo en cada mesa

  Escenario: Se guarda una mesa con datos capturados
    Dado un formulario vacío de referencia y un formulario lleno con resolutor "Sergio" (id 7)
    Cuando se limpia el formulario tras guardar
    Entonces todos los campos quedan como el formulario vacío, excepto Resolutor que sigue siendo "Sergio" (id 7)
