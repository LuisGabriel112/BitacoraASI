Característica: Restringir acceso por IP de red autorizada

  Escenario: IP configurada tiene acceso
    Dado que la lista de IPs permitidas incluye "189.240.215.209"
    Cuando alguien entra desde "189.240.215.209"
    Entonces se le permite el acceso

  Escenario: IP no configurada no tiene acceso
    Dado que la lista de IPs permitidas incluye "189.240.215.209"
    Cuando alguien entra desde "1.2.3.4"
    Entonces se le niega el acceso

  Escenario: Localhost siempre tiene acceso (desarrollo local)
    Cuando alguien entra desde "127.0.0.1" o "::1"
    Entonces se le permite el acceso, sin importar la configuración

  Escenario: Varias IPs separadas por coma
    Dado que la lista de IPs permitidas es "189.240.215.209, 200.1.2.3"
    Cuando alguien entra desde "200.1.2.3"
    Entonces se le permite el acceso
