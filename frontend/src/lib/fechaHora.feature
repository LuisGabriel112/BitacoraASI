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
