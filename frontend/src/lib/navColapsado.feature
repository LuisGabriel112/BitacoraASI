Característica: Ocultar la barra lateral
  Para trabajar con la tabla y las gráficas a ancho completo
  Como persona de soporte operativo
  Quiero colapsar la barra lateral y que siga colapsada la próxima vez

  Escenario: La barra arranca visible la primera vez
    Dado un almacenamiento sin la preferencia guardada
    Cuando leo el estado de la barra
    Entonces la barra no está colapsada

  Escenario: Recordar que la barra quedó colapsada
    Dado un almacenamiento con la preferencia en colapsada
    Cuando leo el estado de la barra
    Entonces la barra está colapsada

  Escenario: Guardar que la barra se colapsó
    Dado un almacenamiento vacío
    Cuando guardo el estado colapsado
    Entonces el almacenamiento conserva la preferencia en colapsada

  Escenario: Guardar que la barra se volvió a mostrar
    Dado un almacenamiento con la preferencia en colapsada
    Cuando guardo el estado no colapsado
    Entonces el almacenamiento conserva la preferencia en no colapsada

  Escenario: Un almacenamiento no disponible no rompe la pantalla
    Dado que no hay almacenamiento
    Cuando leo el estado de la barra
    Entonces la barra no está colapsada

  Escenario: Un valor corrupto se trata como barra visible
    Dado un almacenamiento con el valor "quizás"
    Cuando leo el estado de la barra
    Entonces la barra no está colapsada
