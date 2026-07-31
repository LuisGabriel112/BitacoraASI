# language: es
Característica: Hoja de resumen con gráficas en la exportación a Excel
  Como responsable de soporte
  Quiero ver gráficas de días con más soportes y temas más frecuentes al exportar a Excel
  Para compartir un reporte visual sin armar las gráficas a mano

  Escenario: Contar registros por día
    Dado registros con fechas 2026-07-24 (x2) y 2026-07-25 (x1)
    Cuando calculo el conteo por día
    Entonces obtengo [("2026-07-24", 2), ("2026-07-25", 1)] ordenado por fecha

  Escenario: Sin registros no hay conteo por día
    Dado una lista vacía de registros
    Cuando calculo el conteo por día
    Entonces obtengo una lista vacía

  Escenario: Omitir temas frecuentes si Gemini no está configurado
    Dado que Gemini no está configurado
    Cuando calculo los temas frecuentes de los registros
    Entonces obtengo una lista vacía, sin llamar a Gemini ni fallar el export

  Escenario: Omitir temas frecuentes si falta el embedding de algún registro
    Dado que Gemini está configurado
    Y al menos un registro no tiene embedding guardado
    Cuando calculo los temas frecuentes de los registros
    Entonces obtengo una lista vacía (no se calculan embeddings nuevos durante el export)

  Escenario: Calcular temas frecuentes cuando todos los embeddings ya están cacheados
    Dado que Gemini está configurado
    Y todos los registros tienen embedding guardado
    Y dos descripciones son semánticamente similares entre sí y una tercera es distinta
    Cuando calculo los temas frecuentes de los registros
    Entonces obtengo un tema con cantidad 2
    Y el registro aislado no aparece (los grupos de 1 no cuentan como "frecuente")

  Escenario: La hoja Resumen siempre se crea, con o sin datos
    Dado cualquier lista de registros, incluso vacía
    Cuando genero el xlsx
    Entonces existe una hoja llamada "Resumen"
    Y no se lanza ninguna excepción

  Escenario: Las gráficas solo aparecen cuando hay datos que graficar
    Dado registros con al menos un día de datos y temas frecuentes calculables
    Cuando genero el xlsx
    Entonces el archivo contiene una gráfica de barras (por día) y una de pastel (por tema)

  Escenario: Sin temas frecuentes, no se agrega la gráfica de pastel
    Dado registros con datos por día pero sin temas frecuentes (Gemini no configurado)
    Cuando genero el xlsx
    Entonces el archivo contiene la gráfica de barras pero no la de pastel
