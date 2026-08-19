Característica: Registro de iconos SVG reemplaza a los emoji de la interfaz

  Escenario: Cada icono tiene contenido SVG valido
    Dado el registro de iconos ICONOS
    Cuando reviso cada entrada
    Entonces ninguna esta vacia y todas empiezan con una etiqueta SVG

  Escenario: No hay nombres de icono duplicados o mal escritos
    Dado el registro de iconos ICONOS
    Cuando pido un icono por nombre conocido
    Entonces obtengo su marcado, no undefined
