# language: es
Característica: Cerrar una mesa desde su creación
  Como responsable de soporte administrativo
  Quiero poder capturar una mesa ya resuelta con su solución de una vez
  Para no tener que crear y luego editar cuando ya se sabe la solución

  Escenario: Crear una mesa abierta (sin info de cierre)
    Dado los datos de apertura sin solución, tipo de solución ni fecha de cierre
    Cuando construyo el MesaCreate
    Entonces se acepta sin error

  Escenario: Crear una mesa ya cerrada, con los 3 campos de cierre
    Dado los datos de apertura más solución, tipo de solución y fecha real de cierre
    Cuando construyo el MesaCreate
    Entonces se acepta sin error

  Escenario: Rechazar cierre parcial al crear
    Dado los datos de apertura con solo la solución (sin tipo ni fecha de cierre)
    Cuando construyo el MesaCreate
    Entonces se rechaza con un error de validación
