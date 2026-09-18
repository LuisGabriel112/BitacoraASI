Característica: Catálogo de modelos 3D de jefes
  Con seis modelos, semanas seguidas caían en el mismo cuerpo. El catálogo crece
  y la variante se sigue eligiendo por hash del nombre, así que un jefe conserva
  su modelo toda la semana.

  Escenario: Hay muchos modelos disponibles
    Dado el catálogo de modelos de enemigo
    Cuando se cuentan sus entradas
    Entonces hay al menos 14 modelos

  Escenario: Cada modelo tiene constructor y color
    Dado el catálogo de modelos de enemigo
    Cuando se revisa cada entrada
    Entonces tiene una función constructora y un color de cuerpo

  Escenario: La variante de un nombre siempre existe en el catálogo
    Dado el nombre de un jefe
    Cuando se calcula su variante
    Entonces el índice cae dentro del catálogo

  Escenario: El catálogo y la cantidad de variantes no se desincronizan
    Dado el catálogo de modelos de enemigo
    Cuando se compara con CANTIDAD_VARIANTES_ENEMIGO
    Entonces ambos valen lo mismo
