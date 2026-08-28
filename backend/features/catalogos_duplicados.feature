# language: es
Característica: Evitar duplicados de catálogo por diferencia de mayúsculas
  Como usuario que filtra o llena un formulario
  Quiero que crear un valor de catálogo sea insensible a mayúsculas/minúsculas
  Para no terminar con "Tramites E." y "tramites E." como dos módulos distintos

  Escenario: Ya existe el nombre con otra combinación de mayúsculas
    Dado que el catálogo ya tiene un valor "Tramites E."
    Cuando se pide crear "tramites e." en el mismo catálogo
    Entonces la búsqueda de existente encuentra "Tramites E." sin importar el caso

  Escenario: El nombre no existe en ninguna variante de mayúsculas
    Dado que el catálogo no tiene ningún valor parecido
    Cuando se construye la consulta de existente para "Valor Nuevo"
    Entonces la consulta compara en minúsculas contra el catálogo correcto
