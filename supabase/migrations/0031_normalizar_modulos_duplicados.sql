-- El endpoint de creación de catálogo comparaba nombre = nombre (case-sensitive),
-- así que "Tramites E." y "tramites E." se guardaron como dos módulos distintos
-- y rompían las estadísticas del panel principal (se repartía el mismo módulo
-- real en dos rebanadas). El backend ya se corrigió para comparar sin importar
-- mayúsculas; esta migración funde la fila duplicada existente en la canónica.

do $$
declare
  id_canonico int;
  id_variante int;
begin
  select id into id_canonico from modulos where nombre = 'Tramites E.';
  select id into id_variante from modulos where nombre = 'tramites E.';

  if id_canonico is not null and id_variante is not null and id_canonico <> id_variante then
    update registros set modulo_id = id_canonico where modulo_id = id_variante;
    delete from modulos where id = id_variante;
  end if;
end $$;
