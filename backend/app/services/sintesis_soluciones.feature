Característica: Agrupar mesas para sintetizar soluciones repetidas

  Escenario: Mesas de la misma categoria y tipo de solucion se agrupan
    Dado 3 mesas con categoria_id=1 y tipo_solucion="Modificación en BD"
    Cuando se agrupan por categoria y tipo
    Entonces queda un grupo con esas 3 mesas

  Escenario: Grupos con menos del minimo se descartan
    Dado 2 mesas con la misma categoria_id y tipo_solucion
    Cuando se agrupan por categoria y tipo
    Entonces no aparece ningún grupo para esas mesas

  Escenario: Categorias distintas nunca se agrupan juntas
    Dado 3 mesas con categoria_id=1 y 3 mesas con categoria_id=2, mismo tipo_solucion
    Cuando se agrupan por categoria y tipo
    Entonces resultan dos grupos separados

  Escenario: La muestra representativa quita duplicados exactos y respeta el limite
    Dado una lista de soluciones con textos repetidos y más de "limite" únicos
    Cuando se toma la muestra representativa
    Entonces no hay duplicados y el tamaño no excede "limite"
