Característica: Resolver texto escrito en un combobox creatable sin exigir clic
  Como usuario capturando una mesa
  Quiero que escribir un nombre baste para seleccionarlo o crearlo
  Para no verme forzado a hacer clic en la opción o en "+ Crear"

  Escenario: El texto coincide exactamente con una opción existente (sin distinguir mayúsculas)
    Dado que las opciones del catálogo son "Redes", "Soporte", "Infraestructura"
    Cuando el texto escrito es "soporte"
    Entonces la coincidencia exacta encontrada es "Soporte"

  Escenario: El texto no coincide con ninguna opción existente
    Dado que las opciones del catálogo son "Redes", "Soporte"
    Cuando el texto escrito es "Redes y telecomunicaciones"
    Entonces no hay coincidencia exacta

  Escenario: El campo se guarda al salir sin haber hecho clic
    Dado que el usuario escribió "Soporte" en el campo y no hizo clic en ninguna opción
    Cuando el campo pierde el foco
    Entonces se selecciona automáticamente la opción "Soporte" existente

  Escenario: El campo crea la opción al salir si no existe
    Dado que el usuario escribió "Redes y telecomunicaciones" y no hizo clic en "+ Crear"
    Cuando el campo pierde el foco
    Entonces se crea automáticamente la opción "Redes y telecomunicaciones" y queda seleccionada
