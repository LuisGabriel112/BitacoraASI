Característica: Decidir si redirigir a login segun el estado de sesion

  Escenario: Sesion valida no redirige
    Dado que el backend respondio /auth/me con ok
    Cuando se evalua si redirigir
    Entonces no se redirige a login

  Escenario: Sesion invalida redirige
    Dado que el backend respondio /auth/me sin ok
    Cuando se evalua si redirigir
    Entonces se redirige a login
