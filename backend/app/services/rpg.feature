Característica: Nivel y progreso del personaje a partir del XP acumulado
  Como usuario con un personaje en la bitácora
  Quiero que mi nivel, título y barra de progreso se calculen a partir de mi XP total
  Para que nunca haya un nivel guardado que se desincronice del XP real

  Escenario: Personaje nuevo empieza en nivel 1 sin progreso
    Dado que el XP total acumulado es 0
    Cuando se calcula el nivel y progreso
    Entonces el nivel es 1
    Y el XP en el nivel actual es 0
    Y el XP para el siguiente nivel es 100

  Escenario: XP negativo se trata como cero (dato corrupto o bug upstream)
    Dado que el XP total acumulado es -50
    Cuando se calcula el nivel y progreso
    Entonces el resultado es igual al de XP total 0

  Escenario: Justo antes del umbral no sube de nivel
    Dado que el XP total acumulado es 99
    Cuando se calcula el nivel y progreso
    Entonces el nivel es 1
    Y el XP en el nivel actual es 99

  Escenario: Justo en el umbral sube de nivel
    Dado que el XP total acumulado es 100
    Cuando se calcula el nivel y progreso
    Entonces el nivel es 2
    Y el XP en el nivel actual es 0

  Escenario: El título cambia según el nivel
    Dado que el nivel es 1, 4, 5, 9, 10, 24, 25, 49, 50, 99, 100, 149, 150,
      199, 200, 299, 300, 499 o 500
    Cuando se calcula el título del nivel
    Entonces los niveles 1-4 son "Aprendiz", 5-9 "Técnico", 10-24 "Veterano",
      25-49 "Experto", 50-99 "Maestro", 100-149 "Leyenda", 150-199 "Mítico",
      200-299 "Inmortal", 300-499 "Trascendente", 500+ "Divino"
