Característica: Validación de apariencia del personaje 3D
  Como usuario creando o editando mi personaje
  Quiero que el backend rechace colores/accesorios inválidos
  Para que el modelo 3D nunca reciba datos que no sepa dibujar

  Escenario: Un color hex válido se acepta
    Dado el color "#3b82f6"
    Cuando se valida como color de piel o cuerpo
    Entonces se acepta

  Escenario: Un color sin formato hex se rechaza
    Dado el color "azul"
    Cuando se valida como color de piel o cuerpo
    Entonces se rechaza

  Escenario: Un color hex corto (3 dígitos) se rechaza
    Dado el color "#fff"
    Cuando se valida como color de piel o cuerpo
    Entonces se rechaza

  Escenario: Un accesorio de la lista se acepta
    Dado el accesorio "gorra"
    Cuando se valida el accesorio
    Entonces se acepta

  Escenario: Un accesorio fuera de la lista se rechaza
    Dado el accesorio "sombrero"
    Cuando se valida el accesorio
    Entonces se rechaza

  Escenario: El registro sin apariencia usa los valores por defecto
    Dado un registro sin color_piel/color_cuerpo/accesorio
    Cuando se valida el payload de registro
    Entonces toma los valores por defecto (piel clara, azul, sin accesorio)
