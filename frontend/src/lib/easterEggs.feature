Característica: Easter egg del primer soporte de Atzimba Torres
  Como parte del equipo
  Quiero un sonido especial la primera vez que Atzimba Torres registra un soporte
  Para celebrar ese momento puntual sin afectar a nadie más

  Escenario: Es el primer soporte de Atzimba Torres
    Dado que el agente seleccionado es "Atzimba Torres"
    Y el total de soportes atendidos por ese agente (incluyendo el recién creado) es 1
    Cuando se evalúa si aplica el easter egg
    Entonces aplica el easter egg

  Escenario: No es el primer soporte de Atzimba Torres
    Dado que el agente seleccionado es "Atzimba Torres"
    Y el total de soportes atendidos por ese agente es 2 o más
    Cuando se evalúa si aplica el easter egg
    Entonces no aplica el easter egg

  Escenario: El agente no es Atzimba Torres
    Dado que el agente seleccionado es "Juan Pérez"
    Y es su primer soporte
    Cuando se evalúa si aplica el easter egg
    Entonces no aplica el easter egg

  Escenario: El nombre coincide sin distinguir mayúsculas ni espacios extra
    Dado que el agente seleccionado es "  atzimba   torres "
    Y es su primer soporte
    Cuando se evalúa si aplica el easter egg
    Entonces aplica el easter egg
