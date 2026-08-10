-- Import de mesas historicas 2023 desde bitacoras mensuales. Requiere 0016 aplicada antes.
-- Idempotente: omite codigos que ya existan en mesas.

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2023-001331', 'CORRECCION IMPORTE CONVENIO', '2023-04-25 16:25:00', 'buen dia 

en relación al convenio 3 del contrato ASPN-GI--CO-62601-003-22, solicito su apoyo para adecuar el monto del mismo ya que al solicitarlo y tramitarlo el sistema tomo el importe como 11,902,886.86, siendo que el convenio se encuentra autorizado y formalizado por 11,902,887.75

quedo atento a sus comentarios 

saludos',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'González Martínez, Francisco de Jesus'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2025-09-10 12:49:00', 'Seguimiento de proceso, se brindo apoyo con la mesa antigua', 'Seguimiento de proceso', '2025-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2023-001331');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2023-001468', 'Solicitud de cambio de conceptos de Normal a Convenio.', '2023-05-05 09:51:00', 'Buenos días.
Referente al contrato ASPN-GI-CO-62601-002-22 de rubro: "MANTENIMIENTO GENERAL EN LAS EXPLANDAS 4,7,9,12,13 Y 14 , UBICADAS DENTRO DE LA BAHÍA SUR DEL PUERTO DE VERACRUZ". Se solicita su apoyo para poder permitir que el contratista pueda cargar los siguientes conceptos en la estimación 02-C, ya que actualmente sólo les aparecen para cargarlos como estimación convenio 5-N, quedando la estimación negativa ya que corresponden a conceptos en los que se realizan deductivas.
Los conceptos con sus claves del sistema son los siguientes:
1.6.1.80471   1F.C. SUMINISTRO Y COLOCACION DE REFUERZO PARA BARDA PERIMETRAL......
1.6.2.80471   2F.C. SUMINISTRO Y FRABRICACIÓN DE CASTILLO DE REFUERZO.................
1.6.2.80471   3F.C.  DEMOLICION DE MURO DE BLOCK EN BARDA PERIMETRAL.........
1.6.2.80471   4F.C.  DEMOLICION DE APLANADO EN BARDA PERIMETRAL , ESPESOR.........
1.6.2.80471   5F.C.   REPOSICION DE APLANADO EN BARDA PERIMETRAL, ESPESOR DE .........
1.6.2.80471   6F.C.   PERFORA HORIZONTAL DIRIGIDA PARA LA CONSTRUCCION DE BANCOS.......
1.6.2.80471   7F.C.   DEMOLICION DE MAQUINARIA Y/O MEDIOS MANUEALES DE CONCRETO HIDRAULICO ARMADO CON DOBLE..............
1.3.35.80335 35 SUMINISTRO Y COLOCACION DE PORTON..............
1.6.60.80335 60   CRUCE DIRIGIDO DE UNA VIA   FERREA PARA LA CONSTRUCCION.......
1.6.61.80335 61  CRUCE DIRIGIDO DOBLE  DE DOBLE VIA  FERREA PARA LA CONSTRUCCION DE BANCOS DE DUCTOS...........
QUEDAMOS ATENTOS A SU PRONTA ATENCION. GRACIAS',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Briano Rangel, Isaac Giovanni'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2025-09-10 13:09:00', 'Seguimiento de proceso, se brindo apoyo con la mesa antigua', 'Seguimiento de proceso', '2025-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2023-001468');

