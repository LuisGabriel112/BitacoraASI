Característica: Captura del tiempo de atención de un soporte
  Como agente capturando un soporte (llamada o mesa)
  Quiero anotar cuántos minutos me tomó atenderlo
  Para medir después el esfuerzo real de cada soporte

  Escenario: Un tiempo en minutos válido se convierte a número
    Dado el texto "45"
    Cuando se parsea el tiempo de atención
    Entonces devuelve 45 minutos sin error

  Escenario: Dejar el campo vacío es válido y no registra tiempo
    Dado el texto ""
    Cuando se parsea el tiempo de atención
    Entonces devuelve nulo sin error

  Escenario: Un texto que no es número se rechaza
    Dado el texto "media hora"
    Cuando se parsea el tiempo de atención
    Entonces devuelve error "El tiempo debe ser un número entero de minutos"

  Escenario: Un tiempo de cero o negativo se rechaza
    Dado el texto "0"
    Cuando se parsea el tiempo de atención
    Entonces devuelve error "El tiempo debe estar entre 1 y 1440 minutos"

  Escenario: Un tiempo mayor a una jornada de 24 horas se rechaza
    Dado el texto "1441"
    Cuando se parsea el tiempo de atención
    Entonces devuelve error "El tiempo debe estar entre 1 y 1440 minutos"

  Escenario: Un tiempo con decimales se rechaza
    Dado el texto "12.5"
    Cuando se parsea el tiempo de atención
    Entonces devuelve error "El tiempo debe ser un número entero de minutos"

  Escenario: Los minutos se muestran como horas y minutos legibles
    Dados 95 minutos
    Cuando se formatea el tiempo de atención
    Entonces devuelve "1 h 35 min"

  Escenario: Menos de una hora se muestra solo en minutos
    Dados 45 minutos
    Cuando se formatea el tiempo de atención
    Entonces devuelve "45 min"

  Escenario: Sin tiempo capturado se muestra un guion
    Dado un tiempo nulo
    Cuando se formatea el tiempo de atención
    Entonces devuelve "—"
