# language: es
Característica: Bono de XP/daño por horario tardío, volumen alto y golpes críticos
  Como equipo de soporte y mesas
  Quiero que las acciones en horario pico o de alto volumen valgan más
  Para incentivar cerrar tickets en los momentos más difíciles del día

  Escenario: Bono de hora tardía se aplica si la regla está activa y la hora coincide
    Dado la regla "hora_cierre_tardio" activa con 20%
    Cuando calculo el bono a las 17:30 con actividad baja en el día
    Entonces el porcentaje de bono es 20 e incluye la etiqueta de esa regla

  Escenario: Bono de hora tardía no se aplica si la regla está inactiva
    Dado la regla "hora_cierre_tardio" inactiva con 20%
    Cuando calculo el bono a las 17:30 con actividad baja en el día
    Entonces el porcentaje de bono es 0

  Escenario: Bono de volumen alto se aplica si el conteo llega al umbral
    Dado la regla "volumen_alto_dia" activa con 15%
    Cuando calculo el bono con 10 o más mesas+soportes en el día
    Entonces el porcentaje de bono es 15 e incluye la etiqueta de esa regla

  Escenario: Ambos bonos se suman si las dos condiciones se cumplen
    Dado las reglas "hora_cierre_tardio" (20%) y "volumen_alto_dia" (15%) activas
    Cuando calculo el bono a las 17:30 con 10 o más mesas+soportes en el día
    Entonces el porcentaje de bono es 35 e incluye ambas etiquetas

  Escenario: Sin reglas configuradas no hay bono
    Dado que no hay ninguna regla de bono
    Cuando calculo el bono en cualquier momento
    Entonces el porcentaje de bono es 0 y no hay etiquetas

  Escenario: Golpe crítico por horario (últimos 10 minutos del día)
    Cuando se evalúa si es crítico a las 23:50
    Entonces es crítico

  Escenario: No es crítico por horario antes de las 23:50
    Cuando se evalúa si es crítico a las 23:49
    Entonces no es crítico por horario

  Escenario: Golpe crítico por ser múltiplo de 5 soportes del día
    Cuando el soporte es el número 5, 10 o 15 del día
    Entonces es crítico por soportes

  Escenario: No es crítico si el conteo de soportes es 0 o no es múltiplo de 5
    Cuando el soporte es el número 0, 3 o 4 del día
    Entonces no es crítico por soportes

  Escenario: Aplicar solo el porcentaje de bono (sin crítico)
    Dado una cantidad base de 100 y un bono de 20%
    Cuando aplico el bono sin golpe crítico
    Entonces el resultado es 120

  Escenario: Aplicar solo el golpe crítico (sin bono)
    Dado una cantidad base de 100 y un bono de 0%
    Cuando aplico el golpe crítico
    Entonces el resultado es 200 (se duplica)

  Escenario: Bono y crítico se combinan
    Dado una cantidad base de 100 y un bono de 20%
    Cuando aplico el bono y el golpe crítico juntos
    Entonces el resultado es 240

  Escenario: El resultado nunca baja de 1
    Dado una cantidad base de 0
    Cuando aplico cualquier combinación de bono y crítico
    Entonces el resultado nunca es menor a 1

  Escenario: El porcentaje de bono del momento combina reglas activas y actividad del día
    Dado reglas activas en base de datos y un conteo de actividad del día
    Cuando pido el porcentaje de bono de un momento
    Entonces se consulta la base de datos una vez por reglas y una vez por conteo
    Y el resultado es el mismo que calcular_bono con esos datos

  Escenario: Un soporte es crítico si cae en horario tardío, aunque no sea múltiplo de 5
    Dado que el conteo de soportes del día no es múltiplo de 5
    Cuando el soporte ocurre a las 23:55
    Entonces se considera crítico

  Escenario: Un soporte es crítico si es múltiplo de 5, aunque no sea horario tardío
    Dado que el soporte ocurre a mediodía
    Cuando es el quinto soporte del día
    Entonces se considera crítico
