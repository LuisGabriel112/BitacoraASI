Característica: Variante de modelo 3D determinista por nombre de jefe

  Escenario: El mismo nombre siempre da la misma variante
    Dado un nombre "El SLA Vencido"
    Cuando pido su variante de enemigo dos veces
    Entonces obtengo la misma variante las dos veces

  Escenario: La variante siempre es un indice valido
    Dado varios nombres de jefe distintos
    Cuando pido la variante de cada uno
    Entonces cada indice esta entre 0 y CANTIDAD_VARIANTES_ENEMIGO - 1

  Escenario: Nombres distintos pueden dar variantes distintas
    Dado varios nombres de jefe distintos
    Cuando pido la variante de cada uno
    Entonces no estan forzados a la misma variante
