# language: es
Característica: Tienda de objetos que mejoran stats contra el jefe semanal
  Como usuario de la bitácora
  Quiero comprar objetos con créditos ganados por trabajo real
  Para mejorar mi daño, crítico, cooldown de minijuegos o XP esta semana

  Escenario: Comprar un objeto básico lo equipa y descuenta su costo
    Dado que tengo créditos suficientes
    Cuando compro un objeto básico
    Entonces el objeto queda equipado
    Y mis créditos disponibles bajan en el costo del objeto

  Escenario: Comprar un objeto combinado consume las 2 partes y cobra solo el extra
    Dado que tengo equipadas las 2 partes que pide un objeto combinado
    Cuando compro el objeto combinado
    Entonces las 2 partes ya no aparecen equipadas
    Y el objeto combinado sí aparece equipado
    Y mis créditos bajan solo el costo extra del combinado

  Escenario: No se puede comprar sin créditos suficientes
    Dado que no tengo créditos suficientes para un objeto
    Cuando intento comprarlo
    Entonces se rechaza la compra

  Escenario: No se puede comprar un combinado sin tener sus partes
    Dado que no tengo equipadas las partes que pide un objeto combinado
    Cuando intento comprarlo
    Entonces se rechaza la compra

  Escenario: No se puede comprar el mismo objeto dos veces en la semana
    Dado que ya tengo un objeto equipado
    Cuando intento comprarlo de nuevo
    Entonces se rechaza la compra

  Escenario: Los objetos y créditos son por semana
    Dado objetos comprados en una semana anterior
    Cuando consulto mi inventario y créditos de la semana actual
    Entonces no aparecen los de la semana anterior

  Escenario: Sin objetos equipados los bonos son cero
    Dado que no tengo ningún objeto equipado
    Cuando calculo mis bonos de stats
    Entonces todos los porcentajes son cero

  Escenario: Crear o cerrar una mesa, o crear un registro, da créditos
    Dado que resuelvo una mesa o creo un registro con mi cuenta vinculada
    Cuando se completa la acción
    Entonces gano créditos de tienda por esa acción
    Y no gano créditos por jugar minijuegos
