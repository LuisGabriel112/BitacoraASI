# language: es
Característica: Ranking de soportes frecuentes por tema
  Como responsable de soporte
  Quiero ver qué temas de soporte se repiten en la semana
  Para priorizar mejoras sin importar quién atendió cada caso

  Escenario: Agrupar descripciones similares por significado
    Dado un conjunto de embeddings donde los índices 0 y 2 son semánticamente similares (coseno >= umbral)
    Y el índice 1 es distinto a los demás
    Cuando agrupo por similitud con umbral 0.86
    Entonces obtengo un grupo con los índices 0 y 2
    Y obtengo un grupo separado con solo el índice 1
    Y los grupos están ordenados de mayor a menor tamaño

  Escenario: Vectores idénticos siempre caen en el mismo grupo
    Dado dos embeddings idénticos
    Cuando agrupo por similitud con cualquier umbral <= 1.0
    Entonces ambos quedan en el mismo grupo

  Escenario: Elegir el tema representativo de un grupo
    Dado un grupo con las descripciones "Cambio contraseña", "Cambio contraseña", "Cambiar contraseña"
    Cuando calculo el tema del grupo
    Entonces el tema es "Cambio contraseña" (la más repetida)

  Escenario: Desempate de tema por longitud cuando no hay repetidas
    Dado un grupo con las descripciones "Usuario bloqueado", "Bloqueo"
    Cuando calculo el tema del grupo
    Entonces el tema es "Bloqueo" (la más corta, ya que empatan en frecuencia)

  Escenario: Cachear embeddings ya calculados sin llamar a Gemini de nuevo
    Dado 3 registros donde 2 ya tienen embedding guardado y 1 no
    Cuando aseguro los embeddings de los 3 registros
    Entonces Gemini solo es llamado para el registro faltante
    Y el resultado incluye los 3 embeddings en el orden original
    Y el embedding nuevo se guarda en BD con una sola sentencia UPDATE en bloque

  Escenario: Todos los embeddings ya están cacheados
    Dado 3 registros que ya tienen embedding guardado
    Cuando aseguro los embeddings de los 3 registros
    Entonces Gemini no es llamado ninguna vez
    Y no se ejecuta ningún UPDATE en BD

  Escenario: Reintento ante error de cuota (429) hasta obtener éxito
    Dado que Gemini responde 429 dos veces y luego 200 con un embedding válido
    Cuando pido el embedding de un texto
    Entonces recibo el embedding sin error
    Y Gemini fue llamado exactamente 3 veces

  Escenario: Cuota excedida tras agotar los reintentos
    Dado que Gemini responde 429 en todos los intentos disponibles
    Cuando pido el embedding de un texto
    Entonces recibo un error GeminiError con el detalle de Gemini
