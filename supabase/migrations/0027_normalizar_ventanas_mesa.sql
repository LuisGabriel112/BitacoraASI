-- El catálogo ventanas_mesa (importado en 0016 desde bitácoras históricas)
-- quedó con variantes de un mismo nombre por como cada quien las escribía:
-- singular/plural o repetido con leve variación de redacción. Se unifican
-- bajo el nombre canónico, reapuntando las mesas que usaban la variante y
-- borrando después la fila duplicada del catálogo.

do $$
declare
  canonico text;
  variante text;
  id_canonico int;
  id_variante int;
  grupos text[][] := array[
    array['CAMBIOS DE FECHA', 'CAMBIO DE FECHA'],
    array['CAMBIOS DE FECHA', 'CAMBIO DE FECHAS'],
    array['PEDIDOS', 'PEDIDO'],
    array['RECEPCION DE CFDI', 'RECEPCION CFDI'],
    array['RECEPCION DE CFDI', 'RECEPCION DE CFDIS']
  ];
  grupo text[];
begin
  foreach grupo slice 1 in array grupos loop
    canonico := grupo[1];
    variante := grupo[2];

    select id into id_canonico from ventanas_mesa where nombre = canonico;
    select id into id_variante from ventanas_mesa where nombre = variante;

    if id_canonico is not null and id_variante is not null and id_canonico <> id_variante then
      update mesas set ventana_id = id_canonico where ventana_id = id_variante;
      delete from ventanas_mesa where id = id_variante;
    end if;
  end loop;
end $$;
