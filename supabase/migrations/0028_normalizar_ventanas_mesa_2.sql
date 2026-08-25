-- Segunda pasada de normalización de ventanas_mesa (ver 0027): variantes por
-- typo, acento, mayúscula o redacción ligeramente distinta del mismo nombre.
-- Mismo mecanismo: reapunta las mesas a la fila canónica y borra la variante.

do $$
declare
  canonico text;
  variante text;
  id_canonico int;
  id_variante int;
  grupos text[][] := array[
    array['ASIGNACION DE VACACIONES', 'ASIGNACION VACACIONES'],
    array['CALCULO DE ESTIMACIONES', 'CALCULO ESTIMACIONES'],
    array['CANCELACION DE FACTURAS', 'CANCELACION FACTURAS'],
    array['FOLIOS DE SALIDA', 'FOLIOS SALIDA'],
    array['FOLIOS DE SALIDA', 'FOLIOS_SALIDA'],
    array['MODIFICACIONES AL CONTRATO', 'MODIFICACIONES Al CONTRATO'],
    array['NOTAS DE CREDITO', 'NOTA DE CREDITO'],
    array['PERSONAS AUTORIZADAS PARA FIRMAR CONTRATO', 'PERSONAS AUTIRIZADAS PARA FIRMAR CONTRATO'],
    array['REQUISICIONES', 'REQUISIONES'],
    array['SIIPv2', 'SIIPV2'],
    array['VALIDACION DE CFDI', 'VALIDACION CFDI'],
    array['FACTURACIÓN ELECTRÓNICA', 'FACTURACION ELECTRONICA'],
    array['TRÁMITES ELECTRÓNICOS', 'TRAMITES ELECTRÓNICOS'],
    array['TRÁMITES ELECTRÓNICOS', 'TRAMITES ELECTRONICOS'],
    array['COMPROBACIÓN DE VIÁTICOS', 'COMPROBACION DE VIATICOS'],
    array['COMPROBACIÓN DE VIÁTICOS', 'COMPROBACION DE VIÁTICOS'],
    array['COMPROBACIÓN DE VIÁTICOS', 'COMPROBACION DE VÍATICOS'],
    array['COMPROBACIÓN DE VIÁTICOS', 'COMPROBACION VIATICOS'],
    array['COMPROBACIÓN DE VIÁTICOS', 'COMPROBACIONDEVIATICOS'],
    array['JUSTIFICACION DE INCIDENCIAS', 'JUSTIFICACION DE INCIDENCIA'],
    array['JUSTIFICACION DE INCIDENCIAS', 'JUSTIFICACIÓN DE INCIDENCIAS'],
    array['INVESTIGACION DE MERCADO', 'INVESTIGACIÓN DE MERCADO'],
    array['INVESTIGACION DE MERCADO', 'INVESTIGACION MERCADO'],
    array['INVESTIGACION DE MERCADO', 'INVESTIGACIONMERCADO'],
    array['SOLICITUDES DE CONTRATO', 'SOLICITUD DE CONTRATO'],
    array['SOLICITUDES DE CONTRATO', 'SOLICITUD DE CONTRATOS'],
    array['SOLICITUDES DE CONTRATO', 'SOLICITUDES DE CONTRATOS'],
    array['SOLICITUDES DE CONVENIOS', 'SOLICITUD DE CONVENIO'],
    array['SOLICITUDES DE CONVENIOS', 'SOLICITUDES DE CONVENIO'],
    array['COMPLEMENTOS DE PAGO', 'COMPLEMENTO DE PAGO'],
    array['COMPLEMENTOS DE PAGO', 'COMPLEMENTOS'],
    array['DETALLE DE PAGOS DEL CONTRATO', 'DETALLES DE PAGO DEL CONTRATO'],
    array['DETALLE DE PAGOS DEL CONTRATO', 'DETALLES DE PAGOS EL CONTRATO'],
    array['POLIZA VS ESTRUCTURA PROGRAMATICA', 'POLIZAS VS ESTRUCTURA PROGRAMATICA'],
    array['POLIZA VS ESTRUCTURA PROGRAMATICA', 'POLIZAS vs ESTRUCTURA PROGRAMATICA'],
    array['ESTADO DE SOLICITUDES DEL CONTRATO', 'ESTADO DE SOLICITUDES DE CONTRATO'],
    array['REQUISICIONES E INVESTIGACION DE MERCADO', 'REQUISICION E INVESTIGACION DE MERCADO'],
    array['REQUISICIONES E INVESTIGACION DE MERCADO', 'REQUISICIONES E INVESTIGACIONMERCADO'],
    array['REQUISICIONES E INVESTIGACION DE MERCADO', 'REQUISICION E INVESTIGACIONMERCADO'],
    array['REQUISICIONES E INVESTIGACION DE MERCADO', 'REQUISICIONES/INVESTIGACION DE MERCADO']
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
