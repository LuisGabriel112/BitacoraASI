Característica: Aviso sonoro y visual al guardar registro
  Como usuario que captura mesas o soportes en la bitácora
  Quiero escuchar un sonido y ver un popup de color
  Para saber sin leer texto si mi captura se guardó o falló

  Escenario: Mesa guardada con éxito
    Dado que envío un formulario de mesa con todos los campos completos
    Cuando el servidor confirma que se guardó la mesa
    Entonces se reproduce el sonido que elegí para "guardar mesa" en /sonidos (o uno de éxito al azar si no elegí)
    Y aparece un popup de color verde con el mensaje de éxito

  Escenario: Soporte guardado con éxito
    Dado que envío un formulario de soporte con todos los campos completos
    Cuando el servidor confirma que se guardó el registro
    Entonces se reproduce la fanfarria mariachi sintetizada
    Y aparece un popup de color verde con el mensaje de éxito

  Escenario: Falta un campo obligatorio
    Dado que envío un formulario de mesa o soporte con un campo obligatorio vacío
    Cuando la validación detecta el campo faltante
    Entonces se reproduce el sonido que elegí para "mensaje de error" (o uno de error al azar si no elegí)
    Y aparece un popup de color rojo con el mensaje de qué falta

  Escenario: El servidor rechaza el guardado
    Dado que envío un formulario de mesa o soporte completo
    Cuando el servidor responde con un error al guardar
    Entonces se reproduce el sonido de error que me corresponde
    Y aparece un popup de color rojo con el mensaje de error

  Escenario: Silencié una acción en /sonidos
    Dado que marqué "sin sonido" para mensaje de error
    Cuando falla un guardado
    Entonces aparece el popup rojo pero no suena nada

  Escenario: El catálogo no pudo cargarse
    Dado que el backend no respondió al pedir el catálogo de sonidos
    Cuando se guarda o falla un formulario
    Entonces suena uno del pool fijo de respaldo de la categoría correspondiente

  Escenario: Confeti al guardar un soporte con éxito
    Dado que envío un formulario de soporte con todos los campos completos
    Cuando el servidor confirma que se guardó el registro
    Entonces se muestra la animación de confeti
