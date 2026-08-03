# language: es
Característica: Cierre de mesas
  Como responsable de soporte administrativo
  Quiero cerrar una mesa registrando solución, tipo de solución y fecha real de cierre
  Para saber qué mesas siguen abiertas sin agregar una columna de estado redundante

  Escenario: Cerrar una mesa abierta
    Dado una mesa abierta (sin fecha de cierre real)
    Cuando la cierro con solución, tipo de solución y fecha de cierre
    Entonces la mesa queda con esos 3 campos guardados
    Y se considera cerrada (fecha_cierre_real ya no es nula)

  Escenario: Cerrar una mesa que ya está cerrada
    Dado una mesa que ya tiene fecha de cierre real
    Cuando intento cerrarla de nuevo
    Entonces recibo un error 400 ("La mesa ya está cerrada")

  Escenario: Cerrar una mesa que no existe
    Dado que no existe ninguna mesa con ese id
    Cuando intento cerrarla
    Entonces recibo un error 404

  Escenario: Filtrar por estado en el listado
    Dado un conjunto de mesas, algunas con fecha_cierre_real y otras sin ella
    Cuando filtro el listado por estado "abierta"
    Entonces solo obtengo las mesas sin fecha_cierre_real
    Cuando filtro el listado por estado "cerrada"
    Entonces solo obtengo las mesas con fecha_cierre_real
