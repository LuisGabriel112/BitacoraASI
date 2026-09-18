# language: es
Característica: Créditos según el tipo de trabajo registrado
  Soporte administrativo solo abre y cierra mesas, y son muchas menos que los
  soportes que atiende soporte operativo. Pagar lo mismo por cada evento hacía
  que una sola mesa (creada + cerrada) rindiera más que varios soportes.

  Escenario: Un soporte operativo cobra la tarifa completa
    Dado el motivo "registro_creado"
    Cuando se calculan sus créditos
    Entonces recibe 8 créditos

  Escenario: Abrir una mesa paga poco
    Dado el motivo "mesa_creada"
    Cuando se calculan sus créditos
    Entonces recibe 2 créditos

  Escenario: Cerrar una mesa paga poco
    Dado el motivo "mesa_cerrada"
    Cuando se calculan sus créditos
    Entonces recibe 3 créditos

  Escenario: Un motivo desconocido cobra la tarifa completa
    Dado un motivo que no está en la tabla de tarifas
    Cuando se calculan sus créditos
    Entonces recibe 8 créditos
