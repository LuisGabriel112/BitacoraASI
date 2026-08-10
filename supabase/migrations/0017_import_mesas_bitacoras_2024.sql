-- Import de mesas historicas 2024 desde bitacoras mensuales. Requiere 0016 aplicada antes.
-- Idempotente: omite codigos que ya existan en mesas.

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-000990', 'MONTO USADO CERO / COBRO 425036', '2024-04-15 09:16:00', 'Buen día

Agradeceremos señalar en el cobro 425036 el   M. Usado " 0 " .

Cualquier duda o comentario quedamos a sus órdenes

Saludos',
  (select id from ventanas_mesa where nombre = 'COBROS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Cobros'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-04-15 14:16:00', 'Se hizo la modificacion en la tabla COBROS dentro del esquema FACTURACION, el campo MONTOUSADO se paso a 0', 'Modificación en BD', '2024-04-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-000990');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-000972', 'Cargar en papel factura', '2024-04-11 13:56:00', 'Buena tarde 

Solicito
 cargar en papel la factura con el folio en MEDIPORT 81495 por el monto 
de $261,629.62 del proveedor con RFC : RAMI861119DS0 RAMOS MANGE IVAN.
No me deja cargar los archivos me arroja error.
Anexo
 evidencia del error que arroja y los archivos PDF y XML. anteriormente 
ya a ocurrido el mismo erros con con las facturas del mismo proveedor , 
es un error en el XML.Quedo atento a sus comentarios. saludos',
  (select id from ventanas_mesa where nombre = 'TABLERO CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-15 10:48:00', 'Se dio soporte al usuario al "desbloquear" los candados en el tablero de cfdi en mediport para que el usuario pudiera cargar los archivos xml y pdf', 'Seguimiento de proceso', '2024-04-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-000972');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-000952', 'modificación de precio unitario', '2024-04-10 12:24:00', 'buenas tardes
solicito el apoyo para que en el sistema se pueda capturar el concepto fuera de catalogo ya autorizado y poder hacer estimación finiquito así como modificación de montos el cual no se puede realizar',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES Al CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras'),
  (select id from solicitantes_mesa where nombre = 'Deceano Ocampo, Isidro'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-04-15 11:15:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-000952');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-000999', 'CONCEPTO ACTA ENTREGA RECEPCIÓN DE SERVICIOS', '2024-04-15 14:01:00', 'Por este medio solicito de su apoyo para revisar por que al imprimir el acta entrega recepción de servicios de la solicitud 343, en los dos pagos realizados, no esta saliendo el concepto que se visualiza en el apartado cuando se selecciona artículos y esta saliendo otro concepto dice: Debe decir:

SERVICIOS GENERALES
ARRENDAMIENTO DE TRANSPORTE VEHICULAR TERRESTRE DENTRO DEL TERRITORIO NACIONAL PARA LOS EJERCICIOS FISCALES 2024 AL 2025 DE LA ADMINISTRACION DEL SISTEMA PORTUARIO NACIONAL VERACRUZ.


Quedo atenta a sus indicaciones.
Saludos cordiales.
Anexo evidencia donde se encuentra lo comentado.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-16 10:01:00', 'Se modificó la tabla SOLCONTRATOS en el campo "Objeto" se cambió el valor por "SERVICIOS GENERALES ARRENDAMIENTO DE TRANSPORTE VEHICULAR TERRESTRE DENTRO DEL TERRITORIO NACIONAL PARA LOS EJERCICIOS FISCALES 2024 AL 2025 DE LA ADMINISTRACION DEL SISTEMA PORTUARIO NACIONAL VERACRUZ."', 'Modificación en BD', '2024-04-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-000999');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001007', 'Solicitud de cambio de fecha', '2024-04-16 09:16:00', 'Hola buenos días 

Por medio de la presente solicito de la manera mas atenta su apoyo con le cambio de fecha de la requisición 132320 y la investigación de mercado 009775.

Fecha solicitada para ambas: 06/04/2024.

De antemano agradezco la atención, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-16 13:16:00', 'Se realizó cambio de fecha en la tabla REQUISICIONES e INVESTIGACIONMERCADO, para la requisición: 132320 en los campos FECHA, FECHAALTA, FECHAAUTOR01, FECHAREQUIERE y la investigación de mercado: 009775 en los campos FECHAALTA, FECHATRAMITO y FECHAAUTOR, a la fecha de 06/04/24', 'Modificación en BD', '2024-04-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001007');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001017', 'FACTURA SUBIDA EN LA BOVEDA', '2024-04-16 15:36:00', 'Por este medio solicito de su apoyo ya que al intentar subir la factura en el Portal de Mediport me indica que ya fue cargada en la bóveda, del folio 81525.

Anexo la factura y captura de pantalla de lo que me indica el sistema.',
  (select id from ventanas_mesa where nombre = 'TABLERO CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-17 10:36:00', 'Se eliminaron los archivos PDF_81525_S_AAA1E9E8-E6E8-464F-A557-055384950A3A.pdf
CFDI_81525_S_AAA1E9E8-E6E8-464F-A557-055384950A3A.xml
de la bóveda, y se eliminó en la tabla CFD_RECEPCION un registro con folio_interno = 81525', 'Modificación en BD', '2024-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001017');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-000956', 'CARGAR FACTURA', '2024-04-10 13:56:00', 'BUENA TARDE 


SOLICITO EN MEDIPORT CARGAR AL FOLIO 81492 SERIE F, LOS ARCHIVOS DE LA FACTURA PFD Y XML LOS CUALES ANEXO. DE IGUAL FORMA CARGAR AL FOLIO 81492 SERIE N, LOS ARCHIVOS DE LA NOTA DE CREDITO. DEL PROVEEDOR AME880912I89.
QUEDO ATENTO. SALUDOS.',
  (select id from ventanas_mesa where nombre = 'TABLERO CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-12 17:45:00', 'Se dio soporte al usuario al "desbloquear" los candados en el tablero de cfdi en mediport para que el usuario pudiera cargar los archivos xml y pdf', 'Seguimiento de proceso', '2024-04-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-000956');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001013', 'VALIDACION DE COMPLEMENTO DE PAGO_PROVEEDOR DHL', '2024-04-16 12:51:00', 'Hola buenas tardes

 

Por medio del presente se solicita se lleve a cabo la validación en papel de los complementos de pago del proveedor DHL EXPRESS MEXICO (966), lo anterior debido a la forma en la cual el proveedor emite los complementos de pago, lo anterior ya fue compartido con el Departamento de Presupuesto y Contabilidad.

 

Se adjunta complemento emitido por DHL.

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'TABLERO CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-18 11:09:00', 'Se dio soporte al usuario al "desbloquear" los candados en el tablero de cfdi en mediport para que el usuario pudiera cargar los archivos xml y pdf', 'Seguimiento de proceso', '2024-04-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001013');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001015', 'CAMBIO DE FECHA', '2024-04-16 13:47:00', 'Buenas tardes.
Solicito de su apoyo para realizar cambio de fecha al PEDIDO No. 34992, a la fecha 05/04/2024

Sin otro particular quedo a la orden.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-18 13:15:00', 'Se realizó el cambio de fecha en la tabla PEDIDOS. 
Para pedido 34992, en los campos FECHA, FECHAALTA, FECHAMODIF y FECHAENTREGA con la fecha de 05/03/24', 'Modificación en BD', '2024-04-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001015');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001031', 'Mi nombre no aparece para que contratista pueda cobrar estimacion', '2024-04-18 09:21:00', 'Buenos
 días. el día de hoy la superintendente de la contratista lucero polito 
robles, la cual llevo dos contratos (1 de servicios y 1 de obra) me 
comenta que al intentar cargar cambios de estimaciones que debe entregar
 y modificar en el portal, no aparezco en la lista de residentes de 
ASIPONA, anexo captura de lo antes mencionado.',
  (select id from ventanas_mesa where nombre = 'PERSONAS AUTORIZADAS PARA FIRMAR CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Molina Hernández, Javier Alexis'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-04-18 13:21:00', 'Se agrego a el registro del usuario a la tabla USUARIOS y posteriormente a la tabla UTIPOSA dentro del esquema OBRAS', 'Modificación en BD', '2024-04-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001031');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001004', 'solicitud de cambio de fecha de pedido 34971', '2024-04-15 17:24:00', 'buenas tarde por medio de la presente, se solicita el cambio de fecha del pedido 34971, se encuentra en estado de tramite para realizar el cambio requerido. 
fecha solicitada: 08/04/2024
saludos, quedo pendiente a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-18 13:13:00', 'Se realizó el cambio de fecha en la tabla PEDIDOS. 
Para pedido 34971, en los campos FECHA, FECHAALTA, FECHAMODIF y FECHAENTREGA con la fecha de 08/04/24', 'Modificación en BD', '2024-04-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001004');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-000989', 'CAMBIO DE FECHA', '2024-04-12 18:36:00', 'Por este medio solicito de su apoyo para el cambio de fecha  del pedido de servicios 34981.
DEBE DECIR: 20/03/2024

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-18 17:01:00', 'Se realizó el cambio de fecha en la tabla PEDIDOS. 
Para pedido 34981, en los campos FECHA, FECHAALTA, FECHAMODIF y FECHAENTREGA con la fecha de 20/03/24', 'Modificación en BD', '2024-04-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-000989');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001035', 'MODIFICACION EN REQUISICION TABLERO PRESUPUESTAL', '2024-04-18 10:58:00', 'Buenos días estimados.
Derivado a la actualización de datos en la requisición 132269 se solicita retirar la autorización presupuestal de dicha requisición con el fin de poder ser visualizada nuevamente por parte de la Jefatura de Presupuesto y Contabilidad para su validación. 

Saludos.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/Tablero Presupuestal'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-18 17:58:00', 'Se realizó cambio en la tabla REQUISICIONES en el campo aprueba_conta dandole valor 0', 'Modificación en BD', '2024-04-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001035');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001040', 'Habilitar "Comprobación de viáticos" en SIIP', '2024-04-18 14:40:00', 'Solicito apoyo para habilitar en mi usuario del sistema SIIP la pestaña "Comprobación de viáticos"

usuario: cpromocion2',
  (select id from ventanas_mesa where nombre = 'MODULO TRAMITES Y SOLICITUDES/VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Espinosa López, Nora Luisa'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-19 10:00:00', 'Se consultó su usuario en la tabla Usuarios, y se activó la pestaña en el módulo de seguridad, en la sección de privilegios a usuarios', 'Seguimiento de proceso', '2024-04-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001040');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001045', 'MODIFICACIÓN EN FECHA REQUISICIÓN E I.M.', '2024-04-19 10:56:00', 'Buenos días, 

Por medio del presente solicito su apoyo para realizar la modificación en la fecha de elaboración de los siguientes documentos: 

    Requisición 132323
    Investigación de Mercado 9778


Ambos documentos deben decir: 19/03/2024

Agradeciendo de antemano su valiosa colaboración, le envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-19 16:40:00', 'Se realizó cambio de fecha en la tabla REQUISICIONES e INVESTIGACIONMERCADO, para la requisición: 132323 en los campos FECHA, FECHAALTA, FECHAAUTOR01, FECHAMODIF, FECHAREQUIERE y la investigación de mercado: 009778 en los campos FECHAALTA, FECHATRAMITO y FECHAAUTOR, a la fecha de 19/03/24', 'Modificación en BD', '2024-04-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001045');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001050', 'CAMBIO DE FECHA DE REQUISION E INVESTIGACION', '2024-04-19 15:26:00', 'Hola buenas tardes

Por medio de la presente solicito de su apoyo para el cambio de fecha de la requisicion:132324, Investigación de Mercado:9779.

Fecha solicitada para ambos documentos: 18/04/2024.

De antemano agradezco la atención, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-22 12:26:00', 'Se realizó cambio de fecha en la tabla REQUISICIONES e INVESTIGACIONMERCADO, para la requisición: 132324 en los campos FECHA, FECHAALTA, FECHAAUTOR01, FECHAMODIF, FECHAREQUIERE y la investigación de mercado: 009779 en los campos FECHAALTA, FECHATRAMITO y FECHAAUTOR, a la fecha de 18/04/24', 'Modificación en BD', '2024-04-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001050');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001019', 'no me deja registra grabar el usuario', '2024-04-16 17:03:00', 'CAPTURO LA INFORMACION EN EL MODULO DE OFICIALIA DE PARTES, A QUIEN VA DIRIGIDO EL OFICIO CON EL  NUMERO DE USUARIO DEL (DG) AL FINALIZAR EL LLENADO DE TODOS LOS CAMPOS Y DARLE GUARDAR NO ME GUARDA LA INFORMACION.


ANEXO:CAPTURA DE PANTALLA (EN LA PARTE INFERIOR APARECE LA LEYENDA).

ATTE,

PERLA SANCHEZ
OFICIALIA DE PARTES.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Oficialia de partes'),
  (select id from solicitantes_mesa where nombre = 'Sanchez Solano, Perla'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-17 12:03:00', 'Modificación del formulario, se cambió la longitud del campo vTitulo(10) a 15', 'Modificación en BD', '2024-04-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001019');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001056', 'Problemas en Justificacion de Incidencias || ALC', '2024-04-19 16:38:00', 'Buen dia, 
Por favor de su apoyo, he estado tratando de justificar unas incidencias en el Sistema SIIP, y no me ha permitido "Tramitar"',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS / SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-22 10:38:00', 'Se agregó en la tabla USUARIOS del esquema EDIV2 en el campo TRABNUM el valor 69619', 'Modificación en BD', '2024-04-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001056');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001065', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-04-22 16:01:00', 'Buena tarde
Agradeceremos el apoyo con el timbrado de la nota de egreso 16682 , folio 13960


Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-04-23 12:01:00', 'Se hizo el cambio en VTNOTASCREDITO en el campo monto, en la tabla FACTURAS_TIMBRADOR se hizo el cambio en timbrado de 2 a 0', 'Modificación en BD', '2024-04-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001065');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001064', 'Solicitud de cambio de fecha', '2024-04-22 15:35:00', 'Buenas tardes

Por medio de la presente solicito de la presente solicito su apoyo para el cambio de fecha del contrato 35011, que se encuentra en estado de  tramite.

Fecha solicitada 06/04/2024

De antemano agradezco la atención, saludos cordiales',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-23 16:03:00', 'Se realizpo el cambio en PEDIDOS en los campos FECHA, FECHAALTA, FECHAMODIF, FECHAENTREGA con el valor de 06/04/2024', 'Modificación en BD', '2024-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001064');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001039', 'MODIFICACION EN REQUISICION TABLERO PRESUPUESTAL', '2024-04-18 12:31:00', 'Buenas tardes.
Derivado a la actualización de datos en la requisición 132297 se
 solicita retirar la autorización presupuestal de dicha requisición con 
el fin de poder ser visualizada nuevamente por parte de la Jefatura de 
Presupuesto y Contabilidad para su validación. 

Saludos.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/Tablero Presupuestal'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-24 11:20:00', 'Se realizó cambio en la tabla REQUISICIONES en el campo aprueba_conta dandole valor 0', 'Modificación en BD', '2024-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001039');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001071', 'VALIDACION DE COMPLEMENTOS DE PAGO PEMEX', '2024-04-23 10:07:00', 'Por medio del presente se solicita se lleve a cabo la validación en papel de los complementos
de pago del proveedor Pemex Transformación Industrial (2593), lo anterior
debido a la forma en el cual el proveedor emite los complementos de pago, lo
anterior ya fue validado con el Departamento de Presupuesto y Contabilidad. Se
adjuntan complementos emitidos PEMEX.
Sin más por el momento quedo atenta, saludos',
  (select id from ventanas_mesa where nombre = 'TABLERO CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-24 11:22:00', 'Se dio soporte al usuario al "desbloquear" los candados en el tablero de cfdi en mediport para que el usuario pudiera cargar los archivos xml y pdf', 'Seguimiento de proceso', '2024-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001071');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001041', 'COMPLEMENTOS DE CFE', '2024-04-18 17:04:00', 'BUENA TARDE 

SOLICITO
 ABRIR LOS CANDADO DE LOS COMPLEMENTOS DEL PROVEEDOR CON NUMERO 2370  
CFE SUMINSTRADOR DE SERVICIOS BASICOS. RFC: CSS160330CP7. PARA REALIZAR 8
 PAGOS CORRESPONDIENTES AL MES DE ABRIL
QUEDO ATENTO. SALUDOS',
  (select id from ventanas_mesa where nombre = 'TABLERO CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-24 09:14:00', 'Se dio soporte al usuario al "desbloquear" los candados en el tablero de cfdi en mediport para que el usuario pudiera cargar los archivos xml y pdf', 'Seguimiento de proceso', '2024-04-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001041');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001061', 'SE SOLICITA EL AMBIO DE FECHA DE INVESTIGACION DE MERCADO 009773/2024', '2024-04-22 11:58:00', 'BUENAS
 TARDES, POR EL PRESENTE SE SOLICITA EL CAMBIO DE FECHA DE LA 
INVESTIGACIÓN DE MERCADO CON NUMERO 009773/2024, LA CUAL SALIO CON FECHA
 DEL 15 DE ABRIL, PARA QUE APAREZCA CON FECHA DEL 17 DE ABRIL, POR 
CAMBIO DEL GERENTE DE OPERACIONES.

AGRADECIENDO SU ATENCIÓN, QUEDO ATENTO A SUS COMENTARIOS.',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Ortiz Morales, Cesar'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-23 16:07:00', 'Se modificó la tabla INVESTIGACIONMERCADO 009773 en los campos FECHAALTA, FECHATRAMITO y FECHAAUTOR, a la fecha de 17/04/24', 'Modificación en BD', '2024-04-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001061');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001030', 'CAMBIO DE FECHA', '2024-04-17 18:38:00', 'Buenas tardes.
Solicito de su apoyo para realizar cambio a:FACTURA  No. 81534, a la fecha 17/04/2024PEDIDO 34998 a la fecha 03/04/2024



Sin otro particular quedo a la orden.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'SIIPv2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-24 09:02:00', 'Se realizpo el cambio en PEDIDOS en los campos FECHA, FECHAALTA, FECHAMODIF, FECHAENTREGA con el valor de 03/04/2024 y en INVENTARIO.FACTURAS en el campo FECHA por 17/04/24', 'Modificación en BD', '2024-04-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001030');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001099', 'MESA DE AYUDA CONTRATO ASPN-GI-CS-62601-001-23', '2024-04-24 22:52:00', 'BUENAS TARDES ESTIMADOS,

POR
 ESTE MEDIO ME PERMITO SOLICITAR SU APOYO CON MOTIVO AL 
CONTRATO ASPN-GI-CS-62601-001-23, PUESTO QUE EL MONTO DE AMORTIZACIÓN 
FUE AMORTIZADO EN SU TOTALIDAD EN LA ESTIMACIÓN 2C, SIN EMBARGO EL SALDO
 DE AMORTIZACIÓN NO SE ACTUALIZA EN LA ESTIMACIÓN 3C.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Galván, Pamela Estefanía'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-04-26 10:30:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-04-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001099');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001105', 'COMPROBACION DE VIATICOS', '2024-04-25 12:09:00', 'BUENAS TARDES

SOLICITO SU APOYO CON LA MODIFICACION EN EL SISTEMA DE LA COMPROBACION DE VIATICOS DE 
LIC. JULIAN ESCAMILLA GODINEZ   EMPLEADO 40205 FOLIO: 4321


GRACIAS.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Ríos, Verania Lizette'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-25 17:09:00', 'Se realizó consulta en VTCOSCOMPROBACION con el folio de solicitud, se consultaron los detalles de comprobación en VTCOSDETCOMPROBACION con el folio de comprobación, después se ubicaron las facturas generadas en INVENTARIO.FOLIO_FACTURAS, y se eliminaron los registros y los archivos xml y pdf correspondientes de la bóveda, Finalmente se eliminaron los registros en los detalles de comprobación.', 'Modificación en BD', '2024-04-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001105');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001089', 'NO PERMITE CARGAR CONVENIO', '2024-04-23 17:55:00', 'BUENAS
 TARDES, SOLICITO DE SU APOYO YA QUE EN LA CASILLA DE PORCENTAJE 
ACUMULADO ME APARECE ### QUE GENERA ERROR Y NO ME DEJA GUARDARLO MENOS 
TRAMITARLO.
QUEDO ATENTO A SUS RECOMENDACIONES',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES Al CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Ramos Cházaro, Efrén'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-04-25 16:53:00', 'Se hizo la modificacion en la tabla SOLCNTOVIGENTES y CNTOVIGENTES en el campo IMPORTETOTALORIGINAL', 'Modificación en BD', '2024-04-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001089');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001125', 'SOLICITUD DE ELIMINACIÓN DE FACTURAS', '2024-04-29 09:06:00', 'Buen día,


Se solicita eliminar una factura errónea subida dentro del proceso de comprobación de viáticos.

Es la marcada en color azul.


Saludos Cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIONDEVIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Morfinez Anaya, José Gabriel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-30 09:06:00', 'Se realizó consulta en VTCOSCOMPROBACION con el folio de solicitud, se consultaron los detalles de comprobación en VTCOSDETCOMPROBACION con el folio de comprobación, después se ubicaron las facturas generadas en INVENTARIO.FOLIO_FACTURAS, y se eliminaron los registros y los archivos xml y pdf correspondientes de la bóveda, Finalmente se eliminaron los registros en los detalles de comprobación.', 'Modificación en BD', '2024-04-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001125');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001127', 'NO PERMITE TRAMITAR CONVENIO', '2024-04-29 11:37:00', 'BUENOS DIAS 

ADJUNTO CARATULA YA LISTA PARA TRAMITAR PERO ME APARECE LA LEYENDA DE QUE LOS MONTOS NO SON IGUALES LA DIFERENCIA ES DE 1 CENTAVO.POR LO QUE SOLICITO EL APOYO PARA PODER CARGAR CORRECTAMENTE ESTE CONTRATO ASPN-GI-CO-62601-002-23',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES Al CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Ramos Cházaro, Efrén'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-30 11:37:00', 'Se hizo la modificacion del monto del contrato en VERSIONESCONTRATO y SOLCNTOVIGENTES(Aqui se puso el valor de importetotalnuevo en importetotal ya que aun conservaba el valor original del contrato)', 'Modificación en BD', '2024-04-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001127');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001130', 'VALIDACION DE COMPLEMENTOS DE PAGO DHL', '2024-04-29 13:19:00', 'Hola buenas tardes

 

Por medio del presente se solicita se lleve a cabo la validación en papel de los complementos de pago del proveedor DHL EXPRESS MEXICO (966), lo anterior debido a la forma en la cual el proveedor emite los complementos de pago, lo anterior ya fue compartido con el Departamento de Presupuesto y Contabilidad.

 

Se adjunta complemento emitido por DHL.

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-30 16:26:00', 'Se dio soporte al usuario al "desbloquear" los candados en el tablero de cfdi en mediport para que el usuario pudiera cargar los archivos xml y pdf', 'Seguimiento de proceso', '2024-04-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001130');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001123', 'VALIDACION DE COMPLEMENTOS DE PAGO PEMEX', '2024-04-29 09:02:00', 'Por medio del presente se solicita se lleve a cabo la validación en papel de los complementos de pago del proveedor Pemex Transformación Industrial (2593), lo anterior debido a la forma en el cual el proveedor emite los complementos de pago, lo anterior ya fue validado con el Departamento de Presupuesto y Contabilidad. Se adjuntan complementos emitidos PEMEX.


Sin más por el momento quedo atenta, saludos',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-30 16:26:00', 'Se dio soporte al usuario al "desbloquear" los candados en el tablero de cfdi en mediport para que el usuario pudiera cargar los archivos xml y pdf', 'Seguimiento de proceso', '2024-04-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001123');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001107', 'NO PERMITE TRAMITAR', '2024-04-25 18:16:00', 'SALE LEYENDA DEL MONTO DE CONTRATO NO ES EL MISMO. ADJUNTE DONDE SE APRECIA SI SON IGUALES CARATULAS',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES Al CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Ramos Cházaro, Efrén'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-04-30 09:52:00', 'Se hizo la modificacion del monto del contrato en VERSIONESCONTRATO y SOLCNTOVIGENTES(Aqui se puso el valor de importetotalnuevo en importetotal ya que aun conservaba el valor original del contrato', 'Modificación en BD', '2024-05-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001107');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001146', 'COMPROBACION DE VIATICOS', '2024-04-30 12:28:00', 'Buena tarde:
A
 solicitud del Depto. de Contabilidad, requiero de su apoyo para la 
eliminación de tres facturas de la comprobación No. 4572 de Elias 
Armando Ronces Rodríguez, las facturas a eliminar son las siguientes:
No. Factura         Monto      Emisor 6180100902      $32.00       Tiendas OXXO
6175730840        87.00       Tiendas OXXO
5074                  411.00        Los Giros

Agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIONDEVIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-01 11:28:00', 'Se realizó consulta en VTCOSCOMPROBACION con el folio de solicitud, se consultaron los detalles de comprobación en VTCOSDETCOMPROBACION con el folio de comprobación, después se ubicaron las facturas generadas en INVENTARIO.FOLIO_FACTURAS, y se eliminaron los registros y los archivos xml y pdf correspondientes de la bóveda, Finalmente se eliminaron los registros en los detalles de comprobación.', 'Modificación en BD', '2024-05-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001146');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001124', 'Boletas de Liberación de Carga', '2024-04-29 09:05:00', 'Buen día, se solicita su apoyo para modificar la fecha en las Boletas de Liberación con folios 93977 y 93975, dice 04/04/2024 y debe decir 09/04/2024',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-04-30 11:30:00', 'Se realizó la modificación en OPERACION.det_folios_salida donde se cambió el campo FECHA con la fecha solicitada: 09/04/2024', 'Modificación en BD', '2024-05-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001124');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001177', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-05-03 10:08:00', 'Buen día
Agradeceremos el apoyo con el timbrado de la nota de egreso 16727, folio 13996.
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 08:08:00', 'Se hizo el cambio en VTNOTASCREDITO en el campo monto, en la tabla FACTURAS_TIMBRADOR se hizo el cambio en timbrado de 2 a 0', 'Modificación en BD', '2024-05-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001177');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001180', 'ERRORES EN IMPRESIÓN DE CARÁTULAS, CONTRATO ASPN-GI-CO62602-001-24', '2024-05-03 10:38:00', 'Buenos días,
Solicito
 su ayuda para revisar y corregir un error al momento de imprimir las 
carátulas del sistema de estimaciones, dado que se imprimen datos 
incorrectos, pues no coinciden los montos capturados en el sistema 
integral, con los impresos.
contrato ASPN-GI-CO-62602-001-24, estimación 1
Se anexa captura e impresión',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'González Martínez, Francisco de Jesus'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-05-06 08:38:00', 'Preguntar a gabriel 3FJ', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001180');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001166', 'JUSTIFICACION DE INCIDENCIAS', '2024-05-02 14:40:00', 'Buenas tardes; solicito de su valioso apoyo ya que al querer justificar incidencias de la 2da quincena del mes de Abril no me aparecen,  solo me aparecen las quincenas hasta el mes de Febrero.


Adjunto evidencia fotográfica.

Gracias.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Limón Acevedo, Rodolfo'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-03 10:00:00', 'Seguimiento con usuario', 'Seguimiento de proceso', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001166');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001154', 'Justificación de Incidencia', '2024-05-02 10:19:00', 'Por favor su apoyo ya que he intentado guardar mi justificación de incidencia para posteriormente tramitar pero no me permite ya que cuando le doy guardar me la deja en estado PENDIENTE, adjunto pantalla de cómo me muestra',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-02 17:19:00', 'Seguimiento con usuario', 'Seguimiento de proceso', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001154');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001195', 'APOYO CAMBIO DE FECHA REQUISICIÓN NÚMERO 132341 E INVESTIGACIÓN DE MERCADO 9794', '2024-05-03 17:13:00', 'Buena tarde estimados, por este medio, tengo a bien
solicitar su amable apoyo a efecto de poder realizar el cambio de fecha a la
requisición con número 132341 e investigación de mercado 9794 quedando definida la fecha 02/05/2024. 

Quedo al pendiente por cualquier duda o inquietud sobre lo
anteriormente descrito.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 14:21:00', 'Se realizó el cambio de fecha a la
requisición con número 132341 e investigación de mercado 9794 en los campos relacionados a fecha (a excepcion de fechaVencimiento) con valor de 02/05/2024.', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001195');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001191', 'NOMINA / DESCRIPCION', '2024-05-03 15:26:00', 'Buena tarde Compañeros
Solicito
 de su apoyo urgente, les comento al momento de estar haciendo mi 
incidencia, ingrese la información y pude observar la fecha a 
justificar, solo que ese numero de solicitud lo ocuparon. 
Volví a ingresar pero ya no se puede observar la fecha que necesito justificar que es la 2da quincena de abril.
 
Les anexo pantalla para referencia.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Vargas Zapata, Maria Isabel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 09:26:00', 'Seguimiento con usuario', 'Seguimiento de proceso', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001191');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001097', 'CAMBIO DE FECHA', '2024-04-24 17:29:00', 'Por este medio se solicita de su apoyo para el cambio de fecha del pedido de servicios:35023
debe decir: 23/04/2024.
Quedo atenta.
Saludos.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 11:54:00', 'Se realizó la modificación en tabla PEDIDOS en los campos FECHA, FECHAALTA, FECHAMODIF Y FECHAENTREGA con valor de 23/04/2024', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001097');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001169', 'CAMBIO DE FECHA', '2024-05-02 15:26:00', 'Buenas tardes estimados:
Solicito de su apoyo para realizar cambio al PEDIDO 35031 a la fecha 26/04/2024


Sin otro particular quedo a la orden.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 14:27:00', 'Se realizó la modificación en tabla PEDIDOS en los campos FECHA, FECHAALTA Y FECHAENTREGA con valor de 26/04/2024', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001169');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001185', 'Solicitud de cambio de fecha', '2024-05-03 12:31:00', 'Hola buenas tardes

Por medio de la presente solicito su apoyo para el cambio de fecha del pedido 35040, que se encuentra en estado de tramite.

Fechas solicitada: 19/04/2024

De antemano agradezco la atención, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 08:24:00', 'Se realizó la modificación en tabla PEDIDOS en los campos FECHA, FECHAALTA Y FECHAENTREGA con valor de 19/04/2024', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001185');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001186', 'ELIMINAR REGISTROS DE LA COMPROBACIÓN CON FOLIO 4567', '2024-05-03 13:36:00', 'Buenas tardes

Por medio del presente y a petición del departamento de contabilidad, se solicita que en la Comprobación de viáticos con Folio 4567, se eliminen los siguientes registros para correcciones:

El registro del comprobante con folio No.00001865, por un monto de $ 3150.00

El registro del comprobante con folio No.5223, por un monto de $ 135.00

El registro del comprobante con folio No. 5255, por un monto de $ 100.00

El registro del comprobante con folio No. 5339, por un monto de $ 235.00

El registro del comprobante con folio No. 768890, por un monto de $ 18.00

 

De antemano Gracias.

 

Saludos',
  (select id from ventanas_mesa where nombre = 'COMPROBACIONDEVIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Molina Montiel, Miriam del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 08:36:00', 'Se eliminaron los registros de la tabla VTCOSDETCOMPROBACION en base al monto y referencia de la comprobacion', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001186');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001188', 'ELIMINAR REGISTROS DE LA COMPROBACIÓN CON FOLIO 4568', '2024-05-03 13:57:00', 'Buenas tardes

Por medio del presente y a petición del departamento de contabilidad, se solicita que en la Comprobación de viáticos con Folio 4568, se eliminen los siguientes registros para correcciones:

El registro del comprobante con folio No.00001874, por un monto de $ 1050.00

El registro del comprobante con folio No.5352, por un monto de $ 140.00

El registro del comprobante con folio No. 25840, por un monto de $ 193.1, mas IVA.

 

De antemano Gracias.

 

Saludos',
  (select id from ventanas_mesa where nombre = 'COMPROBACIONDEVIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Molina Montiel, Miriam del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 08:57:00', 'Se eliminaron los registros de la tabla VIATICOS.VTCOSDETCOMPROBACION en base al monto y referencia de la comprobacion, además, como se había generado una factura, se eliminó de bóveda y de la tabla INVENTARIO.FOLIO_FACTURA', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001188');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001202', 'TRAMITE DE JUSTIFICACION DE INCIDENCIA DE SIIP', '2024-05-06 09:56:00', 'BUENOS DIAS

SOLICITO DE SU APOYO PARA QUE ME APARTUREN LA SEGUNDA QUINCENA DEL MES DE ABRIL, YA QUE EN DIAS PASADOS INTENTE REALIZARLA, PERO NO ME FUE POSIBLE CUANDO TOME EL FOLIO NO ME PERMITIO GUARDAR LOS CAMBIOS EN SISTEMA SIIP

ESPERO SU RESPUESTA ..
SALUDOS',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Marquez Berruecos, Ivette Teresa'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 14:56:00', 'Seguimiento con usuario', 'Seguimiento de proceso', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001202');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001196', 'PARA CAMBIO DIRECTA CON CONTRATO', '2024-05-03 17:38:00', 'Hola buenas tardes

Por medio de la presente se solicita se lleve acabo el cambio de tipo de adjudicación del contrato de servicios No. 35011 del proveedor UMA TABLAESTACA Y ACEROS, S.A. DE C.V., de adjudicación  Directa con Pedido a Directa con Contrato.

- El contrato se encuentra en estado Abierto.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-06 14:45:00', 'Se modificó en tabla INVENTARIO.PEDIDOS el campo TIPOADJ con valor a 2', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001196');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001172', 'CAMBIO DE FECHA', '2024-05-02 18:23:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido: 35036
Debe decir: 29/04/2024
Anexo evidencia.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-07 13:49:00', 'Se realizó la modificación en tabla PEDIDOS en los campos FECHA, FECHAALTA, FECHAMODIF, FECHAAUTOR05 Y FECHAENTREGA con valor de 29/04/2024', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001172');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001170', 'CAMBIO DE FECHA EN PEDIDO', '2024-05-02 15:37:00', 'Buenas tardes

Por medio del presente solicito su valioso apoyo con el cambio de fecha del siguiente pedido:

PEDIDO DE SERVICIOS: 35032

FECHA SOLICITADA: 29/04/2024',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Castro Arano, Beatriz'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-07 10:59:00', 'Se realizó la modificación en tabla PEDIDOS en los campos FECHA, FECHAALTA, FECHAMODIF Y FECHAENTREGA con valor de 29/04/2024', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001170');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001210', 'VIATICOS', '2024-05-06 16:38:00', 'Buena tarde:

Estimados compañeros, solicito su apoyo para la eliminación de una factura de la comprobación de viáticos con folio 4573 de Isidro Deceano Ocampo, los datos son los siguientes:

FACTURA No. 1401429 
IMPORTE  $139.00
EMISOR; Roberto Ignacio Grajeda Manzo

Agradezco la atención y quedo pendiente a sus comentarios.   

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIONDEVIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-07 12:38:00', 'Se eliminaron los registros de la tabla VIATICOS.VTCOSDETCOMPROBACION en base al monto y referencia de la comprobacion, además, como se había generado una factura, se eliminó de bóveda y de la tabla INVENTARIO.FOLIO_FACTURA', 'Modificación en BD', '2024-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001210');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001181', 'VALIDACION EN MEDIPORT', '2024-05-03 10:45:00', 'Solicito de su amable apoyo para poder subir a MEDIPORT el CFDI adjunto al presente debido a que presenta el siguiente error al momento de su validación.
Mismo que corresponde al folio en MEDIPORT: 81266

Cabe mencionar que los impuestos si estan declarados en el CFDI con la tasa del 2% como lo señala el CÓDIGO FINANCIERO PARA EL ESTADO DE VERACRUZ DE IGNACIO DE LA LLAVE, mismo que para pronta referencia se muestra a continuación.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-07 17:00:00', 'Seguimiento con usuario: Abrir los "candados" con des después de cfdi en el link', 'Seguimiento de proceso', '2024-05-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001181');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001209', 'ERROR EN CARGA MEDIPORT', '2024-05-06 15:47:00', 'Solicito de su amable apoyo para poder validar el complemento de pago adjunto al presente en el folio 7625 de Medirport en el apartado PAGOS PENDIENTES - VALIDAR COMPLEMENTO.

Dicho tema ya se validó con el área contable.

Sin otro particular, se envía un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-07 13:09:00', 'Seguimiento con usuario: Abrir los "candados" con des después de cfdi en el link', 'Seguimiento de proceso', '2024-05-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001209');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001218', 'PROBLEMA INGRESO AL SIIP', '2024-05-07 11:12:00', 'Que tal buenos días

Por este medio informo que el no puedo ingresar al sistema SIIP ya que indica CLAVE ERRONEA

La clave que indico es la de la PC adjunto foto',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Salgado Navarro, Agustin'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-07 16:12:00', 'Seguimiento con usuario', 'Seguimiento de proceso', '2024-05-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001218');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001227', 'Añadir nombre como residente de contrato ASPN-GI-CS-62601-003-24', '2024-05-07 14:13:00', 'Solicito su apoyo para dar de alta mi nombre como residente en el portal de INTEGRAL para el contrato ASPN-GI-CS-62601-003-24, siendo este: Lluvia del Carmen Gutiérrez Fernández',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Fernández, Lluvia del Carmen'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-05-08 10:00:00', 'Se hizo el cambio en la tabla de USUARIOS para cambiar el nombre al actual y posteriormente en la tabla de FIRMAS_CONTRATO se cambio el trabnum del residente erroneo al correcto', 'Modificación en BD', '2024-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001227');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001184', 'AYUDA EN HABILITAR MI USUARIO EN LA SOLICITUD DE SALIDA DE SUMINITRO', '2024-05-03 12:21:00', 'BUEN DIA;

NECESITO DE SUS AMABLE APOYO PARA HABILITAR MI USUARIO SECOPERACIONES PARA PODER REALIZAR LA SOLICITUD DE PEDIDO DE SUMINISTROS EN RECURSOS MATERIALES:

LE ADJUNTO LA MUESTRA PORQUE NO ME PERMITE',
  (select id from ventanas_mesa where nombre = 'SOLICITUDDESALIDAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Acceso al modulo de Compras'),
  (select id from solicitantes_mesa where nombre = 'Morales Tronco, Diana Isabel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-07 15:00:00', 'Seguimiento con usuario: Se le explicó el proceso para realizar una solicitud de suministros', 'Seguimiento de proceso', '2024-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001184');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001235', 'Mensaje en integral', '2024-05-07 19:34:00', 'Buenas tardes Estimado compañero, 

relativo al contrato ASPN-GI-CO-62602-010-22 de rubro “DESMANTELAMIENTO Y REHABILITACIÓN DE ALMACENES Y CASETAS DE CONTROL DE ACCESO UBICADOS EN LA BAHÍA SUR DEL PUERTO DE VERACRUZ EN EL EJERCICIO 2022 - 2023” a cargo de 

Servicios Industriales y de Infraestructura GOSAN, S.A. de C.V.


Al respecto se informa que el sistema integral esta marcando el siguiente error al intentar cargar la estimación 3C y no permite continuar con el proceso.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-05-08 13:00:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001235');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001249', 'borrar factura en siip', '2024-05-09 10:00:00', 'Buenos días, solicito de su apoyo para ELIMINAR LA FACTURA seleccionada en la imagen',
  (select id from ventanas_mesa where nombre = 'COMPROBACIONDEVIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Flores Saldaña, Andrea'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-09 14:00:00', 'Se eliminaron los registros de la tabla VIATICOS.VTCOSDETCOMPROBACION en base al monto y referencia de la comprobacion, además, como se había generado una factura, se eliminó de bóveda y de la tabla INVENTARIO.FOLIO_FACTURA', 'Modificación en BD', '2024-05-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001249');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001253', 'Asignación de privilegios de residente de obra en la plataforma SIIP', '2024-05-09 13:45:00', 'Buenas tardes a quien corresponda.

Por la presente solicito el apoyo para que se me otorguen los privilegios de residente de obra, ya que me encuentro asignado como tal en la obra con numero de contrato ASPN-GI-CO-62602-008-24.

De antemano agradezco su apoyo.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras'),
  (select id from solicitantes_mesa where nombre = 'Gozo Avila, Jesus Guillermo'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-05-10 12:45:00', 'Se hizo el cambio en la tabla de USUARIOS para cambiar el nombre al actual y posteriormente en la tabla de FIRMAS_CONTRATO se cambio el trabnum del residente erroneo al correcto', 'Modificación en BD', '2024-05-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001253');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001206', 'SOLICITUD DE CAMBIO DE ADJUDICACIÓN CONTRATOS', '2024-05-06 13:42:00', 'Buenas tardes

Por medio del presente solicito el apoyo para realizar el cambio de adjudicación en el apartado que se muestra en la imagen adjunta, en los siguientes contratos:

CONTRATO DE SERVICIOS: 34970 cambiar a: DIRECTA CON CONTRATO.


CONTRATO DE SERVICIOS: 35028 cambiar a: DIRECTA CON CONTRATO.



Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Castro Arano, Beatriz'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-10 12:00:00', 'Se cambió el tipo de adjudicación en la tabla INVENTARIO.PEDIDOS en el  campo TIPOADJ a estado 1, Directa con contrato', 'Modificación en BD', '2024-05-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001206');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001233', 'CAMBIO DE FECHA', '2024-05-07 18:03:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido de servicios 35026 para que quede con fecha: 23/04/2024. 

Quedo atenta a su indicación.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-10 12:15:00', 'Se realizó la modificación en tabla PEDIDOS en los campos FECHA, FECHAALTA, FECHAMODIF Y FECHAENTREGA con valor de 23/04/2024', 'Modificación en BD', '2024-05-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001233');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001265', 'Alta de residente', '2024-05-13 09:38:00', 'Buenos días.

Solicito su apoyo para asignar como residente, en el sistema de supervisión de obras, al Ing. Pablo Muñoz para el contrato ASPN-GI-CO-62602-002-22 asignado al contratista Maquila y Servicios de Ingeniería, S.C., lo anterior debido a que en el sistema de supervisión, el nombre del ingeniero no se encuentra entre las opciones para residente.
Cabe mencionar que dicho residente ya fue asignado por la Gerencia de Ingeniería al contrato. 

Quedo al pendiente de sus comentarios.

Saludos',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-05-14 09:38:00', 'Se hizo el cambio en la tabla de USUARIOS para cambiar el nombre al actual y posteriormente en la tabla de FIRMAS_CONTRATO se cambio el trabnum del residente erroneo al correcto', 'Modificación en BD', '2024-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001265');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001274', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-05-13 16:42:00', 'Buena tarde
Agradeceremos el apoyo con el timbrado de la nota de egreso 16755  , folio  14020
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-14 12:42:00', 'Se cambio el monto erroneo en VTNOTASCREDITO y luego en FACTURAS_TIMBRADOR se paso de 2 a 0', 'Modificación en BD', '2024-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001274');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001171', 'cambio de recinto', '2024-05-02 17:44:00', 'Favor de cambiar de recinto los conocimientos del buque  ALS VESTA ID:240782 de importación, se adjunta archivo. 
Deben decir recinto 67',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Machado Piña, Hilda'),
  (select id from resolutores_mesa where nombre = 'Hernandez Gonzalez, Gabriel'),
  '2024-05-03 12:44:00', 'Se modifica en OPERACION.DESG_MCIAS Y OPERACION.MERCANCIAS en el campo refism3, verificando que si es 63, no haya mov. de almacén ni facturas', 'Modificación en BD', '2024-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001171');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001281', 'modificación de precio unitario', '2024-05-14 11:58:00', 'solicito el apoyo para que en el sistema se pueda capturar el concepto fuera de catalogo ya autorizado y poder hacer estimación finiquito así como modificación de montos el cual no se puede realizar 
este apoyo ya se a solicitado con anterioridad ultima solicitud fue REQ. 2024-001131',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Deceano Ocampo, Isidro'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-15 09:10:00', 'Se cambio la cantidad en CNTOVIGENTES(importetotaloriginal) y SOLCNTOVIGENTES(importetotaloriginal) de 1 a la cantidad de 627108.65', 'Modificación en BD', '2024-05-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001281');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001285', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-05-14 13:50:00', 'Buena tarde

Agradeceremos el apoyo con el timbrado de las siguientes notas de egreso.

Nota        Folio



16758     14023
16760     14025


Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-15 12:50:00', 'Se cambio el monto erroneo para ambas notas en VTNOTASCREDITO y luego en FACTURAS_TIMBRADOR se paso de 2 a 0', 'Modificación en BD', '2024-05-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001285');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001224', 'CAMBIO DE FECHA', '2024-05-07 12:32:00', 'Solicito de su amable apoyo para realizar el cambio de fecha de la factura con Número de Folio: 81266 
Dice: 14/03/2024
Debe decir: 29/04/2024

Sin otro particular agradezco el apoyo.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-15 13:29:00', 'Se modificó la fecha en la tabla INVENTARIO.FACTURAS en los campos FECHA, FECHAFACTURA, FECHARECEPCION, FECHAPAGO, FECHAALTA, FECHAMODIF, FECHACOSTO con el valor de 29/04/2024', 'Modificación en BD', '2024-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001224');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001234', 'SUSTITUCION DE CFDI_FACTURA 81604_DISTRIBUIDORA JUGUETRON', '2024-05-07 19:08:00', 'Buenas tardes, 

El motivo del presente es para solicitar su apoyo con la sustitución del CFDI en el sistema SIIP, en la factura 81604 del proveedor DISTRIBUIDORA JUGUETRON, ya que se debe cargar el obtenido de la pagina del SAT, pues muestra el nombre del Receptor de manera clara, y en el comprobante que se encuentra adjunto no se aprecia. Adjunto al presente el CFDI emitido de forma correcta, para lo que corresponda:',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-15 17:32:00', 'Se sustituyeron los archivos proporcionados por el usuario en la bóveda, en Folio_factura', 'Seguimiento de proceso', '2024-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001234');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001290', 'cambio de peso', '2024-05-15 11:13:00', 'buenas  tardes por instrucciones de Jefe de almacenes y a solicitud de la naviera  se solicita lo siguiente
cambio de peso del bl BE2407361 de Mercedes Benz y que vino en el MORNING LINDA V-EC403 ID 240746

DICE: 705,020 KGS  DEBE DECIR: 699,654 KGS,


NOTA: existen otras facturas cargadas a este bl por almacenajes, pero ninguna es por muellaje',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-16 09:13:00', 'Se modificaron OPERACIONES.DESG_MCIAS en existencia_peso, DET_MOVS_ALM en peso_alm y ACUMULADOS_ALM en entradas_peso, saldo_final_peso con valor de 699654', 'Modificación en BD', '2024-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001290');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001291', 'CAMBIO DE CASETA OPERATIVA // SIG FOLIO: 2631/24', '2024-05-15 11:55:00', 'Hola buen día 

Su valioso apoyo en realizar los siguientes cambios de la solicitud de caseta operativa con codigo SIG-CS-130524-2452847, ya que por situaciones ajenas a nosotros se realizo el cambio de caseta operativa de la C a la F por fallas en el aire acondicionado.

favor de realizar los cambios siguientes datos:

    dice: caseta C
    debe decir: caseta F


corrimiento de días:

    dice:  Ocupación Desde: 13/05/2024 Hasta: 16/05/2024
    debe decir  Ocupación Desde: 13/05/2024 Hasta: 19/05/2024


Cualquier duda o aclaracion favor de comunicarse a la ext: 73113',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-16 09:55:00', 'Se realizó la consulta del niddocumento en EDIV2.DOCUMENTO y se modificó en EDIV2.CASETA_SOLICITUD en el campo caseta y FTermino con el valor de F y 19/05/2024', 'Modificación en BD', '2024-05-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001291');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001254', 'VALIDACION DE COMPLEMENTO DE PAGO - PROVEEDOR EDENRED MÉXICO S.A. DE C.V.', '2024-05-09 13:47:00', 'Buena tarde



Se solicita la validación del complemento de pago en papel del proveedor  (105331) Edenred México S.A.  de C.V.  lo anterior debido a que la información de los consumos forma parte de una addenda, por lo cual las facturas se encuentran timbradas con valor 0.



El folio en mediport es:

9907

Sin más por el momento quedo atenta.

Saludos',
  (select id from ventanas_mesa where nombre = 'CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-15 16:44:00', 'Apertura de  "candados" para subir archivos de complementos de pago', 'Seguimiento de proceso', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001254');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001258', 'VALIDACION DE COMPLEMENTOS DE PAGO PEMEX', '2024-05-10 09:13:00', 'Por medio del presente se solicita se lleve a cabo la validación en papel de los complementos de pago del proveedor Pemex Transformación Industrial (2593), lo anterior debido a la forma en el cual el proveedor emite los complementos de pago, lo anterior ya fue validado con el Departamento de Presupuesto y Contabilidad. Se adjuntan complementos emitidos PEMEX.

Sin más por el momento quedo atenta, saludos',
  (select id from ventanas_mesa where nombre = 'CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-15 13:14:00', 'Apertura de  "candados" para subir archivos de complementos de pago', 'Seguimiento de proceso', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001258');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001306', 'CANCELACION DE ARTICULO 23.', '2024-05-16 15:23:00', 'Buenas tardes;

Solicito de su valioso apoyo para la cancelación de un articulo 23 de exportación ya que el día de ayer se cancelo por información faltante pero cuando lo cancelo me sigue saliendo pendiente por firma, lo he cancelado varias veces pero el tramite sigue apareciendo.

Adjunto evidencia fotográfica para mejor referencia.

Gracias.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Limón Acevedo, Rodolfo'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-17 10:23:00', 'En EDIV2.DOCUMENTO y EDIV2.FLUJODOCUMENTO se modificaron los estados estadodoc y nidestadodoc respectivamente, con el valor de 1, que es rechazado.', 'Modificación en BD', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001306');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001309', 'CAMBIO EN LA FECHA DE LIBERACION // BUQUE STRATEGIC FORTIDE ID:240792', '2024-05-17 10:10:00', 'Hola buen día equipo

Su apoyo en realizar la corrección de la fecha de liberación en el programa SIIP dentro del segmento folios de salida, lo cual fue el numero 94886 del conocimiento 9 del buque mencionado en asunto, ya que dice 14/05/24 y debe decir 09/05/24.

cualquier duda favor de marcar a la ext. 73113

saludos cordiales',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Buques'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-17 15:10:00', 'En INVENTARIO.FOLIO_SALIDA en campo FECHA_LIBERACION', 'Modificación en BD', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001309');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001303', 'CANCELACION DE COPIA SIMPLE DE EXPORTACION', '2024-05-16 11:17:00', 'Buen dia, 
Por este medio solicito de su apoyo para la Cancelación de un Tramite de Copia Simple, derivado a comentarios del Agente Aduanal esta se va a cancelar por Rectificación de Pedimento.

Id 240882 Buque: Ithaca Patience',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Aduana'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-16 16:17:00', 'En EDIV2.DOCUMENTO y EDIV2.FLUJODOCUMENTO se modificaron los estados estadodoc y nidestadodoc respectivamente, con el valor de 1, que es rechazado.', 'Modificación en BD', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001303');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001292', 'cambiar fecha de inicio', '2024-05-15 13:48:00', 'BUEN DIA 
SOLICITO QUE SEA CAMBIADA LA FECHA EN CONVENIO SOLICITADO LA DE INICIO NUEVO TIENE 17/11/2023 POR 06-12-2023 YA QUE ESTA OBRA TUVO DIFERIMIENTO POR ANTICIPO.
ADJUNTO OFICIO DONDE FUE AUTORIZADO DICHO DIFERIMIENTO
SALUDOS',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Ramos Cházaro, Efrén'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-20 14:18:00', 'Se cambio en la tabla de VERSIONESCONTRATO el campo fechainicio nuevo por la fecha solicitada y posteriormente tambien estadoconv de 1 a 0', 'Modificación en BD', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001292');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001323', 'Correccion de conceptos', '2024-05-20 11:45:00', 'Buenos días Estimado compañero, 

En relación a 

Contrato No. ASPN-GI-CO-62602-006-24 

 

Obra: “Mantenimiento de Almacenes y casetas del Puerto de Veracruz, durante el ejercicio 2024- 2025”

 

Al respecto solicito su valioso apoyo para corregir algunos de los conceptos cargados en el sistema, ya que presentan detalles que puedes afectar el entendimiento de los conceptos.',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-21 11:45:00', 'En la tabla de CONCEPTOSUNIV se modificaron en todos los casos la descripcion de aquellos conceptos que se señalaron con la nueva descripcion proporcionada', 'Modificación en BD', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001323');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001293', 'Estado de pedimento', '2024-05-15 14:29:00', 'Se solicita de su apoyo, ya que los pedimentos no se pueden leer en el sistema Medi-Port se muestran en CONSULTA.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Machado Piña, Hilda'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-16 12:00:00', 'Se dio seguimiento de usuario mediante llamada telefónica (Verificación)', 'Seguimiento de proceso', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001293');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001324', 'SOLICITUD DE ALTA EN LISTA DE RESIDENTES', '2024-05-20 12:21:00', 'Buenas tardes,

Por medio del presente pido de su ayuda para el alta de mi nombre en la siguiente lista de residentes; debido a que no aparezco según el contrato ASPN-GI-CO-62602-002-24.

Mostrando image.png',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Simonín Baldwin, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-21 12:21:00', 'Se hizo el cambio en la tabla de USUARIOS para cambiar el nombre al actual asi como el trabnum', 'Modificación en BD', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001324');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001302', 'cambio de fecha de pedido 35064', '2024-05-16 10:25:00', 'Buenos días por medio de la presente, se solicita el cambio de fecha del pedido 35064, se encuentra en estado de tramite para realizar el cambio requerido. 
fecha solicitada: 06/05/2024
saludos, quedo pendiente a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-21 11:17:00', 'Se realizó la modificación en tabla PEDIDOS en los campos FECHA, FECHAALTA, FECHAMODIF Y FECHAENTREGA con valor de 06/05/2024', 'Modificación en BD', '2024-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001302');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001336', 'INCIDENCIAS MES DE MAYO 2024 QUINCENA 1', '2024-05-21 09:43:00', 'BUENOS DIAS

SE SOLICITA SU APOYO , YA QUE NO PUEDO JUSTIFICAR MIS INCIDENCIAS EN EL SISTEMA, SOLO APARECE 2023... ES LA QUINCENA 1 DE MAYO 2024, TENGO HASTA EL DIA DE HOY PARA JUSTIFICAR.


QUEDO EN ESPERA , GRACIA, SALUDOS.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Ríos, Verania Lizette'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-21 17:43:00', 'Ejecutar el procedimiento de EDIV2.ELIMINAR_INCIDENCIAS para que el usuario pueda registrar su justificacion de incidencia nuevamente', 'Modificación en BD', '2024-05-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001336');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001334', 'incidencia no permite guardarla', '2024-05-20 18:25:00', 'En el módulo de incidencias, no permite guardarla y en consecuencia, tampoco tramitarla
Favor de configurar para no tener faltas',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Cruz González, Gerardo'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-21 13:00:00', 'Se modificó EDIV2.USUARIOS en el campo ACTIVO con valor a 0 y en el campo TRABNUM  con valor null', 'Modificación en BD', '2024-05-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001334');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001301', 'modificar fecha', '2024-05-16 09:56:00', 'buen día 
me podrían apoyar con la modificación del año de vigencia del contrato para poder continuar 

Mostrando image.png',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Deceano Ocampo, Isidro'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-23 16:59:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001301');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001332', 'cambio de fecha', '2024-05-20 17:02:00', 'buen día, 

Derivado de una corrección solicito su amable apoyo para realizar el cambio de fecha de la requisición 132396 por la fecha de 16/05/2024 en toda la requisición así como la investigación de mercado.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-22 13:26:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES en los campos correspondienes de fecha, y también en INVENTARIO.INV_MERCADO en todos los campos de fecha, MENOS FECHA_VENCIMIENTO', 'Modificación en BD', '2024-05-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001332');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001343', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-05-21 16:06:00', 'Buena tarde
Agradeceremos el timbrado de la nota 16772, folio 14036 

Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-22 11:06:00', 'Se cambio el monto erroneo para ambas notas en VTNOTASCREDITO y luego en FACTURAS_TIMBRADOR se paso de 2 a 0', 'Modificación en BD', '2024-05-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001343');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001340', 'no me aparece en el sip, el modulo mis p3', '2024-05-21 15:29:00', 'Buenas tardes.

Me podrían apoyar para que se viera en el SIP, el modulo de P3',
  (select id from ventanas_mesa where nombre = 'MIS P3'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Martínez Guerola, Héctor Manuel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-22 13:29:00', 'Se habilitó el permiso de MISP3 del SIIP en SEGURIDAD / PRIVILEGIOS A USUARIOS', 'Seguimiento de proceso', '2024-05-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001340');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001131', 'modificación de precio unitario', '2024-04-29 13:25:00', 'solicito el apoyo para que en el sistema se pueda capturar el concepto fuera de catalogo ya autorizado y poder hacer estimación finiquito así como modificación de montos el cual no se puede realizar',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Deceano Ocampo, Isidro'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-23 09:26:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001131');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001347', 'Cuadre en MEDIPORT', '2024-05-22 09:34:00', 'Buen día

Solicito de su apoyo para el cuadre de los siguientes conocimiento a 0 en Mediport, ya que se muestra que no hay más existencias y los pesos cuentan con -0.004 y 0.004 en los conocimientos KKLU693017528 y KKLU693017529 respectivamente

Buque: Goodwood
ID: 240596',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Bernal Hernández, Sarha Melissa'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-22 09:44:00', 'Se realizó la modificación de pesos en DESG_MCIAS, DET_MOVS_ALM Y ACUMULADOS_ALM en los campos de peso', 'Modificación en BD', '2024-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001347');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001288', 'COMPROBACIÓN DE VIATICOS', '2024-05-15 09:27:00', 'Buenos días,

De la manera más atenta solicito su apoyo para cambiar el estado de la comprobación  de viáticos con numero 4571 a LIQUIDADA.',
  (select id from ventanas_mesa where nombre = 'COMPROBACION DE VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-22 11:51:00', 'Se modificó el estado en VIATICOS.VTCOSCOMPROBACION en campo status con valor = 5 que es LIQUIDADA', 'Modificación en BD', '2024-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001288');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001350', 'no me aparece en el sip, el modulo mis p3', '2024-05-22 15:22:00', 'Buenas tardes:

Me podrían apoyar
para que se viera en el SIP, el modulo de P3, a mi compañero Ismael De La Cruz Martínez. 

usuario: idelacruz

por su atencion gracias.',
  (select id from ventanas_mesa where nombre = 'MIS P3'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Martínez Guerola, Héctor Manuel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-23 10:22:00', 'Se habilitó el permiso de MISP3 del SIIP en SEGURIDAD / PRIVILEGIOS A USUARIOS', 'Seguimiento de proceso', '2024-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001350');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001342', 'actualización en los oficios', '2024-05-21 15:36:00', 'Se solicita la actualización de los datos del gerente de operaciones para la elaboración de oficios de notificación en el sistema SIIP, así mismo la actualización de los logos.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Machado Piña, Hilda'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-22 10:36:00', 'Modificación a un reporte de Oracle, donde se le cambió el nombre del gerente de operaciones a VICEALM. RET. Augusto Cruz Morales', 'Modificación en BD', '2024-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001342');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001330', 'COMPLEMENTOS DE PAGO CFE', '2024-05-20 15:24:00', 'BUENA TARDE 

SOLICITO EL APOYO PARA ABRIR LOS CANDADO DEL PROVEEDOR 2370 CFE SUMINISTRADOR DE SERVICIOS BASICO, PARA PODER REALIZAR LA CARGA DE LOS 7 RECIBOS PENDIENTES DEL MES DE MAYO. QUEDO ATENTO. SALUDOS',
  (select id from ventanas_mesa where nombre = 'TRAMITES ELECTRONICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-23 10:07:00', 'Apertura de  "candados" para subir archivos de complementos de pago', 'Seguimiento de proceso', '2024-05-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001330');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001357', 'PERSONAL DE RECINTO FISCALIZADO', '2024-05-23 09:58:00', 'Favor de ingresar a la compañera Violeta Caballero Cortez a la plataforma Mediport en el aparatado personal de recito.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Diaz Ortiz, Oscar'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-23 13:58:00', 'Se modificó en NOMINA.EMPLEADOS en el campo RECINTO = 1 para activar el usuario en el recinto fiscalizado', 'Modificación en BD', '2024-05-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001357');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001364', 'SOLICITUD POR DICEY DEBE DECIR', '2024-05-23 16:07:00', 'Buenas tardes;

Solicito de su valioso apoyo para realizar una solicitud por dice y debe decir de cambio de bultos a articulo 23 de exportación por petición de la A.A. vía correo electrónico. adjunto captura de pantalla para mejor referencia.
BUQUE: HOEGH BRASILIAID:  240877FOLIO: 499956DICE:  81 BULTOSDEBE DECIR: 86 BULTOS.

GRACIAS.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Limón Acevedo, Rodolfo'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-24 11:07:00', 'Modificación en EDIV2.SOLMULTIPLE_CARGA en el campo de CANTIDAD, además de DESG_MCIAS, ACUMULADOS_ALM Y DET_MOVS_ALM en sus campos de cantidad y existencia.', 'Modificación en BD', '2024-05-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001364');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001349', 'ERROR DE LA CARGA DEL ANTICIPO PARA TRAMITE DE ESTIMACION', '2024-05-22 15:20:00', 'CONTRATISTA: CONSTRUCTORA VERACRUZANA DE PUENTES S.A. DE C.V.
RUBRO: MANTENIMIENTO DE SUPERFICIE DE RODAMIENTO DE LA EXPLANADA 14 DE LA BAHÍA SUR DEL PUERTO DE VERACRUZ
CONTRATO: ASPN-GI-CO-62602-002-24 EXPRESA LA CONTRATISTA  UN ERROR EN EL TRAMITE DE ESTIMACIONES POR NO REFLEJARSE INOFRMACIÓN EN EL APARTADO QUE CORRESPONDE AL ANTICIPO DE LA OBRA.

ESPERANDO PUEDAN BRINDARNOS EL APOYO NECESARIO PARA REALIZAR LA CONCLUSION DEL TRAMITE.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Simonín Baldwin, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-23 10:20:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001349');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001375', 'CAMBIO DE FECHA PEDIDOS SIIP', '2024-05-24 10:18:00', 'Por este medio solicito de su apoyo para el cambio de fecha de los siguientes pedidos:

-35101-DEBE DECIR: 08/05/2024.
-35100-DEBE DECIR:13/05/2024.
-35099-DEBE DECIR:13/05/2024.
-35098-DEBE DECIR:13/05/2024.

-35096-DEBE DECIR:13/05/2024.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-27 10:37:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDOS en los campos correspondienes de fecha', 'Modificación en BD', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001375');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001377', 'CAMBIO DE FECHA', '2024-05-24 10:52:00', 'Buenos días estimados.

Se solicita de su amable apoyo para realizar el cambio de fecha a los pedidos con las fechas que se muestran a continuación.
  PEDIDO - FECHA
  35104 - 06/05/2024
  35097 - 10/05/2024
  35089 - 13/05/2024
  35087 - 13/05/2024
35103 - 13/05/2024
  35090 - 13/05/2024
  35102 - 13/05/2024
  33088 - 13/05/2024
  35086 - 13/05/2024
  35084 - 13/05/2024
  35081 - 13/05/2024
  35082 - 13/05/2024
  35083 - 13/05/2024
  35080 - 14/05/2024
De ante mano muchas gracias.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-27 12:29:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDOS en los campos correspondienes de fecha', 'Modificación en BD', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001377');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001385', 'ELIMINACIÓN DE FACTURA PARA COMPROBACIÓN DE VIÁTICOS EN SIIPV', '2024-05-24 16:51:00', 'Buenas tardes estimado, por medio de la presente me permito solicitar su amable apoyo para eliminar un registro cargado en el SIIPV el cual ya no
 es necesario para realizar la comprobación de viáticos de la Lic. Isis González Vidrio Subgerente de Desarrollo de Mercado. 
A continuación, incorporo los datos del registro que se desea eliminar:
FOLIO: 4584
RUBRO: 6
DESCRIPCIÓN: IMPUESTO SOBRE HOSPEDAJE
IMPORTE: 1,650.00
Sin otro particular, aprovecho la ocasión para enviarle un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'COMPROBACION DE VÍATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-27 14:51:00', 'Se eliminó la factura de la bóveda, se eliminó el registro de INVENTARIO.FOLIO_FACTURAS y VIATICOS.VTCOSDETCOMPROBACION correspondiente al folio proporcionado.', 'Modificación en BD', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001385');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001384', 'ABRIR CANDADO 10174 PROVETECNIA', '2024-05-24 16:43:00', 'Ing. Gabriel e Ing. Héctor.

Buena tarde.

 

Mucho agradeceré su apoyo para abrir el candado del proveedor 10174, PROVETECNIA, S.A. DE C.V.

 

Derivado que el día de ayer se generaron 2 pagos al proveedor pero este se encuentra en el periodo de emisión de los complementos de pago correspondientes, dichos complementos quedarán cargado en sistema tan pronto nos sean remitidos.

 

Cabe mencionar que para el día de hoy están programados 3 pagos y que dicho recurso $ ya se encuentra apartado.

 

Agradezco su atención, les envío un cordial y respetuoso saludo.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTO DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-27 15:09:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001384');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001369', 'VALIDACION DE COMPLEMENTO DE PAGO - PROVEEDOR DHL', '2024-05-24 08:45:00', 'Hola buenos dias

 

Por medio del presente se solicita se lleve a cabo la validación en papel de los complementos de pago del proveedor DHL EXPRESS MEXICO (966), lo anterior debido a la forma en la cual el proveedor emite los complementos de pago.


 

Se adjunta complemento emitido por DHL.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTO DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-27 11:30:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001369');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001370', 'CARGA DE COMPLEMENTOS DE PAGO GRUPO MAS', '2024-05-24 08:53:00', 'Buenos dias,

Por este medio solicito de su apoyo para que se permita subir el complemento de pago con folio 9946 del proveedor (2397 ) Grupo metropolitano de agua y saneamiento, ya que la fecha en que fue aplicado el pago en su sistema es el día 14/05/2024, por lo tanto se encuentran correctos.

adjunto captura de pantalla para mayor referencia',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTO DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-27 11:29:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001370');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001372', 'DIFERENCIA DE MONTO AL VALIDAR COMPLEMENTO', '2024-05-24 09:12:00', 'Buenos días

Por medio de la presente solcito el apoyo para la validación del siguiente complemento de pago, ya que presente una diferencia de en el monto del complemento de pago, la cantidad en el complemento es $5500.00 y en sistema $5499.99.

Adjunto complemento de pago para mayor referencia, de antemano agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTO DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-27 11:30:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001372');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001392', 'Error en Folios de Salida', '2024-05-27 12:09:00', 'Buen día

Solicito de su apoyo ya que no se pueden dar de baja boletas en el SIIP, al querer guardar los cambios, la plataforma se queda trabada y no concluye con el proceso

Quedo atenta, gracias!',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Bernal Hernández, Sarha Melissa'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-28 09:09:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001392');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001397', 'RECTIFICACION CAMBIO DE RECINTO FISCAL A 275', '2024-05-27 17:35:00', 'Buenas tardes, 

Por medio del presente se solicita su apoyo con el cambio de recinto fiscal de todos y cada uno de los conocimientos enumerados, los cuales deben  cambiar a recinto numero 275:',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-28 13:00:00', 'Cambio en OPERACION.MERCANCIAS Y OPERACION.DESG_MCIAS en el campo REFISM3 con el valor requerido.', 'Modificación en BD', '2024-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001397');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001399', 'SOLICITUD DE CAMBIO DE FUNDAMENTO A LA ASIGNACION DE REQUSICION 132411 Y PEDIDO 35117', '2024-05-27 18:45:00', 'Buena tarde.

Por medio del presente solicito su apoyo para realizar un cambio en el fundamento legal de la asignación de la requisición 132411 como sigue:

Dice: 16. Art.26-III, art. 41 VII
Debe decir: 14. Art. 26-III, art. 42


Así mismo, realizar el cambio en el fundamento del Pedido de Servicios 35117.
Agradezco la atención.

Saludo cordial.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-28 17:00:00', 'Se modificó en INVENTARIO.REQUISICIONES e INVENTARIO.PEDIDOS el campo FUNDAMENTOS con valor de 14', 'Modificación en BD', '2024-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001399');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001398', 'NO SE VISUALIZAN EL LISTADO DE VINS EN LA NOTIFICACION DE SALIDA DE RECINTO', '2024-05-27 17:44:00', 'BUENA TARDE ESTIMADOS DE TI;  SOLICITO DE SU APOYO YA QUE EN LA CONSULTA DE NOTIFICACION DE SALIDA DE RECINTO DEL VIAJE 240717 BUQUE: CHESAPEAKE HIGHWAY MARCA GM, A LA HORA DE REALIZAR LA CONSULTA DE VINS EN EL PROCESO DE NOTIFICACION DE SALIDA DE RECINTO NO ME ARROJA NINGUN VIN, SIENDO QUE LA MANIOBRISTA YA TRANSMITIO LA TOTALIDAD DEL RETIRO DEL PATIO DE ASIPONA.

SE REQUIERE QUE SE VISUALICEN PARA DESGLOSAR LAS FECHAS DE ACUERDO A LAS SALIDAS DEL RECINTO.

ADJUNTO PANTALLA.',
  (select id from ventanas_mesa where nombre = 'CONSULTA DE VINS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Servicio Web Automoviles'),
  (select id from solicitantes_mesa where nombre = 'Martinez Hernández, Jorge'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-28 13:00:00', 'Se modificó el buque en EDIV2.AUTOS_TRANSFERENCIA en el campo BUQUE = ''CHESAPEAKE HIGHWAY'' con una E faltante', 'Modificación en BD', '2024-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001398');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001408', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-05-28 12:39:00', 'Buena tarde
Agradeceremos el apoyo con el timbrado de las notas 16780 folio 14043 y nota 16783 folio 14046

Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-29 11:39:00', 'Se cambio el monto erroneo para ambas notas en VTNOTASCREDITO y luego en FACTURAS_TIMBRADOR se paso de 2 a 0', 'Modificación en BD', '2024-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001408');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001412', 'ASIGNACION RESIDENTE EN INTEGRAL', '2024-05-28 15:12:00', 'Buenas tardes, 

Del contrato no.  ASPN-GI-CO-62601-002-24 con rubro "Construcción de edificios para el alojamiento de personal administrativo y de apoyo (incluyendo casetas en la periferia) de la nueva aduana del Puerto Veracruz" la Arq. Pamela Estefanía Hernández Galván es la residente de ese contrato y no se encuentra asignada en el integral, para su amable apoyo para que se asigné.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Cornejo, Angelli'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-29 13:12:00', 'Se hizo el cambio en la tabla de USUARIOS para cambiar el nombre al actual y posteriormente en la tabla de FIRMAS_CONTRATO se cambio el trabnum del residente erroneo al correcto', 'Modificación en BD', '2024-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001412');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001414', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-05-28 16:16:00', 'Buena tarde

Agradeceremos el apoyo con el timbrado de la nota 16786  , folio 14049


Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-29 11:16:00', 'Se cambio el monto erroneo para la nota en VTNOTASCREDITO y luego en FACTURAS_TIMBRADOR se paso de 2 a 0', 'Modificación en BD', '2024-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001414');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001409', 'VALIDACION DE COMPLEMENTO DE PAGO - PROVEEDOR PEMEX', '2024-05-28 14:09:00', 'Hola buenos días

 

Por medio del presente se solicita se lleve a cabo la validación en papel de los complementos de pago del proveedor PEMEX TRANSFORMACION INDUSTRIAL (2593), lo anterior debido a la forma en la cual el proveedor emite los complementos de pago.


Se adjunta complemento emitido por PEMEX.

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTO DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-29 15:43:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001409');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001403', 'SOLICITUD PARA CAMBIAR ESTADO DE REQUISICION Y RETIRAR AUTORIZACIÓN PRESUPUESTAL', '2024-05-28 10:43:00', 'Buenos días, 

Derivado a la actualización de datos en la requisición 132382 se solicita cambiar su estado a TRAMITE y retirar la autorización presupuestal de dicha requisición con el fin de poder ser visualizada nuevamente por parte de la Jefatura de Presupuesto y Contabilidad para su validación.
Agradeciendo de antemano su colaboración, le envío un cordial saludo',
  (select id from ventanas_mesa where nombre = 'CONSULTA DE VINS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-29 16:24:00', 'Se modificó en INVENTARIO.REQUISICIONES en el campo ESTADO con valor de 1 y APRUEBA_CONTA con valor a 0', 'Modificación en BD', '2024-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001403');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001431', 'VIATICOS- MODULO TRAMITES Y SOLICITUDES', '2024-05-29 16:56:00', 'Buenas tardes,

De la manera más atenta solicito su apoyo para que me puedan habilitar la sección de viáticos en el modulo de TRAMITES Y SOLICITUDES, por favor.Cualquier duda o comentario quedo a sus ordenes.

Saludos.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-30 11:56:00', 'Se le asignaron los permisos a ese usuario para que pueda visualizar las ventanas de viáticos en TRAMITES Y SOLICITUDES', 'Modificación en BD', '2024-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001431');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001389', 'CAMBIO DE FECHA EN PEDIDOS', '2024-05-27 10:40:00', 'BUEN DIA 

SOLICITO CAMBIAR LA FECHA DE LOS SIGUIENTES PEDIDOS 


PEDIDO 35108 FECHA SOLICITADA 13/05/2024
PEDIDO 35115 FECHA SOLICITADA 13/05/2024
PEDIDO 35113 FECHA SOLICITADA 16/05/2024
PEDIDO 35116 FECHA SOLICITADA 13/05/2024
PEDIDO 35114  FECHA SOLICITADA 13/05/2024

TODOS LOS PEDIDOS SE ENCUENTRANEN ESTADO DE TRAMITE, SON DEL PROVEEDOR SECRETARIA DE GOBERNACION. 
QUEDO ATENTO',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-29 12:32:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDOS en los campos correspondienes de fecha', 'Modificación en BD', '2024-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001389');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001424', 'Apoyo acceso integral', '2024-05-29 11:35:00', 'Buenos días estimado compañero, 
Solicito amablemente de su apoyo, para poder reestablecer la contraseña del integral, ya que por cambio de puesto, no puedo acceder a este sistema., no se cual sea la contraseña.

Quedo atenta de su apreciable apoyo.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-30 09:35:00', 'Se actualizo el usuario en CONTACTOS01 y USUARIOS32', 'Modificación en BD', '2024-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001424');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001427', 'RECTIFICACION CAMBIO DE RECINTO FISCAL', '2024-05-29 14:22:00', 'Buenas tardes, 

Por medio del presente se solicita su apoyo con el cambio de recinto fiscal de todos y cada uno de los conocimientos enumerados, y de los cuales se indica a que recinto deben ser cambiados en la segunda columna:',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-30 12:00:00', 'Se realizó el cambio en OPERACIONES.DESG_MCIAS Y OPERACIONES.MERCANCIAS en el campo REFISM3 con el valor indicado.', 'Modificación en BD', '2024-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001427');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001422', 'APOYO CAMBIO DE FECHA REQUISICIÓN NUMERO 132422 E INVESTIGACION DE MERCADO 9862', '2024-05-29 10:08:00', 'Buen día estimados, por este medio, tengo a bien solicitar su amable apoyo a efecto de poder realizar el cambio de fecha a la requisición con número 132422 e investigación de mercado 9862 quedando definida la fecha 28/05/2024. 
Quedo al pendiente por cualquier duda o inquietud sobre lo anteriormente descrito.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-30 15:41:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES E INVENTARIO.INVESTIGACIONMERCADO en los campos correspondienes de fecha', 'Modificación en BD', '2024-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001422');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001433', 'APOYO CAMBIO DE FECHA REQUISICIÓN NUMERO 132422 E INVESTIGACION DE MERCADO 9862.', '2024-05-29 17:25:00', 'Buena tarde estimados, por este medio, tengo a bien solicitar su amable apoyo a efecto de poder realizar el cambio de fecha a la requisición con 
número 132422 e investigación de mercado 9862 quedando definida la fecha 22/05/2024. 
Quedo al pendiente por cualquier duda o inquietud sobre lo anteriormente descrito.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-30 15:23:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES E INVENTARIO.INVESTIGACIONMERCADO en los campos correspondienes de fecha', 'Modificación en BD', '2024-05-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001433');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001434', 'Cargar caratulla en integral', '2024-05-29 17:50:00', 'Buenas tardes estimado compañero, me podrían apoyar con una caratula en sistema integral, ya que al cargar los conceptos no carga los datos del concepto seleccionado. relativo al contrato ASPN-GI-CO-62602-010-22-AC de rubro “DESMANTELAMIENTO Y REHABILITACIÓN DE ALMACENES Y CASETAS DE CONTROL DE ACCESO UBICADOS EN LA BAHÍA SUR DEL PUERTO DE VERACRUZ EN EL EJERCICIO 2022 - 2023” a cargo de  















Servicios Industriales
y de Infraestructura GOSAN, S.A. de C.V.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-30 12:50:00', 'Se agrego en la tabla tmpestimaciones en el esquema de obras una estimacion de tipo AJUSTE sin conceptos la cual  permitio realizar la anexion de los conceptos a el contratista', 'Modificación en BD', '2024-05-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001434');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001432', 'Cambio conceptos de Convenio a Normal', '2024-05-29 17:08:00', 'Solicito su apoyo para que los siguientes conceptos del contrato ASPN-GI-CO-62601-002-23 se puedan cobrar en sistema como estimación 
NORMAL:',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-30 17:09:00', 'En la tabla CPTOSCONTRATADOS se modificaron los conceptos (7,8,9,10,11,12,13,14,53 y 54) de la partida 80484 pasando de tipo Convenio a tipo Normal', 'Modificación en BD', '2024-05-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001432');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001440', 'APOYO CAMBIO DE FECHA REQUISICIÓN NUMERO  132422', '2024-05-30 11:37:00', 'Buen día estimados, por este medio, tengo a bien solicitar su amable apoyo a efecto de poder realizar el cambio de fecha a la requisición con número 132422 quedando definida la fecha 28/05/2024. 
Quedo al pendiente por cualquier duda o inquietud sobre lo anteriormente descrito',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 11:53:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES en los campos correspondienes de fecha', 'Modificación en BD', '2024-05-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001440');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001443', 'APOYO PARA CAMABIO DE RUBRO COMPROBACIÓN DE VIATICOS', '2024-05-30 15:22:00', 'Buenas tardes, estimados. 

Solicito su valioso apoyo para cambiar un rubro en un elemento de comprobación de viáticos con Folio 4591 (En la imagen de abajo, lo subraye en amarillo): 
DICE: 4- CONSUMO DE ALIMENTOS 
DEBE DECIR: 2- SERVICIO DE TAXI 
Quedo atenta a cualquier duda y agradezco mucho su ayuda. 
Bonito día',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Martínez, Gabriela Yuritzi'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 10:22:00', 'Modificar en OPERACIONES.VTCOSDETCOMPROBACION en el campo RUBRO con el valor indicado', 'Modificación en BD', '2024-05-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001443');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001439', 'MODIFICACION EN REQUISICION TABLERO PRESUPUESTAL', '2024-05-30 09:57:00', 'Buenos días.
Derivado a la actualización de datos en la requisición 132389 se solicita RETIRAR LA AUTORIZACIÓN PRESUPUESTAL de dicha requisición con el fin de poder ser visualizada nuevamente por parte de la Jefatura de Presupuesto y Contabilidad para su validación, así como tambien realizar el CAMBIO DE ESTADO de la misma requisición de AUTORIZADO a "TRÁMITE"
De ante mano muchas gracias.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Tablero Presupuestal'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 12:16:00', 'Se modificó en INVENTARIO.REQUISICIONES en el campo ESTADO con valor de 1 y APRUEBA_CONTA con valor a 0', 'Modificación en BD', '2024-05-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001439');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001442', 'COMPLEMENTO CON DIFERENCIA DE 0.1 CENTAVO', '2024-05-30 13:31:00', 'Por este medio solicito de su apoyo para que pueda cargar en el Mediport el complemento de pago del proveedor: RAMOS MANGE ISRAEL, ya que tiene una diferencia de 1 centavo y no me permite cargarla en el sistema con numero de folio: 9974.


    Diferencias en =Importe anterior= [XML:7540.27 / Sistema:7540.26]
    Diferencias en =Importe pagado= [XML:7540.27 / Sistema:7540.26]',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTO DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 10:20:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001442');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001436', 'DIFERENCIA DE MONTO AL VALIDAR LA FACTURA', '2024-05-29 19:15:00', 'Buenas tardes


Por medio de la presente solicito su apoyo para validar la factura con folio 81799, ya que presenta una diferencia de 10 centavos arriba del pedido 35119 y lo pagado al proveedor: COSTCO DE MEXICO, S.A. DE C.V.


Anexo imagen del error y archivos de facturación para mayor referencia',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTO DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 10:27:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-05-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001436');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001450', 'Boletas de liberación', '2024-05-30 17:10:00', 'Buenas tardes, 

Me podrían apoyar modificando la fecha en la boleta de liberación con folio 95042 
 DICE:25/05/2004 DEBE DECIR:25/05/2024',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Machado Piña, Hilda'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 12:10:00', 'Se modificó OPERACION.FOLIOS_SALIDA y OPERACION.DET_MOVS_ALM la fecha correspondiente', 'Modificación en BD', '2024-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001450');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001458', 'ELIMINACION DE FOLIO SIIP *35856*', '2024-05-31 10:55:00', 'Buen día 
Solicito de su apoyo para eliminar el folio de cotización 35856 ya que se enlazó a una requisición que no corresponde. Se validó en pedidos y la requisición a la que se asignó, no corresponde. 

agradezco de antemano el apoyo 

quedo al pendiente de sus amable apoyo 

saludos!!',
  (select id from ventanas_mesa where nombre = 'COTIZACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cotizaciones'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 15:55:00', 'Se elimino de INVENTARIOS.COTIZACIONES el registro requerido', 'Modificación en BD', '2024-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001458');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001449', 'cuadre en MEDIPORT', '2024-05-30 17:04:00', 'Se solicita su apoyo para el cuadre del conocimiento 1 a 0 en Mediport, ya que se muestra que no hay más existencias y el peso cuentan con .167 debiendo quedar en 0.
Buque: Genco Languedoc       ID: 240324',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 12:04:00', 'Se cambió en OPERACION.FOLIOS_SALIDA la cantidad de salida,  OPERACION.ACUMULADOS_ALM, OPERACION.DET_MOVS_ALM, OPERACION.DESG_MCIAS en los campos referente a la cantidad de salida de la carga', 'Modificación en BD', '2024-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001449');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001453', 'DIFERENCIA DE MONTO AL VALIDAR LA FACTURA.', '2024-05-30 20:48:00', 'Buenas noches
Por medio de la presente solicito su apoyo para validar la factura con folio 81807, ya que presenta una diferencia de 45 centavos arriba del pedido 35109 y lo pagado al proveedor: COSTCO DE MEXICO, S.A. DE C.V.


Anexo imagen del error y archivos de facturación para mayor referencia',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-03 12:49:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001453');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001455', 'CAMBIO EN ESTADO DE COTIZACION', '2024-05-31 10:23:00', 'buenos Días Por medio de la presente solicito su apoyo para el cambio de estado de el cotizacionnumero 35849 de estado ORDENADO a estado ABIERTOCON LA IMAGEN ADJUNTA',
  (select id from ventanas_mesa where nombre = 'COTIZACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-05-31 17:18:00', 'Se modificó en INVENTARIOS.COTIZACIONES en el campo de Estado de valor 2 a 1', 'Modificación en BD', '2024-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001455');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001474', 'Solicitud de carga de factura en papel', '2024-06-03 11:53:00', 'Buenos días

Por medio de la presente solicito su apoyo para la carga en papel de la factura adjunta ya que el proveedor  por el pago de derechos es GOBIERNO DEL ESTADO DE VERACRUZ, otro de los errores que envía es que la diferencia del monto ya que el proveedor  IVAN RAMOS MANGE es RESICO, adjunto factura.
No. de folio: 81812
Pedido: 35033',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-04 09:14:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001474');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001498', 'no recibo  correos de incidencias', '2024-06-04 15:42:00', 'no me llegan  los correos de las incidencias',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-05 12:42:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001498');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001499', 'NO PUEDO CONTESTAR MIS INCIDENCIAS DEL MES', '2024-06-04 16:36:00', 'NO PUEDO ACEDERP AL SIP EN EL AREA DE JUSTIFICACION DE INCIDENCIAS',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'González Vargas, Marilyn Monserrath'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-05 11:36:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001499');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001489', 'Activacion de usuario siipv2', '2024-06-04 10:26:00', 'Buenos días espero me puedan apoyar con la activación de usuario secplaneacion para poder hacer mis incidencias',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Robledo Navarrete, Dolores'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-05 09:26:00', 'Se modificó en EDIV2.USUARIOS el campo ACTIVO de 1 a 0, para el usuario que ya no iba a utilizar', 'Modificación en BD', '2024-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001489');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001500', 'incidencias SIIP', '2024-06-04 17:56:00', 'Buenas tardes, a quien corresponda 

Por la presente, solicito apoyo para eliminar el registro de incidencias con folio 11740, ya que se cometió un error al momento de tramitar, y se sustituyo por la incidencia con el numero de folio 11742 

Agradezco su apoyo de antemano',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Gozo Avila, Jesus Guillermo'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-05 12:56:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001500');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001503', 'Solicitud de usuario y contraseña para el sistema integral de estimaciones', '2024-06-05 11:04:00', 'Buenos días, consecuencia de mi cambio de puesto, solicito su ayuda para que me compartan el usuario y contraseña que deberé usar para ingresar al sistema integral, gracias.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'González Martínez, Francisco de Jesus'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-05 16:04:00', 'Se modifico en las tablas USUARIOS32 y CONTACTOS01 la informacion en el usuario de integral correspondiente', 'Modificación en BD', '2024-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001503');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001491', 'clave mediport', '2024-06-04 12:03:00', 'Buenos días, por el presente se les solicita nombre de usuario y clave para el sistema mediport , para el Cap. Francisco Javier Hernandez Rolón, Jefe de señalamiento marítimo de nuevo ingreso
Con los mismos privilegios de un operador radarista,
por su atención, gracias',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Accesos'),
  (select id from solicitantes_mesa where nombre = 'Ortiz Morales, Cesar'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-05 10:03:00', 'Se ejecutó el procedimiento almacenado REPLICA_PERMISOS_USUARIOS con el usuario original con todos los permisos, y el usuario que los va a recibir.', 'Modificación en BD', '2024-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001491');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001504', 'USUARIO DE MEDIPORT', '2024-06-05 11:04:00', 'Buen día se solicita el nuevo usuario de Mediport para la compañera Patricia Elizabeth Flores López, auxiliar de control y almacenaje, asignada al departamento de Documentación.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-05 16:04:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001504');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001505', 'Usuario de SIIP', '2024-06-05 11:06:00', 'Buen día se solicita el nuevo usuario de SIIP para la compañera Patricia
Elizabeth Flores López, auxiliar de control y almacenaje, asignada al departamento de Documentación.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-06 09:33:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001505');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001515', 'CANCELACION DE ARTICULO 23 || MV GRANDE TORINO', '2024-06-05 15:56:00', 'Buen día, Por favor de su para la Cancelación de Articulo 23 de Exportación, debido a que el día de hoy se Cancelo por información faltante, sin embargo sigue apareciendo como pendiente de firma.',
  (select id from ventanas_mesa where nombre = 'TRAMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-06 10:56:00', 'Modificar en EDIV2.FLUJODOCUMENTO el campo NIDUSUARIO  en vacío, eliminando la firma del usuario en ese documento, y en el campo NIDESTADODOC con valor a 2 para que esté pendiente de revisar y lo puedan volver a firmar, también cambiar en EDIV2.DOCUMENTO el campo de estado a 2.', 'Modificación en BD', '2024-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001515');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001522', 'Tramite de incidencias', '2024-06-05 20:41:00', 'Buenas tardes Estimado compañero, 

Tengo problemas para guardar y/o tramitar mis incidencias:',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-06 17:00:00', 'Se modificó EDIV2.USUARIOS el campo activo con valor 0 y el campo trabnum con 0, para que existe usuario duplicado.', 'Modificación en BD', '2024-06-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001522');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001523', 'Error en sistema integral', '2024-06-06 10:37:00', 'Buen día estimado compañero, 
En relación al contrato ASPN-GI-CO-62602-006-24, la empresa contratista comenta que no le permite cargar la caratula, y que al llamar a soporte, le pidieron que el residente tendría que levantar una mesa de ayuda, por lo que me permito solicitar de su apoyo para poder corregir el error.
comparto captura de pantalla de la empresa contratista',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-06 03:37:00', 'se agregaron los permisos faltantes al usuario en la tabla CONTACTO_PERMISO16', 'Modificación en BD', '2024-06-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001523');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001519', 'Eliminar 2% al millar en caratula', '2024-06-05 05:05:00', 'Buenas tardes Estimado compañero,  En relación al contrato ASPN-GI-CS-62601-005-24 de rubro "Ejecución de los programas y estudios ambientales de la quinta etapa del Libramiento Ferroviario, en la UMA Punta Gorda, la ZAL, Boulevard Bahía Norte, en la UMA La Pinera y en el área de exportación para la Nueva Aduana de Veracruz, periodo 2024-2025" a cargo de   TAEK Taller de Arquitectura Ambiental, S.A. de C.V.

al respecto se informa que la empresa desistió de la aplicación de la deducción del 2% al millar, por lo que se solicita de su apoyo para eliminar esto de su caratula de sus estimaciones en el sistema integral.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-07 09:03:00', 'Se elimino el registro con valor 7 del contrato en la tabla DEDUCCIONES', 'Modificación en BD', '2024-06-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001519');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001521', 'ERROR EN CARGA MEDIPORT COMPLEMENTO DE PAGO', '2024-06-05 18:29:00', 'Buenas tardes estimados.
Solicito de su amable apoyo para poder validar el complemento de pago adjunto,
mismo que corresponde al FOLIO 9851 en el apartado VALIDAR COMPLEMENTO 
en MediPort, para poder continuar con el proceso.

Se adjunta imagen del error mostrado.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-07 10:22:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001521');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001520', 'PONER  INCIDENCIA EN ESTADO ABIERTA', '2024-06-05 18:00:00', 'PONER  INCIDENCIA EN ESTADO ABIERTA',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-06 17:00:00', 'Se eliminó incidencia con procedimiento almacenado ELIMINA_INCIDENCIA', 'Modificación en BD', '2024-06-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001520');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001535', 'APOYO PARA SUBIR FACTURA EN MEDIPORT - FERNANDO RAFAEL RUIZ LOPEZ', '2024-06-06 16:24:00', 'Buenas tardes, 
En seguimiento a la mesa de ayuda REQ 2024-001497, debido al número de decimales que permite agregar el SIIP en el apartado de cantidad y al no ser posible realizar la modificación manualmente de la cantidad .595971223, se dio continuidad a la recepción de materiales y al módulo de facturación, obteniendo el folio de factura: 81846, mismo que muestra una diferencia de dos centavos con la factura del primer pago de acuerdo a lo señalado en el contrato, el cual debe ser por la cantidad de $414,200.00.',
  (select id from ventanas_mesa where nombre = 'CARGAR FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-10 08:33:00', 'Se modificó INVENTARIO.FACTURAS e INVENTARIO.FOLIOS_FACTURA en el campo de monto', 'Modificación en BD', '2024-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001535');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001545', 'SOLICITUD DE CANCELACION_SOLICITUD COPIA SIMPLE_CODIGO_CAM-SM-050624-2458796', '2024-06-07 16:51:00', 'Buenas tardes, 

De su apoyo con la cancelación de la Solicitud de Copia Simple , con el número de código CAM-SM-050624-2458796; el cual por error se autorizo, debiendo ser cancelada por motivos de corrección de documentos oficiales.

Comparto imagen de la solicitud en cuestión para mayor referencia:',
  (select id from ventanas_mesa where nombre = 'TRÁMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-10 10:51:00', 'Se realizó cancelación en EDIV2.DOCUMENTO y EDIV2.FLUJODOCUMENTO en campo estadodoc = 1 y estado = 1', 'Modificación en BD', '2024-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001545');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001497', 'SUSTITUCIÓN EN CANTIDAD DE RECEPCIÓN DE MATERIALES || ROVEEDOR FERNANDO RAFAEL RUIZ', '2024-06-04 13:53:00', 'Buenos tardes, Por medio del presenta se solicita su apoyo para modificar manualmente la cantidad en la recepción de materiales  No. 38731 a .595971223, lo anterior debido a que son dos pagos los que se deben generar durante la vigencia del servicio. 

El primero de ellos por la cantidad de $414,200.00 que equivale al 59.5971223 del monto total del contrato ($695,000.00).',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Recepción de Materiales (embarque)'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Suárez Vázquez, Héctor Andrés'),
  '2024-06-05 16:53:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001497');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001540', 'Caratula en integral', '2024-06-07 11:53:00', 'Buen día estimado compañero, 
En relación al contrato ASPN-GI-CO-62602-006-24, la empresa contratista comenta que no le permite cargar la caratula, y que al llamar a soporte, le pidieron que el residente tendría que levantar una mesa de ayuda, por lo que me permito solicitar de su apoyo para poder corregir el error.
Se trata de un error en el cual, se carga un concepto pero no le aparece en la caratula.
Gracias de antemano por el apoyo.
El periodo de estimación es del 1 de abril de 2024 al 30 de abril de 2024,
la fecha de estimación es 07 de junio de 2024
El concepto seria el siguiente:',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-06-10 09:53:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001540');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001549', 'DICE Y DEBE DECIR.', '2024-06-10 14:22:00', 'Buenas tardes;

Solicito de su valioso apoyo para realizar un dice y debe decir por cambio de bultos a folio de exportación, esto por petición de la agencia aduanal vía correo electrónico.
BUQUE: FWN BONAFIDEID: 240798FOLIO: 498306
DICE: 15,226 BULTOS
DEBE DECIR: 15,206 BULTOS.

Adjunto captura para mejor referencia.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Mercancías de Exportación'),
  (select id from solicitantes_mesa where nombre = 'Limón Acevedo, Rodolfo'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-11 10:22:00', 'Se modificó en OPERACION.DESG_MCIAS en los campos CANTIDAD, EXISTENCIA, en OPERACION.DET_MOVS_ALM en el campo CANTIDAD_ALM, en OPERACION.ACUMULADOS_ALM en los campos ENTRADAS, SALDO_ENTRADA, SALIDA, SALDO_SALIDA, para que se visualice en mediport, se modificó en EDIV2.SOLMULTIPLE_CARGA en PESO, y EDIV2.TABLERO_CARGA_DETALLE', 'Modificación en BD', '2024-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001549');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001555', 'DICE Y DEBE || NO DE BULTOS || MV FWN BONAFIDE', '2024-06-11 10:58:00', 'Buen dia, Estimados Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos al Artículo 23, por petición de Agente Aduanal vía correo electrónico. BUQUE: FWN BONAFIDE 
ID:  240601
FOLIO: 495239
DICE:  16, 439 BTS
DEBE DECIR: 16, 407 btos',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-11 17:58:00', 'Se modificó en OPERACION.DESG_MCIAS en los campos CANTIDAD, EXISTENCIA, en OPERACION.DET_MOVS_ALM en el campo CANTIDAD_ALM, en OPERACION.ACUMULADOS_ALM en los campos ENTRADAS, SALDO_ENTRADA, SALIDA, SALDO_SALIDA, para que se visualice en mediport, se modificó en EDIV2.SOLMULTIPLE_CARGA en PESO, y EDIV2.TABLERO_CARGA_DETALLE', 'Modificación en BD', '2024-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001555');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001553', 'DICE Y DEBE || NO. DE BULTOS', '2024-06-11 10:33:00', 'Buen dia, Estimados Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos al Artículo 23, por petición de Agente Aduanal vía correo electrónico. BUQUE: JANNES 
ID:  240771
FOLIO: 497338
DICE:  5,835 btos
DEBE DECIR: 5,066 btos',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-12 09:33:00', 'Se modificó en OPERACION.DESG_MCIAS en los campos CANTIDAD, EXISTENCIA, en OPERACION.DET_MOVS_ALM en el campo CANTIDAD_ALM, en OPERACION.ACUMULADOS_ALM en los campos ENTRADAS, SALDO_ENTRADA, SALIDA, SALDO_SALIDA, para que se visualice en mediport, se modificó en EDIV2.SOLMULTIPLE_CARGA en PESO, y EDIV2.TABLERO_CARGA_DETALLE', 'Modificación en BD', '2024-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001553');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001554', 'cambio de fecha', '2024-06-11 10:54:00', 'buenos dias

dela boleta de liberación de importación  con folio 95527 en la fecha de salida  debe decir  07/06/24',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-11 17:54:00', 'OPERACION.DET_FOLIOS_SALIDA en fecha y comparar con OPERACION.DET_MOVS_ALM en F_MOV para que coincidan', 'Modificación en BD', '2024-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001554');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001559', 'REACTIVAR ANEXO 4 DE CABOTAJE.', '2024-06-11 12:42:00', 'Buenas tardes;

Solicito de su valioso apoyo para quitar el estatus de rechazo a un anexo 4 de cabotaje para poder asignármelo y firmarlo ya que si se utilizara este folio.
BUQUE: MARID: 240632FOLIO: 495250CODIGO MEDIPORT: NAV-SM-020424-2443190
Adjunto imagen del tramite para mayor referencia.',
  (select id from ventanas_mesa where nombre = 'TRÁMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Cabotaje'),
  (select id from solicitantes_mesa where nombre = 'Limón Acevedo, Rodolfo'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-12 11:42:00', 'Se modificó en EDIV2.FLUJODOCUMENTO en los campos NIDESTADODOC a 2 y NIDUSUARIO vacío, Y EDIV2.DOCUMENTO en el campo ESTADODOC en 2.', 'Modificación en BD', '2024-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001559');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001561', 'ELIMACIÓN FOLIO FACTURA', '2024-06-11 13:45:00', 'Buenas tardes
solicito de su apoyo para eliminar la factura con folio 81868 en el sistema SIIP.',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-12 12:45:00', 'Se eliminó de CUSTOM_DATA e INVENTARIO.FACTURAS', 'Modificación en BD', '2024-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001561');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001469', 'ELIMINAR UNA NOTIFICACIÓN DE CORREO AUTOMÁTICA', '2024-06-03 09:57:00', 'ESTIMADOS.
Solicito de su apoyo para eliminar la notificación automática de un correo (RECORDATORIO DE COMPROBACIÓN DE VIATÍCOS) que de forma reiterada me llega al buzón, el cual pertenece a la anterior subgerente de operaciones y almacenes (Lic. Isaura Rosales).

Gracias de antemano,',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Salazar Loredo, Roberto'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-03 14:57:00', 'Se dio de baja el usuario anterior en VIATICOS.USUARIOS  en el campo USUACTIVO con valor 0, y se eliminó el correo asignado en EMAIL', 'Modificación en BD', '2024-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001469');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001556', 'COMPLEMENTOS DE PAGO CFE', '2024-06-11 11:04:00', 'BUEN DIA 
SOLICITO ABRIR LOS CANDADOS DEL PROVEEDOR 2370 CFE SUMINISTRADOR DE SERVICIOS BASICOS PARA REALIZAR LOS  PRIMEROS 8 PAGOS  DEL MES DE JUNIO
QUEDO ATENTO. SALUDOS',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-12 16:52:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-06-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001556');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001571', 'eliminar conocimientos', '2024-06-12 11:42:00', 'del buque  MSC PHOENIX de importacion  id 240594  se adjunta n conocimientos a eliminara solicitud  de la agencia  RMA-SM-030624-2458238',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-12 16:42:00', 'Se eliminaron manifiestos de OPERACION.DESG_MCIAS y OPERACION.MERCANCIA', 'Modificación en BD', '2024-06-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001571');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001580', 'ERROR EN REPORTE IMPRESO DE PEDIDO', '2024-06-13 10:56:00', 'Buenos días.  En continuidad con lo solicitado en la mesa de ayuda de código REQ 2024-001260 se solicita su apoyo para que al momento de la impresión del PEDIDO 35055 se pueda observar el mismo fundamento del cambio realizado.  Se adjunta imagen de como aparece en sistema   CAMBIO REALIZADO: Sin otro particular, agradezco el apoyo.  Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-13 15:56:00', 'Se modificó en INVENTARIO.PEDIDOS en el campo de FUNDAMENTO con valor 14', 'Modificación en BD', '2024-06-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001580');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001575', 'CAMBIO DE TIPO DE ADJUDICACION EN CONTRATO', '2024-06-12 17:10:00', 'Buenas tardes, estimados.


Solicito de su amable apoyo para realiza el cambio de la sección Adjudic. a la ORDEN 34892 en el SIIP.

Se adjunta imagen para pronta referencia.Dice: 0.DIRECTA CON PEDIDO
Debe decir: DIRECTA CON CONTRATO',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-13 16:10:00', 'Se modificó INVENTARIO.PEDIDOS en el campo TIPOADJ con valor requerido', 'Modificación en BD', '2024-06-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001575');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001574', 'DICE Y DEBE DECIR', '2024-06-12 16:47:00', 'Buenas tardes;

Solicito de su valioso apoyo para realizar una solicitud por dice y debe decir a folio de exportación en cambio de bultos.

BUQUE: BBC AMETHYST
ID: 241006
FOLIO: 501232

DICE: 3,563 BULTOS

DEBE DECIR: 3,492 BULTOS.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Mercancías de Exportación'),
  (select id from solicitantes_mesa where nombre = 'Limón Acevedo, Rodolfo'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-13 15:47:00', 'Se modificó en OPERACION.DESG_MCIAS en los campos CANTIDAD, EXISTENCIA, en OPERACION.DET_MOVS_ALM en el campo CANTIDAD_ALM, en OPERACION.ACUMULADOS_ALM en los campos ENTRADAS, SALDO_ENTRADA, SALIDA, SALDO_SALIDA, para que se visualice en mediport, se modificó en EDIV2.SOLMULTIPLE_CARGA en PESO, y EDIV2.TABLERO_CARGA_DETALLE', 'Modificación en BD', '2024-06-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001574');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001583', 'DICE Y DEBE || NO. DE BULTOS || MV OSLO BULK 5 || EXPO', '2024-06-13 12:55:00', '561Buen día 
Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos al Artículo 23, por petición de Agente Aduanal vía correo electrónico. 

BUQUE: OSLO BULK 5 
ID:  241050
FOLIO: 501391
DICE:  10, 580 BTS
DEBE DECIR: 10, 561 btos',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-14 12:21:00', 'Se modificó en OPERACION.DESG_MCIAS en los campos CANTIDAD, EXISTENCIA, en OPERACION.DET_MOVS_ALM en el campo CANTIDAD_ALM, en OPERACION.ACUMULADOS_ALM en los campos ENTRADAS, SALDO_ENTRADA, SALIDA, SALDO_SALIDA, para que se visualice en mediport, se modificó en EDIV2.SOLMULTIPLE_CARGA en PESO, y EDIV2.TABLERO_CARGA_DETALLE', 'Modificación en BD', '2024-06-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001583');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001600', 'CANCELACION DE SOLICITUD COPIA SIMPLE', '2024-06-17 11:31:00', 'Hola buen día equipo 

Solicito de su apoyo para realizar la cancelación de la copia simple codigo RC-SM-130624-2460856 del buque WOLVERINE con ID: 241085 del conocimiento 4, ya que el agente aduanal mando correo indicando que rectificara el pedimento.

Quedo atento, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'TRÁMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-18 10:31:00', 'Se realizó cancelación en EDIV2.DOCUMENTO y EDIV2.FLUJODOCUMENTO en campo estadodoc = 1 y estado = 1', 'Modificación en BD', '2024-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001600');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001609', 'NO PERMITE GUARDAR LA INCIDENCIA', '2024-06-18 09:16:00', 'Buen día, al hacer mi justificación de incidencia en SIIP no permite guardar y continuar con el proceso, ya se ha intentado varias veces, se ha reiniciado el programa y nada. Se anexa pantalla.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-18 17:16:00', 'Seguimieto de proceso', 'Seguimiento de proceso', '2024-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001609');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001614', 'Solicitud de cambio de fecha', '2024-06-18 12:09:00', 'Hola buenos dias

Por medio del presente solicito de su colaboración para que se lleve a cabo el cambio de fecha del pedido 35273 la fecha que debe tener es del 31/05/2024.

sin mas por el momento quedo atento, saludos.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 11:12:00', 'Se modificó en INVENTARIO.PEDIDOS en las campos de fecha que no sean null', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001614');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001612', 'CAMBIO DE FECHA', '2024-06-18 11:15:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido de servicios: 35164
Para que DIGA: 22/05/2024.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 10:19:00', 'Se modificó en INVENTARIO.PEDIDOS en las campos de fecha que no sean null', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001612');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001547', 'CAMBIO DE FECHA EN REQUISICIÓN 132536', '2024-06-10 12:54:00', 'Por este medio, se solicita su amable apoyo para realizar un cambio de fecha a la requisición 132536 y a su IM 9967 , con fecha del 20/05/2024.
De antemano, gracias.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 09:09:00', 'Seguimieto de proceso', 'Seguimiento de proceso', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001547');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001578', 'CAMBIO DE FECHA EN PEDIDO', '2024-06-12 18:27:00', 'Buena tarde 

Por medio del presente solicito de su colaboración para que se lleve a cabo el cambio de fecha del pedido 35273 la fecha que debe tener es del 31/05/2024.

sin mas por el momento quedo atento,saludos.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Toris Fabian, Samuel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-18 17:53:00', 'Seguimieto de proceso', 'Seguimiento de proceso', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001578');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001605', 'ACTUALIZACIÓN DE REQUISITOS - SIRE', '2024-06-17 15:48:00', 'Buen día Solicito de su amable apoyo para habilitar los requisitos que se encuentran en SIRE de la empresa CONTROL CARGO INTERNACIONAL SA DE CV, ya que no se visualizan:

PAGINA WEB EMPRESARIALANEXO 4 CARTA CONTRATACION DE SEGUROSPROCEDIMIENTOS OPERACIONALES REGISTRO PATRONAL IMSSANEXO 5 TABLA DE ASPECTOS AMBIENTALESANEXO 3 CARTA COMPROMISO CALIDAD',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-18 15:48:00', 'Se agregaron registros en EDIV2.CONTRATOS_SOLICITUD_DETALLE y crearles un flujo en EDIV2.CONTRATOS_SOLICITUD_FLUJO con valor 1 de rechazado.', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001605');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001616', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-06-18 13:20:00', 'Buena tarde

Agradeceremos el apoyo con el timbrado de la nota de egreso 16820, folio 14081 

Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-06-19 11:20:00', 'Se hizo el cambio en VTNOTASCREDITO en el campo monto, en la tabla FACTURAS_TIMBRADOR se hizo el cambio en timbrado de 2 a 0', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001616');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001592', 'ACTUALIZACIÓN DE REQUISITOS - SIRE', '2024-06-14 12:56:00', 'Buenas tardes, 

Solicito de su amable apoyo para habilitar los requisitos de: 
-PROGRAMA DE MANTENIMIENTO 
-TARJETA DE CIRCULACION SICT

Del prestador de servicios MARINOIL SERVICIOS MARÍTIMOS SA DE CV, ya que no se visualizan.

Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-17 10:56:00', 'Se agregaron registros en EDIV2.CONTRATOS_SOLICITUD_DETALLE y crearles un flujo en EDIV2.CONTRATOS_SOLICITUD_FLUJO con valor 1 de rechazado.', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001592');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001615', 'ACTUALIZACIÓN DE REQUISITOS - SIRE', '2024-06-18 12:32:00', 'Buen día, 

Solicito de su amable apoyo para agregar los requisitos que no se visualizan del siguiente prestador en el SIRE; ACTA CONSTITUTIVA EDOS. FINANCIEROSPOLIZAS DE SEGURO EQ. DE OPERACIÓNRELACION DE BARRERAS NUEVAS POR TAMAÑO DE EMBARCACION Y TIPO DE MATERIAL A CONTENERCERTIFICADO DE MATRICULA PARA EMBARCACIONES DE CARGA
LIBRETA DE MAR DEL PERSONAL A CARGOMuchas gracias.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 10:32:00', 'Se agregaron registros en EDIV2.CONTRATOS_SOLICITUD_DETALLE y crearles un flujo en EDIV2.CONTRATOS_SOLICITUD_FLUJO con valor 1 de rechazado.', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001615');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001618', 'APOYO PARA CAMBIAR ABREVIATURA EN EL SISTEMA SIPV2', '2024-06-18 15:44:00', 'Buena tarde. Por instrucciones del Lic. Jaime Lara Carrión, me permito solicitar amablemente su apoyo, a fin de que se pueda modificar en los formatos de diversos trámites que se realizan en el sistema SIPV2, la abreviatura que va antes del nombre del Licenciado Jaime (se adjunta imagen al presente para su pronta referencia), es decir, que se sustituya la palabra "ABOGA" por la abreviatura "LIC.".Quedo atenta a cualquier duda o comentario al respecto.Saludos.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 13:44:00', 'Se modificó NOMINA.EMPLEADOS en el campo TITULO con valor LIC.', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001618');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001589', 'Quitar rechazo en SIRE (MEXROM)', '2024-06-14 10:46:00', 'Se solicita cambiar el estatus de rechazado ya que el documento es correcto.
En el SIRE, en la solicitud de MEXROOM en el nombre del archivo:
   AVISO EMITIDO POR LA SECRETARIA DE SALUD ESTATAL',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Cruz González, Gerardo'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-14 17:46:00', 'Se modificó EDIV2.CONTRATO_SOLICITUD_DETALLE en el campo estado, y EDIV2.CONTRATO_SOLICITUD_FLUJO en el campo ESTADO con valor pendiente de revisión', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001589');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001623', 'no se guardan mis justificaciones de incidencias en siip', '2024-06-19 11:25:00', 'Buena tarde
al guardar mis incidencias y abrir para tramitar no se guardan las incidencias 
anexo captura de pantalla 
saludos',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Belchez Notni, Mario'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-06-20 09:25:00', 'En la tabla USUARIOS de esquema EDIV2 se desactivo al usuario duplicado asi como en la tabla USUARIOS del esquema CONTROL', 'Modificación en BD', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001623');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001622', 'Carga de facturas', '2024-06-19 10:53:00', 'Hola buenos días

Por medio de la presente se solicita su apoyo para cargar la factura del proveedor DHL, ya que se tiene un complemento pendiente el cual ya fue solicitado al proveedor, sin embargo al ser un servicio prioritario se necesita tramitar el pago correspondiente.

Folio: 81935',
  (select id from ventanas_mesa where nombre = 'FACTURACIÓN ELECTRÓNICA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 17:55:00', 'Seguimieto de proceso, apertura de candados', 'Seguimiento de proceso', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001622');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001597', 'CAMBIO DE FECHA EN CONTRA RECIBO', '2024-06-14 17:49:00', 'Buenas tardes, Solicito su apoyo para cambio de fecha de vencimiento en los siguientes contra recibos:',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Valentin Aguirre, Jarumi de los Angeles'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 17:55:00', 'Se realizó la modificación de fecha en INVENTARIO.FACTURAS en el campo FECHAPAGO para la fecha de vencimiento con el valor solicitado.', 'Modificación en BD', '2024-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001597');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001613', 'FACTURA EN PAPEL', '2024-06-18 11:37:00', 'Por este medio solicito de su apoyo para que en el FOLIO: 9509, de complementos de pago del proveedor: ORACLE DE MEXICO, S.A. DE C.V. se pueda subir el complemento de pago en papel ya que no permite subirlo por que el pago se efectuó al tipo de cambio.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 17:23:00', 'Seguimieto de proceso, apertura de candados', 'Seguimiento de proceso', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001613');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001595', 'APOYO PARA PODER VALIDAR COMPLEMENTOS DE PAGO GRUPO MAS', '2024-06-14 16:37:00', 'Buena tarde por medio del presente solicito de su apoyo para que me apoyen a validar los complementos de pago del proveedor Grupo metropolitano de agua y saneamiento,  debido a que al intentar cargarlos me muestra  diferencias en fechas de pago, adjunto pantallas de evidencia y archivos de facturas quedo atento, saludos.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Toris Fabian, Samuel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-20 10:39:00', 'Seguimieto de proceso', 'Seguimiento de proceso', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001595');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001607', 'cambio de estado en recepción de servicios', '2024-06-17 17:30:00', 'Por este medio solicito de su apoyo para que el embarque: 38625 aparezca en estado abierto ya que aparece como estado parcialmente facturado.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-20 09:01:00', 'Se modificó en INVENTARIO.EMBARQUES en el campo ESTADO con valor 1 para que esté abierto', 'Modificación en BD', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001607');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001619', 'Carga de complementos de pago', '2024-06-18 18:59:00', 'Hola buenas tardes
Por medio de la presente solicito su apoyo para validar complementos de pago del proveedor PEMEX, ya que presentan error al intentar validar, adjunto complementos de pago para mayor referencia.
FOLIOS: 10026 Y  10027.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-20 09:58:00', 'Seguimieto de proceso, apertura de candados', 'Seguimiento de proceso', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001619');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001507', 'DIFERENCIA DE MONTO AL VALIDAR LA FACTURA.', '2024-06-05 11:21:00', 'Por medio de la presente solicito su apoyo para validar la factura con folio 81833, ya que presenta una diferencia de 10 centavos arriba del pedido 35227 y lo pagado al proveedor: COSTCO DE MEXICO, S.A. DE C.V.


Anexo imagen del error y archivos de facturación para mayor referencia',
  (select id from ventanas_mesa where nombre = 'TRÁMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-19 16:01:00', 'Seguimieto de proceso, apertura de candados', 'Seguimiento de proceso', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001507');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001624', 'cambio de recinto', '2024-06-19 12:10:00', 'buenos días favor de realizar el cambio de recinto del buque AFRICAN SPOONBI  241093 cambiar al recinto que dice el archivo adjunto.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-20 10:10:00', 'Se modificó en OPERACION.MERCANCIA en el campo REFISM3 con valor de 271. Se omitió DESG_MCIAS ya que aparecía con el recinto requerido.', 'Modificación en BD', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001624');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001627', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-06-19 15:15:00', 'Buena tarde

Agradeceremos el apoyo con el timbrado de la nota de egreso  16833 , folio 14093  


Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-06-20 12:15:00', 'Se hizo el cambio en VTNOTASCREDITO en el campo monto, en la tabla FACTURAS_TIMBRADOR se hizo el cambio en timbrado de 2 a 0', 'Modificación en BD', '2024-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001627');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001630', 'ERROR EN ENCIDENCIAS', '2024-06-19 16:09:00', 'AL REALIZAR MI JUSTIFICACION DE INCIDENCIAS Y DAR CLICK EN GUARDAR, NO SE GUARDA LA INFORMACION POR LO QUE NO ES POSIBLE TRAMITARLAS PARA SU AUTORIZACION.
PARECE SER QUE EL FOLIO ASIGNADO SE QUEDA ATORADO Y NO SE LOGRA ASIGNAR... POR LO QUE NO SE GENERA LA SOLICITUD',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Morfinez Anaya, José Gabriel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-20 15:09:00', 'Se realizaron cambios en EDIV2.USUARIOS donde se dio de alta el usuario.', 'Modificación en BD', '2024-06-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001630');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001637', 'ELIMINAR FACTURA CARGADA EN COMPROBACIÓN DE VIÁTICOS', '2024-06-20 11:33:00', 'Buen día,

Solicito amablemente apoyo a fin de que se elimine la factura cargada en el sipv2 ya que no se visualiza (misma que se encuentra seleccionada en la imagen adjunta al presente), referente a la comprobación de viáticos con folio no. 4600.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-21 10:33:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y se eliminó de VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-06-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001637');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001633', 'APOYO PARA SUBIR COMPLEMENTO DE PAGO || FERNANDO RUIZ LOPEZ', '2024-06-20 09:22:00', 'Buen día, 

Por medio del presente solicito su apoyo para que se adecuen los centavos en el importe pagado e importe anterior, del folio 10085 de complemento de pago en el portal Mediport.
Dice: 480471.98
Debe decir:   480472.00',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-21 09:31:00', 'Seguimieto de proceso, apertura de candados', 'Seguimiento de proceso', '2024-06-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001633');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001635', 'ACCESO A MEDIPORT', '2024-06-20 11:03:00', 'Buenos días

Por medio de la presente solícito su apoyo para que se habilite la opción de facturación electrónica, ya que es necesario para realizar actividades propias del Depto. de Recursos Materiales.
De antemano gracias, Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'FACTURACIÓN ELECTRÓNICA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-21 10:03:00', 'Se realizó asignación de rol COMPRAS al usuario solicitado en FACTURACION ELECTRONICA / USUARIOS', 'Modificación en BD', '2024-06-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001635');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001646', 'JUSTIFICACION DE INCIDENCIAS', '2024-06-21 11:09:00', 'Buenos días,

De la manera más atenta solicito su apoyo para abrir la Justificación de Incidencia  con folio 11929.

Saludos.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACIÓN DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-21 16:09:00', 'Se ejecutó el procedimiento de EDIV2.ELIMINA_INCIDENCIAS con el folio de la solicitud requerido.', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001646');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001647', 'HABILITAR OPCION MIS P3 EN SIIP', '2024-06-21 11:52:00', 'Buenas tardes compañeros, solicito su amable apoyo para poder habilitar la opción de revisar mis p3 en Siip ya que no me aparece mi numero de empleada es 69573
anexo foto y agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'TRAMITES Y SOLICITUDES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Haruel Aguirre, Lizbeth'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-21 16:52:00', 'Se agregaron permisos al usuario de MIS P3 en el SIIP', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001647');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001648', 'Accesabilidad al Sistema SIIPV2', '2024-06-21 12:30:00', 'Con el fin de justificar una falta he intentado hacer el trámite desde este sistema y n he podido. Solicité apoyo del área de recursos humanos pensando que no había hecho bien el procedimiento, sin embargo me comentaron que era un problema de sistema.

Para su resolución les pido su apoyo.

Muchas gracias',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACIÓN DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'González Cadena, David Alfonso'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-21 17:30:00', 'Se creó el usuario en EDIV2.USUARIOS como jdarchivos', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001648');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001649', 'ELIMINAR FACTURA CARGADA EN COMPROBACIÓN DE VIÁTICOS FOLIO NO. 4598', '2024-06-21 15:31:00', 'Buena tarde,

Solicito amablemente apoyo a fin de que se elimine la factura cargada en el sipv2 ya que es necesario modificar los montos de la misma (la cual se encuentra seleccionada en la imagen adjunta al presente), referente a la comprobación de viáticos con folio no. 4598, correspondiente al Lic. Jaime Lara Carrión.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-24 11:31:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y se eliminó de VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001649');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001650', 'ELIMINAR FACTURA CARGADA EN COMPROBACIÓN DE VIÁTICOS FOLIO NO. 4600', '2024-06-21 15:35:00', 'Buena tarde,
Solicito amablemente apoyo a fin de que se elimine la factura cargada en el sipv2 ya que no se visualiza (misma que se encuentra seleccionada en la imagen adjunta al presente), referente a la comprobación de viáticos con folio no. 4600.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-24 09:35:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y se eliminó de VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001650');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001656', 'APOYO PARA ELIMINAR COMPROBACION DE VIATICOS FOLIO: 4600', '2024-06-24 10:03:00', 'Solicito amablemente apoyo a fin de que se elimine la comprobación de viáticos con folio no. 4600 (misma que se encuentra seleccionada en la imagen adjunta al presente), ya que el informe de Comisión que se subió es erróneo.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 09:03:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y se eliminó de VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001656');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001642', 'CAMBIO DE FECHA', '2024-06-20 18:38:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido de servicios: 35281
DEBE DECIR: 20/05/2024.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-24 15:46:00', 'Se modificó en INVENTARIO.PEDIDOS las fechas requeridas.', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001642');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001651', 'FAVOR DE CAMBIAR FECHA EN REQUISICIÓN', '2024-06-21 15:43:00', 'FAVOR DE CAMBIAR FECHA EN REQUISICIÓN 132544 Y EN SU IM 9972, CON FECHA DE 22/05/2024',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 09:56:00', 'Se modificó en INVENTARIO.REQUISICIONES en los campos de fechas requeridas', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001651');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001652', 'CAMBIO DE TIPO DE ADJUDICACION EN CONTRATO', '2024-06-21 16:54:00', 'Buenas tardes estimados.

Solicito de su amable apoyo para realizar el cambio de la sección Adjudic. a la ORDEN 35216 en el SIIP.
Se adjunta imagen para pronta referencia.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 10:07:00', 'Se modificó INVENTARIOS.PEDIDOS en el campo tipoadj con valor 1', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001652');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001654', 'CAMBIO DE FECHA DE PEDIDOS', '2024-06-22 12:25:00', 'Buenas tardes

Por medio de la presente solicito su apoyo para el cambio de fecha de los siguientes pedidos:

35289 y 35290 fecha solicitada: 31/05/2024

De antemano agradezco la atención, saludos cordiales',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 09:58:00', 'Se modificó en INVENTARIO.PEDIDOS las fechas requeridas.', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001654');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001657', 'CAMBIO DE FECHA Y PARTIDA PRESUPUESTAL', '2024-06-24 10:23:00', 'Buenos días

Por medio de la presente solicito de su apoyo para el cambio de fecha de la requisición 132506 y la investigación de mercado 9969, así como el cambio de partida presupuestal.

Fecha de la requisición e investigación: 06/05/2024
Partida presupuestal: 32503

De antemano agradezco la atención y apoyo, saludos cordiales',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 10:42:00', 'Se modificó INVENTARIOS.REQUISICIONES y INVENTARIOS.INVESTIGACIONMERCADO en partida y la fecha requerida.', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001657');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001663', 'CAMBIO DE FECHA EN PEDIDO', '2024-06-24 15:25:00', 'Buenas Tardes 

solicito de su amable apoyo para realizar el cambio de fecha del pedido con número de orden 35291 a la fecha 28/05/2024.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 11:57:00', 'Se modificó en INVENTARIO.PEDIDOS las fechas requeridas.', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001663');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001664', 'DESBLOQUEO SIIP MODULO TRAMITES Y SERVICIOS', '2024-06-24 15:39:00', 'Buenas tardes

Por medio del presente solicito el desbloqueo en el SIIP modulo TRAMITES Y SOLICITUDES - TRAMITES RH - Mis P3, para todos los colaboradores de la Subgerencia de Finanzas.

Jarumi de los Angeles Valentin Aguirre
Reyna Alejjandra Campos García
Jocelyn Aurora Reyes Jiménez
Luis Ángel Melo Escarela
Rogelio Lagos Ambrosio
José Luis Serrano Berriozabal
Barbara Carballido Brenis
Perla del Rocío Sánchez Solano
Marisa Trinidad Mendoza Castillo
Joseline Martínez Pastos
Alfredo Reyes

De antemano gracias.',
  (select id from ventanas_mesa where nombre = 'TRAMITES Y SOLICITUDES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Luna, Candida'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 15:39:00', 'Asignar permisos a diferentes usuarios a la sección Mis P3 de TRÁMITES Y SOLICITUDES', 'Modificación en BD', '2024-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001664');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001667', 'CAMBIO DE FECHA EN REQUISICIÓN 132545', '2024-06-24 17:15:00', 'Buena tarde, se solicita apoyo para el cambio de fecha de la requisición con folio 132545,quedando definida la fecha  21 de junio de 2024.
Gracias',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'de la Cruz Castillo, Alejandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 13:00:00', 'Se modificó en INVENTARIO.REQUISICIONES las fechas requeridas.', 'Modificación en BD', '2024-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001667');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001676', 'APERTURA BUQUE 240746 MORNING LINDA', '2024-06-25 14:57:00', 'Hector / Gabriel buenas tardes Su valioso apoyo por favor para abrir el Buque  240746 MORNING LINDA, mismo que ya zarpo y cerro, debido a que hay 17 unidades que se requiere re-liberar ya que están próximas a caer en Abandono, por lo cual es necesario para que la Ag. Aduanal pueda realizar la liberación en el sistema conforme al procedimiento. Quedo atenta, muchas gracias.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Liberacion de Automoviles'),
  (select id from solicitantes_mesa where nombre = 'García González, María Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-06-26 10:00:00', 'Seguimieto de proceso', 'Seguimiento de proceso', '2024-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001676');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001685', 'Solicitud de apoyo', '2024-06-26 14:49:00', 'Buenas tardes
Recibe un cordial saludo con la presente la cual tiene la finalidad de informarte de la baja del Ing. Mijael Vargas González del Integral y registrar al Ing. Rafael Martínez Salazar, ambos de Inter-Syst con los mismos privilegios que tenia el Ing Misael.Agradeciendo tu atención, quedo pendiente',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Cruz González, Gerardo'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-06-27 13:00:00', 'Se actualizo el usuario correspondiente en CONTACTOS01 y USUARIOS32 asi como tambien se creo el nuevo usuario en esas tablas', 'Modificación en BD', '2024-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001685');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001684', 'Solicitud de apoyo', '2024-06-26 14:47:00', 'Buenas tardes

Recibe un cordial saludo con la presente la cual tiene la finalidad de informarte de la baja del Ing. Mijael Vargas González del mediport y registrar al Ing. Rafael Martínez Salazar, ambos de Inter-Syst , con los mismos privilegios que tenia el Ing Misael

Agradeciendo tu atención, quedo pendiente.',
  (select id from ventanas_mesa where nombre = 'TRÁMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Cruz González, Gerardo'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-27 13:00:00', 'Se creó el usuario en EDIV2.USUARIOS y se dio de baja al usuario con el campo ACTIVO = 0, también se ejecutó el procedimiento REPLICA_PERMISOS_USUARIO para otorgar permisos al nuevo usuario.', 'Modificación en BD', '2024-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001684');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001686', 'Abrir folio de salida', '2024-06-26 15:12:00', 'Hola buena tarde

Me podrían apoyar para regresar existencias  en el sistema SIIP correspondiente al folio de baja 94680
del ID 240596 GOODWOOD // USO ECONOMICO.

Sin mas que agregar, quedo atenta.

Saludos!!',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Flores Lopez, Patricia Elizabeth'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-27 10:12:00', 'Se modificó en OPERACIONES.DESG_MCIAS el existencia_peso, existencia_cantidad, en OPERACIONES.DET_MOVS_ALM se eliminó el movimiento de salida, en OPERACIONES.ACUMULADOS_ALM se realizó el cuadre de peso para que no hubiera salidas, se eliminó de OPERACIONES.FOLIOS_SALIDA, OPERACIONES.DET_FOLIOS_SALIDA, OPERACIONES.FOLIOS_SALIDA_DESGCONT los registros correspondientes a ese folio', 'Modificación en BD', '2024-06-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001686');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001681', 'ERROR EN CARGA MEDIPORT', '2024-06-25 18:19:00', 'Buenas tardes estimados.

Solicito de su apoyo para poder realizar la carga de los documentos adjuntos (complemento de pago) para la validación del Folio 10004 de MEDIPORT en el apartado VALIDAR COMPLEMENTO, debido a que presenta el siguiente error.





De ante mano, muchas gracias.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-27 17:44:00', 'Seguimieto de proceso', 'Seguimiento de proceso', '2024-06-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001681');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001679', 'ERROR EN CARGA MEDIPORT', '2024-06-25 17:38:00', 'Buenos días estimados.

Se solicita de su amable apoyo para poder realizar la validación de los documentos adjuntos en la presente en MEDIPORT correspondientes a la factura 81989 debido a que presenta los siguientes errores, sin embargo los cambios se han realizado en el sistema.



De ante mano muchas gracias.
Saludos.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-27 15:59:00', 'Seguimieto de proceso', 'Seguimiento de proceso', '2024-06-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001679');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001645', 'SUSTITUCION DE PDF EN MEDIPORT', '2024-06-21 10:26:00', 'Buen días estimados.

Solicito de su apoyo para poder realizar la sustitución del PDF del FOLIO 81813 de Mediport.

De nate mano muchas gracias, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-25 11:33:00', 'Se eliminaron los registros de la factura en CFD_RECEPCION, CFD_CUSTOM_DATA y se regresó a estado 0 en INVENTARIO.FOLIO_FACTURA', 'Modificación en BD', '2024-06-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001645');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001696', 'Cambio de Recinto', '2024-06-27 11:54:00', 'Buen día, por favor su valioso apoyo para el cambio del recinto de los siguientes conocimientos así como de sus desgloses.


debe decir Recinto 67
ID-241082
MSC MANYA


MEDUC1429199
MEDUC1433993
MEDUC1434009
MEDUC1434025
MEDUC1434405
MEDUD8566777
MEDUE1219330
MEDUEJ671969
MEDUEJ735004
MEDUEJ738917
MEDUEJ772114
MEDUJ7248340
MEDUJ7288627
MEDUJ7388179
MEDUJ7416483
MEDUQL315577',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-27 16:54:00', 'Modificación en OPERACION.MERCANCIA Y OPERACION.DESG_MCIAS en el campo REFISM3', 'Modificación en BD', '2024-06-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001696');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001693', 'Cambio de Recinto', '2024-06-27 11:28:00', 'Me podrían apoyar con el cambio  de recinto de los siguientes conocimientos así como de sus desgloses.

debe decir Recinto 67
ID-241082
MSC MANYA
MEDUP1802610
MEDUP1819952
MEDUP1819960
MEDUP1819986
MEDUP1820034
MEDUP1820158
MEDUP1826437
MEDUP1839638
MEDUP1839646
MEDUP1839687
MEDUP1839695
MEDUP1839745
MEDUP1839919
MEDUP1844448
MEDUP1846724
MEDUP1846732
MEDUP1846757
MEDUP1846765
MEDUP1846773
MEDUP1846781
MEDUP1846799
MEDUP1846807
MEDUP1865922
MEDUP1869080
MEDUP1869155
MEDUP1869932
MEDUP1869999
MEDUP1870120',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-28 10:28:00', 'Modificación en OPERACION.MERCANCIA Y OPERACION.DESG_MCIAS en el campo REFISM3', 'Modificación en BD', '2024-06-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001693');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001695', 'Cambio de Recinto', '2024-06-27 11:37:00', 'Me podrían apoyar con el cambio  de recinto de los siguientes conocimientos así como de sus desgloses.

debe decir Recinto 67
ID-241082
MSC MANYA

MEDUE8167185
MEDUE8174694
MEDUE8177424
MEDUE8178695
MEDUE8178778
MEDUE8178851
MEDUE8180204
MEDUE8239554
MEDUE8239745
MEDUE8241154
MEDUE8247441
MEDUE8249157
MEDUE8249165
MEDUE8249470
MEDUE8255204
MEDUE8257788
MEDUE8258786
MEDUE8264362
MEDUE8264388',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-28 10:37:00', 'Modificación en OPERACION.MERCANCIA Y OPERACION.DESG_MCIAS en el campo REFISM3', 'Modificación en BD', '2024-06-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001695');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001698', 'ELIMINACIÓN DE FACTURA EN COMPROBACIÓN DE VIÁTICOS', '2024-06-28 09:17:00', 'Buenos días, por medio del presente me permito solicitar su amable apoyo para eliminar un rubro en la comprobación de viáticos del Lic. Felipe Quijano.

A continuación, se detallan los datos necesarios para hacerlo:
FOLIO: 4604
RUBRO: 4 CONSUMO DE ALIMENTOS
MONTO: 202.00

Sin más por el momento, y en espera de su amable apoyo, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-06-28 13:17:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y se eliminó de VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-06-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001698');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001948', 'Solicitud de cambio de fecha', '2024-07-25 11:17:00', 'BUEN DIA

POR MEDIO DE LA PRESENTE SOLICITO SU APOYO PARA EL CAMBIO DE FECHA DEL PEDIO 35358.

FECHA DE PEDIDO: 31/05/2024

DE ANTEMANO AGRADEZCO LA ATENCION, SALUDOS CORDIALES',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-29 09:10:00', 'Cambiar fecha en INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-07-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001948');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001960', 'Carga de complemento de pago', '2024-07-26 15:38:00', 'Hola buenas tardes


Por medio del presente se solicita se lleve a cabo la validación en papel del complemento de pago del proveedor DHL EXPRESS MEXICO (966), lo anterior debido a la forma en la cual el proveedor emite los complementos de pago.

Se adjunta complemento emitido por DHL.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-29 11:52:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-07-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001960');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001951', 'Cambio de cantidad en cotizacion y pedido', '2024-07-26 10:07:00', 'Hola buenos días


Por medio de la presente solcito su apoyo para el cambio de cantidad de la siguiente cotización y pedido:


-Al capturar la cantidad de la cotización 36029, tuve un error en lugar de 350, capture 300 en la partida de combustible Diesel, en ese sentido el pedido 35360 presenta el mismo error, por lo que solicito su apoyo para el cambio de cantidad:


A 350.00


Lo anterior para validar la factura de manera correcta, por su atención gracias.',
  (select id from ventanas_mesa where nombre = 'COTIZACIONES/PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-26 15:07:00', 'Se abrió la cotización para que pueda editar la cantidad de la partida con INVENTARIO.COTIZACIONES en Estado y se modificó la cantidad del pedido en INVENTARIO.DETPEDIDOS en el campo CANTIDAD y en INVENTARIO.PEDIDOS en CANTIDAD  para el total', 'Modificación en BD', '2024-07-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001951');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001736', 'FIRMA DE PLANEACION BUQUE BBC NORWAY ID 241263', '2024-07-03 12:58:00', 'buen día compañeros, su apoyo para eliminar la firma por parte de una servidora en la planeación del buque BBC NORWAY ya que no paso por firma al área de recintos.
Agradezco de antemano la atención y quedo atenta.',
  (select id from ventanas_mesa where nombre = 'CONSULTA DE DOCUMENTOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Buques/Planeación'),
  (select id from solicitantes_mesa where nombre = 'Haruel Aguirre, Lizbeth'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-04 10:58:00', 'Se retiró la firma del usuario: EDIV2.FLUJODOCUMENTO  en campo NIDUSUARIO en null y ESTADODOC de 4 a 2, también en EDIV2.DOCUMENTO se cambió ESTADO de 4 a 2.', 'Modificación en BD', '2024-07-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001736');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001964', 'B/M LAKE TAUPO', '2024-07-26 19:43:00', 'El sistema Medi port no generó el número de registro al ingresar su fin de viaje del B/M LAKE TAUPO que le corresponde el no. 1311.',
  (select id from ventanas_mesa where nombre = 'BITACORA CCTM'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones/Arribos y Zarpes de Buques'),
  (select id from solicitantes_mesa where nombre = 'de Trafico Maritimo, Centro de Control'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-29 15:00:00', 'Se agregó el número de registro: En OPERACION.VIAJES en campo REG_OF_IMP.', 'Modificación en BD', '2024-07-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001964');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001971', 'CAMBIAR ESTADO EN SOLICITU DE COTRATO 262 || MODULO DE LICITACIONES || UNINET', '2024-07-29 12:14:00', 'Buenas tardes, 

Por medio del presente solicito su apoyo para cambiar el estado en la solicitud de contrato 262 en el módulo de licitaciones. 

Debe decir: PARCIAL PAGADO. 

Lo anterior para estar en posibilidad de realizar los pagos pendientes de realizar.

Quedo atenta a sus comentarios',
  (select id from ventanas_mesa where nombre = 'LICITACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-30 09:14:00', 'Se cambió el estado de la solicitud: INVENTARIO.SOLCONTRATOS en el campo ESTADO con valor de 3 a 2.', 'Modificación en BD', '2024-07-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001971');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001914', 'SUSTITUCION DE CFDI EN MEDIPORT', '2024-07-22 18:30:00', 'Buenas tardes estimados.

Solicito su apoyo de eliminar de la Bóveda de MediPort el CFDI correspondiente al folio 82102 para reemplazar dicho documento.



Se adjunta CFDI a eliminar para pronta referencia.

Sin otro particular quedo a la orden.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FACTURACIÓN ELECTRÓNICA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-29 14:23:00', 'Se eliminó la factura: Se eliminaron los archivos de la bóveda, y los registros de CFDCONNECT.CFD_RECEPCION, CFDCONNECT.CFD_CUSTOMDATA y se cambió en INVENTARIO.FOLIO_FACTURA el campo estado de 2 a 0(abierto)', 'Modificación en BD', '2024-07-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001914');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001986', 'Viaticos', '2024-07-30 13:43:00', 'Buena tarde:

Solicito apoyo para que se le asignen privilegios en el modulo de viáticos al ING. JESUS GUILLERMO GOZO AVILA, quien se desempeña como Técnico en Mantenimiento en la Gerencia de Ingeniería.

Siendo su Usuario: tmantenimiento1

Agradezco la atención, quedando atenta a sus indicaciones.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-31 09:43:00', 'Se le dieron los permisos de comprobación de viáticos y solicitud de viáticos. Además se dio de alta el usuario en viáticos.', 'Modificación en BD', '2024-07-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001986');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001953', 'CAMBIO DE NOMBRE DEL CAPITAN DE PUERTO DEL REPORTE DIARIO DE BUQUES', '2024-07-26 12:22:00', 'Buenos días, por el presente se les solicita el cambio del nombre del Capitán de Puerto, en el reporte diario de buques del SIIP.

Ahora tendrá que decir en capitán de Puerto:


Contralm. Ret. Ing. CS. Nav. Rodolfo Álvarez Zárate.


agradeciendo su atención, quedo pendiente.',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones/Reportes'),
  (select id from solicitantes_mesa where nombre = 'Ortiz Morales, Cesar'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-26 17:22:00', 'Se cambió el nombre en OPERACION.FIRMAS en el campo NOMBRE', 'Modificación en BD', '2024-07-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001953');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001989', 'CANCELACION DE COPIA SIMPLE CODIGO CAM-SM-240724-2470372', '2024-07-30 14:53:00', 'Buen día Estimados

Solicito de su valioso apoyo con la cancelación de la solicitud de la copia simple de codigo CAM-SM-240724-2470372, ya que el agente aduanal rectifico el pedimento.

Comparto correo del agente aduanal.

saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'TRÁMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-31 10:00:00', 'Se cambió EDIV2.FLUJODOCUMENTO el campo ESTADODOC de 3 a 1(cancelado) y en EDIV2.DOCUMENTO el campo ESTADO  de 3 a 1(cancelado)', 'Modificación en BD', '2024-07-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001989');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2024-001985', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-07-30 13:35:00', 'Buena tarde

Agradeceremos el apoyo con el timbrado de las notas de egreso 17014 - 14264, 17015 - 14264.

Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-07-31 12:35:00', 'Se cambio el monto en VTNOTASCREDITO con el centavo de diferencia y luego en FACTURAS_TIMBRADOR se cambio timbrado a 0', 'Modificación en BD', '2024-07-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2024-001985');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001995', '241317 MORNING CAPO falta PARTIDA 2 x 6 UNIDADES', '2024-07-31 12:25:00', 'Buenos días compañeros 

Podrían apoyarme con lo siguiente, se presenta el mismo caso de ayer al subir la cédula, adjunto pantalla y cédula.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'García González, María Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-01 10:25:00', 'Modificar EDIV2.AUTOS_TRANSFERENCIA en el campo PTDA_MOV_ALM de 1 a 2 para cambiarlo a segunda partida', 'Modificación en BD', '2024-07-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001995');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002025', 'ELIMINAR CONOCIMIENTOS', '2024-08-01 17:48:00', 'Se solicita la eliminación de los conocimientos cargados en el Buque MSC PRATITI ID 241408, por error en nombre de buque. Gracias',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 15:48:00', 'Se eliminaron los manifiestos en OPERACION.MERCANCIAS y OPERACION.DESG_MCIAS', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002025');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001994', 'CAMBIO DE FECHA', '2024-07-31 12:04:00', 'Por este medio solicito el cambio de fecha del pedido de servicios: 35348.

Debe decir: 28/05/2024.
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 12:32:00', 'Cambiar fecha en INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001994');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001961', 'SOLICITUD DE CAMBIO DE FECHA DE REQUISICIÓN 132568 E INV. DE MERCADO 9999', '2024-07-26 16:07:00', 'Buena tarde estimados, por este medio tengo a bien solicitar el cambio de fecha de la REQUISICIÓN 132568 e INV. DE MERCADO 9999, quedando definida con fecha 14/05/2024.

Espero contar con su valioso apoyo, muchas gracias.

Saludos cordiales!',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 15:57:00', 'Cambiar fecha en INVENTARIO.REQUISICIONES Y INVENTARIO.INVESTIGACIONMERCADO en los campos de fecha correspondientes', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001961');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002014', 'COMPLEMENTO DE PAGO (OBRA)', '2024-08-01 12:43:00', 'Buenas tardes,

De la manera más atenta solicito su apoyo para en el módulo de COMPRAS desmarcar la casilla usa complemento del folio de pago 81074

 



Cualquier duda o comentario quedo a sus órdenes.


Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 15:35:00', 'Se cambió en INVENTARIO.PAGOS en el campo REQUIERE_COMP de valor 1 a 0, al igual que LIBERACION_COMP y se eliminó el folio relacionado del complemento en FOLIO_COMP. Además se eliminó el registro en INVENTARIO.FOLIOS_COMPLEMENTO', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002014');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002040', 'B/M STI DONALD CTRAUSCHT', '2024-08-02 16:27:00', 'Buenas tardes. El  B/M STI DONALD CTRAUSCHT con ID. 241433, el sistema no adquirió su numero de registro el cual es 1344 favor de capturarlo.
Gracias.',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones/Arribos y Zarpes de Buques'),
  (select id from solicitantes_mesa where nombre = 'de Trafico Maritimo, Centro de Control'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-05 10:27:00', 'Se asignó no. de registro en OPERACION.VIAJES en campo REG_OF_IMP', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002040');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002027', 'B/M BUXCLIFF', '2024-08-02 00:16:00', 'Buenos días. Al B/M BUXCLIFF con ID. 241397, se le capturó erróneamente la fecha del cruce de escollera de salida, se le intento cambiar pero no fué posible, favor de apoyarnos:  La correcta es: 31-07-24  a las 23:48 hrs.',
  (select id from ventanas_mesa where nombre = 'ARRIBO O ZARPE DE BUQUE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones/Arribos y Zarpes de Buques'),
  (select id from solicitantes_mesa where nombre = 'de Trafico Maritimo, Centro de Control'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 17:00:00', 'Se cambió en OPERACION.VIAJES en el campo F_ZARPE', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002027');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002030', 'CORRECION EN UBICACION DE MERCANCIA', '2024-08-02 10:42:00', 'Buen día, 

solicito de su apoyo para realizar la corrección  en la ubicación del seguimiento conocimiento; derivado a que se capturo erróneamente. 

Buque. HAMBURG HIGHWAY 
Conocimiento: KKLU524123015

Dice: Explanada Playa Linda ( clave 112)
Debe Decir: Explanada Playa Linda (TC1) (25)',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 16:06:00', 'Se cambió en OPERACION.DET_MOVS_ALM y en OPERACION.FOLIOS_SALIDA en area_alm', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002030');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002012', 'CAMBIO DE AREA DE MERCANCIA', '2024-08-01 12:25:00', 'nuevamente  y por instrucciones se solicita 
cambio del área de  mercancía del buque 241267 FLORIJNGRACHT

conocimiento 01
partida 1 dice  

PATIO FRONTAL (119)
debe  decir 

ALMACEN 21 (58)

nota importante  cambiar en todo el siip y mediport',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Liberacion de Automoviles'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 10:25:00', 'Se cambió en OPERACION.DET_MOVS_ALM y en OPERACION.FOLIOS_SALIDA en area_alm', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002012');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002021', 'SOLICITUD PARA VALIDAR FACTURA', '2024-08-01 16:26:00', 'Hola buenas tardes


Por medio de la presente solicito su apoyo para la validación del los siguiente archivos ya que la factura fue validada con anterioridad, enviando el siguiente mensaje.


Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'FACTURACIÓN ELECTRÓNICA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 15:50:00', 'Se eliminó la factura de la bóveda, los registros en CFDCONNECT.CFD_RECEPCION, CFDCONNECT.CUSTOM_DATA se eliminaron y en INVENTARIO.FOLIO_FACTURA se cambió ESTADO  de 2 a 0', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002021');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002041', 'MODIFICACIÓN EN FECHA DE ELABORACIÓN REQUISICIÓN E INV DE MERVADO', '2024-08-02 19:04:00', 'Buenas tardes, 

Por medio del presente solicito la modificación en la fecha de elaboración de los siguientes documentos:

Requisición 132574
Inv de mercado 10000

Deben decir: 27/05/2024

Agradeciendo de antemano su colaboración, le envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-05 15:28:00', 'Se cambió la fecha en INVENTARIO.REQUISICIONES Y INVENTARIO.INVESTIGACIONMERCADO en los campos de fecha correspondiente', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002041');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002039', 'COMPROBACION VIATICOS', '2024-08-02 15:31:00', 'Buenas tardes:

Solicito apoyo para la eliminación de las facturas que detallo correspondientes a la comprobación de viáticos No. 4643 de Jesús Guillermo Gozo Ávila, ya que al intentar subir los archivos pdf y xml marca que han sido capturadas y no se visualizan ni se agregaron los montos al total de la comprobación.

Factura 1254 por 180.00
Factura 7904945 por 485.00

Agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'TRAMITES Y SOLICITUDES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-05 12:31:00', 'Se eliminó la factura de la bóveda, se eliminó el registro de INVENTARIO.FOLIO_FACTURA con la referencia que causó conflicto', 'Modificación en BD', '2024-08-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002039');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001942', 'SOLICITUD DE HABILITAR EL BOTON DE BORRAR EN SIIPV2 /REQUISICIONES', '2024-07-01 11:36:00', 'Buena tarde estimados, por este medio tengo a bien solicitar su apoyo para habilitar el botón de BORRAR en el SIIPV2-REQUISICIONES, para el usuario AUXSEGURIDAD12, adjunto imagen para mayor referencia.

Gracias, saludos.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 12:50:00', 'Se le dieron privilegios al usuario sobre el botón borrar en el SIIP / Seguridad', 'Modificación en BD', '2024-08-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001942');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002050', 'CAMBIO DE NOMBRE DE USUARIO SIIP', '2024-08-05 12:04:00', 'Buen día,


Quisiera solicitar cambio de usuario en el SIIP debido a que aparece el nombre de otra persona y no puedo continuar con la solicitud de pago hasta que aparezca mi nombre en el apartado de revisado y a todos aquellos formatos a los cuales les aplique.


Muchas gracias y quedo pendiente.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-06 09:04:00', 'Cambio de nombre en reporte de pedidos: Se dio de alta al usuario en INVENTARIO.USUARIOS', 'Modificación en BD', '2024-08-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002050');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002049', 'fecha de baja', '2024-08-05 11:46:00', 'buenas tardes  favor  de  cambiar  la fecha de baja  al folio 97414  de la boleta de liberación en el sistema SIIP 

dice  05/08/24 debe decir 02/08/24',
  (select id from ventanas_mesa where nombre = 'FOLIOS_SALIDA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-05 16:46:00', 'Cambiar la fecha en OPERACION.DET_FOLIOS_SALIDA en el campo de la fecha de liberación', 'Modificación en BD', '2024-08-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002049');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002036', 'regresar boletas en estado abierto', '2024-08-02 12:53:00', 'regresar  boletas  a estado abierto  ya se dieron de baja  pero el sistema NO  quito  cantidad y peso 

buque  ARC RESOLVE  240959  CTO. BR2413732
FOLIOS',
  (select id from ventanas_mesa where nombre = 'FOLIOS_SALIDA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Liberacion de Automoviles'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-05 09:53:00', 'En OPERACION.FOLIOS_SALIDA en el campo ESTADO de 3 a 0 (abierto) para que el usuario pueda generar la salida y se inserten bien los registros en DET_MOVS_ALM y aparezca bien el cuadre de pesos', 'Modificación en BD', '2024-08-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002036');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002032', 'Error en cantidad al realizar el embarque', '2024-08-02 11:11:00', 'Hola buen día

Por medio de la presente solicito su apoyo para que se grabe la cantidad correcta en el embarque 38900, ya que de presenta un erro al grabar la cantidad, originalmente se levanto la mesa  INC 2024-001951. para generar el registro de la cantidad de manera correcta, la cantidad es de 350.

Si tiene alguna duda estoy para servirles, saludos cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Recepción de Materiales (embarque)'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 16:11:00', 'Se cambió la cantidad en INVENTARIO.DISTRPEDIDOS de 300 a 350', 'Modificación en BD', '2024-08-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002032');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001945', 'SOLICITUD DE PERMISOS PARA APROBACIÓN DE CONTRATOS EN EL MODULO JURIDICO DEL SIIP', '2024-07-24 17:31:00', 'Buenas tardes compañeros, derivado de las reuniones establecidas entre áreas pertinentes y llamadas telefónicas donde se ejecuto prueba y error, solicitamos de su apoyo para brindar permisos de aprobación de contrato a los siguiente usuarios:

IVANJD

jdcontratos

Quedo atento a sus comentarios, saludos',
  (select id from ventanas_mesa where nombre = NULL),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-01 10:28:00', 'Se agrego el permiso 39 a los usuarios dentro de SERVICIO.CONTACTO_PERMISO16', 'Modificación en BD', '2024-08-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001945');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002023', 'CAMBIO DE MONTO EN PEDIDO', '2024-08-01 17:23:00', 'Buen día 

Me podrían apoyar con la modificación de la retención de ISR en el pedido de servicios 35104 por favor? ya que no se consideró con los datos correctos y tendríamos que cancelar todo el proceso e incluso eliminar la factura de bóveda. 



MONTOS INCORRECTOS',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-02 16:23:00', 'Se cambió en INVENTARIO.DETPEDIDOS en el campo RETENCION1 de 10 a 1.25 y RETENCION_RETENCION1 de 3 a 33.', 'Modificación en BD', '2024-08-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002023');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002070', 'CAMBIO DE FECHA', '2024-08-07 09:27:00', 'Buenas tardes estimados.

Solicito de su amable apoyo para realizar el cambio de fecha de:

REQUISICION 132577 a fecha: 29/05/2024

INVESTIGACION DE MERCADO 10002 a fecha: 29/05/2024



Sin otro particular agradezco el apoyo.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-07 16:50:00', 'Se cambió la fecha en INVENTARIO.REQUISICIONES Y INVENTARIO.INVESTIGACIONMERCADO en los campos de fecha correspondiente', 'Modificación en BD', '2024-08-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002070');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002085', '241317 MORNING CAPO PARTIDA 2 X 6 UNIDADES NO SUBE CEDULA', '2024-08-08 11:52:00', 'Buen día compañeros

Solicito su apoyo ya que el conocimiento BE2425571 desglose 2 por 6 unidades nuevamente no sube el archivo para la generación de factura por pago de almacenaje. Se adjunta archivo.


Gracias por su atención.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Liberacion de Automoviles'),
  (select id from solicitantes_mesa where nombre = 'Murillo Vazquez, Patricia'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-09 11:04:00', 'En la tabla EDIV2.AUTOS_TRANSFERENCIA en el campo PTDA_MOV_ALM de valor 1 a 2, ya que corresponden a la segunda partida en base al campo PTDA_MCIA', 'Modificación en BD', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002085');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002084', 'CAMBIO DE FECHA', '2024-08-08 10:17:00', 'Buenos días estimados.

Solicito su amable apoyo para realizar el cambio de fecha del PEDIDO 35380 a la fecha 29/05/2024.

De ante mano se agraece el apoyo.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-09 10:36:00', 'Se cambió la fecha en INVENTARIO.PEDIDOS en los campos de fecha correspondiente', 'Modificación en BD', '2024-08-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002084');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2024-002103', 'Falla en el Integral', '2024-08-09 15:58:00', 'Buenas tardes, a quien corresponda

La presente es para solicitar apoyo en el sistema integral, ya que en el apartado de ingeniería en la sección de estimaciones al querer realizar el tramite de un concepto extraordinario el porcentaje de avance aparece con el símbolo "######", esta solicitud la hago mediante el correo de la Arq. Pamela Estefania Hernandez Galvan, sin embargo corresponde al integral de mi persona el Ing. Jesus Guillermo Gozo Ávila. agradeceré de su apoyo a la brevedad.



Sin mas que agregar quedo a sus órdenes. Anexo evidencia',
  (select id from ventanas_mesa where nombre = 'MODIFICACION DEL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Galván, Pamela Estefanía'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-12 12:58:00', 'Se cambion en los campos de IMPORTETOTALORIGINAL el valor de 1 al valor de contrato en SOLCNTOVIGENTES Y CNTOVIGENTES en OBRAS', 'Seguimiento de proceso', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2024-002103');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002100', 'VALIDACION COMPLEMENTO DE PAGO DHL', '2024-08-09 12:27:00', 'Buen día,

Por medio de la presente solicito de su apoyo para poder validar el complemento de pago de DHL debido a que marca un error en estructura.

Adjunto complemento de pago en PDF y XML para su oportuna valoración.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-12 08:09:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002100');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002101', 'HABILITACION DE LA CASETA OPERATIVA C PARA RENTA DE USUARIOS.', '2024-08-09 12:52:00', 'Hola buen día equipo

En relacion a la solicitud de mesa de ayuda con codigo REQ-2024-001289, haciendo referencia a la deshabilitacion temporal de la caseta operativa C, ya que el clima que se encuentra dentro estaba dañado, por lo que ya fue sustituido por otro aire acondicionado semi nuevo, dando por hecho que ya se puede ocupar la infraestructura portuaria.

Pido de su apoyo para realizar la habilitación de esa caseta en el portal de mediport, para que los usuarios puedan rentarla, ya que contamos con demanda de casetas.

Quedo atento.

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CONTROL DE CASETAS OPERATIVAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-12 09:52:00', 'Se eliminó el condicional IF en el procedimiento almacenado PACK_TIPOGRANEL.CONSULTA_ESTADO_CASETA', 'Modificación en BD', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002101');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002094', 'VALIDACION COMPLEMENTOS DE PAGO POR ERROR', '2024-08-08 17:40:00', 'Buenas tardes,

Por medio de la presente solicito su apoyo para la validación de los complementos de pago PEMEX ya que presenta error al subir los archivos PDF y XML.

Se anexa PDF y XML para su valoración',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-09 17:42:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002094');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002091', 'Complemento de pago CFE', '2024-08-08 15:32:00', 'Buena tarde 

Solicito abrir los candados del proveedor 2370, CFE SUMINISTRADOR DE SERVICIOS BASICOS. 
para realizar los primeros 8 pagos del mes de agosto.
Quedo atento, saludos',
  (select id from ventanas_mesa where nombre = 'FACTURACIÓN ELECTRÓNICA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-09 16:18:00', 'Se modificó el campo estado en INVENTARIO.FOLIO_COMPLEMENTOS de 2 a 5', 'Modificación en BD', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002091');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002071', 'VALIDACION COMPLEMENTOS DE PAGO POR ERROR EN FECHA', '2024-08-07 09:42:00', 'Bueno días,

Por medio de la presente solicito su apoyo para la validación de los complementos de pago del proveedor de Grupo MAS (2397) ya que presenta error en las fechas emitidas.

Se anexa PDF y XML para su valoración',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-09 16:16:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002071');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002089', 'CANCELACIÓN DE ENTRADA // VISUALIZACIÓN DE PEDIMENTO // BUQUE INASA 241332', '2024-08-08 15:09:00', 'Buen día estimados.

El motivo del presente es para solicitar su apoyo con la cancelación de entrada al almacén en el sistema SIIP, ya que el pedimento con conocimiento L1009442 aparece como no encontrado al momento de realizar el folio de salida del buque.

Quedo atenta a sus comentarios.

Cualquier duda o aclaración marcar a la ext. 73113 

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FOLIOS DE SALIDA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Piña Pereda, Ximena'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-09 12:09:00', 'Se modificó en OPERACION.PEDIMENTOS en el campo STATUS de N(PEDIMENTO NO ENCONTRADO) a X(PEDIMENTO POR CONSULTAR)', 'Modificación en BD', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002089');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002072', 'ERROR EN SISTEMA SIIPV2', '2024-08-07 09:44:00', 'Buen día solicito de su amable apoyo para revisar el error que me marca el sistema SIIPV2 en su modulo de control de contratos ( FRM-40815: VARIABLE GLOBAL NID01 doest not exist. ) que lo marca a la hora de editar, ya que se necesita actualizar la información de los cesionarios',
  (select id from ventanas_mesa where nombre = 'CONTRATOS CCPD'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Cesion Parcial'),
  (select id from solicitantes_mesa where nombre = 'Padrón Ramón, Juan Vicente'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-07 13:44:00', 'Se modificó en SERVICIO.CONTACTOS01 y USUARIOS32 agregando el registro en ambas tablas y dandole permisos en SERVICIO.CONTACTO_PERMISO16', 'Modificación en BD', '2024-08-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002072');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002118', 'IMPRESION DE VIATICOS', '2024-08-12 16:11:00', 'BUENAS TARDES

SE SOLICITA SU APOYO YA QUE LA LIC. MONTSERRAT , EL SISTEMA SIIP NO LE PERMITE IMPRIMIR LAS HOJAS YA AUTORIZADAS

ADJUNTO IMAGEN DE LA PANTALLA',
  (select id from ventanas_mesa where nombre = 'TRAMITES Y SOLICITUDES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Ríos, Verania Lizette'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-13 12:11:00', 'Se modificó el supervisor del departamento, en NOMINA.DEPARTAMENTOS en el campo TRABNUM_TITULAR con el trabnum correcto y (SI APLICA) cambiar el supervisor del solicitante en NOMINA.EMPLEADOS1 en el campo SUPERVISOR', 'Modificación en BD', '2024-08-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002118');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002115', 'DICE Y DEBE DECIR', '2024-08-12 14:20:00', 'Buenas tardes;

Solicito de su valioso apoyo para  realizar un dice y debe decir por cambio de cantidad y peso a un  folio de mercancía de exportación ya que el sistema MEDIPORT no me permite modificar.

BUQUE: FWN BONAFIDE


ID: 241410


FOLIO DE EXPORTACION: 507597


DICE: 537,598 BULTOS POR 38, 892, 595. 00 KG


DEBE DECIR: 18,117 BULTOS POR 4, 341, 155. 44 KG.

Adjunto captura  de pantalla de la solicitud vía correo electrónico para mejor referencia.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Limón Acevedo, Rodolfo'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-13 10:20:00', 'Se cambió el valor en OPERACION.DESG_MCIAS, OPERACION.DET_MOVS_ALM y OPERACION.ACUMULADOS_ALM, para que se refleje en el tablero, se cambió el EDIV2.SOLMULTIPLE_CARGA y EDIV2.TABLERO_CARGA_DETALLE', 'Modificación en BD', '2024-08-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002115');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002108', '241317 MORNING CAPO PARTIDA 2 X 6 UNIDADES NO SUBE CEDULA', '2024-08-10 11:40:00', 'Buen dia compañeros


Soy Paty Murillo estoy en la maquina de Isabel Vargas, porque no tuve acceso a la mesa de ayuda por mi equipo.

Es por eso que solicito de su apoyo ya que el conocimiento BE2425571 desglose 2 x 6 unidades, nuevamente no sube el archivo para la generación de factura por pago de almacenaje. (se anexa archivo de excell)


Pueden por favor validar el detalle y avisarme cuando quede listo??


Quedo al pendiente, gracias.


Saludos',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Liberacion de Automoviles'),
  (select id from solicitantes_mesa where nombre = 'Vargas Zapata, Maria Isabel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-12 12:00:00', 'En la tabla EDIV2.AUTOS_TRANSFERENCIA en el campo PTDA_MOV_ALM de valor 1 a 2, ya que corresponden a la segunda partida en base al campo PTDA_MCIA', 'Modificación en BD', '2024-08-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002108');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002127', 'SOLICITUD DE ELIMINACIÓN DE FACTURAS', '2024-08-13 16:54:00', 'Buena tarde,


Solicito se elimine la factura por el monto de $95.24, toda vez que el archivo PDF marca error en la visualización.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Morfinez Anaya, José Gabriel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-14 13:54:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-08-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002127');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002128', 'REIMPRESION DE PEDIDO DE SERVICIOS', '2024-08-13 17:05:00', 'Buena tarde, solicito de su apoyo parea la reimpresión de los pedidos de servicios de los siguientes números de orden:
35378

35373

Gracias.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-14 16:05:00', 'Se cambió el estado del pedido para que pudiera imprimirlo en INVENTARIO.PEDIDOS en el campo ESTADO de 5 a 1(tramite)', 'Modificación en BD', '2024-08-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002128');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002135', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO.', '2024-08-14 12:08:00', 'Hola buenas tardes estimados a quien corresponda.


Agradeceremos el apoyo con el timbrado de la nota de crédito 17058,  folio 14305

La cual se recibe notificación de diferencia en centavos: $0.01',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Reyes, Alfredo'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-15 11:08:00', 'Se cambio el centavo de diferencia en VTNOTASCREDITO y luego el campo TIMBRADO a 0 en FACTURAS_TIMBRADOR', 'Modificación en BD', '2024-08-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002135');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002130', 'VALIDACION COMPLEMENTO DE PAGO DHL', '2024-08-14 09:11:00', 'Buen día,

Solicito apoyo para la validación del complemento de pago de DHL ya que marca error por el formato que envían. 

Adjunto los archivos para su oportuna revisión.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-15 15:46:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002130');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002134', 'ELIMINACIÓN DE MANIFIESTO', '2024-08-14 11:54:00', 'Buen día, 

Me podrían apoyar con la eliminación de los conocimientos del buque: SEASPAN EMISSAR ID:241478

archivos SAMM3


A2701540.221
A2701541.221
A2701542.221
A2701543.221',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Machado Piña, Hilda'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-15 10:54:00', 'Se eliminó de OPERACION.MERCANCIAS y OPERACION.DESG_MCIA con los ID_MCIAS', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002134');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002132', 'eliminar archivos de manifiestos', '2024-08-14 11:30:00', 'Buenos dias  a solicitud  del cliente se solicita  lo siguiente
por este medio solicito de su apoyo con la cancelación/rechazode los archivos SAMM3 A2701540.221, A2701541.221, A2701542.221, A2701543.221 enviado vía mediport con el numero ID 241478 ya que este buque no es PORTACONTENEDORES, es de GRANEL AGRICOLA.',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-14 16:30:00', 'Se eliminó de OPERACION.MERCANCIAS y OPERACION.DESG_MCIA con los ID_MCIAS', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002132');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002133', 'ELIMICION DE FIRMA EN PLANEACION DE BUQUES MEDIPORT', '2024-08-14 11:34:00', 'Buen dia, 
por favor de su apoyo para retirar la firma de una servidora, en la planeación de Buque, dado que esta se firmo erróneamente. 

Buque: Mandarin Phoenix 241485,',
  (select id from ventanas_mesa where nombre = 'TRAMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Buques/Planeación'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-14 16:34:00', 'Se eliminó el nid de EDIV2.FLUJODOCUMENTO y se cambió el cambio de estado de 4 a 2, también en EDIV2.DOCUMENTO de 4 a 2', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002133');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002113', 'MEDIPORT', '2024-08-12 12:48:00', 'BUENAS TARDES:

SOLCITO EL APOYO PARA DESBLOQUEAR UN SERVICIO DE AVITUALLAMIENTO POR LA PLATAFORMA MEDIPORT EL NUMERO DE CODIGO DE LA SOLCITUD ES EL SIGUIENTE 2474590',
  (select id from ventanas_mesa where nombre = 'TRAMITES ELECTRÓNICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Servicio Web Automoviles'),
  (select id from solicitantes_mesa where nombre = 'Aguilar Heredia, Juan de Dios'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-13 11:48:00', 'Se eliminó el nid de EDIV2.FLUJODOCUMENTO y se cambió el cambio de estado de 4 a 2, también en EDIV2.DOCUMENTO de 4 a 2', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002113');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002150', 'DICE Y DEBE || NO DE BULTOS || BALSA 85', '2024-08-15 10:43:00', 'Buen día, Estimados 

Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos al Artículo 23, por petición de Agente Aduanal vía correo electrónico. 

BUQUE: BALSA 85
ID:  241435
FOLIO: 507638
DICE:  15,384 BTS
DEBE DECIR: 13,152 BTS',
  (select id from ventanas_mesa where nombre = 'CONTROL DE CARGA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-15 17:43:00', 'Se cambió en OPERACION.DESG_MCIA, OPERACION.DET.MOVS_ALM, OPERACION.ACUMULADOS_ALM en los campos de cantidad y peso correspondientes, y en EDIV2.TABLERO_CARGA_DETALLE y EDIV2.SOLMULTIPLE_CARGA', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002150');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002149', 'DICE Y DEBE || NO. DE BULTOS || BBC PEARL', '2024-08-15 10:22:00', 'Buen día, Estimados 

Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos al Artículo 23, por petición de Agente Aduanal vía correo electrónico. 

BUQUE: BBC PEARL 
ID:  241393
FOLIO: 507127
DICE:  30,641 BTS
DEBE DECIR: 30,173 BTS',
  (select id from ventanas_mesa where nombre = 'CONTROL DE CARGA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-15 15:22:00', 'Se cambió en OPERACION.DESG_MCIA, OPERACION.DET.MOVS_ALM, OPERACION.ACUMULADOS_ALM en los campos de cantidad y peso correspondientes, y en EDIV2.TABLERO_CARGA_DETALLE y EDIV2.SOLMULTIPLE_CARGA', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002149');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002068', 'Apoyo en Sistema Integral, Comprometer año 2023', '2024-08-06 17:21:00', 'Buenas tardes.

Solicito su amable apoyo para comprometer importe en el año 2023 para el contrato ASPN-GI-CS-62601-041-23. Lo anterior con la finalidad de que GAF pueda realizar ajustes presupuestarios entre los proyectos involucrados, lo cual no es posible ya que no se tiene recurso disponible para ese año en el sistema.

Adjunto al presente encontrara evidencia de lo indicado.


Quedo al pendiente de sus comentarios.

Saludos.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Castillejos Lugo, Oscar'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-15 12:36:00', 'Se agrego un registro nuevo en DISTRCONTRATOS para el año 2024 y en el año 2023 se coloco en 0 y se coloco el ESTADOPRESUPUESTAL en COMPROMETIDO, en el nuevo registro se agrego el monto, iva y monto total a los campos de MONTOPEND, IVAPEND, MONTOTOTAPEND respectivamente para poder comprometerlo; Tambien el estado presupuestal se coloco en PENDIENTE DE COMPROMETER', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002068');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002154', 'DICE Y DEBE || NO. DE BULTOS || FWN BONAFIDE', '2024-08-15 12:37:00', 'Buen día, Estimados 

Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos al Artículo 23, por petición de Agente Aduanal vía correo electrónico. 

BUQUE: FWN BONAFIDE 
ID:  241410
FOLIO: 507597
DICE:  18, 117 BTS
DEBE DECIR: 17, 862 BTS',
  (select id from ventanas_mesa where nombre = 'CONTROL DE CARGA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-15 17:37:00', 'Se cambió en OPERACION.DESG_MCIA, OPERACION.DET.MOVS_ALM, OPERACION.ACUMULADOS_ALM en los campos de cantidad y peso correspondientes, y en EDIV2.TABLERO_CARGA_DETALLE y EDIV2.SOLMULTIPLE_CARGA', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002154');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002148', 'cambio de fecha de pedidos', '2024-08-14 19:00:00', 'Buena tarde 

Solicito modificar la fecha de los pedidos en el SIIP, se encuentran en estado de tramite, tienen fecha de 14/08/2024, la fecha solicitada es el 31/05/2024

Los numero de pedidos son: 
35399
35398
35397
35396
35395
35394
35393
  35391
35390
35389
35388
35387

Quedo atento, saludos',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-16 11:43:00', 'Se cambió la fecha en INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002148');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002147', 'CAMBIO DE FECHA EN PEDIDO', '2024-08-14 17:29:00', 'Buenas tardes, 

Me podrían apoyar con el cambio de fecha de la orden 35392 por favor?? 

La fecha correcta que debe tener es 31 de mayo de 2024.

Agradezco de antemano el apoyo 

Saludos!!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-15 17:11:00', 'Se cambió la fecha en INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002147');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002155', 'CAMBIAR DEDUCCION - 2 AL MILLAR POR 5 AL MILLAR', '2024-08-15 13:35:00', 'Buenas tardes Compañeros, solicitando de su apoyo para cambiar la deducción del 2 al millar por el 5 al millar, se realizo la carga erróneamente.

Contrato ASPN-GI-CO-62602-016-24

DISEÑOS ARCHIPIELAGOS, S.A. DE C.V.

Quedo atento',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-16 10:42:00', 'Se cambio el valor de NIDVALOR de la tabla DEDUCCIONES en el esquema de OBRAS de 7 a 8', 'Modificación en BD', '2024-08-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002155');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002166', 'JUSTIFICACION DE INCIDENCIA', '2024-08-16 17:42:00', 'Solicito de su apoyo para que por favor me validen la solicitud de la justificación de incidencia numero 12257 ya que al momento de guardarla, me dice que este folio no es parte de mi incidencia, favor de verificarlo.
Por favor me lo pueden checar, muchas gracias.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACIÓN DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Vargas Zapata, Maria Isabel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-19 11:42:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002166');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002088', 'ELIMINACION DE CONOCIMIENTOS', '2024-08-08 14:27:00', 'Se solicita la eliminación de los siguientes conocimientos:

BUQUE: MSC CANCUN
ID: 241406
MEDUDY272996
MEDUDY273895
MEDUDY285931
MEDUAY105127',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-09 10:00:00', 'Se eliminaron los conocimientos de OPERACION.MERCANCIA y OPERACION.DESG_MCIAS', 'Modificación en BD', '2024-08-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002088');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002169', 'SOLICITUD DE CAMBIO DE FECHA DE REQUISICIÓN 132581 E INV. DE MERCADO 10003', '2024-08-17 13:11:00', 'Buena tarde estimados,

Por este medio tengo a bien solicitar el cambio de fecha de la Requisición 132581 e Inv. de Mercado 10003, ambas fechas quedando definidas para el 28/05/2024.

Sin más por el momento reciban un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-20 11:59:00', 'Se cambió en INVENTARIO.REQUISICIONES en los campos de fecha correspondientes', 'Modificación en BD', '2024-08-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002169');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002170', 'Eliminación de manifiesto ‌ ‌SONGA PUMA ID: 241459', '2024-08-19 09:15:00', 'Hola buenos dias me podrían apoyar con la eliminacion de estos manifiestos en el sistemas mediport (rechazar) y en el sistema SIIP ya que el cliente de manera involuntaria se equivoco.

SONGA PUMA ID: 241459

RMA-SM-170824-2476083
RMA-SM-170824-2476084

image.png


Quedo atento a sus apreciables comentarios',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Flores Lopez, Patricia Elizabeth'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-19 14:15:00', 'Se eliminaron los conocimientos de OPERACION.MERCANCIA y OPERACION.DESG_MCIAS, además se canceló el trámite en EDIV2.DOCUMENTOS y en EDIV2.FLUJODOCUMENTO cambiando el estado de 4 a 2', 'Modificación en BD', '2024-08-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002170');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002167', 'eliminar manifiesto completo', '2024-08-17 12:11:00', 'ELIMINACION DE MANIFIESTO COMPLETO DEL BM MED PACIFIC V-0424..,.PUERTO DE LUMUT, MALAYSIA (CAMBIO PUERTO DE DESCARGA) ARCHIVO A ELIMINAR:  A2779457.222  QUE ES ENCUENTRA EN EL  FOLIO  RMA-SM-090824-2474173',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-19 12:00:00', 'Eliminar de OPERACION.MERCANCIAS filtrado por NOMBRE_ARCHIVO y VID y en OPERACION.DESG_MCIAS con el VID y los ID_MCIAS recuperados de MERCANCIAS', 'Modificación en BD', '2024-08-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002167');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002159', 'Eliminación de Conocimiento', '2024-08-15 16:00:00', 'Se solicita su apoyo para la eliminación del conocimiento MEDUQP792565, del buque Maersk Puelo ID 241419',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-16 11:00:00', 'Eliminar de OPERACION.MERCANCIAS filtrado por NOMBRE_ARCHIVO y VID y en OPERACION.DESG_MCIAS con el VID y los ID_MCIAS recuperados de MERCANCIAS', 'Modificación en BD', '2024-08-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002159');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002158', 'NO SUBE LA FACTURA DE ALMACENAJE EXPORTACION UN VIN GENERA CONFLICTO', '2024-08-15 15:58:00', 'buena tarde compañeros

Solicito apoyo, ya que la cedula de almacenaje de exportación no se puede cargar, presenta error dice que no se actualizo la información BM HOEGH MANILA ID 241441 folio 502731 desglose 1 por 2 unidades TOYOTA. Adjunto cedula de almacenaje.',
  (select id from ventanas_mesa where nombre = 'API CARGA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Libreación de Vehiculos'),
  (select id from solicitantes_mesa where nombre = 'Murillo Vazquez, Patricia'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-16 10:58:00', 'Se modificó en EDIV2.AUTOS_TRANSFERENCIA en el campo PTDA_MOV_ALM dependiendo de lo que tenga en OPERACION.VEHICULOS_MCIAS en PTDA_MOV_ALM', 'Modificación en BD', '2024-08-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002158');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002117', 'NO SUBE LA FACTURA DE ALMACENAJE IMPORTACION UN VIN GENERA CONFLICTO', '2024-08-12 15:47:00', 'Buena tarde compañeros

Solicito apoyo, ya que la cedula de almacenaje no se puede cargar presenta error dice que no se actualizo la información.BM SIRIUS LEADER ID 241275 conocimiento  NYKS780017461  desglose 1.',
  (select id from ventanas_mesa where nombre = 'API CARGA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Libreación de Vehiculos'),
  (select id from solicitantes_mesa where nombre = 'Murillo Vazquez, Patricia'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-13 11:47:00', 'Se modificó en EDIV2.AUTOS_TRANSFERENCIA en el campo PTDA_MOV_ALM dependiendo de lo que tenga en OPERACION.VEHICULOS_MCIAS en PTDA_MOV_ALM', 'Modificación en BD', '2024-08-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002117');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002176', 'CAMBIO DE FECHA', '2024-08-19 11:15:00', 'Buen día estimados.

Solcito de su apoyo para realizar el cambio de fecha de la requisición 132406 a la fecha: 16/05/2024

Sin otro particular, agradezco de ante mano el apoyo brindado.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-20 12:56:00', 'Se cambió en INVENTARIO.REQUISICIONES en los campos de fecha correspondientes', 'Modificación en BD', '2024-08-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002176');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002190', 'AYUDA SIIP FONDO REVOLVENTE', '2024-08-20 09:27:00', 'Buenos días, 

Solicito su apoyo para poder seguir capturando comprobantes en fondo revolvente, ya que estaba grabando normal y al intentar una me apareció la siguiente leyenda pero no tuve ningún antecedente.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS / CAJA CHICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos/Caja Chica'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-21 12:12:00', 'Se eliminó el registro fantasma de INVENTARIO.FOLIO_FACTURA y se eliminó el registro en VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-08-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002190');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002179', 'Cambio de fecha', '2024-08-19 12:23:00', 'Buen día

Solicito modificar la fecha en el SIIP del pedido 35400 del proveedor LUIS ALBERTO GARCIA , se encuentra en estado de tramite.  
La fecha solicitada es 31 de mayo del presente año. 
Quedo atento a sus comentarios. Saludos',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-21 12:02:00', 'Se cambió en INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-08-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002179');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002196', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-08-20 16:00:00', 'Hola buenas tardes estimados a quien corresponda.

Agradeceremos el apoyo con el timbrado de la nota de crédito 17074,  folio 14318

La cual se recibe notificación de diferencia en centavos: $0.01',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Reyes, Alfredo'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-21 13:00:00', 'Se cambio el centavo de diferencia en VTNOTASCREDITO y luego el campo TIMBRADO a 0 en FACTURAS_TIMBRADOR', 'Modificación en BD', '2024-08-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002196');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002205', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRES', '2024-08-21 12:10:00', 'Hola buenas tardes estimados a quien corresponda.


Agradeceremos el apoyo con el timbrado de la nota de crédito 17079,  folio 14323

La cual se recibe notificación de diferencia en centavos: $0.01 

saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Reyes, Alfredo'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-22 11:10:00', 'Se cambio el centavo de diferencia en VTNOTASCREDITO y luego el campo TIMBRADO a 0 en FACTURAS_TIMBRADOR', 'Modificación en BD', '2024-08-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002205');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002198', 'Cambio de estado en recepcion de material', '2024-08-20 17:53:00', 'Buena tarde 

Solicito en el SIIP en la ventana de recepción de materiales, cambiar el estado de la Recepción numero 38966 y 38965 de estado parcialmente recibido a estado abierto.
Quedo atento a sus comentarios. Saludos',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Recepción de Materiales (embarque)'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-21 12:53:00', 'Se cambió el estado de PARCIALMENTE FACTURADO A ABIERTO en INVENTARIO.EMBARQUES en el campo ESTADO de 2 a 1', 'Modificación en BD', '2024-08-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002198');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002197', 'modificar coprobacion de viáticos con folio 4640', '2024-08-20 17:19:00', 'Buenas tardes, se solicita la modificación de la comprobación de viáticos con numero de folio 4640.

Son dos modificaciones:

    Se solicita borrar la comprobación por la cantidad de 357 pesos por el concepto de consumo de alimentos.
    Se solicita quitar la factura de la comprobación por la cantidad de 150 pesos por el consumo de alimentos.

Agradeciendo su atención quedo atento a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'COMPROBACION DE VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Ortiz Morales, Cesar'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-21 16:19:00', 'Se eliminó la factura de INVENTARIO.FOLIO_FACTURA y el registro, además de eliminarlo en VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-08-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002197');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002202', 'Eliminación de SAMM3', '2024-08-21 10:56:00', 'Buen día

Solicito de su apoyo para la eliminación de los siguientes manifiestos a solicitud del cliente por omisión a Veracruz. Se describe el nombre de archivo SAMM3 y el puerto correspondiente

A2701626.226 - BUENOS AIRES
A2701627.226 - ITAPOA
A2701630.226 - SANTOS 
A2701632.226  - CARTAGENA
A2701633.226  - MONTEVIDEO

Quedamos atentas, 

Saludos!',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Bernal Hernández, Sarha Melissa'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-21 15:56:00', 'Eliminar de OPERACION.MERCANCIAS filtrado por NOMBRE_ARCHIVO y VID y en OPERACION.DESG_MCIAS con el VID y los ID_MCIAS recuperados de MERCANCIAS', 'Modificación en BD', '2024-08-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002202');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002203', 'CAMBIO DE CORREO EN SIRE', '2024-08-21 11:54:00', 'Buen día 

Solicito su apoyo para cambiar el correo para recibir notificaciones que se encuentra registrado en el SIRE de la empresa CIS INSPECCIONES SA DE CV

El nuevo correo es:  carolina.moxica@cisinspecciones.com

Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-22 10:54:00', 'Se cambió el correo en EDIV2.CONTRATOS_SOLICITUD en el campo EMAIL', 'Modificación en BD', '2024-08-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002203');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002186', 'COMPLEMENTO DE PAGO CFE', '2024-08-19 16:01:00', 'Buena tarde 

Solicito abrir el candado del proveedor CFE SUMINISTRADOR DE SERVICIOS BASICOS con rfc  CSS160330CP7.
Para realizar pagos correspondientes al mes de agosto.
Quedo atento. Saludos',
  (select id from ventanas_mesa where nombre = 'FACTURAS PENDIENTES'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-21 15:16:00', 'Para subir factura sin complemento, se cambia el campo ESTADO en INVENTARIO.FOLIO_COMPLEMENTOS de 2 a 5', 'Modificación en BD', '2024-08-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002186');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002208', 'HABILITAR PARA PODER MODIFICAR FECHA DE COBRO', '2024-08-21 15:34:00', 'Buenas tardes estimado Héctor

Agradecería tu apoyo para habilitar para que podamos modificar la fecha de cobro en facturación – Cuentas por Cobrar – Depósitos en garantía.

O en su defecto en caso de no ser posible, que ustedes le modifiquen la fecha para poder realizar un cobro de unas facturas emitidas el día de hoy y que se van a cobrar con un saldo en garantía:

Cobros: 433951, 433952 y 433954

PONER FECHA DEL 27/07/2024 en cada cobro por favor',
  (select id from ventanas_mesa where nombre = 'COBROS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Depósitos en garantía'),
  (select id from solicitantes_mesa where nombre = 'Serrano Berriozabal, Jose Luis'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-22 13:34:00', 'Se modificó el campo de Fecha en FACTURACION.COBROS', 'Modificación en BD', '2024-08-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002208');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002193', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 132570 E INVESTIGACIÓN DE MERCADO 9997', '2024-08-20 13:02:00', 'Buena tarde, 
Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 132570.

Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):

FECHA QUE REQUIERE: 24/07/2024 
DEBE DECIR: 22/05/2024

Así mismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 9997, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.

La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):

FECHA ACT: 24/07/2024
DEBE DECIR: 21/05/2024

FECHA COTIZACIÓN: 09/07/2024 
DEBE DECIR: 20/05/2024',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-22 13:25:00', 'Se cambió la fecha en INVENTARIO.REQUISICIONES en todos los campos de fecha, se cambió en INVENTARIO.PROVEINVESTIGACIONMERCADO en el campo FCOTIZACION y FECHA_ACTPROVEEDOR, además, se cambió la fecha de alta de INVENTARIO.INVESTIGACIONMERCADO', 'Modificación en BD', '2024-08-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002193');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002194', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 132572 E INVESTIGACIÓN DE MERCADO 9998.', '2024-08-20 13:07:00', 'Buena tarde, 


Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 132572.

 

Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):

 


FECHA QUE REQUIERE: 26/07/2024 

DEBE DECIR: 22/05/2024






Así mismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 9998, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.


La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):

 


FECHA ACT: 26/07/2024 

DEBE DECIR: 21/05/2024


FECHA COTIZACIÓN: 09/07/2024 

DEBE DECIR: 20/05/2024',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-22 15:53:00', 'Se cambió la fecha en INVENTARIO.REQUISICIONES en todos los campos de fecha, se cambió en INVENTARIO.PROVEINVESTIGACIONMERCADO en el campo FCOTIZACION y FECHA_ACTPROVEEDOR, además, se cambió la fecha de alta de INVENTARIO.INVESTIGACIONMERCADO', 'Modificación en BD', '2024-08-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002194');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002210', 'FACTURA EN PAPEL', '2024-08-21 18:27:00', 'Por este medio silicito de su apoyo para que se suba la factura en papel del Proveedor: EDENRED MEXICO, SA DE CV con el numero de folio: 82376.

Ya que tenemos una diferencia de $0.01
Cualquier duda quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FACTURAS PENDIENTES'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-22 16:52:00', 'Se generó el registro en INVENTARIO.FOLIO_FACTURA con los datos correspondientes a la factura, y se abrió el candado para que el usuario pudiera subir la factura', 'Modificación en BD', '2024-08-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002210');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002214', 'ERROR EN CARGA MEDIPORT EUROS', '2024-08-22 10:54:00', 'Buenos días estimados.

Se solicita de su amable apoyo para poder realizar la validación de los documentos adjuntos en la presente en MEDIPORT correspondientes a la factura 82377 debido a que presenta los siguientes errores, sin embargo los atributos se encuentran correctos en el sistema.',
  (select id from ventanas_mesa where nombre = 'FACTURAS PENDIENTES'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-22 17:07:00', 'Se cambió en CFD_CONNECT.PARAMETROS_CONFIGPROVEE en los campos EXCENTO_INTERNA
EXCENTO_XSD, con valor de 0 a 1, una vez subidas las facturas, se regresa a 0', 'Modificación en BD', '2024-08-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002214');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002188', 'VALIDACION COMPLEMENTOS DE PAGO POR ERROR EN FECHA', '2024-08-20 09:07:00', 'Buenos días,

De la manera más atenta le solicito su apoyo para poder validar los complementos de pago de Grupo MAS por error en fecha entre el sistema y el xml. Le adjunto las facturas para su oportuna valoración.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-22 17:17:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002188');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002218', 'CAMBIO DE FECHA EN PEDIDO', '2024-08-22 16:01:00', 'Buenas tardes, 

Me podrían apoyar con el cambio de fecha del pedido con número de orden: 35409 por favor?

La fecha correcta del pedido debe ser 28 de mayo 2024

Agradezco de antemano el apoyo 

Quedo a sus órdenes 

Saludos!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-23 13:01:00', 'Se cambió en INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-08-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002218');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002195', 'ELIMINACION FOLIO 13689 RELACION DE ANTICIPOS Y GARANTIAS CON SUS ESTADOS', '2024-08-20 13:15:00', 'Buenas tardes compañeros 

Me podrían apoyar eliminando el folio 13689 del reporte " relación de anticipos y garantías con sus estados " del día 09 de agosto 2024 ya que mismo folio se repite en el día 16 de agosto 

DIA 09 AGOSTO :
DIA 16 AGOSTO:
Quedo atenta ante cualquier duda o comentario 

De ante mano gracias

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'REPORTES DE ANTICIPOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación
/Depósitos en garantía'),
  (select id from solicitantes_mesa where nombre = 'Martínez Pastor, Joseline'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-21 09:15:00', 'Se cambió FACTURACION.COBROS en el campo FOLIO del valor 13689 a null, momentáneamente, para que el usuario pudiera imprimir el reporte y luego regresarlo a su valor original', 'Modificación en BD', '2024-08-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002195');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002168', 'NO SE VEN CONOCIMIENTOS EN TABLERO', '2024-08-17 12:41:00', 'NO SE VISUALIZAN EN EL TABLERO  LOS CONOCIMIENTOS QUE SE VAN A ADJUNTAR EN UN ARCHVO, SE HACE MENCION  QUE FUE POR QUE REALIZARON CAMBIOS DE RECINTO POR PARTE DE LA NAVIERA Y EL SISTEMA YA NO LO JALO 

ID 241333 BUQUE  GOODWOOD IMPORTACION',
  (select id from ventanas_mesa where nombre = 'TABLERO MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-19 12:00:00', 'Se cambió EDIV2.TABLERO_CARGA_DETALLE en el campo ACTIVO de 0 a 1', 'Modificación en BD', '2024-08-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002168');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-001723', 'REVISION INDICADOR MES DE JUNIO 2024', '2024-07-02 13:27:00', 'Por este medio solicito de su apoyo ya que al descargar el reporte del indicador del mes de JUNIO 2024 no lo imprime completo y le falta el porcentaje total.
Anexo evidencia de uno anterior y el de junio.

Quedo atenta a las indicaciones.
Saludos cordiales.

Ejemplo de reporte anterior:',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-07-03 09:27:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-001723');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002185', 'AJUSTE DE MONTOS EN ACTA ENTREGA RECEPCION DE SERVICIOS', '2024-08-19 14:06:00', 'Por este medio solicito el ajuste de montos en la entrada del Pedido de servicios: 35037 ya que es un caso especial por que se cuadro el IVA para que se ajustara con la factura.

Pero a la hora de generar el Acta Entrega Recepción  de Servicios aparece otro IVA
DICE: $111.55
DEBE DECIR: $54.37


Para que nos apoyen y que se ajusten los montos de la entrada de acuerdo al pedido.


Anexo Captura de pantalla y factura.
Así como del  Acta Entrega Recepción  de Servicios.

Quedo atenta a sus indicaciones.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-21 10:23:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002185');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002238', 'CAMBIO DE USUAIO SIIP', '2024-08-26 11:21:00', 'Buenos días,

Solicito de su apoyo para modificar el estado de la solicitud a ABIERTO, ya que se necesita cambiar el  usuario que realiza la recepción del servicio.

Gracias y quedo al pendiente.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-27 10:21:00', 'Se cambió INVENTARIO.EMBARQUES en el campo ESTADO de valor 2 a 1 (abierto)', 'Modificación en BD', '2024-08-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002238');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002240', 'DICE Y DEBE || MV UAL AFRICA', '2024-08-26 11:28:00', 'Buen día, Estimados 

Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos al Artículo 23, por petición de Agente Aduanal vía correo electrónico. 


Buque: UAL AFRICA

ID: 241511

Folio: 508487

 

DICE: 1,781 BULTOS / 2,253,563.00 kg

DEBE DECIR: 1,791 BULTOS / 2,243,066.00 kg',
  (select id from ventanas_mesa where nombre = 'CONTROL DE CARGA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-26 16:28:00', 'Se actualizó información en OPERACION.DESG_MCIAS, OEPRACION.DET_MOVS_ALM, OPERACION.ACUMULADOS_ALM, EDIV2.SOLMULTIPLE_CARGA, EDIV2.TABLERO_CARGA_DETALLE en los campos de peso correspondientes para el cuadre', 'Modificación en BD', '2024-08-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002240');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002228', 'SOLICITUD DE CAMBIO DE FECHA DE REQUISICIÓN 132583', '2024-08-23 17:14:00', 'Buena tarde estimados, por este medio tengo a bien solicitar el cambio de fecha de la requisición 132583 quedando definida para el 31/07/2024.

Gracias!!

Saludos...',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-27 09:52:00', 'Se cambió en INVENTARIO.REQUISICIONES', 'Modificación en BD', '2024-08-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002228');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002232', 'SOLICITUD PARA CAMBIO DE FECHA DE LA REQUISICIÓN 132581', '2024-08-24 12:25:00', 'Buena tarde estimados, espero que se encuentren muy bien.

Por este medio, tengo a bien solicitar el cambio de fecha de la requisición 132581, quedando definida con fecha 28/05/2024.

Gracias por el apoyo.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-26 16:57:00', 'Se cambió en INVENTARIO.REQUISICIONES', 'Modificación en BD', '2024-08-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002232');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002227', 'MODIFICAR MONTOS DE FOLIO DE FACTURA Y NOTA DE CREDITO EN MEDIPORT - ASPN-GI-CO-62602-010-22 GOSAN', '2024-08-23 16:52:00', 'Buenas tardes Compañeros, solicitamos de su valioso apoyo para modificar el monto de los folios siguientes:


CONTRATO ASPN-GI-CO-62602-010-22
FOLIO 	SERIE 	SUBTOTAL 	TOTAL
82026 	F 	 $     284,445.91 	 $     329,957.26
82026 	N 	 $  1,053,968.15 	 $  1,222,603.05


Lo anterior, corresponde a los montos correctos para que la contratista GOSAN pueda cargar la facturas adjuntas.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-26 11:50:00', 'Se cambio los montos de INVENTARIO.folio_factura para el folio 82026 al solicitado', 'Modificación en BD', '2024-08-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002227');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002250', 'VICULAR FOLIO 82400 a la cuenta MEDIPORT MARTINEZ ROSAS ANAMAR', '2024-08-26 17:05:00', 'Buenas tardes, solicitamos de su apoyo para vincular el folio 82400 de la estimación 5-N del contrato API-GI-CS-62602-004-21 del ya fenecido MARTINEZ WOLF LUIS.

Lo anterior, se solicita la vinculación al MEDIPORT de su heredera para ella pueda cargar factura de estimación finiquito y poder cerrar el contratos en mención.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-27 13:00:00', 'Se cambiaron los campos de RFC, PROOVEDOR, EMAIL en INVENTARIO.FOLIO_FACTURA en los registros con el folio 82400', 'Modificación en BD', '2024-08-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002250');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002256', 'Sección Reportes SIIP OBRAS', '2024-08-27 12:14:00', 'Muy buena tarde. 

Solicito de su apoyo. Ya que en recientes días la sección de reportes en el SIIP obras se encuentra deshabilitada, esta sección se utiliza de manera recurrente para verificación y reimpresión de los documentos.




Revisar el seguimiento con el Ing. Román Monsivais en la Ext. 73035. 



Se Anexa soporte del antes y después de las pantallas en el sistema.',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras'),
  (select id from solicitantes_mesa where nombre = 'Ronces Rodríguez, Elias Armando'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-27 17:14:00', 'Se elimino de SERVICIO.CONTACTO_PERMISO16 los permisos 39 y 40 al usuario IVANJD para posteriormente asignarlos al usuario jdcontratos', 'Modificación en BD', '2024-08-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002256');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002119', 'CARGAR FACTURAS', '2024-08-12 16:51:00', 'Buenas tardes compañeros, derivado de  derivado de la revisión del finiquito del contrato ASPN-GI-CO-62602-010-22 , en el cual se detectaron pagos en exceso, los cuales importan un total de $1,053,968.15 (un millón cincuenta y tres mil novecientos sesenta y ocho pesos 15/100 M.N.), mientras que el importe de finiquito es por $234,683.15 (doscientos treinta y cuatro mil seiscientos ochenta y tres pesos 15/100 M.N.), de lo cual resulta una diferencia por $819,285.00 en favor de esta Administración.
De lo anterior, en coordinación del área de finanzas y de manera particular para hacer el reintegro del recurso a la Entidad, las facturas se requirieron de la manera en que se adjuntan.
Cualquier duda o comentarios, estamos a la orden.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-08-20 16:57:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002119');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002247', 'MODIFICACION EN REQUISICION TABLERO PRESUPUESTAL', '2024-08-26 15:51:00', 'Buen día.
Derivado a la actualización de datos en la requisición 132581 se solicita RETIRAR LA AUTORIZACIÓN PRESUPUESTAL de dicha requisición con el fin de poder ser visualizada nuevamente por parte de la Jefatura de Presupuesto y Contabilidad para su validación.

De ante mano muchas gracias.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Tablero Presupuestal'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-28 11:08:00', 'Se cambió INVENTARIO.REQUISICIONES en el campo APRUEBA_CONTA de 1 a 0', 'Modificación en BD', '2024-08-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002247');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002251', 'BORRAR DE LA BOVEDA FACTURA DEL SAT', '2024-08-27 09:36:00', 'Buenos días, 

Por medio del presente solicito su apoyo para borrar de la bóveda la factura xml y pdf, que se encuentra actualmente validada en el folio 82311 en el portal Mediport. 

Lo anterior para estar en posibilidad de validar la factura directa del portal sat, al tener problemas de lector de QR la factura proporcionada por el proveedor.

Agradeciendo de antemano su atención al presente. 

Le envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'FACTURAS PENDIENTES'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-28 09:43:00', 'Se eliminó de la bóveda, el registro de CFD_RECEPCION,CFD_CUSTOM_DATA y en FOLIO_FACTURA se modificó el campo ESTADO de 2 a 0', 'Modificación en BD', '2024-08-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002251');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002254', 'SOLICITUD DE ACCESO AL MÓDULO DE VERIFICACIÓN DE PRESUPUESTO-COMPRAS', '2024-08-27 12:05:00', 'Buen día estimados, espero que se encuentren muy bien.

Por este medio tengo a bien solicitar su apoyo para poder tener acceso al módulo de VERIFICACIÓN DE PRESUPUESTO en COMPRAS.

Muchas gracias por el apoyo.

Saludos',
  (select id from ventanas_mesa where nombre = 'VERIFICACIÓN DE PRESUPUESTA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-28 09:24:00', 'Se le otorgaron permisos al usuario requerido y se dio de alta en seguridad->catalogo -> usuarios', 'Modificación en BD', '2024-08-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002254');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002252', 'BM MSC SARAH NO SE VISUALIZA EN TABLERO', '2024-08-27 09:42:00', 'Los desgloses del buque en cuestión se cargaron correctamente, se solicita su apoyo para el buque se visualice en sistema y poder subir los VINs

ID: 241453',
  (select id from ventanas_mesa where nombre = 'EXPEDIENTE_BUQUE'),
  (select id from categorias_mesa where nombre = '/Sistemas/Tablero de Carga'),
  (select id from solicitantes_mesa where nombre = 'Loperena Dominguez, Sergio Adolfo'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-27 16:42:00', 'Se cambió el tipo de carga en OPERACION.VIAJES en el campo TIPO_CARGA del valor de contenedor(19 o 20) al valor de automóviles (21), en este caso también se cambió el STATUS a Atracado(A) y se ejecutó el procedimiento EDIV2.PACK_EXPEDIENTE_BUQUES.generaTableroinformación', 'Modificación en BD', '2024-08-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002252');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002248', 'MSC ALDEBARAN ID 241412', '2024-08-26 16:00:00', 'Buena tarde compañeros

Se informa que del buque mencionado en el titulo, el cual se trata de una Transferencia de Cice - Asipona, ya se hicieron los desgloses correspondientes en sistema, por ello solicito que se visualice en el tablero para poder subir vins.
Quedo de su respuesta y comentarios.
Saludos',
  (select id from ventanas_mesa where nombre = 'EXPEDIENTE_BUQUE'),
  (select id from categorias_mesa where nombre = '/Sistemas/Tablero de Carga'),
  (select id from solicitantes_mesa where nombre = 'Vargas Zapata, Maria Isabel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-27 14:00:00', 'Se cambió el tipo de carga en OPERACION.VIAJES en el campo TIPO_CARGA del valor de contenedor(19 o 20) al valor de automóviles (21), en este caso también se cambió el STATUS a Atracado(A) y se ejecutó el procedimiento EDIV2.PACK_EXPEDIENTE_BUQUES.generaExpedienteImportacion', 'Modificación en BD', '2024-08-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002248');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002235', 'VALIDACION COMPLEMENTO DE PAGO DHL', '2024-08-26 10:42:00', 'Buenos días,

Solicito su apoyo para poder cargar los complementos de pago expedidos por DHL, debido a que marcan un error en el formato. De igual manera, adjunto los complementos de pago y facturas par su oportuna revisión.

Gracias y quedo al pendiente.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-28 15:50:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-08-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002235');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002260', 'COMPROBACION FONDO REVOLVENTE', '2024-08-28 10:33:00', 'Solicito su apoyo para continuar con la carga de las facturas para la comprobación del fondo revolvente, esto debido a que al intentar cargarla me aparece error.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS / CAJA CHICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-28 15:33:00', 'Se eliminó de la bóveda y el registro de INVENTARIO.FOLIO_FACTURA', 'Seguimiento de proceso', '2024-08-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002260');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002263', 'Modificacion de fecha de baja en Boleta de Salida', '2024-08-28 11:44:00', 'Hola buenos días, 

Me podrían apoyar con la modificación en el sistema SIIP de las siguientes fechas de baja de las boletas abajo desglosadas, ya que de manera involuntaria se dio de baja con el mes actual.


ID-241096 Buque: DSI POLLUX


Folio:97974 Dice 22/08/2024 Debe Decir:22/07/2024

Folio:97973 Dice 21/08/2024 Debe Decir:21/07/2024

Quedo atenta.

Saludos, cordiales!!',
  (select id from ventanas_mesa where nombre = 'FOLIOS DE SALIDA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Flores Lopez, Patricia Elizabeth'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-28 16:44:00', 'Se cambió la fecha en OPERACION.FOLIOS_SALIDA en el campo F_EXPEDICION, en OPERACION.DET_FOLIOS_SALIDA en el campo FECHA y en OPERACION.DET_MOVS_ALM en el campo de F_MOV', 'Modificación en BD', '2024-08-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002263');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002265', 'CAMBIO DE FECHA EN PEDIDO', '2024-08-28 15:38:00', 'Buenas tardes, 

solicito de su amable apoyo para realizar un cambio de fecha en la orden 35415.

La fecha correcta debe ser 28 de mayo de 2024

Agradezco de antemano el apoyo 

Saludos!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-29 12:03:00', 'Se cambió en INVENTARIO.PEDIDOS en los campos de fecha correspondiente.', 'Modificación en BD', '2024-08-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002265');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002266', 'CAMBIO DE FECHA', '2024-08-28 15:40:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido de servicios:35416
Para que quede con fecha: 22/05/2024.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-29 11:59:00', 'Se cambió en INVENTARIO.PEDIDOS en los campos de fecha correspondiente.', 'Modificación en BD', '2024-08-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002266');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002268', 'BORRAR REGISTRO EN COMPROBACION', '2024-08-28 18:04:00', 'BUENAS TARDES

POR MEDIO DEL PRESENTE SOLICITO SU APOYO PARA BORRAR REGISTRO DE LA FACTURA NO.75684079 POR UN MONTO DE $ 49.97, EN  LA COMPROBACIÓN 4655, POR CAMBIO DE CONCEPTO.


DE ANTEMANO GRACIAS.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Molina Montiel, Miriam del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-29 13:00:00', 'Se eliminó de la bóveda y el registro de INVENTARIO.FOLIO_FACTURA y en VIATICOS.VTCOSDETCOMPROBACION', 'Seguimiento de proceso', '2024-08-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002268');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002267', 'CAMBIO DESCRIPCION DEL ARTICULO EN ACTA ENTREGA RECEPCION DE SERVICIOS', '2024-08-28 17:47:00', 'Buenas tardes estimados.

Solcito su amable apoyo para poder cambiar la parte de OBSERVACIONES correspondiente a la Solicitud de contrato 314 Partida 12, mismo que se imprime en la Descripción del Artículo que se encuentra en el Acta Entrega Recepción de Servicios (ASPN-VER-GAF-F-28) con No. de Embarque: 32757.

DICE:
DE ENFILACIÓN INSTALADA EN EL HOTEL HAWAII                      CORRESPONDIENTE AL MES DE ABRIL 2024.                                  PERIODO 12 DE MAYO 2024 AL 12 DE JUNIO 2024

DEBE DECIR:
DE ENFILACIÓN INSTALADA EN EL HOTEL HAWAII                      CORRESPONDIENTE AL MES DE MAYO 2024.                                  PERIODO 12 DE MAYO 2024 AL 12 DE JUNIO 2024

De antemano agradezco la atencion.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Recepción de Materiales (embarque)'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-30 12:52:00', 'Se cambió en INVENTARIO.DETSOLCONTRATOS en el campo OBSERVACIONES con el texto proporcionado', 'Modificación en BD', '2024-08-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002267');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002271', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 132588 E INVESTIGACIÓN DE MERCADO 10005', '2024-08-29 12:01:00', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 132588 E INVESTIGACIÓN DE MERCADO 10005',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-30 12:46:00', 'Se cambió en INVENTARIO.REQUISICIONES, INVENTARIO.INVESTIGACIONMERCADO en los campos de fecha correspondientes y en INVENTARIO.PROVEINVESTIGACIONMERCADO en F_COTIZACION, y FECHAACTPROVEEDOR', 'Modificación en BD', '2024-08-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002271');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002274', 'VICULAR FOLIO 82423 a la cuenta MEDIPORT MARTINEZ ROSAS ANAMAR', '2024-08-30 10:40:00', 'Buenos días, solicitamos de su apoyo para vincular el folio 82423 de la estimación 5-N del contrato API-GI-CS-62602-004-21 del ya fenecido MARTINEZ WOLF LUIS.

Lo anterior, se solicita la vinculación al MEDIPORT de su heredera para ella pueda cargar factura de estimación finiquito y poder cerrar el contrato en mención. La mesa de ayuda anterior a esta se soluciono con éxito, sin embardo en la caratula de contrato se detecto un calculo erróneo en el ISR por lo cual se habilito un nuevo folio.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Obras Externos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-02 08:40:00', 'Se cambiaron los campos de RFC, PROOVEDOR, EMAIL en INVENTARIO.FOLIO_FACTURA en los registros con el folio 82400', 'Modificación en BD', '2024-08-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002274');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002281', 'SOLICITUD DE APOYO PARA ELIMINAR FOLIOS DE COMPROBACION DE VIATICOS DEL DIRECTOR GENERAL', '2024-09-02 10:58:00', 'Buen día, se solicita su valioso apoyo eliminado todos los folios de la comprobación de viáticos del Director con fecha 29/08/2024.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Altamirano Landa, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-03 09:58:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002281');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002276', 'Solicitud de cambio de cambio de atributos en Nota de credito', '2024-08-30 11:38:00', 'Hola buenas tardes

Por medio de la presente solicito el apoyo para el cambio de atributos para realizar la validación de la nota de crédito, la cual se adjunta.

Actualmente el sistema solicita estos atributos en la nota de crédito:',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-30 17:48:00', 'Se cambió la información en INVENTARIO.FOLIO_FACTURA en los atributos FORMA_PAGO
METODO_PAGO
USO_CFDI', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002276');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002278', 'CASETAS OPERATIVAS - MEDIPORT', '2024-08-31 11:54:00', 'Buenos días 

Por este medio solicito su apoyo para el bloqueo de la caseta F) de las casetas operativas hasta el 03 de septiembre, para que se visualice libre el 04 de septiembre del presente año, por otra parte se solicita el bloque de la caseta H), hasta nuevo aviso.

Sin otro particular, agradezco de antemano la atención.',
  (select id from ventanas_mesa where nombre = 'API SERVICIOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Diaz Ortiz, Oscar'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-02 15:00:00', 'Se modificó con un if en el procedimiento PACK_SERVPORT_CASETASGRANEL.consultaEstadoCaseta con las condiciones correspondientes.', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002278');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002277', 'MEDIPORT - PERSONAL DEL RECINTO', '2024-08-31 09:48:00', 'Buenos días.

Por este medio solicito de su apoyo para agregar en el apartado de personal de recinto del mediport, a la compañera Ximena Piña Pereda.

Sin más agradezco de antemano.',
  (select id from ventanas_mesa where nombre = 'PERSONAL RECINTO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Diaz Ortiz, Oscar'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-02 12:00:00', 'Se modificó NOMINA.EMPLEADOS en el campo RECINTO de 0 a 1 para que esté activo', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002277');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002289', 'CANCELACION NOTA DE EGRESO ESTADO 3', '2024-09-02 13:19:00', 'Buena tarde
Con la finalidad de efectuar la cancelación del folio SIP 919687por almacenaje, cobrada con anticipo
Agradeceremos la cancelación de la nota de egreso 17112 folio 14353 , con motivo de cancelación 3. NO SE LLEVO A CABO LA OPERACION
Cualquier duda o comentario, quedamos a sus órdenes
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-03 10:00:00', 'En CFDCONNECT.CFD_EMISION se cambio en la nota con folio 14353 CANCELADO=1 y MOTIVO_CANCELACION=03, en la tabla FACTURACION.VTNOTASCREDITO se cambio al resgistro del folio 17112 el campo ESTADO=4', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002289');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002257', 'FACTURA EN PAPEL Y REGISTRO', '2024-08-27 17:01:00', 'Por este medio solicito de su apoyo para poder cargar en papel los folios:-82415-82414-82413Cabe señalar que solo se cargaría el documento en PDF ya que no se cuenta con el XML.También se envía captura de pantalla ya que al seleccionar factura en papel en Facturas CFDI se borran los datos.Como se muestra a continuación:',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-08-29 16:12:00', 'Se generaron los registros en INVENTARIO.FOLIO_FACTURA, se cargaron en MEDIPORT los pdf proporcionados y XML incorrectos de otra factura, una vez cargados, se corrigen los datos correctos y se elimina el xml de la bóveda, poniendo como MENSAJE_VALIDACION que se cargó sin dicho archivo', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002257');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002282', 'SOLICITUD DE CAMBIO DE FECHA DE REQUISICIÓN 132589 E INV. DE MERCADO 10006', '2024-09-02 11:00:00', 'Buen día compañeros, espero que se encuentren muy bien.

Por este medio tengo a bien solicitar el cambio de fecha de la REQUISICIÓN 132589 e INV. DE MERCADO 10006, quedando definida para el 29/05/2024 para ambas.

Quedo atenta a cualquier comentario.

Saludos.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-03 12:46:00', 'Se cambiaron las fechas en INVENTARIO.REQUISICIONES e INVENTARIO.INVESTIGACIONMERCADO', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002282');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002291', 'CANCELACION NOTA DE EGRESO ESTADO 3', '2024-09-02 14:18:00', 'Buena tarde
Con la finalidad de efectuar la cancelación del folio SIP 919683 por almacenaje, cobrada con anticipo
Agradeceremos la cancelación de la nota de egreso 17141 folio 14382 , con motivo de cancelación 3. NO SE LLEVO A CABO LA OPERACION
Cualquier duda o comentario, quedamos a sus órdenes
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-03 10:18:00', 'En CFDCONNECT.CFD_EMISION se cambio en la nota con folio 14382 CANCELADO=1 y MOTIVO_CANCELACION=03, en la tabla FACTURACION.VTNOTASCREDITO se cambio al resgistro del folio 17141 el campo ESTADO=4', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002291');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002293', 'CANCELACION NOTA DE EGRESO - ESTADO 3 . NO SE LLEVO A CABO LA OPERACION.', '2024-09-02 15:12:00', 'Buena tarde
Con la finalidad de efectuar la cancelación del folio SIP 919757 por almacenaje, cobrada con anticipo
Agradeceremos la cancelación de la nota de egreso 17148 folio 14389, con motivo de cancelación 3. NO SE LLEVO A CABO LA OPERACION
Cualquier duda o comentario, quedamos a sus órdenes
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-03 11:12:00', 'En CFDCONNECT.CFD_EMISION se cambio en la nota con folio 14389 CANCELADO=1 y MOTIVO_CANCELACION=03, en la tabla FACTURACION.VTNOTASCREDITO se cambio al resgistro del folio 17148 el campo ESTADO=4', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002293');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002294', 'CANCELACION NOTA DE EGRESO - NO SE LLEVO A CABO LA OPERACION', '2024-09-02 15:43:00', 'Buena tarde
Con la finalidad de efectuar la cancelación del folio SIP 919683 por almacenaje, cobrada con anticipo
Agradeceremos la cancelación de la nota de egreso 17115 folio 14356, con motivo de cancelación 3. NO SE LLEVO A CABO LA OPERACION
Cualquier duda o comentario, quedamos a sus órdenes
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-03 11:43:00', 'En CFDCONNECT.CFD_EMISION se cambio en la nota con folio 14356 CANCELADO=1 y MOTIVO_CANCELACION=03, en la tabla FACTURACION.VTNOTASCREDITO se cambio al resgistro del folio 17115 el campo ESTADO=4', 'Modificación en BD', '2024-09-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002294');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002299', 'ELIMINAR FACTURA CARGADA EN COMPROBACIÓN DE VIÁTICOS.', '2024-09-02 16:37:00', 'Buena tarde,

Solicito amablemente apoyo a fin de que se elimine la factura cargada en el sipv2 ya que no se visualiza (misma que se encuentra seleccionada en la imagen adjunta al presente), referente a la comprobación de viáticos con folio no. 4659.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-03 15:37:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002299');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002296', 'NO SE VISUALIZA EN MEDIPORT EL CONTRATO PARA AMPLIAR', '2024-09-02 15:55:00', 'BUENA TARDE. PIDO EL APOYO PARA PODER VISUALIZAR EN AMPLIACIÓN DE VIGENCIA DE CONTRATOS EL CONTRATO NUM.

ASPN-GI-CS-62601-013-23

BIORECUPERACIÓN INTEGRAL SUSTENTABLE DEL GOLFO, S.A. DE C.V.',
  (select id from ventanas_mesa where nombre = 'TRAMITES ELECTRÓNICOS /AMPLIAR CONTRATO A EMPRESAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Cancino Aguirre, Nardy Neyrot'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-03 11:55:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002296');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002292', 'APERTURA DE CANDADO PROVEEDOR 108186 TUROPLASTICS', '2024-09-02 14:20:00', 'MUY BUENA TARDE EQUIPO.


POR MEDIO DEL PRESENTE, SOLICITO SU APOYO PARA REALIZAR LA APERTURA DEL CANDADO DEL PROVEEDOR:  108186 TUROPLASTICS, S.A. DE C.V.


LO ANTERIOR PARA QUE PERMITA REALIZAR LA CARGA DEL CFDI DERIVADO DE LA COMPROBACIÓN DE LOS CUBREBOCAS PARA ESTE EJERCICIO 2024, CABE MENCIONAR QUE, EL DEPARTAMENTO DE PRESUPUESTO Y CONTABILIDAD YA TIENE CONOCIEMINTO, A QUIEN MARCO COPIA PARA SU AUTORIZACIÓN.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-03 10:27:00', 'Se cambió INVENTARIO.FOLIO_COMPLEMENTO en el campo ESTADO de 2 a 5 para que se refleje que ya se subieron los complementos', 'Modificación en BD', '2024-09-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002292');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002290', 'MSC BARBADOS ID 241521', '2024-09-02 14:16:00', 'Buena tarde compañeros

Se informa que del buque mencionado en el titulo, el cual se trata de una Transferencia de Icave - Asipona, ya se hicieron los desgloses correspondientes en sistema, por ello solicito de su apoyo para que se visualice en el tablero y poder subir vins.
Quedo de su respuesta y comentarios.
Saludos.',
  (select id from ventanas_mesa where nombre = 'TABLERO EXPEDIENTE BUQUE'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Liberacion de Automoviles'),
  (select id from solicitantes_mesa where nombre = 'Vargas Zapata, Maria Isabel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-03 10:16:00', 'Se cambió en OPERACION.VIAJES en el campo de TIPO_CARGA de 20 o 19 a 21, y se ejecutó el procedimiento PACK_EXPEDIENTE_BUQUE.GeneraExpedienteImportacion', 'Modificación en BD', '2024-09-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002290');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002310', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-09-03 12:18:00', 'Buen día
Agradeceremos el apoyo con el timbrado de las siguientes notas de egreso :Nota 17178  Folio 14419
Nota  17180  Folio 14421

Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-03 17:18:00', 'Se cambio el monto en VTNOTASCREDITO con el centavo de diferencia y luego en FACTURAS_TIMBRADOR se cambio timbrado a 0 para ambos casos', 'Modificación en BD', '2024-09-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002310');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002302', 'CAMBIO DE FECHA EN PEDIDO', '2024-09-02 18:23:00', 'Buenas tardes 

Solicito de su amable apoyo para realizar un cambio de fecha en el pedido con número de orden: 35419

La fecha correcta debe ser 28 de mayo de 2024

Agradezco de antemano el apoyo 

Quedo a sus órdenes 
saludos!!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 15:34:00', 'Se modificó en INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-09-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002302');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002303', 'CAMBIO DE FECHA
 EN PEDIDO', '2024-09-02 18:29:00', 'Por este medio solicito de su apoyo para el cambio de fecha del contrato de servicios: 35420.

Debe decir: 30/08/2024.

Quedo atenta a sus indicaciones.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 15:32:00', 'Se modificó en INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-09-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002303');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002301', 'CAMBIO DE FECHA EN REQUISICIÓN E INVESTIGACIÓN DE MERCADO', '2024-09-02 17:05:00', 'Favor de cambiar fecha a la requisición  132590 y a su Investigación de mercado  10007 , con fecha 07/05/2024.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 12:39:00', 'Se cambiaron las fechas en INVENTARIO.REQUISICIONES e INVENTARIO.INVESTIGACIONMERCADO', 'Modificación en BD', '2024-09-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002301');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002312', 'PRIVILEGIOS SIIP JENNIFER CASTIILO MORALES', '2024-09-03 13:05:00', 'ESTIMADOS, BUENAS TARDES.


DE LA MANERA MAS ATENTA SE SOLICITA QUE A LA COMPAÑERA JENNIFER CASTIILO MORALES LE SEAN OTORGADOS LOS PRIVILEGIOS DE VISUALIZACIÓN Y CAMBIOS EN EL SIIP, IGUALES A LOS QUE CUENTA UN SERVIDOR, LOS CUALES BÁSICAMENTE CONSISTEN EN LA VISUALIZACIÓN DEL APARTADO “CONTROL DE CONTRATOS” PARA QUE DENTRO DE "CAPTURA DE CONTRATOS" PUEDA MODIFICAR LA INFORMACIÓN DE LA PESTAÑA "JURÍDICO", Y DE ESTA MANERA PUEDA REALIZAR LA ACTUALIZACIÓN DE LA INFORMACIÓN SEGUIMIENTO DE ESTA GERENCIA JURIDICA.


SIN OTRO PARTICULAR, QUEDÓ A LA ÓRDEN PARA EL CASO DE REQUERIR INFORMACIÓN ADICIONAL PARA EL CUMPLIMIENTO DE LO SOLICITADO.

 
RESPETUOSAMENTE.',
  (select id from ventanas_mesa where nombre = 'CONTROL DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Becerra Reyes, Jose Aubert'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 12:05:00', 'Se dio de alta al usuario en SERVICIO.CONTACTOS01, SERVICIO.USUARIOS32 y se agregaron los permisos de JURIDICO en SERVICIO.CONTACTOS_PERMISOS16 con valor de 31, 48, 68, 67', 'Modificación en BD', '2024-09-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002312');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002318', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-09-04 10:18:00', 'Buen díaAgradeceremos el apoyo con el timbrado de la siguiente nota de egreso :Nota 17192  Folio 14433


Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-04 15:18:00', 'Se cambio el monto en VTNOTASCREDITO con el centavo de diferencia y luego en FACTURAS_TIMBRADOR se cambio timbrado a 0', 'Modificación en BD', '2024-09-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002318');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002320', 'CASILLA DE COMPLEMENTO DE PAGO', '2024-09-04 10:40:00', 'Buen día, 

Solicito su apoyo para desmarcar la casilla de "usa complemento" del folio de pago 81100 del modulo de compras, así como eliminar el complemento de pago generado con número 10291.',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Valentin Aguirre, Jarumi de los Angeles'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 17:14:00', 'Se cambió en INVENTARIO.PAGOS en el campo REQUIERE_COMP de valor 1 a 0, al igual que LIBERACION_COMP y se eliminó el folio relacionado del complemento en FOLIO_COMP. Además se eliminó el registro en INVENTARIO.FOLIOS_COMPLEMENTO', 'Modificación en BD', '2024-09-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002320');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002323', 'CONVENIO EN MONTO Y TIEMPO EN INTEGRAL: ERROR AL SUMAR LAS CANTIDADES.', '2024-09-04 14:01:00', 'BUENAS TARDES, 

AL CARGAR CONVENIO EN TIEMPO Y MONTO DEL CONTRATO ASPN-GI-CO-62602-002-24, SE INGRESARON LOS NUEVOS VOLÚMENES DE LOS CONCEPTOS EXISTENTES. SIN EMBARGO, LA SUMA DE TODO ESTO NO CUADRA CON LO INGRESADO AL SISTEMA  (SE COMPROBÓ SUMANDO MANUALMENTE LAS CANTIDADES)

LA CANTIDAD QUE DEBIERA SER ES POR $8,352,262.21 
EN EL SISTEMA ES DE $6,661,375.99 

AGRADECIENDO PUEDAN APOYARME QUEDO AL PENDIENTE.',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Simonín Baldwin, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-05 13:00:00', 'Se cambio la cantidad en SOLCNTOVIGENTES(importetotal) y VERSIONESCONTRATOS(importetotalnuevo) a la cantidad real obtenida desde VOLUMEN x PUNITARIO en SOLCPTOSCONTRATADOS', 'Modificación en BD', '2024-09-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002323');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002330', 'APOYO PARA ELIMINAR FOLIO DE LOS VIATICOS DEL DIRECCIÓN GENERAL', '2024-09-04 17:24:00', 'Buenas tardes,

Por medio del presente se solicita su valioso apoyo para eliminar una factura cargada (seleccionada de color azul con un monto de $1''987) en los viáticos del Director (con folio 4657)

Sin mas por el momento reciba un cordial saludo..',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Pulido López, Rey David'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-05 16:24:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002330');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002333', 'ELIMINACION DE MANIFIESTOS', '2024-09-05 14:33:00', 'Se solicita la cancelación de los manifiesto que se relacionan del Buque MSC DON GIOVANNI ID 241413.


A2573371.334 SAINT JOHN,

A2573142.328	 MONTREAL,

A2573696.341 FREEPORT',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Zamora Martinez, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-06 10:00:00', 'Se eliminaron de OPERACION.MERCANCIAS y OPERACION.DESG_MCIAS en base a los id_mcias obtenidos de MERCANCIAS', 'Modificación en BD', '2024-09-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002333');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002334', 'CARGA DE ARCHIVOS COMRPOBACION FONDO REVOLVENTE SIIP', '2024-09-05 14:45:00', 'Buenas tardes, por medio de la presente le solicito de la manera más atenta su ayuda para poder seguir cargando facturas a la comprobación de fondo revolvente ya que me marca error, la última que subí fue del rubro 131 factura 711650.

Gracias',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-06 10:00:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002334');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002311', 'ELIMINAR FACTURA CARGADA EN COMPROBACIÓN DE VIÁTICOS NO.4650', '2024-09-03 12:56:00', 'Buena tarde,

Solicito amablemente apoyo a fin de que se elimine la factura cargada en el sipv2 ya que se sustituirá por otro concepto (misma que se encuentra seleccionada en la imagen adjunta al presente), referente a la comprobación de viáticos con folio no. 4650.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 11:56:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002311');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002326', 'CANCELACION ANTICIPO - ESTADO 3 . NO SE LLEVO A CABO LA OPERACION.', '2024-09-04 16:40:00', 'Buena tarde

Derivado de la duplicidad de registro, agradeceremos la cancelación del anticipo folio SIP 919989.

Estado 3 , motivo no se llevó a cabo la operación.



Saludos',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-05 15:40:00', 'Se canceló la factura CFD_CONNECT.CFD_EMISION en los campos CANCELADO DE 0 a 1, MOTIVO_CANCELACION se pone 03 o el motivo indicado, y en FACTURACION.VTFACTURAS en ESTADO  de 1 a 4', 'Modificación en BD', '2024-09-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002326');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002309', 'DICE Y DEBE DECIR || HOEGH YOKOHAMA || CAMBIO DE BULTOS', '2024-09-03 12:13:00', 'Buen día, Estimados 

Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio en Cantidad al Artículo 23, por petición de Agente Aduanal vía correo electrónico. 


Buque: Hoegh YOKOHAMA

Viaje: 241607

Folio:509932

Dice: 1121 bts

Debe decir: 1 bulto',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 11:13:00', 'Se modificó en OPERACION.DESG_MCIAS en los campos CANTIDAD, EXISTENCIA, en OPERACION.DET_MOVS_ALM en el campo CANTIDAD_ALM, en OPERACION.ACUMULADOS_ALM en los campos ENTRADAS, SALDO_ENTRADA, SALIDA, SALDO_SALIDA, para que se visualice en mediport, se modificó en EDIV2.SOLMULTIPLE_CARGA en PESO, y EDIV2.TABLERO_CARGA_DETALLE', 'Modificación en BD', '2024-09-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002309');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002314', 'SIIP - REQUISICIONES.', '2024-09-03 14:31:00', 'Buenas tardes.

Por este medio solicito de su apoyo para que se apertura del SIIP, del apartado requisiciones una folio con fecha de 27 de mayo de 2024, lo anterior para atender una instrucciones de destrucción por parte de la autoridad aduanera.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Diaz Ortiz, Oscar'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 16:04:00', 'Se cambiaron las fechas en INVENTARIO.REQUISICIONES e INVENTARIO.INVESTIGACIONMERCADO', 'Modificación en BD', '2024-09-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002314');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002342', 'SOLICITUD DE ELIMINACIÓN DE FACTURAS EN EL SIIPV', '2024-09-06 09:52:00', 'Buenos días,

Por medio del presente, solicito su amble apoyo para la eliminación de facturas en 2 comprobaciones de viáticos. Las cuales se detallan a continuación:
Felipe Adolfo Quijano Montoya

FOLIO: 4663

RUBRO: 2 Taxis                          $410.00

               4 Consumo alimentos $1,094.50


Gabriela Yuritzi Bautista Martínez

FOLIO: 4664

RUBRO: 10 Boletos (autobus) $1,246.00

                2  Taxis                       $410.00

                4  Consumo de alimentos $475.00


Sin más por el momento, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-06 17:52:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002342');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002340', 'SOLICITUD DE AYUDA PARA ELIMINAR FOLIOS EN MEDIPORT', '2024-09-06 08:59:00', 'Buen día, se solicita su valioso apoyo eliminando todas facturas cargadas, lo anterior en virtud, en que Contabilidad comentó que se debe de dar alta los proveedores.
FOLIO: 4646',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Altamirano Landa, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-06 13:00:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002340');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002328', 'CORRECIÓN INVENTARIO BUQUE BULKTEC', '2024-09-04 17:17:00', 'Buen día estimados

Solicito de su amable apoyo en la corrección de REPORTE DE CIERRE DE BUQUE DE IMPORTACIÓN de Buque BULKTEC con ID 241073, en el cual cuenta con un conocimiento (BTECTCVC01) que no coincide las fechas de operación correspondientes: 

Inicio de operación: 06/08/24 
Termino de operación: 12/08/24 

Quedo en espera de sus indicaciones. 

Saludos Cordiales.',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Piña Pereda, Ximena'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-05 16:17:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002328');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002331', 'CASETAS OPERATIVAS-MEDIPORT', '2024-09-04 17:47:00', 'Por este medio solicito su apoyo para el bloqueo de la caseta H de las casetas operativas, debido a que se encuentra en mantenimiento del clima por presentar falla en su funcionamiento, dicho bloqueo será hasta nuevo aviso.

Sin otro particular, agradezco de antemano la atención.

Saludos.

Violeta Caballero Cortez',
  (select id from ventanas_mesa where nombre = 'CASETAS OPERATIVAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-05 15:47:00', 'Se modificó el procedimiento para CASETAS en mantenimiento', 'Modificación en BD', '2024-09-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002331');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002327', 'RECUPERACIÓN DE FOLIO 98598 DE BUQUE SIIPV', '2024-09-04 16:47:00', 'Buen día estimados

Solicito su amable apoyo para la recuperación de folio 98598 (boleta) en el sistema SIIPV del Buque STELLAR ISABELLA con ID 241229, ya que por equivocación se cerro el conocimiento (folio).

Quedo atenta a sus indicaciones. 

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FOLIOS DE SALIDA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Piña Pereda, Ximena'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-05 15:47:00', 'Se cambió en OPERACION.FOLIOS_SALIDA en el campo ESTADO de 2 a 0 y en F_VIGENCIA cambiándolo al día actual, además se eliminó el detalle de la liberación de mercancía en OPERACION.DET_FOLIOS_SALIDA', 'Modificación en BD', '2024-09-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002327');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002313', 'ERROR EN CARGA MEDIPORT', '2024-09-03 14:05:00', 'Buenas tardes.

Derivado a diferencia de 01 centavos entre Complemento de Pago y Comprobante de Pago, solicito de su apoyo para poder validar el Complemento adjunto a la presente correspondiente al Folio 10296 de la sección PAGOS PENDIENTES - VALIDAR COMPLEMENTOS',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-04 17:35:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002313');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002343', 'SISTEMA MEDIPORT', '2024-09-06 10:25:00', 'Buenos días, solicito su apoyo para la correcta validación de una factura en Mediport ya que me aparece que ya se encuentra en bóveda. Adjunto las facturas para su oportuna revisión.


Muchas gracias y quedo pendiente.',
  (select id from ventanas_mesa where nombre = 'FACTURAS PENDIENTES'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-09 08:25:00', 'Se eliminó de la bóveda, el registro de CFD_CONNECT.CFD_RECEPCION, en CFD_CONNECT.CFD_CUSTOM_DATA y se regresó a estado 0 en INVENTARIO.FOLIO_FACTURA', 'Modificación en BD', '2024-09-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002343');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002351', 'CASETAS OPERATIVAS-MEDIPORT', '2024-09-06 17:01:00', 'Buenas tardes, 

Por este medio se solicita se inhabilite la caseta operativa "C" toda vez que se reporta que el clima no enfría, y ya se reporto la falla a mantenimiento.

Saludos',
  (select id from ventanas_mesa where nombre = 'CASETAS OPERATIVAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-09 14:01:00', 'Se modificó el procedimiento para CASETAS en mantenimiento', 'Modificación en BD', '2024-09-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002351');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002349', 'CASETAS OPERATIVAS-MEDIPORT', '2024-09-06 16:41:00', 'Buenas tardes, 

Por este medio solicito su apoyo para el desbloqueo de la caseta Operativa "H" toda vez que ya se realizó el mantenimiento del clima, 

De antemano, Gracias 

Saludos',
  (select id from ventanas_mesa where nombre = 'CASETAS OPERATIVAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-09 12:41:00', 'Se modificó el procedimiento para CASETAS en mantenimiento', 'Modificación en BD', '2024-09-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002349');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002347', 'SOLICITUD PARA ELIMINAR FOLIO DE COMPROBACION DE VIATICOS', '2024-09-06 16:27:00', 'Solicito su valioso apoyo eliminando las facturas el Folio 4398 de la comprobación de viáticos de Rey David Pulido López del 18/08/2024 al 23/08/2024',
  (select id from ventanas_mesa where nombre = 'COMPROBACION DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Altamirano Landa, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-09 10:27:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002347');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002348', 'ELIMINACIÓN DE FACTURA EN EL SIIPV', '2024-09-06 16:33:00', 'Buenas tardes,

Por medio del presente, solicito su amable apoyo para la eliminación de una factura en la comprobación de viáticos del Lic. Felipe Quijano Montoya. A continuación, detallo los datos para su eliminación:

FOLIO: 4663

RUBRO: 4 CONSUMO DE ALIMENTOS $504.50

Sin otro particular, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPROBACION DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-09 10:33:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002348');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002354', 'CAMBIO DE FECHA EN PEDIDO', '2024-09-09 09:29:00', 'Buenos días Compañeros 

Solicito de su amable apoyo para realizar cambio de fecha en pedido con número de orden 35464 por favor. 

La fecha correcta debe ser 15 de mayo 2024

quedo a sus órdenes 

saludos!!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-09 16:02:00', 'Se cambió INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-09-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002354');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002335', 'Agregarr 2% y 5% al millar en caratula', '2024-09-05 15:53:00', 'Buenas tardes estimado compañero, En relación al contrato ASPN-GI-CO-62602-010-22de rubro“Desmantelamiento y rehabilitación de almacenes y casetas de control de acceso ubicados en bahía sur del puerto de Veracruz en el ejercicio 2022-2023”
Se solicita de su apoyo para colocar de nuevo la parte del 2% y 5% al millar, que fueron eliminados temporalmente a solicitud de su servidora.

aGRADEZCO EL APOYO. sALUDOS.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Segura, Mayra Celeste'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-10 16:13:00', 'En OBRAS.DEDUCCIONES se agregaron los registros 7 y 8 para el contrato solicitado', 'Modificación en BD', '2024-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002335');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002026', 'Solicitud para realizar modificación', '2024-08-01 18:35:00', 'Solicito su amable apoyo para realizar una modificación de un importe, por lo que solicito su apoyo para abrir la plataforma. 
Adjunto imágenes',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Obras Externos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Fernández, Lluvia del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-10 11:53:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002026');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002352', 'MODIFICACION DE FECHA EN CONTRA RECIBO', '2024-09-06 17:19:00', 'Buenas tardes:
Por favor su apoyo para la modificación del contra recibo emitido desde el módulo Facturas Obra en el apartado de Fecha Venc., folio 82026


Dice
Fecha Recep.: 04/09/2024
Fecha Venc.  : 04/09/0024

DEBE DECIR
Fecha Recep.: 04/09/2024
Fecha Venc.  : 04/09/2024',
  (select id from ventanas_mesa where nombre = 'FACTURAS OBRA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cuentas por Pagar'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-10 16:27:00', 'Corrección en INVENTARIO.FACTURA en la fecha de vencimiento con la fecha correcta', 'Modificación en BD', '2024-09-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002352');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002366', 'Eliminación de SAMM3', '2024-09-10 10:52:00', 'Buen día

Solicito de su apoyo con la eliminación de los siguientes manifiestos correspondientes al buque AS PALINA con ID:241610, tráfico de importación y exportación a solicitud del cliente por omisión a puerto (adjunto capturas de solicitud)

Archivos SAMM3 a eliminar:
--> A3571680.229 (importación) (código de mediport de la solicitud RMA-SM-280824-2478582)
--> A3571197.249 (exportación)  (código de mediport de la solicitud RMA-SM-050924-2480308)',
  (select id from ventanas_mesa where nombre = 'MANIFIESTOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Bernal Hernández, Sarha Melissa'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-10 15:52:00', 'Se eliminaron los registros OPERACION.DESG_MCIAS filtrados por ID_MCIAS y OPERACION.MERCANCIAS filtrado por NOMBRE_ARCHIVO', 'Modificación en BD', '2024-09-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002366');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002361', 'CASETAS OPERATIVAS-MEDIPORT', '2024-09-09 12:26:00', 'Buenas tardes, 

De su apoyo con habilitar la caseta operativa "C" toda vez que el clima de la misma ya se encuentra reparado, y puede ser rentada a los usuarios.

Saludos',
  (select id from ventanas_mesa where nombre = 'CASETAS OPERATIVAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-10 11:26:00', 'Se habilitó la caseta C en el procedimiento PACK_SERVPORT_CASETASGRANEL.Consultaestadocaseta, con un condicional', 'Modificación en BD', '2024-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002361');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002360', 'APOYO PARA ELIMINAR FACTURA DEL FOLIO 4646 DEL FONDO REVOLVENTE DE CAJA CHICA DE LA DIRECCIÓN GENERAL', '2024-09-09 12:06:00', 'Buenas tardes,

Por medio del presente solicito su valioso apoyo para eliminar una factura del fondo revolvente con folio No. 4646. Se marca con azul la factura seleccionada a eliminar.

De antemano muchas gracias',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Pulido López, Rey David'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-10 09:06:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002360');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002369', 'SOLICITUD DE ELIMINACIÓN DE FACTURA EN COMPROBACIÓN DE VIÁTICOS', '2024-09-10 12:43:00', 'Buenas tardes,

Por medio del presente, solicito su apoyo para eliminar una factura en la comprobación de viáticos de la Lic. Gabriela Bautista. A continuación comparto los datos necesarios para tal fin:FOLIO: 4664RUBRO: 10 BOLETO (AUTOBUS) IMPORTE: $1,246.00
Sin otro particular, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPROBACIÓN DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-11 11:43:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002369');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002372', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-09-10 17:22:00', 'Buena tarde
Agradeceremos el apoyo con el timbrado de la nota de egreso  17217 folio 14456

Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-11 12:22:00', 'Se cambio el monto en VTNOTASCREDITO con el centavo de diferencia y luego en FACTURAS_TIMBRADOR se cambio timbrado a 0', 'Modificación en BD', '2024-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002372');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002346', 'FACTURA EN PAPEL', '2024-09-06 15:52:00', 'Buenas tardes estimados.

Solicito de su apoyo para poder subir la factura correspondiente al folio 82473 con factura en papel para poder realizar la comprobación de un pago de crédito fiscal.

De ante mano muchas gracias.',
  (select id from ventanas_mesa where nombre = 'FACTURAS PENDIENTES'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-11 09:22:00', 'Se generaron los registros de CFD_CONNECT.CFD_RECEPCION subiendo en mediport la factura PDF con un XML incorrecto, para después hacer la corrección de los datos y eliminar el UUID en RECEPCION y INVENTARRIO.FOLIO_FACTURA', 'Modificación en BD', '2024-09-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002346');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002373', 'Registro de nuevos proveedores', '2024-09-10 17:42:00', 'Área: recursos materiales 6 piso edificio principal.
Detalle de imperfecto: al registrar a un nuevo proveedor después de llenar todos los datos necesarios y al presionar grabar ( aparece leyenda que solicita agregar la antes del numero) como se refleja en el dato enviado, como evidencia del detalle.

( saludos cordiales) 
Atte. Alejandro',
  (select id from ventanas_mesa where nombre = 'PROVEEDORES/ACREEDORES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Vacaciones'),
  (select id from solicitantes_mesa where nombre = 'Arresola Martínez, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-11 12:42:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002373');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002374', 'Registro de nuevos proveedores', '2024-09-10 17:52:00', 'Área: recursos materiales 6 piso edificio principal

Detalle de imperfecto: al inscribir a un nuevo proveedor y después de haber llenado todos los datos y oprimir grabar (pide ingresar lada antes del numero telefónico) y no permite grabar',
  (select id from ventanas_mesa where nombre = 'PROVEEDORES/ACREEDORES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Arresola Martínez, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-11 12:52:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002374');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002382', 'Carga de factura folio 82528', '2024-09-11 12:37:00', 'Hola buenos días

Por medio de la presente solicito su apoyo para la carga de la factura adjunta, ya que el proveedor tiene complemento de pago pendiente, sin embargo es necesario dar tramite al pago ya que se trata de un servicio continuo para la entidad.

* El complemento de pago ha sido solicitado.

PROVEEDOR: EDENRED MEXICO
PEDIDO: 35473
FOLIO DE FACTURA:82528',
  (select id from ventanas_mesa where nombre = 'FACTURAS PENDIENTES'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-12 10:02:00', 'Se modificó INVENTARIO.FOLIO_COMPLEMENTOS en ESTADO de 0 a 5', 'Modificación en BD', '2024-09-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002382');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002376', 'ESTADO ABIERTO SIIP GRUPO METROPOLITANO', '2024-09-10 19:26:00', 'Hola buenas tardes,

Por este medio solicito su apoyo para poder cambiar el estado de la recepción 38998 a ABIERTO, lo anterior para la eliminación de las partidas y posteriormente borrar el embarque.

Gracias y quedo al pendiente.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Recepción de Materiales (embarque)'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-12 11:31:00', 'En INVENTARIO.EMBARQUES se cambió el campo ESTADO de 2 a 1', 'Modificación en BD', '2024-09-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002376');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002378', 'Cambio de fecha', '2024-09-11 09:11:00', 'Buen día 

Solicito cambiar de fecha los pedidos con numero de orden 35241y 35243 del proveedor radiomovil dipsa, la fecha solicitada es  30/05/2024.
Quedo atento, saludos',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-12 11:41:00', 'Se cambió INVENTARIO.PEDIDOS en los campos de fecha correspondientes', 'Modificación en BD', '2024-09-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002378');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002234', 'SIIPV | MODULO DE COMPRAS', '2024-08-26 10:38:00', 'Buen día,
Por instrucciones superiores lo siguiente;

Solicitando de su amable apoyo para que se habilite en el sistema SIIPV, el modulo de Compras (Todo lo que conlleva para elaborar Requisiciones), al Comisionado de Marina, el Tte. Angel Isaac de Paz Ortiz, que se encuentra adscrito a la Gerencia de Operaciones. 

Lo anterior, para poder dar cumplimiento a las actividades encomendadas. 

Quedamos atentos. 

Saludos.',
  (select id from ventanas_mesa where nombre = 'USUARIOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Sarmiento Aquino, Adriana Monserrat'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-11 09:53:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002234');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002394', 'PESO DEPOSITADO IMPORTACION', '2024-09-12 15:46:00', 'Buena tarde compañeros
Solicito de su apoyo, les comento del BM MSC BARBADOS ID 241521 este buque es el que se esta manejando con Art. 15 de ICAVE A ASIPONA.
Del conocimiento MEDUEU650879 el peso manifestado con el depositado se observa incongruente
debe de quedar de la siguiente anera su existencia
DICE:

DEBE DECIR:
Por favor pueden validar este detalle.??
Quedo de su respuesta y comentarios.
Saludos',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Liberacion de Automoviles'),
  (select id from solicitantes_mesa where nombre = 'Vargas Zapata, Maria Isabel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-13 10:46:00', 'Se cambió la cantidad y peso de existencia en OPERACION.DESG_MCIAS, OPERACION.DET_MOVS_ALM, OPERACION.ACUMULADOS_ALM', 'Modificación en BD', '2024-09-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002394');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002390', 'CAMBIO DE FECHA EN INFORME DE ENTRADA EN ALMACEN Y CAMBIO DE RECEPCIÓN', '2024-09-12 12:08:00', 'Buen día estimados.



Se solicta su apoyo para realizar el cambio de fecha de recepción en el 1 SUBALMACEN GENERAL del No. Entrada: 38328/2024 a la fecha 06/02/2024, así como el cambio de la persona que RECIBIÓ: por MARIA DEL CARMEN QUIROZ RAMIREZ',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Recepción de Materiales (embarque)'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-13 16:18:00', 'Se cambió INVENTARIO.EMBARQUES en los campos de FECHA y en INVENTARIO.MOVSALM en TRABNUM_ENCARGADO', 'Modificación en BD', '2024-09-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002390');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002393', 'Modificar fecha de pedido', '2024-09-12 13:32:00', 'Buena tarde 
Solicito cambiar de fecha en el SIIP los pedidos con numero de orden 35477, 35476, 35475, 35474.

Se encuentran en estado de tramite, la fecha solicitada es 30/05/2024.

Quedo atento, saludos',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-13 13:11:00', 'Se cambió en INVENTARIO.PEDIDOS en los campos de FECHA correspondientes', 'Modificación en BD', '2024-09-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002393');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002392', 'Eliminar comprobantes', '2024-09-12 13:10:00', 'buenas tardes por medio del presente solicito se eliminen los archivos del folio de comprobación numero 4638',
  (select id from ventanas_mesa where nombre = 'COMPROBACION DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-13 17:19:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002392');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002391', 'CARGA COMPLEMENTOS DE PAGO MEDIPORT', '2024-09-12 13:05:00', 'Hola buenas tardes, 

Por medio de la presente solicito su apoyo para la carga en papel de dos complementos de pago de Teléfonos de México, debido a que en mediport me marca error en monto.

Adjuntos el PDF y XML de las mismas para su oportuna revisión.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-13 12:50:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002391');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002305', 'APOYO PARA REVISIÓN', '2024-09-03 10:38:00', 'Por este medio solicito de su apoyo ya que al imprimir mi indicador se visualiza la solicitud de pedido 319 en el módulo de licitaciones del SIIP del cual se realizó el proceso para comprometer su presupuesto por lo cual ya no debería aparecer en el indicador como pendiente.


Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'INDICADORES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-04 09:38:00', 'Se modificó el archivo del reporte, agregando la condición en FORMULA1 if vEstadoPed = ''AUTORIZADO'' OR vEstadoPed = ''ORDENADO''', 'Modificación en BD', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002305');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002402', 'Dice | Debe || Cambio de Bultos || BBC Elisabeth', '2024-09-13 15:57:00', 'Buen día, Estimados 

Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos  al Artículo 23, por petición de Agente Aduanal vía correo electrónico. 



Buque: BBC ELISABETH

ID: 241544

Folio: 508975

 

DICE: 29,388 BULTOS 

DEBE DECIR: 22,938 BULTOS',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-16 09:57:00', 'Se cambió en OPERACION.DESG_MCIA, OPERACION.ACUMULADOS_ALM, OPERACION.DET_MOVS_ALM cambiando los campos de CANTIDAD Y PESO correspondientes', 'Modificación en BD', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002402');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002400', 'APOYO PARA SUBIR COMPLEMENTO DE PAGO EN PAPEL || TOTAL PLAY', '2024-09-13 11:01:00', 'Buenos días, 


Por medio del presente solicito de su colaboración para subir en papel el complemento de pago con folio: 10450  lo anterior debido a diferencias en el monto por cuestiones de redondeo.

Se adjunta complemento de pago proporcionado por el proveedor para su pronta referencia.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-13 16:21:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002400');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002404', 'DICEY DEBE || CAMBIO DE BULTOS || MANIZALES', '2024-09-14 11:48:00', 'Buen día, Estimados 

Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos  al Artículo 23, por petición de Agente Aduanal vía correo electrónico

Buque: MANIZALES

ID: 241602

Folio: 509368

 

DICE: 14,950 BULTOS
DEBE DECIR: 12,494 BULTOS',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-16 15:00:00', 'Se cambió en OPERACION.DESG_MCIA, OPERACION.ACUMULADOS_ALM, OPERACION.DET_MOVS_ALM cambiando los campos de CANTIDAD Y PESO correspondientes', 'Modificación en BD', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002404');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002403', 'DICE Y DEBE | CAMBIO DE BULTOS FWN BONAFIDE', '2024-09-14 11:45:00', 'Buen día, Estimados 

Por este medio solicito su apoyo para realizar una solicitud por Dice y Debe  por Cambio de Bultos  al Artículo 23, por petición de Agente Aduanal vía correo electrónico. 

Buque: FWN BONAFIDE

ID: 241625

Folio: 509485

 

DICE: 2,353 BULTOS 

DEBE DECIR: 2,341 BULTOS',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-16 15:00:00', 'Se cambió en OPERACION.DESG_MCIA, OPERACION.ACUMULADOS_ALM, OPERACION.DET_MOVS_ALM cambiando los campos de CANTIDAD Y PESO correspondientes', 'Modificación en BD', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002403');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002406', 'VALIDACION COMPLEMENTO DE PAGO DHL', '2024-09-17 09:01:00', 'Buenos días, 

Por medio de la presente solicito su apoyo para subir en papel el complemento de pago de DHL de la segunda quincena del mes de agosto. Adjunto los documentos PDF y XML para su correcta validación.

Gracias y quedo al pendiente.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-18 09:29:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002406');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002410', 'CARGA DE CONCEPTOS', '2024-09-17 11:24:00', 'REFERENTE AL CONTRATO ASPN-GI-CO-62602-002-24 A CARGO DE LA CONTRATISTA CONSTRUCTORA VERACRUZANA DE PUENTES S.A. DE C.V.

La contratista busca cargar los conceptos de la estimación 1C y comentan que en el sistema no le aparecen los conceptos del 20 en adelante. Por lo que solicita de su ayuda para solucionar el problema.

Gracias!',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Simonín Baldwin, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-17 16:24:00', 'En OBRAS.CPTOSCONTRATADOS se cambio el tipo de (N)ormal a (C)onvenio en 13 conceptos del contrato', 'Seguimiento de proceso', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002410');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002413', 'VALIDACION COMPLEMENTO DE PAGO POR ERROR EN FECHA', '2024-09-17 12:50:00', 'Buenas tardes,


Por medio de la presente solicito su apoyo para poder validar un complemento de pago de Grupo Metropolitano, debido a que me marca diferencia en fecha. Adjunto los archivos PDF y XML para su oportuna revisión.

Gracias y quedo al pendiente.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-18 09:47:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002413');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002412', 'SOLICITUD DE CAMBIOS AL FORMATO ASPN-VER-GAF-F-72 INVESTIGACIÓN DE MERCADO', '2024-09-17 12:08:00', 'Ing. Héctor Andrés Suarez Velázquez
Jefe de Departamento de Desarrollo de Sistemas
Presente,

Bue día Ingeniero, por medio de la presente y con motivo de una de las recomendaciones de observación derivada de una visita de mejora realizada por el OICE de esta Entidad.

Me permito solicitar a usted la incorporación del área contratante al formato ASPN-VER-GAF-F-72 " INVESTIGACIÓN DE MERCADO" como Visto Bueno, siendo esta la figura de Gerente de Administración y Finanzas.

Adjunto Formato para pronta referencia, así como una imagen de ejemplo.

Muchas gracias por su atención.',
  (select id from ventanas_mesa where nombre = 'INVESTIGACION DE MERCADO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-18 11:08:00', 'Se agrego las etiquetas solicitadas y los cambios en la cabecera del reporte', 'Seguimiento de proceso', '2024-09-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002412');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002399', 'COMPROMETER MONTOS A EJERCICIO 2024', '2024-09-13 10:45:00', 'Derivado del reclamo del pago de trabajos de años anteriores, solicitamos su apoyo para comprometer monto en el ejercicio fiscal presente.

Los contratos y montos a pagar son los siguientes: 

 ASPN-GI-CS-62601-009-22          $105,846.00 (mover a ejercicio 2024)',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-17 11:04:00', 'Se agrego un registro nuevo en DISTRCONTRATOS para el año 2024 y en el año 2023 se coloco en 0 y se coloco el ESTADOPRESUPUESTAL en COMPROMETIDO, en el nuevo registro se agrego el monto, iva y monto total a los campos de MONTOPEND, IVAPEND, MONTOTOTAPEND respectivamente para poder comprometerlo; Tambien el estado presupuestal se coloco en PENDIENTE DE COMPROMETER. Esto fue para ambos casos.', 'Seguimiento de proceso', '2024-09-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002399');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002418', 'Eliminación de SAMM3', '2024-09-17 17:38:00', 'Buenas tardes

Solicito de su apoyo con la eliminación del manifiesto A2573597.250  a solicitud del cliente por omisión a Veracruz

ID y Buque: 241551 MSC BALTIC III
Tráfico: exportación
Archivo SAMM3:  A2573597.250  

Adjunto captura de pantalla',
  (select id from ventanas_mesa where nombre = 'RECEPCIÓN VIA MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Bernal Hernández, Sarha Melissa'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-18 16:38:00', 'Eliminar bitácora de OPERACION.MANIFIESTO_ORG y OPERACION.MANIFIESTO_SAMM3', 'Modificación en BD', '2024-09-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002418');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002426', 'GENERAR EXISTENCIA || MV ADRIATIC HWY ||241537', '2024-09-18 12:22:00', 'Buen día, 

Por este medio solicito de su apoyo para generar existencia del folio 510827 correspondiente al Buque Adriatic Highway 241537.



Se requiere que la existencia sea:

Cantidad: 177

Peso: 14,488.00 kg.


Lo anterior para liberar en un tramite aparte.',
  (select id from ventanas_mesa where nombre = 'FOLIOS SALIDA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-18 17:22:00', 'Se modificó OPERACION.FOLIOS_SALIDA en los campos de PESO y CANTIDAD', 'Modificación en BD', '2024-09-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002426');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002417', 'ACTUALIZAR CONTRATO EN SIIP - ASPN-GI-CS-62601-030-23', '2024-09-17 17:16:00', 'Buenas tardes, solicitamos de su apoyo para actualizar contrato en el SIIP.

Para el contrato ASPN-GI-CS-62601-030-23 se requiere realizar una modificación en monto y plazo, sin embargo se observa en el sistema que el monto contractual es un $1.00 debiendo ser  $5,479,518.84, se presume que por ese error no deja la modificación del contrato, envío captura de pantalla para pronta referencia.',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Obras Externos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-19 10:07:00', 'En OBRAS.CNTOVIGENTES y OBRAS.SOLCNTOVIGENTES se cambio el campo de importetotalnuevo de 1 al monto del contrato correcto', 'Modificación en BD', '2024-09-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002417');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002432', 'FACTURA EN BÓVEDA FONDO REVOLVENTE SIIP', '2024-09-18 18:14:00', 'Buenas tardes, por medio de la presente solicito apoyo para poder eliminar una de las comprobaciones en fondo revolvente 4668 debido a que no me aparece pero tampoco me deja seguir cargando, ya que se reflejan en bóveda.

Muchas gracias y quedo al pendiente.',
  (select id from ventanas_mesa where nombre = 'CAJA CHICA / FONDO REVOLVENTE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-19 13:00:00', 'Se eliminaron los comprobantes de INVENTARIO.FOLIO_FACTURA y VIATICOS.VTCOSDETCOMPROBACION', 'Modificación en BD', '2024-09-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002432');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002430', 'CAMBIO DE ESTATUS', '2024-09-18 17:13:00', 'Por medio de la presente solicito su apoyo para que en el módulo de Solicitud de contrato, la solicitud 319, correspondiente al No. de contrato: 34317, cambie a estado a parcialmente pagado, lo anterior para la continuidad del contrato ya que tiene un convenio modificatorio.',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-19 17:22:00', 'Se cambio en INVENTARIO.SOLCONTRATO en el campo ESTADO de 3 a 2', 'Modificación en BD', '2024-09-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002430');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002438', 'DUPLICIDAD EN PROGRAMACION EN MEDIPORT', '2024-09-19 13:03:00', 'Buena tarde compañeros !! solicito su amable apoyo ya que al abrir la programación el día
de hoy, se nos cerro y al la volvimos a abrir y se duplico :( 
nos apoyan eliminando la última con no. 2024184 ya que trabajos el día de hoy con la 183
les agradezco de antemano.',
  (select id from ventanas_mesa where nombre = 'PROGRAMACION DE BUQUES'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Buques/Programación de Buques'),
  (select id from solicitantes_mesa where nombre = 'Haruel Aguirre, Lizbeth'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-20 09:03:00', 'Se eliminó de OPERACION.PROGRAMACION, OPERACION.ATRAQUE_PLANEADO, OPERACION.PROGRAMACION_BITACORA', 'Modificación en BD', '2024-09-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002438');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002440', 'CANCELACION NOTA DE EGRESO - ESTADO 2', '2024-09-19 16:08:00', 'Buena tarde
Con la finalidad de dar atención a la CANCELACIÓN de los folios SIP 919758, 919752 y refacturación de cobro de adición por almacenaje  solicitada en oficio adjunto, agradeceremos el apoyo con la cancelación de notas de egreso asignando el motivo 2 . COMPROBANTE EMITIDO CON ERRORES SIN RELACION.
NOTA   FOLIO        FACTURA ALMACENAJE RELACIONADA17146   14387        919752
17149   14390        919758

Cualquier duda quedamos a sus órdenes

Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Almacenaje'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-19 16:12:00', 'En CFDCONNECT.CFD_EMISION se cambio el campo de cancelado a 1 y motivo_cancelacion a ''02'', en FACTURACION.VTNOTASCREDITO se cambio el campo estado a 4 en ambos casos.', 'Modificación en BD', '2024-09-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002440');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002436', 'GENERAR EXISTENCIA || MV HOEGH YAKOHAMA ||241607', '2024-09-19 10:56:00', 'BUEN DIAPOR ESTE MEDIO SOLICITO DE SU APOYO CON LO SIGUIENTE: GENERAR EXISTENCIA EN TRAMITE DE ART 23 DE EXPORTACION FOLIO 509789; CORRESPONDIENTE AL BUQUE HOEGH YOKOHAMA, DEBIDO A QUE EL AA REALIZO UNA BOLETA DE LIBERACION CON FOLIO 98550.FOLIO 23. 509789BUQUE: HOEGH YOKOHAMAFOLIO BOL LIBERACIÓN: 98550CANTIDAD LIBERADA EB BOLETA: 794 BTOS PESO LIBERADO EN BOLETA: 322181.00 KGS
SE REQUIERE QUE SE GENERE UNA EXISTENCIA PARA GENERAR OTRO TRAMITE DE LIBERACION POR: CANTIDAD: 1 BTOSPESO: 1,384.00 KGS

GRACIAS!!',
  (select id from ventanas_mesa where nombre = 'OPERACION'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Carga'),
  (select id from solicitantes_mesa where nombre = 'Lara Cruz, Amairany'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-20 11:42:00', 'Se cambió OPERACION.FOLIO_SALIDA en CANTIDAD y PESO, además de EDIV2.SLIBERACION_DETALLE y EDIV2.SLIBERACION_FACTURA', 'Modificación en BD', '2024-09-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002436');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002442', 'SOLICITUD PARA INCLUIR AL ARQ NARDY EN LA CARÁTULA DE SISTEMA DEL CONTRATO ASPN-GI-CO-62601-027-23', '2024-09-19 16:21:00', 'Buenas tardes, solicito su apoyo dado que en el sistema, no es posible seleccionar el nombre del Arq. Nardy Cancino, Subgerente de Evaluación, para la impresión de las carátulas de sistema.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'González Martínez, Francisco de Jesus'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-20 11:21:00', 'En OBRAS.USUARIOS se agrego el registro del usuario solicitado asi como en OBRAS.UTIPOSA (esto es para habilitar que un usuario pueda firmar en una estimacion o contrato)', 'Modificación en BD', '2024-09-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002442');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002450', 'CANCELACION NOTA DE EGRESO - ESTADO 2', '2024-09-20 13:17:00', 'Buena tarde

Con la finalidad de dar atención a la CANCELACIÓN de los folios SIP 919922, 920380 y refacturación de cobro de adición por almacenaje  solicitada en oficio adjunto, agradeceremos el apoyo con la cancelación de notas de egreso asignando el motivo 2 . COMPROBANTE EMITIDO CON ERRORES SIN RELACION.




NOTA   FOLIO        FACTURA ALMACENAJE RELACIONADA
17175   14416        919922
17199   14440        920380

Cualquier duda quedamos a sus órdenes

Saludos.',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-23 08:17:00', 'En CFDCONNECT.CFD_EMISION se cambio el campo de cancelado a 1 y motivo_cancelacion a ''02'', en FACTURACION.VTNOTASCREDITO se cambio el campo estado a 4 en ambos casos.', 'Modificación en BD', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002450');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002448', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-09-20 12:10:00', 'Buen día
Agradeceremos el timbrado de las siguientes notas de egreso 

NOTA   FOLIO
17237   14471
17240    14474


Saludos
Departamento Tesorería',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-20 17:10:00', 'Se cambio el monto en VTNOTASCREDITO con el centavo de diferencia y luego en FACTURAS_TIMBRADOR se cambio timbrado a 0', 'Modificación en BD', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002448');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002455', 'SOLICITUD DE CANCELACION_CASETA OPERATIVA-NO 2745/24-CODIGO SIG-CS-190924-2483422', '2024-09-21 10:02:00', 'Buen dia, 

De su apoyo con la cancelación de la solicitud de la caseta operativa G con numero de solicitud 2745/24, la cual se aprobó por error, ya que el cliente solicita la cancelación de la misma por atraso en el buque:

" Buenas tardes, por este medio solicito la cancelación de la caseta G, ya que el barco se atrasó hasta el día lunes."',
  (select id from ventanas_mesa where nombre = 'CASETAS OPERATIVAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-23 15:00:00', 'Se canceló en EDIV2.DOCUMENTOS y EDIV2.FLUJODOCUMENTO', 'Modificación en BD', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002455');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002444', 'ERROR EMITIDO POR SISTEMA MEDIPORT', '2024-09-20 10:15:00', 'POR FAVOR SU APOYO PARA VERIFICAR EL ERROR EMITIDO POR EL SISTEMA MEDIPORT AL INTENTAR UN SERVIDOR APROBAR UN PERMISO ELÉCTRICO.',
  (select id from ventanas_mesa where nombre = 'TRABAJOS ELECTRICOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Moreno Cobix, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-23 12:40:00', 'El error "there is no row at position 0" se da cuando el documento se daña y solo se guarda en la tabla documento pero (en este tramite) no en EDIV2.trabajo_electrico que es donde se guardan los detalles y posteriormente se consulta. Se tiene que generar un nuevo tramite de manera forzosa', 'Seguimiento de proceso', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002444');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002459', 'ACTIVACION DE RUBRO "MOVIMIENTOS DE MERCANCIAS" EN SIIP', '2024-09-23 10:44:00', 'Buenos días

Por medio del presente se solicita amablemente su apoyo para que se active en mi cuenta para poder entrar al rubro de "Movimientos de Mercancías" que está dentro del rubro de "Movimientos de Almacén" en SIIP para revisión de lo reportado y realizar comparativas para fines estadísticos.

Sin más por el momento, agradeciendo de antemano su apoyo a la brevedad posible

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'USUARIOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones'),
  (select id from solicitantes_mesa where nombre = 'Limas Barragan, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-24 10:13:00', 'Se modificó desde el siip los permisos del usuario para que tuviera acceso al módulo de Operacion - Modificaciones de mercacncia', 'Modificación en BD', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002459');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002462', 'ERROR AL SUBIR FACTURA', '2024-09-23 11:36:00', 'Por este medio solicito de su apoyo ya que al intentar subir la factura en el FOLIO: 82621 me indica el siguiente ERROR: 
CFDI40102 - El resultado de la digestión debe ser igual al resultado de la descripción del sello.Para que me indiquen a que se refiere y poder comentarle al proveedor en caso de requerir cambio de factura.Anexo la evidencia.
Quedo atenta.Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FACTURACIÓN ELECTRÓNICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-24 10:36:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002462');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002463', 'SOLICITUD DE CANCELACION_CASETA OPERATIVA 2746/24_CODIGO_CAM-CS-210924-2483873', '2024-09-23 12:09:00', 'Buenas tardes, 

El motivo del presente es para solicitar su apoyo con la cancelación del servicio de casetas 2746/24, debido a que el cliente manifiesta  que no se llevara a cabo el servicio  ya que el buque no se ha atracado por poca disponibilidad de muelles, como se muestra a continuación:',
  (select id from ventanas_mesa where nombre = 'CASETAS OPERATIVAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/API Servicios Portuarios'),
  (select id from solicitantes_mesa where nombre = 'Caballero Cortez, Violeta'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-24 11:09:00', 'Se cambió en EDIV2.DOCUMENTO en el ESTADO de 3 a 1, y en EDIV2.FLUJODOCUMENTO de 3 a 1', 'Modificación en BD', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002463');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002367', 'MODIFICACION IMPORTE PRESUPUESTALES', '2024-09-10 11:58:00', 'Buenas tardes:
Por favor su apoyo en la modificación de los importes en las cuentas contables presupuestales de la póliza Diario 66 mes de septiembre, ya que es sistema no los genero de manera correcta

DICEN 16,239.40
DEBEN DECIR 16,833.33',
  (select id from ventanas_mesa where nombre = 'CONTABILIDAD'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-24 12:22:00', 'Cambiar en CONTA.MOVIMIENTOS en CARGO y ABONO', 'Modificación en BD', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002367');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002460', 'AJUSTE POR PENALIZACION POLIZA DR249 Y DR250 PERIODO 9 (RECURSOS MATERIALES)', '2024-09-23 10:45:00', 'Buenos días, 

De la manera más atenta solicito el ajuste de las pólizas DR249 y DR250, debido que no esta realizando el descuento de la penalización en el registro contable del gasto.

POLIZA DIARIO 249Dice. 97,615 y Debe decir: 96,150.76',
  (select id from ventanas_mesa where nombre = 'CONTABILIDAD'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Captura de pólizas'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-24 09:30:00', 'Cambiar en CONTA.MOVIMIENTOS en CARGO y ABONO', 'Modificación en BD', '2024-09-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002460');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002469', 'SOLICITUD DE VIATICOS', '2024-09-24 09:31:00', 'Buenos días,

De la manera más atenta solicito su apoyo para asignar un importe por concepto de autobús a la solicitud de viatico núm.4410 , debido a que este no fue asignado por omisión antes de su liberación.

importe: $2,300.00',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE VIÁTICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-24 13:31:00', 'Cambiar monto en VIATICOS.VTCOSSOLICITUD en los campos de  IMBOLETOAUT y de IMPORTEADIC', 'Modificación en BD', '2024-09-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002469');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002464', 'ERROR MONTO DE NOTA DE CREDITO EN MEDIPORT', '2024-09-23 12:29:00', 'Me refiero al contrato número ASPN-GI-CO-62602-015-24 estimación 3-N, del contratista CONSORCIO CONSTRUCTOR TWINS,  se solicita apoyo para subir nota de crédito del 2% al millar y 5 al millar, con los montos señalados en la carátula de la estimación ya que existe una diferencia de los montos de la carátula de la estimación, con los montos del sistema , y como consecuencia el sistema no permite cargar nota de crédito:
Adjunto captura de pantalla donde marca el error.
Gracias.

Es importante mencionar que se gestiono nuevamente el folio para la contratista suponiendo que era error temporal del sistema pero no funciono.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas Obras'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-24 12:29:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-09-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002464');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002477', 'CAMBIO DE FUNDAMENTO', '2024-09-24 18:12:00', 'Buenas tardes estimados.

Solicito de su amable apoyo para poder realizar cambio de fundamento asignado en la requisición 132406.

DICE: 21. ART. 26-III, 41-XX

DEBE DECIR: 26. ART 26-II,41-XX',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-25 17:00:00', 'Se cambió el fundamento en INVENTARIO.REQUISICIONES  de 21 a 26', 'Modificación en BD', '2024-09-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002477');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2024-002479', 'CAMBIO DE PROYECTO DE INVERSIÓN', '2024-09-25 09:26:00', 'Buenos días Compañeros, solicitamos de su apoyo para cambio el proyecto de inversión del contrato ASPN-GI-CO-62601-026-23, se requiere pasar del proyecto 0809J3E0005 al proyecto 2313J3E0005.

Lo anterior, para estar en condiciones de solicitarle a nuestra GAF que se comprometa el recurso destinada para el ejercicio 2024.

NOTA: Se solicita amablemente que el autorizador de esta incidencia sea personal adscrito a la Gerencia de Ingenieria


Quedo atento.',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Cambio de proyectos de inversion'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-09-26 15:58:00', 'Se modifico en OBRAS.DISTRCONTRATOS el campo clavepi del de 0809J3E0005 a 2313J3E0005, tambien se modifico el mismo campo en OBRAS.CNTOVIGENTES', 'Modificación en BD', '2024-09-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2024-002479');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002468', 'SOLICITUD PARA BORRAR DE LA BÓVEDA FACTURA', '2024-09-23 18:35:00', 'Buenas tardes, 

Por medio del presente solicito su apoyo para eliminar de la bóveda de mediport la factura que se encuentra cargada en la solicitud de pago con folio 82435, lo anterior debido a que se realizó una modificación en el cfdi por parte del proveedor.',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-26 13:09:00', 'Se eliminaron los archivos de bóveda, los registros en CFD_RECEPCION, CFD_CUSTOM_DATA y se modificó INVENTARIO.FOLIO_FACTURA en el campo estado de 2 a 0', 'Modificación en BD', '2024-09-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002468');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002443', 'SOLICITUD CAMBIO DE FECHA', '2024-09-19 17:58:00', 'Buenas tardes,

Por medio de la presente solicito su apoyo para el cambio de fecha de 19/09/2024 a 27/05/2024, de la orden número 35516, proveedor 105841 GEN INDUSTRIAL, S.A. DE C.V.

Muchas gracias y quedo al pendiente.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-26 13:05:00', 'Se cambió en INVENTARIO.PEDIDOS en los campos de fecha correspondientes.', 'Modificación en BD', '2024-09-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002443');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002475', 'MODIFICACION DE FECHA EN CONTRA RECIBO', '2024-09-24 17:11:00', 'Buenas tardes:
Por favor su apoyo para la modificación del contra recibo emitido desde el módulo Facturas Obra en el apartado de Fecha Venc., folio 82573

Dice
Fecha Recep.: 24/09/2024
Fecha Venc.  : 27/09/0024

DEBE DECIR
Fecha Recep.: 04/09/2024
Fecha Venc.  : 27/09/2024
Por favor nos pueden ayudar validando este detalle de sistema, ya que este tema ha sido reincidente. Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cuentas por Pagar'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-26 13:01:00', 'Se cambió en INVENTARIO.PEDIDOS en los campos de fecha correspondientes.', 'Modificación en BD', '2024-09-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002475');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002485', 'CAMBIO DE FECHA', '2024-09-25 17:50:00', 'Buenas tardes estimados.

Solicito de su apoyo pra realizar el cambio de fecha del Contrato de Servicios con No. ORDEN: 35517 al día 20/06/2024

Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-26 13:05:00', 'Se cambió en INVENTARIO.PEDIDOS en los campos de fecha correspondientes.', 'Modificación en BD', '2024-09-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002485');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002467', 'cambiar el status de requisicion a en tramite', '2024-09-23 18:21:00', 'Estimados 

Solicito su amable apoyo para que a las requisiciones con número de solicitud 132526 y 132529 se pongan en estado en tramite, derivado que se realizaran aqdecuaciones en las mismas .',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-26 17:19:00', 'Cambio de estado en requisicion INVENTARIO.REQUISICIONES en el campo ESTADO de 5 a 1', 'Modificación en BD', '2024-09-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002467');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002490', 'CEDULA REF.-736-SIRIUS LEADER-FOLIO-509336', '2024-09-26 11:45:00', 'Buenas tardes compañeros, podrían apoyarme con la siguiente cedula de Exportación- REF.-736 SIRIUS LEADER POR 1 UNIDAD FORD - FOLIO 509336 marca error a l subirla a MEDIPORT.
ADJUNTO CEDULA Y PANTALLA. AGRADEZCO LA ATENCION , QUEDO ATENTA AL SEGUIMIENTO.',
  (select id from ventanas_mesa where nombre = 'CONSULTA DE VINS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Cedillo Lara, Karla Maria'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-27 09:45:00', 'Se modificó EDIV2.AUTOS_TRANSFERENCIA en el campo de PTDA_MOVS_ALM con el valor que tiene asignado en PTDA_MOVS_ALM en VEHICULO_MCIAS', 'Modificación en BD', '2024-09-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002490');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002496', 'MOFICATORIO FALTA COLUMNA 2025', '2024-09-27 09:45:00', 'Por este medio solicito de su apoyo ya que en la solicitud 288 del proveedor: SISTEMAS CONTINO S.A. DE C.V. en la solicitud de contrato hace falta la columna de 2025 ya quedo autorizado en Modificatorio en la pestaña Solicitudes de convenio modificatorio y ahí si aparece, anexo captura de pantalla.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONVENIOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-27 17:45:00', 'Agregar columna 2025 en solicitudes de convenio', 'Modificación en BD', '2024-09-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002496');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002486', 'CAMBIO DE TIPO DE ADJUDICACION EN CONTRATO', '2024-09-25 19:05:00', 'Buena tarde estimados.


Solicito de su amable apoyo para realizar el cambio de la sección Adjudic. a la ORDEN 35146 en el SIIP.
Se adjunta imagen para pronta referencia.',
  (select id from ventanas_mesa where nombre = 'PEDIDO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-09-30 16:34:00', 'Cambio de adjudicación', 'Modificación en BD', '2024-09-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002486');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002515', 'modificar fecha', '2024-09-30 15:06:00', 'Buen día 

Solicito cambiar en el SIIP la fecha del pedido con numero de orden 35390 , se encuentra en estado de tramite . la fecha solicitada es el día 30/05/2024. 
Quedo atento. Saludos',
  (select id from ventanas_mesa where nombre = 'PEDIDO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-10-02 16:40:00', 'Cambio de fecha en pedidos', 'Modificación en BD', '2024-10-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002515');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002512', 'modificar fecha', '2024-09-30 12:47:00', 'Buen día 

Solicito cambiar en el SIIP la fecha del pedido con numero de orden 35235 , se encuentra en estado de tramite . la fecha solicitada es el día 30/05/2024. 
Quedo atento. Saludos',
  (select id from ventanas_mesa where nombre = 'PEDIDO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-10-03 09:08:00', 'Cambio de fecha en pedidos', 'Modificación en BD', '2024-10-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002512');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002518', 'CONVENIO MODIFICATORIO ERROR EN PORCENTAJE TIEMPO', '2024-09-30 16:34:00', 'Por este medio solicito de su apoyo ya que en la Sol de convenio 272, no me permite continuar debido a que aparece el siguiente mensaje: Para que se ajuste en el sistema y me permita grabar, los datos que se capturaron se encuentran correctos de acuerdo al Modificatorio.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONVENIOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-10-01 12:34:00', 'Seguimiento de usuario (modificacion de sol convenios)', 'Seguimiento de proceso', '2024-10-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002518');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002519', 'no puedo ampliar un contrato en mediport', '2024-10-02 08:58:00', 'buenos días 

pido de su apoyo para poder dar más vigencia a un contrato en mediport 

ASPN-GI-CO-62602-007-24
JAD ASESORES INMOBILIARIOS',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Muñoz Cancino, Pablo'),
  (select id from resolutores_mesa where nombre = 'Nieto Torres, Atzimba del Rosario'),
  '2024-10-02 13:00:00', 'Cambiar el contrato en EMPRESAS edvi2', 'Modificación en BD', '2024-10-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002519');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002509', 'ESTRUCTURA PROGRAMATICA', '2024-09-30 09:58:00', 'Buenos dias:Por favor su apoyo para realizar los momentos presupuestales en la estructura programática de la póliza de pasivo Diario 442, generada del módulo Cuentas por pagar, Facturas folio 82629 ya que el sistema no generó los asientos pertinentes
Adjunto pantalla de como debe generarse',
  (select id from ventanas_mesa where nombre = 'ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cuentas por Pagar'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-02 13:17:00', 'Se modifico en CONTA.ESTPROGPPEGRESODOCTO para agregar los registros de la poliza del diario que no se insertaron', 'Modificación en BD', '2024-10-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002509');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002540', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-10-03 12:42:00', 'Buena tarde
Agradeceremos el timbrado de la nota de egreso  17294, folio 14517
SaludosDepartamento Tesorería',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-03 17:42:00', 'Se cambio el monto en VTNOTASCREDITO con el centavo de diferencia y luego en FACTURAS_TIMBRADOR se cambio timbrado a 0', 'Modificación en BD', '2024-10-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002540');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002533', 'SOLICITUD DE INDICADORES BUQUES', '2024-10-02 15:46:00', 'Estimado Gabriel, con relación a los indicadores del SGI, el cual, para dar cumplimiento al requerimiento, tengo a bien solicitar tu amable apoyo con el total de buques atendidos, buques programados y arribos cancelados relativo al tercer trimestre 2024.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Buques'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Rosas, Jorge Israel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-03 10:46:00', 'Ejecutar conjunto de selects y llenar excel que se solicita', 'Modificación en BD', '2024-10-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002533');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002524', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO', '2024-10-02 10:10:00', 'Buen día
Agradeceremos el apoyo con el timbrado de las siguientes notas de egreso
NOTA     FOLIO
17270   14493  
17271   14494



Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-02 15:10:00', 'Se cambio el monto en VTNOTASCREDITO con el centavo de diferencia y luego en FACTURAS_TIMBRADOR se cambio timbrado a 0 en ambos casos', 'Modificación en BD', '2024-10-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002524');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002531', 'Cambiar fecha de requisición', '2024-10-02 15:29:00', 'Agradezco su apoyo con los siguiente: 

DE LAS REQUISICIONES

132526 y la investigación de mercado 9961 cambiar todas las fechas por la del 27/05/2024

132529 y la investigación de mercado 9962 cambiar  todas las fechas por la del 27/05/2024

GRACIAS',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-04 09:59:00', 'Se cambio la fecha en INVENTARIO.INVESTIGACIÓNMERCADO y en INVENTARIO.REQUISICIONES por la fecha proporcionada por el usuario', 'Modificación en BD', '2024-10-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002531');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002537', 'ERROR EN MONTOS SOLICITUD DE CONTRATO 272', '2024-10-03 11:08:00', 'Por este medio solicito de su apoyo para el cambio de fechas en la solicitud de contrato 272 en la pestaña que dice Datos de Proveedor:En Fecha de Inicio (se señala con flecha azul) Dice: 10/01/2021Debe decir: 01/10/2021 (de acuerdo al contrato el cual se anexa)
En Fecha Fin (se señala con flecha azul) Dice: 10/01/2024Debe decir: 30/09/2024
Fecha Fin Contrato Original (se señala con flecha azul) Dice: 10/01/2021Debe decir: 30/09/2024
Anexo captura de pantalla tanto de la solicitud 272 como evidencia de las fechas, así como de la solicitud de convenios ya que al encontrarse mal las fechas no me permitía grabar por lo cual capture otra fecha para que me dejara grabar y pudieran modificarse las fechas.
Quedo atenta a sus indicaciones.El contrato se envía por correo.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-04 11:18:00', 'Modificaciones en INVENTARIO.SOLCONTRATOS en los campos de FECHAINICONTRATO ,FECHAFINCONTRATO, FECHAFINCONTRATADA y en la tabla de INVENTARIO.SOLCONTCONVENIOS el campo de FECHAFINANTERIOR', 'Modificación en BD', '2024-10-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002537');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002546', 'CAMBIO DE MONTO EN ESTRUCTURA PROGRAMATICA', '2024-10-04 16:08:00', 'Buenas tardes,
Solicito su apoyo en modificar el monto en la estructura programática de la póliza 99 de cheques del mes de septiembre
La póliza dice 3,419.50 y debe decir 3,043.35
Cualquier duda o  comentario quedo a sus ordenes.',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-07 15:00:00', 'Se modifico en CONTA.ESTPROGPPEGRESODOCTO para cambiar los registros de la poliza del diario que se insertaron con montos erroneos', 'Modificación en BD', '2024-10-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002546');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002547', 'ESTRUCTURA PROGRAMATICA', '2024-10-04 16:23:00', 'uenas tardes, Solicito su apoyo dado que al autorizar el folio de pago 82527, no se visualiza la estructura programática, la información que debe mostrar en la estructura programática es la siguiente: 
POL. DE DIARIO: 225U. Resp. Finalidad: J3E-996Obj. Gasto: 37104
8241: -4,049.14 (negativo)8251:  4,049.14 (positivo)8241:  1,251.00 (negativo)8251:  1,251.00 (positivo)

así como, en los movimiento contables que se ubican en la parte de arriba de la póliza debe mostrar la siguiente información:

824110111110000: $1,251.00 (negativo)
825110111110000: $1,251.00 (positivo)',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-07 15:00:00', 'Se modifico en CONTA.ESTPROGPPEGRESODOCTO para agregar los registros de la poliza del diario que no se insertaron y de igual manera en CONTA.MOVIMIENTOS se agregaron los momentos que no se insertaron', 'Modificación en BD', '2024-10-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002547');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002542', 'movimientos contables', '2024-10-03 13:20:00', 'Buenas tardes,

Solicito su apoyo en agregar los momentos contables a la póliza de diario 277 del mes de septiembre

8241: -671.00 (negativo)8251:  671.00 (positivo)

Cualquier duda o comentario quedo a sus órdenes, saludos!',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-04 11:20:00', 'Se modifico en CONTA.MOVIMIENTOS agregar los momentos que no se insertaron', 'Modificación en BD', '2024-10-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002542');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002495', 'SOLICITUD PARA BORRAR DE LA BÓVEDA UNA FACTURA', '2024-09-27 09:34:00', 'Por medio del presente solicito su apoyo para eliminar de la bóveda de mediport la factura que se encuentra cargada en la solicitud de pago con folio 82603, lo anterior debido a que se realizó una modificación en el cfdi por parte del proveedor.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-02 13:17:00', 'Se eliminaron los archivos XML y PDF en la boveda, asi como los registros asociados en CFD_RECEPCION y CFD_CUSTOM_DATA, por ultimo, en INVENTARIO.FOLIO_FACTURA se verifico que el estado estuviera en 0', 'Modificación en BD', '2024-10-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002495');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002545', 'CAMBIO DE FECHA', '2024-10-03 18:36:00', 'Buenas tardes estimado.

Solicito de su apoyo para realizar el cambio de fecha de

Contrato 35520:  23/09/2024
Requisición 132601:  02/10/2024


Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-07 08:00:00', 'Se cambiaron los campos de fechas por la fecha proporcionada por el usuario en la tabla de INVENTARIO.REQUISICIONES', 'Modificación en BD', '2024-10-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002545');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002557', 'ELIMINAR JUSTIFICACION NUMERO: 12644', '2024-10-07 15:09:00', 'Hola buenas tardes estimados a quien corresponda.

Por favor, apoyarme, en el SIIP Tramites y solicitudes en el apartado de justificacion de incidencias, eliminando la justificacion con numero de solicitud: 12644, para volver a realizar justificacion nueva y aparezca la 2 quincena de septiembre 2024 en el modulo.
Quedo atenta.Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-08 15:09:00', 'Se ejecuto el procedimiento elimina_incidencia utilizando el numero de la incidencia proporcionado', 'Modificación en BD', '2024-10-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002557');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002561', 'APOYO PARA ELIMINAR FACTURA EN FONDO REVOLVENTE EN DIRECCION', '2024-10-07 16:49:00', 'Buenas tardes,

Por medio del presente se solicita su valioso apoyo para eliminar una factura del fondo revolvente asignado a este Dirección General con FOLIO 4677',
  (select id from ventanas_mesa where nombre = 'DETALLE DE COMPROBACION DE FONDO REVOLVENTE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos/Caja Chica'),
  (select id from solicitantes_mesa where nombre = 'Altamirano Landa, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-08 12:49:00', 'Se elimino el archivo PDF y XML de la boveda para luego eliminar los registros en VIATICOS.VTCOSDETCOMPROBACION e INVENTARIO.FOLIO_FACTURA', 'Modificación en BD', '2024-10-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002561');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002566', 'Eliminación de SAMM3', '2024-10-08 00:00:00', 'Buen día 

Solcito de su amable apoyo con la eliminación total de los siguientes manifiestos de importación del buque LUCIE SCHULTE con ID: 241747 (Adjunto capturas de la solicitud mediport)

 A3571666.269: Puerto de Ámberes
 A3571525.256: Puerto de BREMERNHAVEN',
  (select id from ventanas_mesa where nombre = 'DOCUMENTO SAM M3'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Bernal Hernández, Sarha Melissa'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-09 12:29:00', 'Se eliminaron los registros en las tablas OPERACION.MERCANCIA y OPERACION.DESG_MECIAS de acuerdo a los datos proporcionados por el usuario: número de viaje y nombre de archivo.', 'Modificación en BD', '2024-10-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002566');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002572', 'SOLICITUD PARA BORRAR DE LA BÓVEDA UNA FACTURA', '2024-10-08 16:00:00', 'Por medio del presente solicito de su apoyo para eliminar de la bóveda de mediport la factura que se encuentra cargada en la solicitud de pago con folio 82579, lo anterior debido a que se realizó una modificación en el cfdi por parte del proveedor.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-09 17:43:00', 'Se eliminaron los archivos XML y PDF en la boveda, asi como los registros asociados en CFD_RECEPCION y CFD_CUSTOM_DATA, por ultimo, en INVENTARIO.FOLIO_FACTURA se verifico que el estado estuviera en 0', 'Modificación en BD', '2024-10-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002572');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002567', 'Eliminación de SAMM3', '2024-10-08 10:30:00', 'Buen día 

Solcito de su amable apoyo con la eliminación total del siguiente manifiesto de exportación del buque LUCIE SCHULTE con ID: 241747 (Adjunto captura de la solicitud mediport)

SAMM3: A3571004.276',
  (select id from ventanas_mesa where nombre = 'DOCUMENTO SAM M3'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Bernal Hernández, Sarha Melissa'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-08 17:30:00', 'Se elimino los registros en las tablas de OPERACION.MANIFIESTO_ORG y OPERACION.MANIFIESTO_SAMM3 de acuerdo con los datos proporcionados por el usuario: número de viaje y nombre de archivo', 'Modificación en BD', '2024-10-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002567');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002581', 'BORRAR FOLIO 82653 MEDIPORT', '2024-10-09 13:03:00', 'Buenas tardes estimados.

En relación al contrato número APSN-GI-CO-62602-004-24 estimación 4-N, solicito me apoyen en borrar el folio de factura 82653 en la plataforma MEDIPORT..

Quedo atento',
  (select id from ventanas_mesa where nombre = 'VALIDAR FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas Obras'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-10 12:03:00', 'Se eliminaron los archivos XML y PDF en la boveda, asi como los registros asociados en CFD_RECEPCION y CFD_CUSTOM_DATA, por ultimo, en INVENTARIO.FOLIO_FACTURA se eliminaron los registros asociados', 'Modificación en BD', '2024-10-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002581');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002571', 'ERROR DE CARGA FACTURA EN MEDIPORT APSN-GI-CO-62602-004-24 estimación 4-N', '2024-10-08 15:44:00', 'Así como como captura de pantalla donde se visualiza que no se subió la factura: 

En relación al contrato número APSN-GI-CO-62602-004-24 estimación 4-N, refiere la contratista que no puede subir las facturas al mediport ya que el sistema la marca error, señalando que el UUID de la factura ya fue cargado anteriormente, sin embargo, al entrar a sistema SIIP no se logran visualizar la factura cargada, por el contrario, la se lee, que no se han subido facturas al sistema.Se anexa copia de la captura de pantalla donde se marca el error:',
  (select id from ventanas_mesa where nombre = 'VALIDAR FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas Obras'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-09 13:44:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-10-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002571');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002578', 'Eliminar conocimientos', '2024-10-09 10:44:00', 'a solicitud de cliente  eliminar DEL SIIP Y MEDIPORT  los archivos SAMM3  A3571009.276 ,  A3571008.276 DEL BUQUE MONTE ROSA DE EXPO 241501 

nota se anexa archivo excel en donde indica cada pestaña el numero de smm3  y sus conocimientos a eliminar',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-09 15:44:00', 'Se elimino los registros en las tablas de OPERACION.MANIFIESTO_ORG y OPERACION.MANIFIESTO_SAMM3 de acuerdo con los datos proporcionados por el usuario: número de viaje y nombre de archivo', 'Modificación en BD', '2024-10-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002578');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002579', 'Cambio de fecha requisición 132606', '2024-10-09 11:11:00', 'Buen día

Por medio de la presente solicito el apoyo para el cambio de fecha de la requisición 132606, la fecha solicitada es la siguiente:

27/09/2024 

De antemano agradezco la atención, saludos cordiales',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-10 12:12:00', 'Se cambiaron los campos de fechas por la fecha proporcionada por el usuario en la tabla de INVENTARIO.REQUISICIONES', 'Modificación en BD', '2024-10-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002579');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002582', 'CAMBIO DE FECHA EN REQUISICIÓN E INVESTIGACIÓN DE MERCADO', '2024-10-09 14:07:00', 'FAVOR DE CAMBIAR LA FECHA DE LA REQUISICIÓN 132607 Y DE SU IM 010020 CON FECHA 03/10/2024.

GRACIAS.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-10 10:00:00', 'Se actualizaron las fechas en las tablas de INVENTARIO.REQUISICIONES e INVENTARIO.INVESTIGACIONMERCADO por la fecha proporcionada por el usuario', 'Modificación en BD', '2024-10-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002582');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002574', 'SOLICITUD DE CAMBIO DE FECHA DE REQUISICIÓN 132605 E INV. DE MERCADO 10019', '2024-10-08 17:54:00', 'Buena tarde estimados,

Por este medio, tengo a bien solicitar su apoyo para el cambio de fecha de la REQUISICIÓN 132605 e INV. DE MERCADO 10019, quedando ambas con la fecha 03/10/2024.

Gracias por el apoyo, saludos.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-10 11:42:00', 'Se actualizaron las fechas en las tablas de INVENTARIO.REQUISICIONES e INVENTARIO.INVESTIGACIONMERCADO por la fecha proporcionada por el usuario', 'Modificación en BD', '2024-10-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002574');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002590', 'abrir candado de cfe', '2024-10-10 08:51:00', 'Buen día 

Solicito
 abrir en mediport el candado de los complementos de pago del proveedor 
2370 SUMINISTRADOR BASICO DE ENERGIA CFE con RFC CSS160330CP7  esto para
 realizar la carga de los primeros 9 recibos del  mes de octubre y 
realizar el pago que debe ser el día 11 del mes presente..
Quedo atento.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-10 15:31:00', 'Se modificó el campo estado en INVENTARIO.FOLIO_COMPLEMENTOS de 2 a 5', 'Modificación en BD', '2024-10-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002590');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002587', 'ESTRUCTURA PROGRAMATICA  Y MOMENTOS CONTABLES PRESUPUESTALES', '2024-10-09 15:42:00', 'Buenas tardes: Por favor su apoyo para realizar los
momentos presupuestales en la estructura programática y momentos contables presupuestales en la
póliza de pasivo Diario 28, generada del módulo Cuentas por pagar,
Facturas folio 82679 ya que el sistema no generó los asientos pertinentes:',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cuentas por Pagar'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-10 17:28:00', 'Se modifico en CONTA.ESTPROGPPEGRESODOCTO para agregar los registros de la poliza del diario que no se insertaron y de igual manera en CONTA.MOVIMIENTOS se agregaron los momentos que no se insertaron. tambien en CONTA.POLIZAS se ajusto el monto que estaba con los valores incorrectos', 'Modificación en BD', '2024-10-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002587');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002588', 'CAMBIO DE FECHA', '2024-10-09 16:50:00', 'Buenas tardes estimados.


Solicito de su apoyo para realizar el cambio de fecha de la Requisición 132608 e Investigación de Mercado 10021 a la fecha 03/10/2024

Sin otro particular, envío un cordial saludo',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-11 12:29:00', 'Se actualizaron las fechas en las tablas de INVENTARIO.REQUISICIONES e INVENTARIO.INVESTIGACIONMERCADO por la fecha proporcionada por el usuario', 'Modificación en BD', '2024-10-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002588');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002589', 'MODIFICAR FECHA EN SOLICITUD DE PAGO', '2024-10-09 17:10:00', 'Buenas tardes 

Me podrían apoyar en modificar la fecha en la solicitud de pago con número de folio 82579 por favor?

La fecha correcta debe ser correspondiente al mes de Octubre 2024.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-14 08:30:00', 'Se actualizo el campo "fecha", en INVENTARIO.FACTURAS con los valores proporcionados por el usuario', 'Modificación en BD', '2024-10-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002589');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002614', 'MODIFICACION DE MONTO EN ESTRUCTURA PROGRAMATICA', '2024-10-14 09:56:00', 'Buen día,

Solicito su apoyo para modificar el monto en la estructura programática de la póliza de cheque 5 y 6 del mes de octubre.

Pol.5 Dice $146,584.40 y debe decir $146,244.80

Pol.6 Dice $97,615.00 y debe decir $96,150.76

Cualquier duda o comentario quedo a sus órdenes, saludos!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Aplicacion de Pólizas'),
  (select id from solicitantes_mesa where nombre = 'Valentin Aguirre, Jarumi de los Angeles'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-15 09:56:00', 'Se actualizaron los montos en CONTA.ESTPROGPPEGREDOCTO de acuerdo con los montos proporcionados por el usuario', 'Modificación en BD', '2024-10-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002614');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2024-002617', 'SUMA ERRONEA EN EL INTEGRAL', '2024-10-14 10:41:00', 'Buenos días, al subir mi convenio de monto y fechas... la suma en el apartado de "Nuevo" debería dar "$14,690,445.03", ya que el incremento al contrato es de $2,732,522.73 y el sistema me arroja otros montos diferentes.',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Cornejo, Angelli'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-15 10:41:00', 'Se actualizaron los montos en OBRA.VERSIONESCONTRATO con los montos proporcionados por el usuario', 'Modificación en BD', '2024-10-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2024-002617');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002619', 'sustituir factura', '2024-10-14 10:51:00', 'Buen día 

Solicito sustituir los archivos de la factura PDF y XML del pedido 35057 del proveedor INDUSTRIAL MARITIMA DE VERACRUZ. 
Anexo los archivos 
Quedo atento, saludos',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-15 10:51:00', 'Se realizo la sustitucion de los archivos mediante la factura localizada en INVENTARIO.FACTURA', 'Seguimiento de proceso', '2024-10-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002619');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2024-002621', 'NO PERMITE GUARDAR PRECIOS', '2024-10-14 11:37:00', 'BUEN DIA CARGO NORMAL LOS CONCEPTOS EXTRAORDINARIOS LE DOY GUARDAR Y ME MARCA ERROR.SOLICITO DE SU APOYO, QUEDO ATENTO ADJUNTO CAPTURA DE PANTALLA',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Ramos Cházaro, Efrén'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-15 11:37:00', 'Se determino que el problema se presento ante un flujo de carga de conceptos accidentado que impedia guardar', 'Seguimiento de proceso', '2024-10-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2024-002621');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002631', 'NOTIFICACION DE NO TIMBRADO  NOTA DE EGRESO', '2024-10-15 11:33:00', 'Buen día

Agradeceremos el apoyo con el timbrado de la nota de egreso 17315 folio 14537',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-15 16:33:00', 'Se cambio el monto en VTNOTASCREDITO con el centavo de diferencia y luego en FACTURAS_TIMBRADOR se cambio timbrado a 0 para ambos casos', 'Modificación en BD', '2024-10-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002631');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002618', 'CAMBIO DE FECHA EN INVESTIGACIÓN DE MERCADO Y REQUISICIÓN', '2024-10-14 10:49:00', 'Buenos días 

Solicito de su apoyo para realizar un cambio de fecha en la investigación de mercado con número 010018/2024 y en la requisición número 132604. 

La fecha correcta que deben tener ambos documentos es 02 de octubre de 2024.

Agradezco de antemano el apoyo 

Saludos!!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-15 16:21:00', 'Se realizo el ajuste en el esquema INVENTARIO.REQUISICIONES e INVENTARIO.INVESTIGACIONMERCADO de acuerdo con la fecha proporcionada por el usuario', 'Modificación en BD', '2024-10-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002618');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002625', 'SUSTITUCION DE ARCHIVO // COMPROBACION DE VIATICOS', '2024-10-14 17:25:00', 'Buenas tardes estimados

Por medio de la presente, solicito su valioso apoyo con la sustitución de archivos para la comprobación de viáticos en el portal SIPPB. 

Es en el rubro #2, descripción: TAXIS (COMPROBANTE CON REQ.FISCAL), ANEXO PDF Y XML',
  (select id from ventanas_mesa where nombre = 'DETALLE DE COMPROBACION DE VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Flores Bretón, Daniel José'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-15 16:00:00', 'Se realizo la investigación para obtener el directorio donde se encuentran los archivos pdf y xml en el servidor de la boveda para ser reemplazados por los proporcionados por el usuario', 'Modificación en BD', '2024-10-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002625');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002607', 'Cambio de fecha requisición', '2024-10-11 12:09:00', 'Buenos días,

Por medio del presente solicito apoyo para realizar un cambio de fecha en la requisición 132609, e investigación de mercado 10022, la cual debe aparecer de la siguiente manera:  3 de octubre de 2024

Quedo a la espera, de antemano gracias

Saludos',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Esparza Cardona, Cesar Enrique'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-16 09:16:00', 'Se realizo el ajuste en el esquema INVENTARIO.REQUISICIONES e INVENTARIO.INVESTIGACIONMERCADO de acuerdo con la fecha proporcionada por el usuario', 'Modificación en BD', '2024-10-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002607');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002638', 'PRECIOS EXTRAS NO PERMITE GUARDARLOS', '2024-10-16 09:54:00', 'BUEN DIANECESITO
 DE SU AYUDA PARA PODER TRAMITAR LOS SIGUIENTES PRECIOS EXTRAORDINARIOS 
DEL CONTRATO ASPN-GI-CO-62601-010-24 CONSTRUCCION DE GALERONES, LOS 
CARGO DE FORMA NORMAL DE HECHO UNO POR UNO Y NO ME PERMITE GUARDAR',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Ramos Cházaro, Efrén'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-16 13:54:00', 'Se determino que el problema se presento ante un flujo de carga de conceptos accidentado que impedia guardar', 'Seguimiento de proceso', '2024-10-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002638');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002493', 'CONVENIO MODIFICATORIO ERROR EN SIIP', '2024-09-26 16:46:00', 'Por
 este medio solicito de su apoyo ya que la solicitud 289 del convenio 
modificatorio los montos son diferentes al contrato por lo cual no me 
permite TRAMITAR el convenio. (Es el mismo caso que el de AUTOSISE que 
se tuvieron que ajustar los montos también se levanto mesa) Para que 
posteriormente en solicitudes de contrato al folio 289 se le agregue la 
columna 2025.
Anexo el cuadro conforme debe quedar los montos:
 
AÑO ESTADOMONTOPORCE. IVAIVATOTAL2022COM $                   299,036.0016.00 $        47,845.76 $              346,881.762023COM $                   897,108.0016.00 $     143,537.28 $          1,040,645.282024COM $                   897,108.0016.00 $     143,537.28 $          1,040,645.282025NUE $                   149,518.0016.00 $        23,922.88 $              173,440.88      
MONTOS TOTALES $               2,242,770.00
 $     358,843.20 $          2,601,613.20',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONVENIOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-02 15:24:00', 'Se realizo el cambio de montos en INVENTARIO.SOLCONTPRESPUESTO y en INVENTARIO.SOLCONVPRESUPUESTO, dejando la misma distribucion para 2025. finalmente se realizo el cambio de estado en INVENTARIO.SOLCONTRATOS a 0 y posteriormente a 2', 'Modificación en BD', '2024-10-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002493');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002634', 'CAMBIO DE TIPO DE ADJUDICACION EN CONTRATO', '2024-10-15 13:52:00', 'Buenas tardes estimados.

Solicito de su amable apoyo para realizar el cambio de la sección Adjudic. a la ORDEN 35560 en el SIIP.
Se adjunta imagen para pronta referencia:',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-16 09:52:00', 'Se realizo el cambio en INVENTARIO.PEDIDOS de acuerdo a la solicitud del usuario', 'Modificación en BD', '2024-10-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002634');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002629', 'Carga de facturas', '2024-10-15 10:44:00', 'Buenos días 

Por medio de la presente solicito su apoyo para la carga de la factura adjunta, lo anterior debido a que el proveedor EDENRED, tiene complementos de pago pendientes, mismos que ya fueron solicitados al proveedor, el folio de la factura es el 82803.

Se adjunta archivos pdf y xml.

De antemano gracias por la atención, saludos cordiales',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-16 10:19:00', 'Se realizo el ajuste en base de datos y se habilito el candado para que pueda subir los archivos', 'Modificación en BD', '2024-10-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002629');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002598', 'ERROR EN MONTOS SOLICITUD DE CONTRATO 271', '2024-10-10 13:17:00', 'Por este medio solicito de su apoyo para la modificación
de los montos de la solicitud de contrato y de la solicitud de convenio 271 ya
que se encuentran incorrectos.

Lo dejo en status abierto el Modificatorio para que se
puedan hacer los cambios necesarios.

También para que una vez ajustados los montos se pueda
agregar la columna de 2025 a la solicitud de contrato: 271.

Se 
anexan capturas de pantalla tanto de la
solicitud de convenio como del contrato, el desglose de pagos por año 
como debe
ser y envió por correo el contrato I-239-2021-G.A.F. así como su 
Modificatorio al correo que me indiquen para corroborar los montos 
originales de
2021.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONVENIOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-11 10:26:00', 'Se realizo el cambio de montos en INVENTARIO.SOLCONTPRESPUESTO y en INVENTARIO.SOLCONVPRESUPUESTO, dejando la misma distribucion para 2025. finalmente se realizo el cambio de estado en INVENTARIO.SOLCONTRATOS a 0 y posteriormente a 2', 'Modificación en BD', '2024-10-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002598');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002599', 'Solicitud de habilitación en SIIPV2', '2024-10-10 15:28:00', 'Buenas tardes, por medio del presente solicito apoyo para la habilitación del módulo de "compras para requisiciones".

De antemano gracias, quedo a la espera de sus comentarios

Saludos',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Esparza Cardona, Cesar Enrique'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-16 09:17:00', 'Se realizo la asignación en privilegiso de acceso en el sistema SIIP de acuerdo con los datos del usuario solicitante', 'Modificación en BD', '2024-10-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002599');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002648', 'ERROR EN TIMBRADO', '2024-10-17 11:15:00', 'Hola buenos dias estimados compañeros. 

Al timbrar la factura con folio 

928440   se presenta un error de timbrado.

Agradecemos
 su amable apoyo para revisar el problema de timbrado ya que se dio el 
alta el cliente en modulo de facturacion de acuerdo a la constancia de 
situación fiscal adjunta.',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-17 16:15:00', 'Se cambio en FACTURAS.CLIENTES el nombre para eliminar un salto de linea, posteriormente se cambio en FACTURAS.FACTURAS_TIMBRADOR el campo timbrado de 2 a 0', 'Modificación en BD', '2024-10-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002648');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002615', 'MODIFICACION EN REQUISICION TABLERO PRESUPUESTAL', '2024-10-14 09:57:00', 'Buen día estimados.
Derivado a la actualización de datos en la requisición 132526 se solicita RETIRAR LA AUTORIZACIÓN PRESUPUESTAL de
 dicha requisición con el fin de poder ser visualizada nuevamente por 
parte de la Jefatura de Presupuesto y Contabilidad para su validación.

De ante mano muchas gracias.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Tablero Presupuestal'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-15 09:57:00', 'En INVENTARIO.REQUISICIONES se cambio el campo APRUEBA_CONTA devuelta a 0', 'Modificación en BD', '2024-10-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002615');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002639', 'APOYO PARA AGREGAR MONTO A CONVENIO MODIFICATORIO || SOL 341', '2024-10-16 10:40:00', 'Buenos días, 

Por
 medio del presente solicito su apoyo para que en el apartado CONVENIO 
ACTUAL de la solicitud de convenio 341, se le asigne la siguiente 
cantidad $309,813.00, lo anterior para dar continuidad al tramite
 de pago de meses subsecuentes, debido a que no es posible la signar la 
cantidad porque rebasa en 20% que permite el sistema, sin embargo, no 
aplica dicho porcentaje para esta ampliación.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONVENIOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-18 11:35:00', 'En INVENTARIO.SOLCONTCONVENIOS se modifico el campo MONTONUEVO', 'Modificación en BD', '2024-10-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002639');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002384', 'problemas para cargar convenio', '2024-09-11 13:39:00', 'Buen dia 
solicito
 apoyo para cargar el siguiente convenio en sistema, ya que en 
"Porcentaje acumulado", se genera un error y no se puede guardar. 
Adjunto imagen de sistema',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Somarriba Uscanga, Isis Grecia de los Angeles'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-18 12:30:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-10-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002384');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002647', 'CONVENIO EN TIEMPO Y MONTO', '2024-10-17 11:03:00', 'BUEN DIA 
CARGO
 CONVENIO Y LOS MONTOS DE CONTRATO Y MONTOS ANUALES SI COINCIDEN SIN 
EMBARGO ME APARECE TEXTO QUE NO SON IGUALES, POR LO QUE NO ME PERMITE 
TRAMITARLO., ADJUNTO CAPTURA  DEPANTALLA DEL CONVENIO A TRAMITAR
SALUDOS CORDIALES',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Ramos Cházaro, Efrén'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-18 12:55:00', 'Se ajusto el volumen del concepto 7 OBRAS.SOLCPTOSCONTRATADOS', 'Modificación en BD', '2024-10-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002647');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002491', 'CAMBIO DE TIPO DE ESTIMACION', '2024-09-26 15:46:00', 'Buenos
 días, se solicita referente al contrato ASPN-GI-CO-62601-027-23 AC de 
la estimacion 1N el  cambio de tipo de estimacion NORMAL a AJUSTE DE 
COSTOS para el correcto proceso administrativo.',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Simonín Baldwin, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-18 12:56:00', 'Se realizo el cambio de los conceptos en OBRAS.CPTOSCONTRATADOS de Normal a aJuste despues de solicitar la eliminacion de la estimacion del tipo erroneo', 'Modificación en BD', '2024-10-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002491');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002593', 'SOLUCIONAR PROBLEMA DE INSERTAR FACTURA DE CONCECION', '2024-10-10 10:15:00', 'Buenos dias estimados a quien corresponda.
Por favor, solicito su amable apoyo, para poder INSERTAR, la facturacion de contraprestacion variable 5% del cliente: 

HIDROCARBUROS Y MATERIAS PRIMAS INDUSTRIALES, S. A. DE C. V.  No. Cliente: 114311 
Una vez llenado los datos en el sistema SIIP facturacion, a la hora de insertar no lo permite e indica el siguiente anuncio de: (EL REGISTRO YA EXISTE), cabe
 mencionar que el registro NO EXISTE AUN, porque no permite insertar. Y 
es la primera vez que se usa el numero de CONCECION: 699
Quedamos atentos a la solucion del problema que se presenta para poder INSERTAR LA FACTURACION.Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FACTURACION DE CONCESIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Concesiones'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-22 11:37:00', 'Problema derivado de la longitud del nombre de la empresa que superaba el limite en el campo de MOVDESCRIPCION en FACTURACION.MOVIMIENTOS', 'Modificación en BD', '2024-10-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002593');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002697', 'Falla en captura de estimación', '2024-10-23 10:37:00', 'Buena tarde, solicito de su ayuda para un error en la captura de estimaciones. En la siguiente imagen le muestro como quedaron guardados los datos. ASPN-GI-CO-60602-018-24

Pero al momento de que cambia de estado a supervisado se borran algunos datos y por consiguiente cambian los montos.

Por lo anterior requiero de su apoyo para imprimir la carátula del sistema con los datos correctos.',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Simonín Baldwin, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-23 15:37:00', 'Se ajusto manualmente el importe_programado en OBRAS.ESTIMACIONES con el correspondiente', 'Modificación en BD', '2024-10-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002697');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002626', 'SOLICITUD DE MESA DE APOYO POR PROBLEMAS EN PLATAFORMA PARA GUARDAR ESTIMACION', '2024-10-14 18:03:00', 'BUENAS  TARDES. 

ENVIO SOLICITUD DE CONTRATISTA; ME
 COMUNICO DE LA EMPRESA CONSTRUCTORA VERACRUZANA DE PUENTES S.A. DE 
C.V., TENEMOS UNA OBRA DENTRO DE ASIPONA Y TENEMOS PROBLEMAS AL CARGAR 
UNA ESTIMACIÓN. CAPTURO
 TODA LA INFORMACIÓN, DOY GUARDAR; PERO AL VOLVER A ABRIRLA NO APARECEN 
LAS CANTIDADES EN “RETENCIONES Y SANCIONES”, LO INTENTE VARIAS VECES 
PERO EL RESULTADO ES EL MISMO. SI ME DA EL TOTAL DE LA ESTIMACION, PERO 
ESA PARTE ESTA EN BLANCO. DE HECHO, ELIMINE LA ESTIMACIÓN Y VOLVI A 
CAPTURARLA TODA, PERO SEGUIMOS TENIENDO EL MISMO PROBLEMA. ADJUNTO DATOS DEL CONTRATO Y LA EVIDENCIA CONTRATO
 No. ASPN-GI-CO-62602-002-24, "MANTENIMIENTO DE SUPERFICIE DE RODAMIENTO
 DE LA EXPLANADA 14 DE LA BAHÍA SUR, DENTRO DEL PUERTO DE VERACRUZ". SI PUEDEN APOYARNOS PARA DAR SOLUCIÓN A ESTE INCONVENIENTE, POR FAVOR SI REQUIEREN ALGUNA OTRA INFORMACION O EVIDENCIA, ESTAMOS A LA ORDEN. MUCHAS GRACIAS',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Simonín Baldwin, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-15 13:00:00', 'Se ajusto manualmente el importe_programado en OBRAS.ESTIMACIONES con el correspondiente', 'Modificación en BD', '2024-10-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002626');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002706', 'REGISTRO DE OFICINA PARA SOLICITUD DE VIÁTICOS', '2024-10-23 14:16:00', 'Buenas
 tardes, Por medio del presente, solicito su apoyo para agregar una 
Oficina para la solicitud de viáticos del Lic. Felipe Quijano Montoya y 
la Lic. Yamile Reyes Sánchez. Lo anterior debido a que se intento 
agregar con las opciones que proporciona la plataforma pero no logra 
registrarse ya que al seleccionar el "Estado" de la solicitud aparece un
 recuadro que dice que "es necesario agregar oficinas para la 
solicitud".

Sin más por el momento y en espera de su amable apoyo, aprovecho la ocasión para enviarle un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-24 10:00:00', 'Se agrego el nuevo registro en DGPORT.TIPO_OFICINA', 'Modificación en BD', '2024-10-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002706');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002668', 'CAMBIO DE FECHA PEDIDO 35568', '2024-10-18 18:38:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido de servicios numero: 35568 del proveedor: SECRETARIA DE GOBERNACIÓN.
DEBE DECIR: 03/10/2024.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-24 13:12:00', 'Ajuste de fecha en INVENTARIO.PEDIDOS con los datos proporcionados por el usuario', 'Modificación en BD', '2024-10-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002668');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2024-002718', 'Salida de almacen', '2024-10-23 19:00:00', 'Buenas tardes

Por
 medio de la presente solicito su apoyo para realizar la salida de 
almacén 36692, ya que al momento de seleccionar el articulo MAGNETTRON 
PARA RADAR DECCA-LITTON 25KW, BRIDGE MARTER BANDA X, el sistema no 
permite realizar la acción correspondiente, en la entrada quedaron 
pendiente de surtir el articulo mencionado y la TARJETA DISPLAY 
COMPATIBILY UNIT PCB ASSY.
PEDIDO: 35057

ENTRADA: 38819

Ojala nos puedan apoyar con este tema, saludos cordiales',
  (select id from ventanas_mesa where nombre = 'DETALLE MOVIMIENTO ALMACEN'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Movimientos de Almacen'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-24 17:00:00', 'En INVENTARIO se modificaron las tablas de DETEMBARQUE (localizando el embarque por medio del pedido) cambiando el campo CANTIDADREC,  en DISTEMBARQUES se agregaron los registros faltantes y en DISTRPEDIDOS se cambiaron las cantidades', 'Modificación en BD', '2024-10-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2024-002718');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002705', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 132614 E INVESTIGACIÓN DE MERCADO 10026.', '2024-10-23 13:41:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 132614.

 

Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):

 


FECHA QUE REQUIERE: 23/10/2024 

DEBE DECIR: 03/10/2024  

Así mismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10026, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.




La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
 


FECHA ACT: 22/10/2024 

DEBE DECIR: 02/10/2024

 

FECHA COTIZACIÓN: 14/10/2024 

DEBE DECIR: 01/10/2024',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-24 13:02:00', 'Se ajsutaron las fechas en INVENTARIO en las tablas REQUISICIONES, INVESTIGACIONDEMERCADO Y PROVEINVESTIGACIONDEMERCADO con las fechas proporcionadas por el usuario', 'Modificación en BD', '2024-10-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002705');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002532', 'modificar la justificacion y uso en requi', '2024-10-02 15:34:00', 'Agradezco su amable apoyo para realizar un cambio en la descripción de una requisición, agradeciendo que no se modifique el status ni fechas de la misma.


De la Requisición 132524 en la descripción del apartado Justificación y Uso cambiar el año 2023 a 2024  :)',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-24 09:44:00', 'Se realizo el ajuste de la descripcion en INVENTARIO en la tabla DETREQUIS con el texto solicitado por el usuario', 'Modificación en BD', '2024-10-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002532');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002693', 'VALIDACION COMPLEMENTO DE PAGO DHL', '2024-10-23 09:42:00', 'Por medio de la presente solicito su apoyo para subir en papel el complemento de pago de DHL de la primera quincena del mes de octubre. Adjunto los documentos PDF y XML para su correcta validación.

Adjunto las facturas para su oportuna revisión.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Gallardo Lopez, Luis Fernando'),
  '2024-10-28 12:58:00', 'Se activo el candado para realizar la carga de archivos al sistema', 'Modificación en BD', '2024-10-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002693');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002753', 'MODIFICACION DEL IMPORTE ORIGINAL DE CONTRATO', '2024-10-28 13:48:00', 'BUENAS
 TARDES, AL CARGAR NUEVO CONVENIO MODIFICATORIO EN TIEMPO Y MONTO DEL 
CONTRATO ASPN-GI-CS-62601-013-23  SE OBSERVA QUE EL IMPORTE ORIGINAL DEL
 CONTRATO TIENE VALOR DE $1.00 POR LO QUE SE SOLICITA EL APOYO PARA EL 
CORRECTO IMPORTE.
 

SE ADJUNTA ASI MISMO LA CARATULA DEL CONTRATO CON LOS DATOS CORRECTOS.',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Simonín Baldwin, Ana Laura'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-29 10:00:00', 'En OBRAS.CNTOVIGENTES y OBRAS.SOLCNTOVIGENTES se cambio el campo de importetotalnuevo de 1 al monto del contrato correcto', 'Modificación en BD', '2024-10-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002753');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002777', 'solicitud de modificación de dos conceptos de normal a convenio', '2024-10-29 15:26:00', 'Buenas tardes estimados,

Por
 este medio me permito solicitar su apoyo para mover dos conceptos y 
pasarlos en estimación convenio a estimación 11 normal finiquito del 
contrato CO-35101-006-23,ya que solo se reflejan al cambiarlo como 
convenio.

correspondientes: ZG-19 Y M2-02.',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Hernández Galván, Pamela Estefanía'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-30 13:33:00', 'En OBRAS.CPTOSCONTRATADOS se cambio el tipo de concepto de C a N despues de verificar que no hubieran sido utilizados en otras estimaciones', 'Modificación en BD', '2024-10-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002777');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002790', 'autorización para firmas en estimación', '2024-10-30 15:19:00', 'no
 se puede dar de alta en el sistema para estimaciones al ingeniero Jose 
luis bravo rosas ya que no aparece en personas autorizadas para firma de
 contrato',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras'),
  (select id from solicitantes_mesa where nombre = 'Deceano Ocampo, Isidro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-10-31 13:19:00', 'En SERVICIO.CONTACTOS01 se actualizo el nombre del usuario sgconstruccion asi como en SERVICIO.USUARIOS32 el trabnum, en OBRAS.USUARIOS se actualizo el nombre y el trabnum', 'Modificación en BD', '2024-10-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002790');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-002794', 'ELIMINAR REQUISITOS SERVICIO MANIOBRAS - SIRE', '2024-10-31 11:55:00', 'Buenas tardes

Solicito
 su apoyo para eliminar los requisitos en el SIRE para la actual 
solicitud (TRAMITADORA DEL PACÍFICO) y futuras solicitudes del servicio 
portuario de maniobras que se enlistan a continuación:

PROTECCIÓN CIVIL
SEGURIDAD E HIGIENE
ACREDITACIONES ACTUALIZADAS

Muchas gracias',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-11-01 10:55:00', 'Se realizo la eliminacion de registros en EDIV2.CONTRATOS_SERVICIO_REQUISITOS', 'Modificación en BD', '2024-10-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-002794');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003267', 'AGREGAR UN SEGUNDO ANTICIPO AL EJERCICIO 2024 - ASPN-CO-62601-026-23', '2024-12-26 12:54:00', 'Buenas tardes estimados.

Solicitando de su apoyo para agregar un anticipo mas al ejercicio 2024 del convenio ASPN-CO-62601-026-23 celebrado con CFE.

LOS MONTOS PARA CADA EJERCICIO QUEDARIAN DE LA SIGUIENTE MANERA:

2023 - $350,000,000.00
2024 - $250,000,000.00
2024 - $88,200,000.00 (SE REQUIERE GENERAR UN SEGUNDO PAGO EN EL EJERCICIO 2024)
2025 - $75,484,138.17',
  (select id from ventanas_mesa where nombre = 'ANTICIPOS DEL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Arcos, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-12-27 12:58:00', 'Se realizo el proceso manual de insercion de una factura de anticipo, desde la estimacion en OBRAS, la factura en FACTURASOBRAS y en DETFACTURASOBRAS. Tambien se creo el folio en FOLIO_FACTURA y posteriormente se solicito el ajuste del monto comprometido para agregar monto de 2025 a 2024', 'Modificación en BD', '2024-12-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003267');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003225', 'REPORTE DE INGRESOS POR CONCEOTO DE PUERTO FIJO, PUERTO VARIABLE Y ATRAQUE', '2024-12-19 10:15:00', 'Buen día
El presente es para solicitar su apoyo con los siguientes reportes:

1.    Ingresos por puerto fijo generados por los buques arribaron a la terminal de ICAVE de 2019 a        
       2023 (por año) y lo que va de 2024.

2.    Ingresos por puerto variable generados por los buques que arribaron a la terminal de ICAVE de    
       2019 a 2023 (por año).

3.    Ingresos por atraque generados por los buques que arribaron a la terminal de ICAVE de 2019 a 
       2023 (por año) y lo que va de 2024

4.    Ingresos por cuota diaria, en caso de aplicar, generados por las embarcaciones que arribaron a la 
       terminal de ICAVE de 2019 a 2023 (por año) y lo que va de 2024.',
  (select id from ventanas_mesa where nombre = 'REPORTES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Reportes'),
  (select id from solicitantes_mesa where nombre = 'Serrano Berriozabal, Jose Luis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-12-27 15:27:00', 'Reporte generado via query', 'Seguimiento de proceso', '2024-12-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003225');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003285', 'MODIFICACIÓN EN RECIBIO EN INFORME DE ENTRTADA', '2024-12-30 09:23:00', 'Buen día, 

Por medio del presente solicito de su apoyo para realizar la modificación en el Informe de entrada No. 36834/2024  de la solicitud de pago 378, debido a que en el siip aparece correctamente en recibio el nombre de la Lic.  Maria del Carmen Quiroz Ramirez, pero al momento de imprimir el documento aparece VICEALM.RET. AUGUSTO CRUZ MORALES.',
  (select id from ventanas_mesa where nombre = 'DETALLE DE PAGOS DEL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Recepción de Materiales (embarque)'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-12-30 14:23:00', 'En INVENTARIO.MOVALMS se cambio el campo de TRABNUM_RECIBIO de 40226 a 69452', 'Modificación en BD', '2024-12-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003285');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003289', 'MODIFICATORIO FALTA COLUMNA 2025 Y NO ME PERMITE GRABAR POR ERROR EN FECHA FIN CONVENIO', '2024-12-30 11:54:00', 'Por este medio solicito de su apoyo ya que en la solicitud de convenio: 345 al capturar los datos me indica el mensaje: El incremento de fechas no puede ser mayor la 20% sobre el periodo original.

Para que me permita capturar y la otra seria una vez que capture y ponga el monto de 2025 se agregue la columna a solicitud de contrato 345 de 2025.


Todo se encuentra en estado abierto para que se pueda trabajar.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONVENIO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-12-30 16:54:00', 'En INVENTARIO.SOLCONTCONVENIOS se modifico el campo FECHAFINNUEVA, tambien en la tabla SOLCONVPRESUPUESTO se modifico el campo distribucion por el max+1', 'Modificación en BD', '2024-12-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003289');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2024-003286', 'No permite crear solicitud para modificación de contrato', '2024-12-30 10:49:00', 'Buenos días.

Solicito de su valioso apoyo, ya que en el sistema integral al intentar crear una solicitud para la modificación de un contrato, dentro del menú de Ingeniería, no se me permite mostrando un mensaje de "Error en la creación de solicitud"

Quedo al pendiente de sus comentarios.

Saludos',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Monsivais Castillo, Roman Alexander'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-12-31 10:49:00', 'En OBRAS.CNTOVIGENTES se cambio el campo PORCENTAJEANTICIPO a 99.99', 'Modificación en BD', '2024-12-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2024-003286');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003280', 'SOLICITUD PARA ACTIVAR BOTON CANCELAR EN REQUISICIONES', '2024-12-27 09:53:00', 'Buen día estimados compañeros,

Por este medio tengo a bien solicitar su amable apoyo para activar a mi usuario AUXSEGURIDAD12 el botón de CANCELAR en SIIPV-REQUISICIONES, esto con el fin de poder cancelar como área requirente algunas requisiciones que ya no se les dio seguimiento.
Adjunto una captura para mayor referencia.

Quedo atenta a sus comentarios.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-12-31 12:57:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2024-12-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003280');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003294', 'MOFICATORIO FALTA COLUMNA 2025', '2024-12-30 14:13:00', 'Por este medio solicito de su apoyo para la columna del 2025 de la solicitudes de contrato de los siguientes convenios modificatorios:
-300
-299
-298

Quedo atenta a sus indicaciones ya se encuentran en estado abierto.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONVENIO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2024-12-31 10:13:00', 'En INVENTARIO.SOLCONVPRESUPUESTO se modifico el campo DISTRIBUCION al max+1 para los 3 casos', 'Modificación en BD', '2024-12-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003294');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003297', 'SOLICITUD PARA MODIFICAR FECHA DE REQUISICIÓN || 132674', '2024-12-30 16:14:00', 'Buen día, 

Por medio del presente solicito su apoyo para realizar la modificación en la fecha de elaboración de la requisición No, 132674 

Debe decir: 03/10/2024

Quedo atenta a sus comentarios. 

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-31 12:55:00', 'Se realizó el cambio en INVENTARIO.REQUISICIONES', 'Modificación en BD', '2024-12-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003297');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003299', 'SUSTITUCION DE CFDI EN MEDIPORT', '2024-12-30 18:23:00', 'Buenas tardes estimados.
Solcito su apoyo para retirar de la bóveda de Mediport el CFDI cargado al folio 83544 para realizar la sustitución de este por cancelación del actualmente cargado.

De ante mano muchas gracias.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cuentas por Pagar'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurión, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-31 17:31:00', 'Se eliminó de la bóveda, de CFDCONNECT.CFD_RECEPCION, CFD_CUSTOM_DATA y se cambió a 0 el ESTADO en INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2024-12-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003299');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003300', 'MODIFICACIÓN EN PEDIDO DE SERVICIOS 35748', '2024-12-30 18:26:00', 'Buenas tardes, 

Por medio del presente solicito su apoyo para realizar la modificación en la fecha de elaboración del pedido de servicios 35748.

Debe decir: 03/10/2024

Agradeciendo de antemano su colaboración, le envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2025-01-02 09:46:00', 'Se realizó el cambio en INVENTARIO.PEDIDOS', 'Modificación en BD', '2024-12-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003300');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003279', 'Eliminar comprobantes', '2024-12-27 09:48:00', 'buenos días por medio del presente me permito pedir su apoyo para eliminar el comprobante 

adjunto imágenes',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas/Sustitucion CFDI'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-31 15:34:00', 'Se eliminó de la bóveda y de CFDCONNECT.CFD_RECEPCION.', 'Modificación en BD', '2024-12-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003279');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003258', 'SOLICITUD PARA ABRIR EL CANDADO "COMPLEMENTOS DE PAGO PENDIENTES DE RECIBIR" APLICABLE A PROVEEDORES.', '2024-12-26 08:39:00', 'Estimados Ingenieros

Buen día.



Por medio del presente, solicito apoyo para autorizar la apertura del candado "complementos de pago pendientes de recibir" aplicable a los proveedores, cabe precisar que ya se encuentra de conocimiento el C.P.A. Rogelio Lagos Ambrosio, Jefe de Departamento de Presupuesto y Contabilidad, a quien marco copia para la autorización correspondiente.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-26 17:48:00', 'Se cambió temporalmente a 5 el ESTADO en INVENTARIO.FOLIO_COMPLEMENTOS.', 'Modificación en BD', '2025-01-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003258');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003295', 'Retirar candado en complemento de pago', '2024-12-30 15:14:00', 'Buena tarde 

Solicito retirar el candado en los complementos de pago del proveedor ISA CORPORATIVO con RFC  ICO960722VD7..

Quedo atento
Saludos',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTO DE PAGO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Ruiz, Francisco'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-31 11:28:00', 'Se cambió temporalmente a 5 el ESTADO en INVENTARIO.FOLIO_COMPLEMENTOS.', 'Modificación en BD', '2025-01-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003295');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003284', 'VALIDACION EN MEDIPORT', '2024-12-27 14:47:00', 'Buenas tardes
Por medio del presente les pido su apoyo para hacer la validación del folio de factura 83541 que se presenta a continuación como FACTURA EN PAPEL',
  (select id from ventanas_mesa where nombre = 'PORTAL CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-31 13:37:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2025-01-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003284');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003290', 'SUBIR FACTURA EN PAPEL', '2024-12-30 12:00:00', 'Buenos Días 
Por medio del presente pido su ayuda para poder cargar en papel (PDF) la comprobación de la factura en sistema con folio 83541
adjunto captura',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-31 09:00:00', 'Seguimiento de proceso', 'Seguimiento de proceso', '2025-01-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003290');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003288', 'ACTUALIZAR REQUISITOS - SIRE', '2024-12-30 11:46:00', 'Buen día, 

Solicito su apoyo para agregar los requisitos que se enlistan a continuación, a la solicitud en SIRE de la empresa BYB TRANSPORTES DE CARGA EN GENERAL SA DE CV, ya que no se visualizan:

    SOLICITUD DE SERVICIO
    CV EMPRESARIAL
    DOS CARTAS DE RECOMENDACION
    FOTOGRAFIA REPRESENTANTE LEGAL
    ANEXO 4 CARTA CONTRATACION DE SEGUROS

Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-30 16:46:00', 'Se crearon registros en EDIV2.CONTRATOS_SOLICITUD_DETALLE y CONTRATOS_SOLICITUD_FLUJO.', 'Modificación en BD', '2025-01-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003288');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2024-003195', 'ACTUALIZAR REQUISITOS EN SIRE', '2024-12-16 11:52:00', 'Buen día 

Solicito su apoyo para dar de alta el requisito PODER APODERADO LEGAL en la solicitud de la empresa GRUPO DE INTERCAMBIO LOGÍSTICO SA DE CV que se encuentra en el SIRE, ya que no se visualiza dicho requisito en el listado.

Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2024-12-20 11:13:00', 'Se crearon registros en EDIV2.CONTRATOS_SOLICITUD_DETALLE y CONTRATOS_SOLICITUD_FLUJO.', 'Modificación en BD', '2025-01-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2024-003195');

