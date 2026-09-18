Característica: Volumen por sistema en el panel principal
  Para saber de un vistazo qué sistema concentra el trabajo de la semana
  Como persona de soporte operativo
  Quiero ver los sistemas ordenados por volumen con su peso relativo

  Escenario: Ordenar los sistemas de mayor a menor volumen
    Dado un conteo por sistema de Mediport 4, Pis 9 y Proactivanet 2
    Cuando calculo el volumen por sistema
    Entonces el primer sistema es Pis con 9
    Y el último sistema es Proactivanet con 2

  Escenario: La fracción se mide contra el sistema más alto
    Dado un conteo por sistema de Mediport 5 y Pis 10
    Cuando calculo el volumen por sistema
    Entonces la fracción de Pis es 1
    Y la fracción de Mediport es 0.5

  Escenario: Un panel sin registros no produce filas
    Dado un conteo por sistema vacío
    Cuando calculo el volumen por sistema
    Entonces la lista queda vacía

  Escenario: Los sistemas sin registros no se muestran
    Dado un conteo por sistema de Mediport 3 y Pis 0
    Cuando calculo el volumen por sistema
    Entonces la lista solo contiene a Mediport

  Escenario: Empate entre sistemas
    Dado un conteo por sistema de Mediport 4 y Pis 4
    Cuando calculo el volumen por sistema
    Entonces ambos sistemas tienen fracción 1
