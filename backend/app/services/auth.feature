Característica: Autenticación por PIN
  Como agente/resolutor de la bitácora
  Quiero iniciar sesión con mi nombre y un PIN
  Para que la app sepa quién soy sin necesidad de correo ni contraseña larga

  Escenario: El PIN correcto verifica contra su propio hash
    Dado que un usuario se registró con el PIN "1234"
    Cuando verifica ese mismo PIN contra el hash guardado
    Entonces la verificación es exitosa

  Escenario: Un PIN incorrecto no verifica
    Dado que un usuario se registró con el PIN "1234"
    Cuando verifica el PIN "9999" contra el hash guardado
    Entonces la verificación falla

  Escenario: Un token recién creado se puede leer de vuelta
    Dado que se crea un token de sesión para el usuario 42
    Cuando se lee ese token
    Entonces el usuario_id obtenido es 42

  Escenario: Un token vencido no es válido
    Dado que existe un token cuya fecha de expiración ya pasó
    Cuando se lee ese token
    Entonces no se obtiene ningún usuario_id

  Escenario: Un token con firma inválida no es válido
    Dado que existe una cadena que no es un token firmado por esta app
    Cuando se lee ese token
    Entonces no se obtiene ningún usuario_id

  Escenario: Cuenta bloqueada tras demasiados intentos fallidos
    Dado que un usuario acumula 5 intentos fallidos de PIN
    Cuando se evalúa si debe bloquearse
    Entonces la cuenta debe bloquearse

  Escenario: Cuenta bloqueada sigue bloqueada mientras no pase el tiempo de bloqueo
    Dado que un usuario tiene bloqueo activo hasta dentro de 5 minutos
    Cuando se consulta si sigue bloqueado en este momento
    Entonces sigue bloqueado

  Escenario: El bloqueo expira solo con el tiempo
    Dado que un usuario tenía un bloqueo que ya venció
    Cuando se consulta si sigue bloqueado en este momento
    Entonces ya no sigue bloqueado

  Escenario: Nombres con espacios extra o mayúsculas distintas se normalizan igual
    Dado los nombres "  Juan Pérez  " y "juan   pérez"
    Cuando se normalizan ambos
    Entonces el resultado normalizado es el mismo para los dos

  Escenario: Usuario con actividad reciente está en línea
    Dado que la última actividad fue hace 10 segundos
    Cuando se consulta si está en línea ahora
    Entonces está en línea

  Escenario: Usuario sin actividad reciente no está en línea
    Dado que la última actividad fue hace 5 minutos
    Cuando se consulta si está en línea ahora (umbral de 90 segundos)
    Entonces no está en línea

  Escenario: Usuario que nunca ha mandado heartbeat no está en línea
    Dado que la última actividad es nula (nunca se conectó)
    Cuando se consulta si está en línea ahora
    Entonces no está en línea
