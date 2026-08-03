# language: es
Característica: Código de mesa único
  Como responsable de soporte administrativo
  Quiero que el código de una mesa de Proactivanet no se pueda duplicar
  Para no capturar la misma mesa dos veces por error

  Escenario: Crear una mesa con código nuevo
    Dado que no existe ninguna mesa con código "TCK-001"
    Cuando creo una mesa con código "TCK-001"
    Entonces la mesa se guarda correctamente

  Escenario: Crear una mesa con código repetido
    Dado que ya existe una mesa con código "TCK-001"
    Cuando intento crear otra mesa con código "TCK-001"
    Entonces recibo un error 409
    Y no se crea una fila duplicada
