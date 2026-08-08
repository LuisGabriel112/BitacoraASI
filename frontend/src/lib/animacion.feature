Característica: Curva de easing para la animación 3D de éxito
  Como usuario que guarda un registro o mesa
  Quiero que el check 3D "rebote" al aparecer
  Para que se sienta como una confirmación satisfactoria, no un salto brusco

  Escenario: Al inicio (t=0) no hay avance
    Dado t = 0
    Cuando se aplica la curva easeOutBack
    Entonces el resultado es 0

  Escenario: Al final (t=1) llega exactamente a su tamaño final
    Dado t = 1
    Cuando se aplica la curva easeOutBack
    Entonces el resultado es 1

  Escenario: En algún punto intermedio se pasa de 1 (efecto rebote)
    Dado varios valores de t entre 0 y 1
    Cuando se aplica la curva easeOutBack a cada uno
    Entonces al menos uno de los resultados es mayor a 1
