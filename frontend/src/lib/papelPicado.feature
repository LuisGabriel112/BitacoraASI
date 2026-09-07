Característica: Generación de banderines de papel picado (tema patrio)

  Escenario: Genera la cantidad pedida de banderines
    Dado que pido 9 banderines
    Cuando genero la lista
    Entonces obtengo 9 banderines

  Escenario: Los colores rotan verde, blanco, rojo en orden
    Dado que pido 6 banderines
    Cuando genero la lista
    Entonces los colores son verde, blanco, rojo, verde, blanco, rojo

  Escenario: El retraso de animación aumenta con cada banderín
    Dado que pido 4 banderines
    Cuando genero la lista
    Entonces cada banderín tiene más retraso que el anterior

  Escenario: Pedir cero banderines da una lista vacía
    Dado que pido 0 banderines
    Cuando genero la lista
    Entonces obtengo una lista vacía
