Característica: Logros de la bitácora operativa (soporte)
  Como agente de soporte
  Quiero lograr insignias por cuándo y cuántos soportes atiendo
  Para que la bitácora operativa tenga el mismo tipo de gamificación que mesas

  Escenario: Soporte atendido antes de que empiece la jornada
    Dado que se registra un soporte a las 8:59am
    Cuando se evalúan las reglas de horario de soporte
    Entonces el logro es "antes_de_jornada_soporte"

  Escenario: Soporte atendido en la recta final del día
    Dado que se registra un soporte a las 5:30pm
    Cuando se evalúan las reglas de horario de soporte
    Entonces el logro es "ultimas_del_dia_soporte"

  Escenario: Soporte atendido un sábado
    Dado que se registra un soporte un sábado al mediodía
    Cuando se evalúan las reglas de horario de soporte
    Entonces el logro es "sabado_guardia_soporte"

  Escenario: Las claves de soporte son distintas a las de mesas
    Dado el mismo momento exacto
    Cuando se evalúan las reglas de horario normales (mesas) y las de soporte
    Entonces ninguna clave se repite entre ambos conjuntos
