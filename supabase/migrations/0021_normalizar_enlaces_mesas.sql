-- Mesas antiguas guardaron el enlace con el dominio viejo (asiponaver.proactivanet.com)
-- o en http:// antes de que Proactivanet migrara a mesadeayuda.puertodeveracruz.com.mx.
-- El resto de la ruta después de /proactivanet/... no cambió, solo el dominio.

update mesas
set enlace = 'https://mesadeayuda.puertodeveracruz.com.mx' || substring(enlace from position('/proactivanet' in enlace))
where enlace is not null
  and enlace <> ''
  and enlace not ilike 'https://mesadeayuda.puertodeveracruz.com.mx/%'
  and position('/proactivanet' in enlace) > 0;
