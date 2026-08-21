Característica: Pegar fecha copiada de Proactivanet en campos de fecha/hora
  Como usuario que copia el ticket desde Proactivanet
  Quiero pegar una fecha tipo "05/08/2026 10:36" en los campos de fecha
  Para no tener que escribirla ni seleccionarla a mano

  Escenario: Pegar fecha con formato exacto DD/MM/AAAA HH:mm
    Dado que el portapapeles contiene "05/08/2026 10:36"
    Cuando se pega en un campo de fecha y hora
    Entonces el campo toma el valor "2026-08-05T10:36"

  Escenario: Pegar fecha con espacio no separable (copiado de una tabla web)
    Dado que el portapapeles contiene "05/08/2026 10:36"
    Cuando se pega en un campo de fecha y hora
    Entonces el campo toma el valor "2026-08-05T10:36"

  Escenario: Pegar fecha con texto alrededor
    Dado que el portapapeles contiene "Fecha: 05/08/2026 10:36 hrs"
    Cuando se pega en un campo de fecha y hora
    Entonces el campo toma el valor "2026-08-05T10:36"

  Escenario: Pegar texto que no es una fecha
    Dado que el portapapeles contiene "TCK-001"
    Cuando se pega en un campo de fecha y hora
    Entonces el campo conserva su valor anterior

  Escenario: Mostrar una fecha guardada en formato legible
    Dado que el valor guardado es "2026-08-06T15:49"
    Cuando se formatea para mostrar en el campo de texto
    Entonces se muestra "06/08/2026 15:49"

  Escenario: No hay nada que mostrar todavía
    Dado que el valor guardado está vacío
    Cuando se formatea para mostrar en el campo de texto
    Entonces se muestra una cadena vacía

Característica: Obtener la fecha y hora actual en formato datetime-local
  Como usuario capturando el cierre de una mesa
  Quiero un botón/clic que tome la fecha y hora actuales
  Para no escribirlas a mano

  Escenario: Convertir una fecha dada al formato datetime-local con ceros a la izquierda
    Dado un instante "2026-01-05T03:07:00" (mes, día, hora y minuto de un solo dígito)
    Cuando pido la fecha y hora actual en formato de campo
    Entonces obtengo "2026-01-05T03:07"
