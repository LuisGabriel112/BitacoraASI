Característica: Aviso sonoro y visual al guardar registro
  Como usuario que captura mesas o soportes en la bitácora
  Quiero escuchar un sonido y ver un popup de color
  Para saber sin leer texto si mi captura se guardó o falló

  Escenario: Registro guardado con éxito
    Dado que envío un formulario de mesa o soporte con todos los campos completos
    Cuando el servidor confirma que se guardó el registro
    Entonces se reproduce el sonido "pop-succes.ogg"
    Y aparece un popup de color verde con el mensaje de éxito

  Escenario: Falta un campo obligatorio
    Dado que envío un formulario de mesa o soporte con un campo obligatorio vacío
    Cuando la validación detecta el campo faltante
    Entonces se reproduce el sonido "denied-ehh.ogg"
    Y aparece un popup de color rojo con el mensaje de qué falta

  Escenario: El servidor rechaza el guardado
    Dado que envío un formulario de mesa o soporte completo
    Cuando el servidor responde con un error al guardar
    Entonces se reproduce el sonido "denied-ehh.ogg"
    Y aparece un popup de color rojo con el mensaje de error

  Escenario: Confeti al guardar un soporte con éxito
    Dado que envío un formulario de soporte con todos los campos completos
    Cuando el servidor confirma que se guardó el registro
    Entonces se muestra la animación de confeti
