# language: es
Característica: Consulta de usuarios en línea filtra en la base de datos
  Como responsable de rendimiento de la bitácora
  Quiero que /auth/en-linea filtre "en línea" en SQL en vez de traer toda
  la tabla de usuarios y filtrar en Python
  Para que el polling cada 10s desde /hub no cargue filas de más conforme
  crece la cantidad de usuarios

  Escenario: La consulta ya no depende del filtro en Python
    Dado el endpoint /auth/en-linea
    Cuando construyo la consulta de usuarios
    Entonces la condición de "en línea" queda en el WHERE de la consulta SQL
    Y ya no se descarta ningún usuario en el código Python después de traerlos
