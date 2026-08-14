# language: es
Característica: Búsqueda de mesas para reusar soluciones anteriores
  Como responsable de soporte administrativo
  Quiero buscar mesas anteriores por código, título, solicitante, descripción o solución
  Para copiar y pegar una solución ya usada sin tener que recordar la mesa exacta

  Escenario: Buscar coincide con el nombre del solicitante
    Dado una mesa cuyo solicitante se llama "Contraloría Portuaria"
    Cuando busco el texto "Contraloría"
    Entonces esa mesa aparece en el resultado

  Escenario: Buscar sigue coincidiendo con código, título, descripción o solución
    Dado mesas que coinciden por código, por título, por descripción o por solución
    Cuando busco un texto que aparece en cualquiera de esos campos
    Entonces cada una aparece en el resultado

  Escenario: Buscar vacío no agrega ningún filtro extra
    Dado el listado sin texto de búsqueda
    Cuando se construye la consulta
    Entonces no se agrega ningún JOIN ni condición de búsqueda de texto

  Escenario: Filtrar mesas con actividad reciente (abiertas o cerradas desde una fecha)
    Dado mesas cargadas o cerradas en distintas fechas
    Cuando filtro por actividad desde una fecha
    Entonces obtengo las mesas cuya fecha de carga o fecha de cierre real es igual o posterior a esa fecha
    Y no obtengo las que no tuvieron actividad desde entonces
