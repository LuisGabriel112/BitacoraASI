# language: es
Característica: Catálogo de objetos de la tienda
  El catálogo original tenía 6 objetos y se agotaba en una semana. Se conservan
  los 6 originales y se agregan muchos más, en tres niveles: básicos, combinados
  de dos básicos y combinados de dos combinados.

  Escenario: Los objetos originales siguen disponibles
    Dado el catálogo de objetos
    Cuando se buscan los ids originales
    Entonces daga_oxidada, nucleo_inestable, chip_overclock, manual_pirata, filo_sangriento y terminal_hackeada existen

  Escenario: El catálogo es grande
    Dado el catálogo de objetos
    Cuando se cuentan sus objetos
    Entonces hay al menos 24 objetos

  Escenario: Cada objeto sirve para algo
    Dado el catálogo de objetos
    Cuando se revisa cada objeto
    Entonces todos tienen costo mayor a cero y al menos un bono mayor a cero

  Escenario: Los combinados se arman con dos piezas del catálogo
    Dado el catálogo de objetos
    Cuando se revisa cada objeto combinado
    Entonces requiere exactamente dos ids distintos que existen en el catálogo

  Escenario: Un combinado rinde más que sus piezas
    Dado un objeto combinado
    Cuando se suman los bonos de las dos piezas que consume
    Entonces el combinado da más bono total que la suma de sus piezas
