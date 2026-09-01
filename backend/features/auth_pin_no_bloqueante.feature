# language: es
Característica: Hash de PIN no bloquea el event loop
  Como usuario que hace login o registro al mismo tiempo que otros
  Quiero que verificar/crear mi PIN no congele el servidor para todos
  Para que juegos, chat y paneles sigan respondiendo durante un login

  Escenario: Crear el hash del PIN corre en un hilo aparte
    Dado un PIN en texto plano
    Cuando se pide su hash
    Entonces se calcula fuera del event loop principal
    Y el hash resultante verifica correctamente contra el mismo PIN

  Escenario: Verificar el PIN correcto corre en un hilo aparte
    Dado un PIN y su hash ya calculado
    Cuando se verifica el PIN correcto
    Entonces se calcula fuera del event loop principal
    Y el resultado es verdadero

  Escenario: Verificar un PIN incorrecto corre en un hilo aparte
    Dado un PIN y el hash de un PIN distinto
    Cuando se verifica el PIN incorrecto
    Entonces se calcula fuera del event loop principal
    Y el resultado es falso
