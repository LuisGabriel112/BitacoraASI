Característica: Easter egg del primer soporte del día de Atzimba Torres
  Como parte del equipo
  Quiero un sonido especial cada día que Atzimba Torres atiende su primer soporte
  Para celebrar ese momento sin depender de su historial completo

  Nota: se reusa el logro "primer_soporte_dia_agente" que el backend ya calcula
  (evaluar_logros_registro) — evita repetir la cuenta de soportes del día en el
  frontend, y evita el bug anterior de comparar contra el total histórico (que
  para un agente con soportes previos a esta función nunca vuelve a ser 1).

  Escenario: Es el primer soporte del día de Atzimba Torres
    Dado que el agente seleccionado es "Atzimba Torres"
    Y los logros del registro creado incluyen "primer_soporte_dia_agente"
    Cuando se evalúa si aplica el easter egg
    Entonces aplica el easter egg

  Escenario: No es su primer soporte del día
    Dado que el agente seleccionado es "Atzimba Torres"
    Y los logros del registro creado NO incluyen "primer_soporte_dia_agente"
    Cuando se evalúa si aplica el easter egg
    Entonces no aplica el easter egg

  Escenario: El agente no es Atzimba Torres
    Dado que el agente seleccionado es "Juan Pérez"
    Y los logros incluyen "primer_soporte_dia_agente"
    Cuando se evalúa si aplica el easter egg
    Entonces no aplica el easter egg

  Escenario: El nombre coincide sin distinguir mayúsculas ni espacios extra
    Dado que el agente seleccionado es "  atzimba   torres "
    Y los logros incluyen "primer_soporte_dia_agente"
    Cuando se evalúa si aplica el easter egg
    Entonces aplica el easter egg
