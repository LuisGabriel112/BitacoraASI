-- Import de mesas historicas 2026 desde bitacoras mensuales. Requiere 0016 aplicada antes.
-- Idempotente: omite codigos que ya existan en mesas.

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000006', 'DESBLOQUEO DE SIIP -FACTURACION- VENTANA DE COBROS', '2026-01-02 12:21:00', 'Buenas tardes estimados a quien corresponda.
Agradecería su amable apoyo, desbloqueando la ventana de cobros, ya que envía mensajes de error, como a continuación se muestra:',
  (select id from ventanas_mesa where nombre = 'COBROS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Cobros'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-05 09:21:00', 'Seguimiento de proceso, se eliminaron las sesiones duplicadas', 'Seguimiento de proceso', '2026-01-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000006');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000010', 'PONER CONSECUTIVO DE FACTURA EN REPORTE DE FACTURAS', '2026-01-05 09:25:00', 'Buenos dias estimados a quien corresponda.

Agradeceria su amable apoyo, en agregar el numero de FACTURA;

En el espacio marcado en amarillo 979881.',
  (select id from ventanas_mesa where nombre = 'REPORTE FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Reportes'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-05 16:25:00', 'Se agrego en FACTURACION.VTFACTURAS en el campo FOLIO = ''979881''', 'Modificación en BD', '2026-01-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000010');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000020', 'AGREGAR REQUISITOS A SOLICITUD EN SIRE', '2026-01-05 15:19:00', 'BUEN DÍA, 


SE SOLICITA SU APOYO PARA AGREGAR LOS REQUISITOS A LA SOLICITUD DE LA EMPRESA MARITIME PROCUREMENT SERVICES EN EL SIRE,  YA QUE NO SE VISUALIZAN

    Acta constitutiva
    Poder apoderado legal
    Estados financieros
    Acta de nacimiento

MUCHAS GRACIAS',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-06 13:19:00', 'Se agregaron los requisitos en EDIV2.CONTRATOS_SOLICITUD_DETALLE y CONTRATOS_SOLICITUD_FLUJO.', 'Modificación en BD', '2026-01-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000020');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000032', 'DUPLICIDAD DE IVA POR PAGAR EN POLIZA DE INGRESO 31/12/2025', '2026-01-07 11:41:00', 'Buenos dias estimados,
se solicita su apoyo con la poliza de ingresos por facturacion del dia 31/12/2025,
ya que se considera un monto por $186,556.26 y el monto correcto es $128,371.66.
Dicho IVA, pertenece a las cuentas por cobrar pagadas y se identificó que el iva esta siendo duplicado en dos facturas /978974/978975 de la KANSAS CITY SOUTHERN DE MÉXICO. 
Para dichas facturas se utilizaron 2 tarifas de cobro.
Quedo atento a sus comentarios y/o dudas al respecto.',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Illescas Guevara, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-07 16:58:00', 'En FACTURACION.MOVIMIENTOS se modifico el monto', 'Modificación en BD', '2026-01-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000032');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000033', 'SIN INGRESO AL SIIPV2', '2026-01-07 12:30:00', 'Buen día, me podrían apoyarme de favor,  con mi usuario para el SIIPV2, quise ingresar y no me permite acceso.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Villalba Rojas, Briseiri Aylin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-08 10:30:00', 'Se desactivó el usuario duplicado en CONTROL.USUARIOS y se pidió al usuario reiniciar su máquina para hacer efectivo el LDAP.', 'Seguimiento de proceso', '2026-01-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000033');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000038', 'REVISION CORREO', '2026-01-07 16:20:00', 'Buenas tardes,
Note que no me estan llegando los correos de notificacion para las incidencias de asistencias, no me llego diciembre y ahora enero.
No sé, si sea lo mismo pero en diciembre si me llego la notificacion para el tema de seleccionar menú.
Correo: cproteccion@puertodeveracruz.com.mx
Saludos',
  (select id from ventanas_mesa where nombre = 'CORREO'),
  (select id from categorias_mesa where nombre = '/Servicios/Correo Electrónico'),
  (select id from solicitantes_mesa where nombre = 'Gómez Hernández, Carlos Ignacio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-08 15:20:00', 'Seguimiento de proceso, se verifico el envio de correos', 'Seguimiento de proceso', '2026-01-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000038');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000043', 'DESBLOQUEO DE SIIP -FACTURACION- VENTANA DE COBROS', '2026-01-07 17:41:00', 'Buenas tardes estimados a quien corresponda.
Agradecería su amable apoyo, desbloqueando la ventana de cobros, ya que envía mensajes de error, como a continuación se muestra:
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COBROS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Cobros'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-08 15:41:00', 'Seguimiento de proceso, se eliminaron las sesiones duplicadas', 'Seguimiento de proceso', '2026-01-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000043');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000039', 'Corrección de pólizas', '2026-01-07 16:43:00', 'Buena tarde, solicito su apoyo para mover la información de la póliza de Cheques 550 del periodo 12 del 2025 al periodo 1 del 2026 asignándole el folio en pólizas de Cheques consecutivo que se encuentre disponible al momento de la corrección, adjunto datos e información de la póliza antes mencionada:',
  (select id from ventanas_mesa where nombre = 'POLIZAS VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-08 13:43:00', 'En CONTA.POLIZAS se agrego la poliza 5 - 01 - ''C'' - 2026 y se elimino la poliza 550 - 12 - ''C'' - 2025 junto a sus respectivos registros en CONTA.MOVIMIENTOS y CONTA.ESTPROGPPEGRESODOCTO', 'Modificación en BD', '2026-01-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000039');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000046', 'AGREGAR NUMERO CONSECUTIVO EN EL REPORTE DE COMPLEMENTOS DIA: 26/12/2025', '2026-01-08 09:40:00', 'Buenos dias estimados a quien corresponda.
Agradeceria su amable apoyo, en el reporte de COMPLEMENTOS DE PAGO, del dia: 26/12/2025, no aparece el Numero consecutivo, debe ir en el cuadro naranja el numero;',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Reportes'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-08 17:40:00', 'Se agrego en el campo FOLIO_COMP_TIMBRADO en la tabla FACTURACION.COMPLEMENTOS_PAGO', 'Modificación en BD', '2026-01-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000046');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000051', 'ELIMINACION DE POLIZA', '2026-01-08 10:43:00', 'Buen día, solicito su apoyo con la eliminación de la póliza 181 de Cheques del periodo de Ene del 2025, al igual que la eliminación de la póliza 519 de cheques del periodo de Dic del 2025.',
  (select id from ventanas_mesa where nombre = 'POLIZAS VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-08 17:33:00', 'En CONTA.POLIZAS se eliminaron las polizas indicadas, asi como sus registros asociados en CONTA.MOVIMIENTOS y en CONTA.ESTPROGPPEGRESODOCTO', 'Modificación en BD', '2026-01-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000051');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000053', 'Carga de complementos de pago', '2026-01-08 12:30:00', 'Buenas tardes, 
Por medio del presente solicito su apoyo para la carga del complemento de pago con número de folio 12487 del proveedor CFE (No. 45), ya que me aparece el siguiente error:



Adjunto los archivos para su revisión y aprobación.
Gracias de antemano,',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-09 10:34:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-01-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000053');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000057', 'ALTA MODULO SIIP', '2026-01-08 17:07:00', 'Buenas tardes,
Me pueden ayudar con la visualización del modulo Solicitud de salidas, por favor.
Módulo Compras ->Inventarios ->  solicitud de salidas.
Saludos',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Gómez Hernández, Carlos Ignacio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-13 09:55:00', 'Se asignaron privilegios de Inventario > Solicitud de Salidas.', 'Modificación en BD', '2026-01-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000057');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000064', 'SOLICITUD CAMBIO DE ESTADO', '2026-01-09 10:25:00', 'Buen día, solicito su apoyo para cambiar esta entrada a estado abierto.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Recepción de Materiales (embarque)'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-12 08:25:00', 'Se modificó el ESTADO de 2 (Parcialmente facturado) a 1 (Abierto) en INVENTARIO.EMBARQUES. El usuario eliminó la factura pero el sistema no revirtió correctamente el estado de la Recepcion de materiales, se pasó a Abierto para que el usuario pudiera eliminar por completo la Recepción de Materiales (Elimina EMBARQUES, DETEMBARS, MOVALMS, modifica PEDIDO).', 'Modificación en BD', '2026-01-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000064');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000075', 'SOLICITUD DE IMPRESION DE PEDIDO Y CONTRATO', '2026-01-12 09:40:00', 'Buenos días,
Por medio del presente, solicito su apoyo para la impresión de los siguientes pedido y contrato de adquisiciones:
    36996
    36744
Esta solicitud se debe a que se están realizando modificaciones en los formatos para actualizarlos conforme a los cambios recientes en la LAASSP y su reglamento.
Agradezco de antemano su atención y apoyo.
Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-13 09:40:00', 'Se colocó temporalmente el ESTADO 1 (Tramitado) en los pedidos para que el usuario pudiera imprimirlos.', 'Seguimiento de proceso', '2026-01-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000075');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000055', 'Sin acceso a requisiciones en el SIIPV2', '2026-01-08 16:07:00', 'Buen dia, No cuento con acceso o permiso a requisiciones en el SIIPV2.
Podria apoyarme por favor.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Acceso al modulo de Compras'),
  (select id from solicitantes_mesa where nombre = 'Villalba Rojas, Briseiri Aylin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-13 10:16:00', 'Se dio de alta al usuario en el módulo de Compras y se dieron privilegios para ventana de Requisiciones.', 'Modificación en BD', '2026-01-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000055');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000071', 'CAMBIO ESTATUS PRESUPUESTO', '2026-01-09 16:20:00', 'Buena tarde, por medio del presente solicito su apoyo para cambiar el estatus presupuestal a abierto.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-13 10:42:00', 'En INVENTARIO.REQUISICIONES se modifico el campo APRUEBA_CONTA de 1 a 0', 'Modificación en BD', '2026-01-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000071');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000023', 'MODIFICAR INVESTIGACION DE MERCADO', '2026-01-05 18:19:00', 'BUENAS TARDES 

SOLICITO QUE DEL RESULTADO DE LA INVESTIGACION DE  MERCADO 10615/2026 EN EL RESULTADO DE LA INVESTIGACION DE MERCADO, SE LE QUITE "Y EL ARTICULO 48 DEL REGLAMENTO"

ASI MISMO EN LA INVESTIGACION DE MERCADO 10616/2025

AGRADEZCO SU AMABLE APOYO',
  (select id from ventanas_mesa where nombre = 'INVESTIGACION MERCADO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-12 11:03:00', 'Se modificó la columna CONCLUSIONES en INVENTARIO.INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-01-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000023');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000079', 'AGREGAR FILA DE EJERCICIO 2026 A SOLICITUDES DE CONTRATO || DERIVADO DE CONVENIO MODIFICATORIOS', '2026-01-12 11:00:00', 'Buenos días, 
Por medio del presente solicito su colaboración, para agregar en el módulo de licitaciones una fila que indique el año 2026 en el apartado "datos del contrato" y "estado de solicitud de contrato" de las solicitudes de contrato 349 y 408, lo anterior, debido a que dichos contratos tienen convenios modificatorios, cuyo nuevo termino de vigencia son el (30/04/2026 y 31/01/2026 respectivamente), tal como se señaló en los convenios modificatorios registrados con el mismo número de solicitud y donde si se visualiza la fila del ejercicio 2026.
Capturas de solicitudes de convenio (donde si se visualiza la fila del ejercicio 2026):
FOLIO 349 FOLIO 408
Captura de solicitudes de contrato (donde se requiere que se agregue la fila del ejercicio 2026):
FOLIO 349
FOLIO 408
Lo anterior se solicita, para estar en posibilidad de realizar el ajuste anual (traspasar el monto pendiente de ejercer del 2025), así como comprometer el ejercicio presupuestado para el ejercicio 2026 (convenios modificatorios).
 Agradeciendo de antemano su colaboración, les envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-13 10:00:00', 'En INVENTARIO.SOLCONTPRESUPUESTO se agrego la linea 2026 con los datos requeridos que se asignaron erroneamente a un registro que no lo correspondia para ambos casos', 'Modificación en BD', '2026-01-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000079');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000042', 'SOLICITUD DE USUARIO PARA SISTEMA INTEGRAL (ESTIMACIONES)', '2026-01-07 17:25:00', 'Por este medio solicito su apoyo para asignar usuario y contraseña del SISTEMA INTEGRAL (ESTIMACIONES) a la Arq. Susana Colorado Solano, Coordinadora de Mantenimiento ( cmantenimiento1), quien se incorpora al área de mantenimiento.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'González Martínez, Francisco de Jesus'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-08 15:25:00', 'Se actualizo el usuario en SERVICIO.CONTACTOS01 y SERVICIO.USUARIOS y en OBRAS.USUARIOS', 'Modificación en BD', '2026-01-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000042');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000090', 'ELIMINACION DEPOLIZAS', '2026-01-12 18:09:00', 'Buena tarde, solicito su apoyo con la eliminación de las pólizas 181 y 182 de Cheques del periodo 1 del 2025 y solicito su apoyo con el traslado de la información de dichas pólizas a el periodo1 del 2026, relacionándoles los folios de pago 84801 correspondiente a la información de la póliza 181 y folio 84802  correspondiente a la información de la póliza   182; adjunto a continuación la información de dichas pólizas:',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-14 10:22:00', 'En CONTA.POLIZAS se eliminaron las polizas indicadas por el usuario y se crearon las polizas en 2026 con el consecutivo correspondiente. En INVENTARIO.PAGOS se actualizaron las polizas correspondientes del 2025 a 2026', 'Modificación en BD', '2026-01-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000090');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000096', 'solicitud de cambio de fecha en requisición', '2026-01-13 15:31:00', 'hola muy buena tarde por medio del presente solicito me ayuden a cambiar la fecha de la requi 133398, ya que la fecha que requiero es del dia 5 de enero de 2026.
sin mas por el momento quedo a sus ordenes.
saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Servicios Generales'),
  (select id from solicitantes_mesa where nombre = 'Serena Silván, Cinthya Araceli'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-14 13:31:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-01-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000096');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000093', 'carga de complemento de pago', '2026-01-13 11:53:00', 'Buenos días


Por medio de la presente, solicito su apoyo con la carga del complemento adjunto correspondiente al proveedor: EDENRED DE MEXICO, lo anterior debido a que presenta error al validar los archivos.


Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-14 10:26:00', 'Se hizo uso del candado ''des''.', 'Modificación en BD', '2026-01-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000093');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000098', 'DESBLOQUEO DE SIIP -FACTURACION- VENTANA DE COBROS', '2026-01-13 16:48:00', 'Buenas tardes estimados a quien corresponda.

Agradecería su amable apoyo, desbloqueando la ventana de cobros, ya que envía mensajes de error, como a continuación se muestra:

Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Cobros'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-14 13:48:00', 'Se cerraron las sesiones que estaban bloqueando la ventana.', 'Seguimiento de proceso', '2026-01-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000098');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000081', 'AGREGAR COLUMNA 2026', '2026-01-12 12:01:00', 'Por este medio solicito de su apoyo para aplicar la columna 2026 en la solicitudes 412 y 313 
FOLIO: 313 (Debido a que los servicios fueron recibidos durante el presente ejercicio fiscal y el pago se genera 20 días posteriores a la recepción pago correspondiente al mes de diciembre y considerado en el contrato original)   FOLIO: 412 (Debido a que los servicios fueron recibidos durante el presente ejercicio fiscal y el pago se genera 20 días posteriores a la recepción pago correspondiente al mes de diciembre y considerado en el contrato original)',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-14 13:28:00', 'Se agrego en INVENTARIO.SOLCONTPRESUPUESTO para ambos contratos la fila 2026 con montos 0 y en estado PEN', 'Modificación en BD', '2026-01-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000081');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000108', 'APOYO CON VISUALIZACIÓN DE FACTURA EN SIIP', '2026-01-14 15:35:00', 'Buenas tardes,

Por medio del presente, solicito su apoyo para la visualización de la factura con número de folio 86333, correspondiente al proveedor SISTEMA DE TRANSFERENCIAS Y PAGOS (STP).

Dicho documento se encuentra disponible en MEDIPORT; sin embargo, no se refleja correctamente en el SIIP.

Agradezco de antemano su atención.

Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-15 13:35:00', 'El error era ocasionado porque habían dos registros en CFDCONNECT.CFD_RECEPCION para el folio 86333. Se eliminó el que estaba subido erróneamente (perteneciente al folio 86340).', 'Modificación en BD', '2026-01-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000108');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000106', 'CAMBIO DE FECHA', '2026-01-14 10:57:00', 'Por medio del presente pido su apoyo para el cambio de fecha del siguiente pedido,

37035 a fecha 08/01/2026

Quedo atento y agradezco su pronta respuesta',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-16 09:08:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-01-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000106');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000117', 'MODIFICACIÓN EN DATOS DE SOLICITUD DE PAGO', '2026-01-15 13:40:00', 'Buenas tardes estimados 

En relación de la mesa de ayuda no. 2026-000108, con respecto a la factura con folio no. 86333 solicito de su muy amable apoyo para que en el apartado No. de factura, aparezca el que esta relacionado con la factura cargada 

Aparece: 


Debe aparecer: 


De antemano agradezco su amable apoyo',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-16 09:57:00', 'Se cambió el NUMFACTURA en INVENTARIO.FACTURAS.', 'Modificación en BD', '2026-01-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000117');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000121', 'NOTIFICACION DE NO TIMBRADO NOTA DE EGRESO.', '2026-01-16 11:00:00', 'Buen dia.
1.-Agradeceremos el apoyo con el timbrado de la nota de egreso 18414 , folio 15533.
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-19 09:00:00', 'En FACTURACION.VTNOTASCREDITO se modifico el campo MONTO asi como en FACTURACION.FACTURAS_TIMBRADOR se regreso el campo TIMBRADO a 0', 'Modificación en BD', '2026-01-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000121');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000065', 'Solicitud/ Permisos SIRE', '2026-01-09 10:54:00', 'Buen día

Se solicita el apoyo para habilitar temporalmente permisos para validación de documentos de prestadores de servicios en SIRE al usuario cauditorias


Actualmente los roles:
Selene
USUARIO: jdcalidad
ROL ACTUAL: Validación

Cristina 
Usuario: cauditorias
ROL ACTUAL: Revisor',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Ramírez Dimas, Cristina'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-19 11:46:00', 'Se otorgó el rol 163 (Contratos Calidad Firma) a los usuarios 11229 jdcalidad y 11228 cauditorias en EDIV2.USUARIOS_ROLES.', 'Modificación en BD', '2026-01-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000065');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000129', 'ACCESO A SISTEMA SIIPV2', '2026-01-16 15:18:00', 'Buen día:
Solicito apoyo para que se asignen privilegios de acceso a los sistemas SIIPV2 L.C. Sergio Reyes Cicero, Jefe del Departamento de Concursos y Contratos adscrito a la Gerencia de Ingeniería.  

Agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'SIIPV2'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-19 09:18:00', 'Seguimiento de proceso, se registro el usuario para su uso en la plataforma', 'Seguimiento de proceso', '2026-01-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000129');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000128', 'ACCESO A SISTEMA INTEGRAL', '2026-01-16 13:00:00', 'Buen día:
Solicito apoyo para que se asignen privilegios de acceso al sistema sistema Integral y al L.C. Sergio Reyes Cicero, Jefe del Departamento de Concursos y Contratos adscrito a la Gerencia de Ingeniería.  

Agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/Integral'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-19 08:00:00', 'Seguimiento de proceso, se registro el usuario para su uso en la plataforma', 'Seguimiento de proceso', '2026-01-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000128');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000127', 'CAMBIO DE FECHA DE PEDIDO', '2026-01-16 12:41:00', 'Buenas tardes solicito su amable apoyo para el cambio de fecha en el pedido no. 37040 que tiene fecha de 16/01/2026 y debe de tener la fecha 08/01/2026, quedo atento a sus comentarios, muchas gracias por su apoyo',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-19 14:20:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Seguimiento de proceso', '2026-01-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000127');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000157', 'PERMISOS SIIP', '2026-01-19 17:29:00', 'Buena tarde compañeros, solicito su amable apoyo para otorgarle los permisos de acceso a la Lic. Adriana Monserrat Sarmiento Aquino en el sistema SIIP  referentes al Área de buques, mismo permisos que tenia la ex compañera Kelly Anairam Lara Guatemala.
Cualquier duda favor marcar a la ext. 73055

Agradezco de antemano el apoyo..',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Haruel Aguirre, Lizbeth'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-20 16:00:00', 'Se otorgaron los privilegios del usuario auxcontrol2 al usuario auxcontrol6.', 'Seguimiento de proceso', '2026-01-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000157');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000162', 'CAMBIO DE FECHA EN No. SOLICITUD DE LA REQUISICIÓN 133401', '2026-01-20 10:41:00', 'Buen día estimados,
Por este medio, tengo a bien solicitar su apoyo a fin de que se pueda cambiar la fecha de la requisición 133401/2025 a 133401/2026, solo es el cambio del año 2025 por 2026.
Quedo atenta a sus comentarios.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-21 10:17:00', 'Se modifico el cambio ANIO en INVENTARIO.REQUISICIONES', 'Modificación en BD', '2026-01-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000162');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000148', 'CAMBIO DE FECHA', '2026-01-19 13:38:00', 'Por medio del presente pido su apoyo para el cambio de fecha del siguiente pedido,
37049 a fecha 08/01/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-21 11:26:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS de 19/01/2026 a 08/01/2026', 'Modificación en BD', '2026-01-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000148');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000167', 'Carga de complementos de pago', '2026-01-20 13:40:00', 'Buenas tardes,

Por medio del presente solicito su apoyo para la carga de los complementos de pago del proveedor CFE (45) ya que me aparece el siguiente error:



Quedo en espera de su amable respuesta.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-21 13:32:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-01-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000167');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000165', 'SOLICITUD DE INFORMACIÓN SIPOT 4TO TRIMESTRE 2025', '2026-01-20 13:02:00', 'Buenas tardes,

Por instrucción del C.P. Rogelio Lagos, y con la finalidad de cumplir en tiempo y forma con la presentación de la información del SIPOT, referente a los conceptos de representación y gastos de viaje erogados por esta Entidad correspondientes al cuarto trimestre de 2025 (01/10/2025 a 31/12/2025), solicito de la manera más atenta su apoyo para proporcionarnos esta información.



Quedo a sus órdenes, saludos.',
  (select id from ventanas_mesa where nombre = 'SIPOT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-21 09:02:00', 'Se mandó la información del SIPOT mediante correo electrónico.', 'Seguimiento de proceso', '2026-01-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000165');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000177', 'FALTA MONTO EN 2026', '2026-01-21 16:19:00', 'Por este medio solicito de su apoyo en la solicitud: 356 en el modulo de licitaciones-SOLICITUDES DE CONTRATO.
Ya que no se visualiza el monto del 2026  en estado de presupuesto que son $118,000.00 por lo cual anexo captura de pantalla de la pestaña de datos del contrato donde se ve lo que corresponde a 2026.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-22 15:19:00', 'En INVENTARIO.SOLCONTPRESUPUESTO se modifico el registro para incluir MONTOPENDIENTE = ''118000'', IVAPEND = ''18880'', TOTALPEND = ''136880''', 'Modificación en BD', '2026-01-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000177');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000176', 'CARGA DE NOTAS DE CREDITO', '2026-01-21 15:38:00', 'Hola buenas tardes

Por medio de la presente, solicito su apoyo con la carga de las notas de crédito adjuntas de las facturas

86377 y 86378, lo anterior debido a que presentan el siguiente error en los atributos de la nota.

Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-22 15:39:00', 'Se cambió el METODO_PAGO a PUE en INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-01-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000176');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000183', 'NOTIFICACION DE NO TIMBRADO - NOTA DE EGRESO', '2026-01-22 13:11:00', 'Buena tarde
Agradecemos el apoyo con el timbrado de la nota de egreso 18425, folio 15543
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-23 09:11:00', 'En FACTURACION.VTNOTASCREDITO se modifico el campo MONTO asi como en FACTURACION.FACTURAS_TIMBRADOR se regreso el campo TIMBRADO a 0', 'Modificación en BD', '2026-01-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000183');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000184', 'Modificación en detalles del pedido', '2026-01-22 13:49:00', 'Por medio de la presente solicito su apoyo para agregar la siguiente información:
RUTA: VER-MEX-VER
En los pedidos no. 37064 y 37065 entre el PNR y el CARGO.


Gracias,',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-23 12:49:00', 'Se realizó la modificación en DESCRIPCION de INVENTARIO.DETPEDIDOS.', 'Modificación en BD', '2026-01-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000184');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000182', 'HABILITACIÓN DE MODULO PARA REVISAR PARTIDAS PRESUPUESTALES', '2026-01-22 12:00:00', 'Buen día estimados,

Por este medio hago la solicitud de que se habilite el módulo de partidas presupuestales a un servidor y a la Lic. Sol de los Ángeles, esto para poder dar seguimiento a los montos estimados, comprometidos y devengados de la Gerencia de Operaciones.

Pongo a mi Jefa directa y Subgerente en copia.

Saludos.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Loperena Dominguez, Sergio Adolfo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-23 16:39:00', 'Se otorgaron los privilegios a COMPRAS>ESPECIALES>VERIFICA PRESUPUESTO X GERENCIA.', 'Seguimiento de proceso', '2026-01-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000182');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000199', 'VIATICOS', '2026-01-23 12:15:00', 'Buen día:

Solicito su apoyo para que le sean asignados privilegios al sistema de viáticos a la Ing. Lluvia del Carmen Gutiérrez Fernández, auxiliar de control adscrita a la Gerencia de Ingeniería.

Agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-23 17:15:00', 'Se dio de alta al usuario en módulo de viáticos.', 'Modificación en BD', '2026-01-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000199');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000192', 'ACCESO A SISTEMA SIIPV2', '2026-01-23 09:38:00', 'Buenos días. Por medio de la presente solicito me sean asignadas las credenciales de acceso al sistema SIIPV2. Gracias.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Muñoz Ayala, Karla Lorena'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-23 13:38:00', 'Se dio de alta al usuario y se proporcionaron credenciales a través de la mesa de ayuda.', 'Seguimiento de proceso', '2026-01-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000192');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000203', 'Solicitud de alta en SIIP', '2026-01-23 15:49:00', 'Buen día;
Solicito amablemente su apoyo para realizar mi alta en las plataformas SIIP.
Agradezco de antemano, quedo atenta.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Lagunes, Nataly'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-01-26 09:49:00', 'Se dio de alta al usuario y se proporcionaron credenciales a través de la mesa de ayuda.', 'Seguimiento de proceso', '2026-01-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000203');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000209', 'CANCELACION DE COMPLEMENTO DE PAGO', '2026-01-26 11:55:00', 'Buenos dias estimados a quien corresponda.
Agradeceriamos su amable en CANCELAR, el siguiente complemento de pago.
Numero consecutivo: 2443
Folio SIIP timbrado: 2441',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-28 15:29:00', 'En CFDCONNECT.CFD_EMISION se cambio el campo cancelado de 0 a 1 y el motivo_cancelacion a 03 buscando por el folio del complemento', 'Modificación en BD', '2026-01-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000209');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000100', 'MODIFICACIÓN EN FORMATOS ASPN-VER-GAF-F-16, ASPN-VER-GAF-F-24, ASPN-VER-GAF-F-25 y ASPN-VER-GAF-F-46.', '2026-01-13 17:13:00', 'Buenas tardes, 
Por medio del presente, solicito su valiosa colaboración, para realizar las modificaciones que se señalan y comentan con color amarillo en los formatos pdf, que se adjuntan al presente, mismos que se enlistan a continuación y cuya revisión se señalan en el recuadro azul, precisando que, la fecha de los 4 formatos deberá ser la "Fecha de Producción".',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-30 16:01:00', 'Se modificaron los reportes indicados por el usuario, asi como la version en INVENTARIO.DOCUMENTOS_SGGAF', 'Seguimiento de proceso', '2026-01-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000100');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000210', 'POLIZA PENDIENTE DE 2026 AL CONTRATO CON SOLICITUD FOLIO 362', '2026-01-26 12:16:00', 'Hola buenas tardes
Por medio de la presente, solicito su apoyo para que se refleje la póliza correspondiente al ejercicio fiscal 2026,  lo anterior para que pueda ser autorizado por el Depto. de Presupuesto y Contabilidad, se adjuntan para pronta referencia la imagen del 2025.
Quedo atenta de sus comentarios, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Solicitud de Contrato de Prestadores'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-28 15:49:00', 'Seguimiento de proceso, se indico el usuario las posibles acciones a seguir para atender la problematica', 'Seguimiento de proceso', '2026-01-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000210');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000249', 'MODIFICACIÓN EN CANTIDAD', '2026-01-30 13:47:00', 'Buenas tardes, 

Por medio del presente solicito su apoyo con la modificación en el pedido No. 37091.
La cantidad dice 55 y debe decir 1

Asimismo en la cotización no. 37782
La cantidad dice 55 y debe decir 1

Quedo en espera de su amable respuesta.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-02 10:47:00', 'Se modificó la CANTIDAD en INVENTARIO.PEDIDOS, DETPEDIDOS, COTIZACIONES y DETCOTIZACIONES.', 'Modificación en BD', '2026-01-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000249');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000250', 'MODIFICACIÓN EN CANTIDAD', '2026-01-30 17:17:00', 'Solicito su apoyo para la modificación en Cantidad de la requisición 133418.
En la parte de órdenes, en la 37901 dice 55 y debe decir 1

Quedo en espera de su amable respuesta.

Saludos,',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-02 15:17:00', 'Se modificó la CANTIDAD en INVENTARIO.DISTRPEDIDOS y la CANTIDADORD en REQUISICIONES y DETREQUIS.', 'Modificación en BD', '2026-01-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000250');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000256', 'BORRAR TODO EL FOLIO 5010 DEL FONDO REVOLVENTE', '2026-02-03 11:08:00', 'Buen día, se solicita su valioso apoyo eliminando la información y los documentos del folio 5010 del fondo revolvente de Dirección General.',
  (select id from ventanas_mesa where nombre = 'FONDO REVOLVENTE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos/Caja Chica'),
  (select id from solicitantes_mesa where nombre = 'Altamirano Landa, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-04 09:08:00', 'Se eliminaron los registros de VIATICOS.VTCOSCOMPROBACION, VTCOSDETCOMPROBACION e INVENTARIO.FOLIO_FACTURA. Y se eliminaron los archivos de la bóveda.', 'Modificación en BD', '2026-02-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000256');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000263', 'MODIFICACIÓN EN MONTO', '2026-02-03 15:12:00', 'Por medio del presente solicito su apoyo con la modificación en el pedido No. 37091.

El monto dice 830,060 y debe decir 15,092


Asimismo, en la cotización No. 37782, el monto dice 830,060 y debe decir 15,092


Quedo en espera de su amable apoyo,',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-04 12:58:00', 'Se modificó el MONTO en INVENTARIO.COTIZACIONES y PEDIDOS. Se modificó la CANTIDAD en DISTRCOTIZACIONES y el ESTADO de la REQUISICION a 4.', 'Modificación en BD', '2026-02-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000263');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000271', 'SOLICITUD CAMBIO DE ESTATUS', '2026-02-04 11:19:00', 'Buen día, por medio del presente solicito su apoyo para que la orden que se anexa a continuación se cambie a estado trámite. (Pedido 36587)',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-04 16:19:00', 'En INVENTARIO.PEDIDOS se modifico el campo ESTADO de 2 a 1 y los campos FECHAAUTOR05 = NULL, USERNAME_AUTORIZO05 = ''''', 'Modificación en BD', '2026-02-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000271');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000275', 'CAMBIO DE PARTIDA PRESUPUESTAL', '2026-02-04 13:48:00', 'Por este medio solicito de su apoyo para el cambio de centro de costos del contrato con numero de solicitud : 349 
Dice: DEPARTAMENTO: 300 GERENCIA DE PLANEACION
Debe decir: DEPARTAMENTO: 200 GERENCIA DE ADMINISTRACION Y FINANZAS
Por el periodo del 2026.
Quedo atenta a sus indicaciones.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-05 09:48:00', 'Seguimiento de proceso, solicitud atendida', 'Seguimiento de proceso', '2026-02-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000275');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000270', 'AGREGAR COLUMNA 2026', '2026-02-04 11:17:00', 'Por este medio solicito de su apoyo para que en la solicitud 431 se agregue la columna del 2026 para poder tramitar el pago ya que el proveedor entrego hasta este periodo 2026.

Quedo atenta a sus indicaciones.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-05 09:17:00', 'Se agrego en INVENTARIO.SOLCONTPRESUPUESTO el registro nuevo para 2026', 'Modificación en BD', '2026-02-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000270');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000289', 'MODIFICACION EN REQUISICION TABLERO PRESUPUESTAL', '2026-02-05 17:08:00', 'Buenas tardes,
Por medio del presente, solicito su apoyo para que en la requisición 133404 se RETIRE LA AUTORIZACIÓN PRESUPUESTAL con el fin de que  la Jefatura de Presupuesto y Contabilidad pueda volver a visualizarla y le aparezca en estatus para autorizar su validación.
De ante mano agradezco el apoyo brindado. Saludos,',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-06 15:08:00', 'En INVENTARIO.REQUISICIONES se modifico el campo APRUEBA_CONTA de 1 a 0', 'Modificación en BD', '2026-02-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000289');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000273', 'Carga de factura CFE', '2026-02-04 12:43:00', 'Por medio del presente solicito su apoyo para la carga de facturas de CFE (proveedor No. 45) con complementos de pago pendientes.

Quedo en espera de su amable respuesta.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-06 15:44:00', 'Se cambió temporalmente el ESTADO a 5 en INVENTARIO.FOLIO_COMPLEMENTO.', 'Modificación en BD', '2026-02-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000273');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000290', 'APERTURA 2DA SEMANA DE ENERO EN SIIP PARA JUSTIFICACION DE INCIDENCIAS', '2026-02-06 09:22:00', 'Buen día compañeros, 
Solicito su amable apoyo para la apertura de la segunda semana de enero en el sistema SIIP para la justificación de incidencias, ya que por error al justificar la quincena pasada, jale la segunda.
Agradezco de antemano y quedo atenta a sus comentarios.
Cualquier duda al respecto, me encuentro en la ext. 73055

saludos',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Haruel Aguirre, Lizbeth'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-06 16:22:00', 'Se eliminaron los registros de EDIV2.DOCUMENTO, FLUJODOCUMENTO, INCIDENCIAS, JUSTIFICA_INCIDENCIA y JUSTIFICA_INCIDENCIA_DETALLE.', 'Modificación en BD', '2026-02-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000290');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000291', 'INCIDENCIAS 2DA QUINCENA ENERO 2026', '2026-02-06 09:30:00', 'Buenos días, por este medio solicito su valioso apoyo para agregar mis incidencias de la segunda quincena del mes de enero 2026 ya que no me aparecen en el portal SIIPV2 y recibi un correo que ya se encontraban habilitadas para justificar.

Agradezco de antemano el apoyo y envio un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-06 16:30:00', 'Se eliminaron los registros de EDIV2.DOCUMENTO, FLUJODOCUMENTO, INCIDENCIAS, JUSTIFICA_INCIDENCIA y JUSTIFICA_INCIDENCIA_DETALLE.', 'Modificación en BD', '2026-02-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000291');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000287', 'Carga de complementos de pago', '2026-02-05 15:16:00', 'Por medio del presente solicito su apoyo para la carga de los siguientes complementos de pago del proveedor CFE (No. 45), ya que me aparece el siguiente error:

Adjunto archivos para su revisión.

Gracias y saludos,',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-06 16:19:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-02-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000287');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000296', 'Relación de CFDI por mes: octubre, noviembre y diciembre 2025', '2026-02-06 12:33:00', 'Buenas tardes
El presente es para solicitar su apoyo con la relación de CFDI octubre, noviembre y diciembre 2025
Para fines de auditoria.
Saludos y gracias.',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Serrano Berriozabal, Jose Luis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-09 09:33:00', 'Seguimiento de proceso, se generaron los reportes solicitados', 'Seguimiento de proceso', '2026-02-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000296');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000299', 'JUSTIFICACION DE INCIDENCIAS', '2026-02-06 14:02:00', 'Buenas tardes compañeros 

Me podrian apoyar cambiando el estatus de la solicitud #15879 , ya que en la descripcion de omision es incorrecta 

Quedo atenta a su apoyo
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Martínez Pastor, Joseline'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-09 11:00:00', 'Se eliminaron los registros de EDIV2.DOCUMENTO, FLUJODOCUMENTO, INCIDENCIAS, JUSTIFICA_INCIDENCIA y JUSTIFICA_INCIDENCIA_DETALLE.', 'Modificación en BD', '2026-02-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000299');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000298', 'APOYO ABRIENDO LA SOLICITUD (15832) DE JUSTIFICACION DE INCIDENCIAS', '2026-02-06 13:32:00', 'Hola buen día Equipo.
Esperando se encuentren bien, me dispongo a pedir su apoyo ya que requiero se coloque en estatus ABIERTA mi solicitud que en este momento esta en estatus CANCELADA, ya que debo eliminar lo indicado con el día 21.

quedo de ustedes agradeciendo de antemano,
saludos.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-09 10:32:00', 'Se eliminaron los registros de EDIV2.DOCUMENTO, FLUJODOCUMENTO, INCIDENCIAS, JUSTIFICA_INCIDENCIA y JUSTIFICA_INCIDENCIA_DETALLE.', 'Modificación en BD', '2026-02-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000298');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000301', 'carga de complemento de pago', '2026-02-09 09:37:00', 'Buenos días


Por medio de la presente, solicito su apoyo con la carga de los siguientes complementos de pago, ya que presentan error al validarse por diferencia en lo total pagado.


Proveedor: EDENRED MEXICO, S.A. DE C.V.


De antemano agradezco la atención, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-09 16:41:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-02-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000301');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000304', 'ERROR EN REQUISICION SIIP', '2026-02-09 10:36:00', 'Buen día,
Al intentar imprimir mi requisición me aparece los siguientes errores.
    TEXTO A INCLUIR:
SERVICIO DE MANT. INTEGRAL DE LAS LANCHAS PATRULLA VIGÍA Y VIGÍA II PARA LA ADMINISTRACIÓN DEL SISTEMA PORTUARIO NACIONAL VERACRUZ, S.A. DE C.V. POR EL PERIODO FEB.-DIC. 2026 CON PRESUPUESTO $1,934,185.00 COMPRENDIENDO LAS SUBPARTIDAS:
1)SERVICIO DE DIAGNÓSTICO A MOTORES FURA DE BORDA DE LAS LANCHAS VIGÍA Y VIGÍA II. MONTO: $695,168.04
2)SERVICIO DE MANT. ELÉCTRICO Y CAMBIO DE PIEZAS DAÑADAS DE LA LANCHA PATRULLA VIGÍA. MONTO: $114,769.00
3)SERVICIO DE MANT. ELÉCTRICO Y CAMBIO DE PIEZAS DAÑADAS DE LA LANCHA PATRULLA VIGÍA II. MONTO: $117,302.00
4)SERVICIO DE MANT. PREVENTIVO DE LAS 100 HORAS DE LAS LANCHAS PATRULLAS VIGÍA Y VIGÍA II. MONTO: $187,272.00
5)SERVICIO DE MANT. PREVENTIVO DE LAS 300 HORAS DE LAS LANCHAS PATRULLAS VIGÍA Y VIGÍA II. MONTO: $179,056.00
6)SERVICIO DE MANT. PREVENTIVO DE LAS 500 HORAS DE LAS LANCHAS PATRULLAS VIGÍA Y VIGÍA II. MONTO: $125,122.00
7)SERVICIO DE LIMPIEZA DE FONDO DE CASCO DE LAS LANCHAS PATRULLA VIGÍA Y VIGÍA II. MONTO: $63,000.00
8)SERVICIO DE ANTIVEGETATIVO PARA LA LANCHA PATRULLA VIGÍA. MONTO: $91,208.00
9)SERVICIO DE CAMBIO DE COJINERÍA DE LAS LANCHAS PATRULLA VIGÍA Y VIGÍA II. MONTO: $361,288.00',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Gómez Hernández, Carlos Ignacio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-10 10:36:00', 'Se modificó la DESCRIPCION en INVENTARIO.DETREQUIS por el límite de espacio en el reporte (aproximádamente 1100 caracteres máx.).', 'Modificación en BD', '2026-02-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000304');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000294', 'Considerar monto comprometido', '2026-02-06 10:31:00', 'Derivado de que el recurso disponible en el Oficio de Liberación de Inversión 1-2026 al día de hoy son insuficientes para comprometer la totalidad de los contratos, se solicita amablemente y si es viable el habilitar para el Número de Contrato ASPN-GI-CO-62601-01-25 número de proyecto 2313J3E0005 INFRAESTRUCTURA COMPLEMENTARIA PARA LA AMPLIACIÓN NATURAL DEL PUERTO DE VERACRUZ EN LA ZONA NORTE del contratista GAMI INGENIERIA E INSTALACIONES, S.A. DE C.V. considerar del monto a comprometer por el ejercicio de $830,153,610.42 habilitar el monto $462,703,967.08 para posterior mente con la liberación de inversión se comprometa el monto original de $830,153,610.42.',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-09 15:48:00', 'En OBRAS.DISTRCONTRATOS se modifico el campo MONTOPEND de 780344733.49 a 462703967.08 asi como los corresponientes montos en IVAPEND y MONTOTOTAPEND', 'Modificación en BD', '2026-02-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000294');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000308', 'SIIP BANCOS', '2026-02-09 13:13:00', 'Buenas tardes compañeros 
Tratando de eliminar una poliza de diarios , se queda trabado el siip bancos . Ya he reiniciado el siip en varias ocasiones pero se queda girando al querer realizar alguna accion 
Saludos.',
  (select id from ventanas_mesa where nombre = 'SIIP BANCOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Bancos'),
  (select id from solicitantes_mesa where nombre = 'Martínez Pastor, Joseline'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-10 10:00:00', 'Seguimiento de proceso, se eliminaron las sesiones duplicadas', 'Seguimiento de proceso', '2026-02-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000308');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000315', 'PRIVILEGIOS EN MODULOS SIIP', '2026-02-10 09:40:00', 'Buenos días

Por medio del presente les solicito muy atentamente agregar al usuario LMELO los privilegios que tenia el usuario RLAGOS en los diversos módulos VIATICOS, CONTABILIDAD, FACTURACION, COMPRAS,del SIIP..

De antemano gracias.

Saludos',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Luna, Candida'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-10 17:40:00', 'Se copiaron los privilegios en SIPP > SEGURIDAD, en INVENTARIO.USUARIOS y se cambió el correo en VIATICOS.SENDEMAILS.', 'Modificación en BD', '2026-02-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000315');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000281', 'REQUISICIONES', '2026-02-05 10:07:00', 'Buenos días,

De la manera más atenta se solicita que los usuarios rcamposg y auxcontabilidad2 tengan acceso al apartado requisiciones.

Cualquier duda quedo a la orden.

Saludos.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-11 16:19:00', 'Se otorgaron privilegios para Requisiciones e Investigacion de mercado.', 'Modificación en BD', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000281');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000283', 'cambio de fecha en requisición e investigación de mercado', '2026-02-05 11:09:00', 'Buenas tardes, 

Solicito su amable apoyo con el cambio de todas las fechas en la requisición 133426 y su investigación de mercado 10641por la fecha de 18 de enero de 2026

Agradezco su amable apoyo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-11 17:18:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000283');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000297', 'AGREGAR TEXTO A INVESTIGACIÓN DE MERCADO', '2026-02-06 12:59:00', 'Buen día, podría apoyarme de favor, agregándole un texto a la investigación de mercado 010641/2026

Texto para agregar en Resultados y conclusiones al final:

LO ANTERIOR, CON BASE EN LO ARTICULOS 35 FRACCION III Y 55 DE LA LEY DE ADQUISICIONES , ARRENDAMIENTOS  Y SERVICIOS DEL SECTOR PUBLICO.',
  (select id from ventanas_mesa where nombre = 'INVESTIGACION DE MERCADO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Villalba Rojas, Briseiri Aylin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-11 13:57:00', 'Se agregó el texto en las CONCLUSIONES de INVENTARIO.INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000297');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000276', 'SOLICITUD PARA CAMBIO DE FECHA EN LA REQUISICIÓN 133428 E INV. DE MERCADO 10642', '2026-02-04 15:17:00', 'Buena tarde estimados,

Por este medio, tengo a bien solicitar su apoyo, a fin que se pueda cambiar la fecha de la REQUISICIÓN 133428 e INV. DE MERCADO 10642, quedando definida la fecha 03/02/2026 para ambas.

Quedo atenta a sus comentarios.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-11 13:17:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000276');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000267', 'agregar leyenda en resultado de investigación de mercado', '2026-02-04 09:28:00', 'Buenos días 

Solicito su amable apoyo para agregar en el resultado de la Investigación de Mercado 010621 al final y articulo 48 de su reglamento.',
  (select id from ventanas_mesa where nombre = 'INVESTIGACION DE MERCADO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-11 13:27:00', 'Se agregó el texto en las CONCLUSIONES de INVENTARIO.INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000267');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000331', 'Mesa de ayuda mediport', '2026-02-10 16:52:00', 'Buenas tardes. Solicito su apoyo para la carga de las
facturas del contratista SG Cimentaciones, correspondiente a la estimación 4 -N
del contrato ASPN-GI-CO-62601-015-25; ya que, al intentar cargarla, el sistema
muestra un error (Se adjunta al presente), indicando que el folio no
corresponde a ninguno registrado en mediport (El folio corresponde al folio del
anticipo del 2025).
Revisando con la factura del 2025, se nota que el folio indicado
en la factura si es el correspondiente al anticipo.
Adjunto al presente se adjunta las facturas que
se intentan cargar (Ingreso, Nota de crédito y Amortización de anticipo), así
cómo, el error indicado por mediport y el contrarrecibo de la factura 2025 en
la cual se encuentra el folio de la misma',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Ronces Rodríguez, Elias Armando'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-11 13:52:00', 'Se cargó la factura del proveedor porque el sistema intentaba utilizar el folio relacionado como folio interno.', 'Modificación en BD', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000331');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000339', 'APROBACION DE REQUISICIONES', '2026-02-11 12:55:00', 'Buenos dias,
Me podrían ayudar a validar el siguiente error al intentar autorizar una requisición en el modulo de compras.
image.png
quedo pendiente, saludos.',
  (select id from ventanas_mesa where nombre = 'CONSULTA DE REQUISICIONES EN TRAMITE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Melo Escarela, Luis Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-12 11:55:00', 'Seguimiento de proceso, se realizo una modificacion temporal sobre la forma cpautptalrequi', 'Seguimiento de proceso', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000339');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000337', 'CAMBIO DE FECHA', '2026-02-11 11:04:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido: 37163.
Dice: 06/02/2026
Debe decir: 30/01/2026
Se encuentra en estado de tramite para realizar los cambios solicitados.
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-12 10:33:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS de 30/01/2026 a 06/02/2026.', 'Modificación en BD', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000337');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000324', 'cambio de iniciales', '2026-02-10 14:54:00', 'Por medio del presente solicito su apoyo para el cambio de iniciales en el formato ASPN-VER-GI-F-25, ya que el sistema lo genera con las iniciales del antiguo jefe de concursos y contratos (AHA) y deberá de ser con las iniciales del actual jefe de concursos y contratos (SRC).
Sin mas por el momento quedo atento a cualquier duda o comentario.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Ronces Rodríguez, Elias Armando'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-11 12:00:00', 'Seguimiento de proceso, se realizo una modificacion sobre el reporte para cambiar las iniciales estaticas', 'Seguimiento de proceso', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000324');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000341', 'Cambio de nombre en el apartado "Revisión Contable Presupuestal"', '2026-02-11 16:15:00', 'Estimados ingenieros
Por medio del presente solicito su apoyo a fin de modificar el nombre de la persona publica en el calce de las requisiciones en especifico aparado "Revisión Contable Presupuestal", a partir del 10 de febrero de 2026, para aquellas requisiciones que deban generarse en el sistema, lo anterior, entendiendo lo siguiente:
Dice: 
Revisión Contable Presupuestal
Nombre: C.P.A ROGELIO LAGOS AMBROSIO
Puesto: JEFE DE DEPARTAMENTO DE PRESUPUESTO Y CONTABILIDAD
Debe decir:
Revisión Contable Presupuestal
Nombre: 
Puesto: JEFE DE DEPARTAMENTO DE PRESUPUESTO Y CONTABILIDAD',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-12 13:15:00', 'Seguimiento de proceso, se realizo una modificacion sobre el reporte para cambiar el nombre del encargado del puesto para dejarlo vacio', 'Seguimiento de proceso', '2026-02-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000341');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000346', 'SOLICITUD CAMBIO DE FECHA.', '2026-02-12 10:21:00', 'Buen día, por medio del presente solicito su apoyo para cambio de fecha en REQUI 133437 e IM 10650 a fecha 29/01/2026.

De antemano agradezco el apoyo brindado. Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-13 09:21:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES y en INVENTARIO.INVESTIGACIONMERCADO de 12/02/2026 a 29/01/2026.', 'Modificación en BD', '2026-02-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000346');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000348', 'Mesa de ayuda mediport', '2026-02-12 14:38:00', 'Buenas tardes. Solicito su apoyo para la carga de las facturas del contratista SG Cimentaciones, correspondiente a la estimación 4 -N del contrato ASPN-GI-CO-62601-015-25; ya que, al intentar cargarla, el sistema muestra un error (Se adjunta al presente), indicando que el folio no corresponde a ninguno registrado en mediport (El folio corresponde al folio del anticipo del 2025).

Revisando con la factura del 2025, se nota que el folio indicado en la factura si es el correspondiente al anticipo.

Adjunto al presente se adjunta las facturas que se intentan cargar (Ingreso, Nota de crédito y Amortización de anticipo), así como, el error indicado por mediport y el contrarrecibo de la factura 2025 en la cual se encuentra el folio de la misma.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Ronces Rodríguez, Elias Armando'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-13 12:00:00', 'Se cargó la factura del proveedor porque el sistema intentaba utilizar el folio relacionado como folio interno.', 'Seguimiento de proceso', '2026-02-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000348');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000268', 'MODIFICAR ESTIMACIONES EN SIIP', '2026-02-04 10:30:00', 'BUEN DIA ESTIMADOS 
LES PIDO SU AOPYO PARA ABRIR LAS SIGUIENTES ESTIMACIONES EN EL SISTEMA SIIP QUE SE ENCUENTRAN EN ESTADO "TRAMITADA"  PARA QUE LA CONTRATISTA PUEDA  MODIFICARLAS DEBIDO A CORRECCIONES  
CONTRATO ASPN-GI-CO-62602-006-25 
Estimacion 1 y 2
QUEDO AL PENDIENTE DE SU AYUDA , GRACIAS',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Colorado Solano, Susana'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-04 15:30:00', 'Seguimiento de proceso, se le comunico al ususario las condiciones por las cuales se presenta la restriccion', 'Seguimiento de proceso', '2026-02-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000268');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000360', 'ESTADO PARCIAL PAGADO', '2026-02-16 13:33:00', 'Por este medio solicito de su apoyo para que en la solicitud 416 en el modulo de licitaciones en el estado de la solicitud Debe decir: PARCIAL PAGADO.
Para poder sacar el ultimo pago.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-17 12:00:00', 'Se cambio el estado en INVENTARIO.SOLCONTRATOS de 3 a 2', 'Modificación en BD', '2026-02-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000360');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000251', 'CAMBIO DE FACTURA EN LA BOVEDA VIRTUAL DE MEDIPORT', '2026-01-30 17:56:00', 'Buenas tardes, solicito su amable apoyo para hacer un cambio de factura en la bóveda virtual de MEDIPORT, haciendo referencia los siguientes datos.
folio: 86335
requisición: 133376
proveedor: DISTRIBUIDORA JUGUETRON S.A. DE C.V. 

Al no poder cargar la factura en PDF y XML por este medio, les agradecería se comuniquen con su servidor a manera de proporcionarles la factura correspondiente',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-11 16:32:00', 'Se reemplazaron los archivos en bóveda.', 'Modificación en BD', '2026-02-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000251');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000362', 'COMPROBACIÓN DE VIATICOS 4682', '2026-02-16 18:24:00', 'BUENAS TARDES.


SOLICITO DE SU APOYO PARA RETIRAR DE LA COMPROBACIÓN DE VIATICOS 4682 RETIRAR LAS FACTURAS MARCADAS EN AZUL CORRESPONDIENTE A HOSPEDAJE ($700) Y ALIMENTOS ($259)',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Díaz Ortíz, Oscar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-17 17:00:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, VIATICOS.VTCOSDETCOMPROBACION, y de la bóveda. Se renombraron los registros para mantener la secuencia', 'Modificación en BD', '2026-02-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000362');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000364', 'Visualización de instrucción de Carátula en Sistema Integral', '2026-02-17 10:53:00', 'Se solicita amablemente su apoyo para la habilitación del botón de Instrucción para la visualización de las  Carátulas de los contratos en el Sistema Integral en el módulo de jurídico en la sección de solicitud.
De antemano gracias',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-17 15:53:00', 'Se retiro temporalmente el permiso 39 en SERVICIO.CONTACTO_PERMISO16 para permitir el uso del boton', 'Modificación en BD', '2026-02-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000364');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000365', 'NOTIFICACION DE NO TIMBRADO - NOTA DE EGRESO', '2026-02-17 11:47:00', 'Buen día
Agradecemos el apoyo con el timbrado de la nota de egreso 18533, folio 15646.
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-01-19 09:00:00', 'En FACTURACION.VTNOTASCREDITO se modifico el campo MONTO asi como en FACTURACION.FACTURAS_TIMBRADOR se regreso el campo TIMBRADO a 0', 'Modificación en BD', '2026-02-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000365');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000373', 'CAMBIO DIRECTA CON CONTRATO', '2026-02-18 10:36:00', 'Buenos Días
Por este medio solicito de su apoyo para el cambio en tipo de Adjudicación del pedido no. 37183, mismo que debe decir Directa Contrato. 
Cabe mencionar que dicho pedido, ya se encuentra en estado ABIERTO 
Cualquier duda o comentario, quedo a su disposición 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-18 15:36:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1', 'Modificación en BD', '2026-02-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000373');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000375', 'RECLASIFICACION ASIENTO CONTABLE EN POLIZA Y ESTRUCTURA PROGRAMATICA RECAUDACION 18-02-2026.', '2026-02-18 11:20:00', 'Buen día
Derivado de la necesidad de la aplicación del saldo disponible por $811,765.83 en la nota de crédito 18539, folio 15652
El día de hoy 18/02/2026 se emite el folio SIP ANTICIPO 982780 a nombre de la empresa TALLERES NAVALES DEL GOLFO S.A. DE C.V.
De acuerdo a la revisión de reportes por la recaudación del día de hoy 18/02/2026 se detecta que el movimiento de la liquidación arriba mencionada, el SIIP no generó la póliza por la afectación presupuestal correspondiente, tanto en la POLIZA DE RECAUDACION como en la ESTRUCTURA PROGRAMATICA en corte de Caja ( Tarifario ).
Al respecto agradeceremos su apoyo, para visualizar el siguiente registro contable.
NOTA SIP 18539            Póliza de Ingresos 1316
                                             CARGO                          ABONO
8141-10111-11-0000          $699,798.13
8151-10111-11-0000                                              $ 699,798.13',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-18 16:20:00', 'Se agrego en FACTURACION.MOVIMIENTOS los registros faltantes asi como en FACTURACION.FACTPPINGRESODOCTO, en este ultimo se personalizo el ID_MOVS obteniendo el maximo del periodo y ejercicio actual + 1', 'Modificación en BD', '2026-02-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000375');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000376', 'JUSTIFICACION DE INCIDENCIAS', '2026-02-18 12:18:00', 'Buen día compañeros 

Me podrían apoyar eliminando la solicitud de incidencias 15941 , ya que hubo error en la justificación  y habilitarla nuevamente para realizar de nuevo las justificaciones. 


De antemano gracias
Saludos.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Martínez Pastor, Joseline'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-19 10:18:00', 'Se eliminaron los registros de EDIV2.JUSTIFICA_INCIDENCIA, JUSTIFICA_INCIDENCIA_DETALLE, INCIDENCIA, DOCUMENTO y FLUJODOCUMENTO.', 'Modificación en BD', '2026-02-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000376');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000374', 'Carga de complementos de pago', '2026-02-18 11:10:00', 'Por medio del presente solicito su apoyo para la carga de complementos de pago del proveedor CFE (45), ya que me aparece el siguiente error:
 

Adjunto los documentos para su revisión.

Gracias de antemano,',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-19 09:42:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-02-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000374');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000381', 'PRIVILEGIOS PARA INCIDENCIAS', '2026-02-19 10:12:00', 'Buenos días,

Solicitando de su amable apoyo para habilitar los privilegios del SIIP de la Licenciada Ileana Vazquez Ruiz con el usuario: secoperaciones2
Ya que al entrar a la plataforma no deja ingresar a ningún modulo. 
 

Se agradece su apoyo.

Saludos.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones'),
  (select id from solicitantes_mesa where nombre = 'Morales Tronco, Diana Isabel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-19 15:12:00', 'Se asignaron los privilegios del anterior usuario secoperaciones2.', 'Seguimiento de proceso', '2026-02-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000381');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000361', 'CAMBIO DE FECHA', '2026-02-16 16:27:00', 'Por este medio solicito el cambio de fecha del contrato: 37181 
Debe decir: 17/02/2026.
Queda en estado tramite para que se puedan hacer las adecuaciones solicitadas.
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-17 12:27:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDO de 16/02/2026 a 17/02/2026.', 'Modificación en BD', '2026-02-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000361');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000368', 'SOLICITUD CAMBIO DE FECHA.', '2026-02-17 12:22:00', 'Buen día, por medio del solicito su apoyo para el cambio de fecha de la orden 37182 a la fecha 29/01/2026.

De antemano gracias. Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-17 17:22:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-02-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000368');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2026-000385', 'INCIDENCIA SIIPV', '2026-02-19 12:31:00', 'Buenas tardes, pueden por favor apoyarme con la tramitación de incidencias.
Sigo el proceso, guardo mi incidencia pero cuando la busco me dice el sistema que no hay incidencias.
Lo comenté con rh pero me dice que lo cheque con ustedes.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Palacios Herrera, Viridiana Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-20 10:31:00', 'Se dio de alta al usuario en EDIV2 para habilitar la Justificación de Incidencias.', 'Modificación en BD', '2026-02-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2026-000385');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000388', 'ACCESO A SIIPV2', '2026-02-19 14:21:00', 'BUNAS TARDES, SOLICITO APOYO PARA MI COMPAÑERO, ING.  CESAR SÁNCHEZ VALENZUELA YA QUE NO LO DEJA ACCEDER Y NO LO DEJA LEVANTAR MESA DE AYUDA',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Briano Rangel, Isaac Giovanni'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-20 12:00:00', 'Se dio de alta al usuario en SIIP y se otorgaron privilegios.', 'Modificación en BD', '2026-02-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000388');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000389', 'PROBLEMAS SIIPV2', '2026-02-19 15:00:00', 'BUNAS TARDES, SOLICITO APOYO PARA MI COMPAÑERO, ING.  RODOLFO e ING. ENRIQUE PISO 2 Coordinador de proyectos y de mantenimiento YA QUE NO LO DEJA ACCEDER Y NO LO DEJA LEVANTAR MESA DE AYUDA',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Briano Rangel, Isaac Giovanni'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-20 12:00:00', 'Se dio de alta al usuario cmantenimiento2 en SIIP y se otorgaron privilegios a su usuario y a cproyectosing4.', 'Modificación en BD', '2026-02-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000389');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000377', 'Corrección en el apartado SIIP', '2026-02-18 13:04:00', 'Corrección de monto de la requisición 133442 , ya que sale en número negativo y tendría ser el monto de 23,465.00',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Hernández Chacha, Valeria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-20 13:48:00', 'Se modificó el MONTOESTIMADO en INVENTARIO.REQUISICIONES y el PRECIOUNITARIO en DETREQUIS.', 'Modificación en BD', '2026-02-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000377');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000391', 'CAMBIO DE ESTIMADO EN EL SIIP', '2026-02-19 15:56:00', 'CAMBIO DE MONTO EN EL ESTIMADO DE LA REQUISICIÓN 133442 , YA QUE SE ENCUENTRA BLOQUEADO PARA EDITAR PERO LA REQUISICIÓN SIGUE ABIERTA.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Hernández Chacha, Valeria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-20 12:56:00', 'Se modificó el MONTOESTIMADO en INVENTARIO.REQUISICIONES y el PRECIOUNITARIO en DETREQUIS.', 'Modificación en BD', '2026-02-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000391');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000396', 'Cambio de monto en la requisición 133442', '2026-02-20 17:06:00', 'Cambio en el estimado del Papel bond a 3,392.24 y cambio de estimado de la requisición a 20,228.49 , el la requisicón número133442',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Hernández Chacha, Valeria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-23 14:06:00', 'Se modificó el MONTOESTIMADO en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO y el PRECIOUNITARIO en DETREQUIS y SUBDETINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-02-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000396');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000400', 'Modificación comprobación de viáticos', '2026-02-23 10:27:00', 'Solicito su apoyo para borrar el registro seleccionado en la comprobación de viáticos 5013. ¡Gracias!',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Santiago Peña, Laryssa Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-23 15:27:00', 'Se eliminó el registro de VIATICOS.VTCOSDETCOMPROBACION y de INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-02-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000400');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000403', 'No aparecen datos para generar solicitud de viáticos', '2026-02-23 11:26:00', 'No me aparecen mis datos para solicitar viáticos.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Morlet Cienfuegos, Luis'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-24 10:26:00', 'Se dio de alta al usuario en módulo de Viáticos.', 'Modificación en BD', '2026-02-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000403');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000399', 'NOTIFICACIONES DEL SIRE A REVISORES Y EMPRESAS', '2026-02-23 10:20:00', 'Buen día 
Se solicita su apoyo para reactivar las notificaciones que anteriormente realizaba el sistema SIRE al momento en que se cargaba una nueva solicitud en el sistema: notificaba a los revisores vía correo electrónico y, cuando los revisores rechazaban algún documento, notificaban a la empresa el motivo por correo electrónico.
Asimismo, se solicita implementar la notificación a los revisores cuando la empresa sube un nuevo requisito "rectificado" o corregido, para que ingresen al sistema a revisar los documentos pendientes.
Cualquier comentario, me encuentro en la extensión 72924.
Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-23 15:20:00', 'En EDIV2.CONTRATOS_SOLICITUD se actualizo el campo EMAIL del erroneo a un correo utilizable para el NID = 616, 611', 'Modificación en BD', '2026-02-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000399');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000401', 'CORRECCION PAGO', '2026-02-23 10:55:00', 'Buen día, solicito su apoyo con la corrección en sistema del pago 84895, favor de agregar en el apartado de "Financiera" el código 2436, quedando al pendiente de validación de proceso en modulo "Bancos", adjunto imagen ilustrativa del campo requerido a modificar',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-24 10:55:00', 'Se agrego el valor 2436 al campo FINANCIERA en INVENTARIO.PAGOS', 'Modificación en BD', '2026-02-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000401');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000406', 'Módulo Viáticos', '2026-02-23 14:58:00', 'Solicito su apoyo ya que no puedo generar una solicitud de viáticos en SIIP, todos los campos se quedan en blanco.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Santiago Peña, Laryssa Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-24 12:58:00', 'Se dio de alta al usuario en módulo de Viáticos.', 'Modificación en BD', '2026-02-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000406');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000412', 'CONTRASEÑA SIPP MARIA JOSE', '2026-02-23 16:10:00', 'Buenas tardes
Por medio del presente se solicita apoyo, para restablecer contraseña de Acceso al SIPP de María José Parra Díaz, con usuario auxadmongi1, ya que la plataforma no le permite entrar.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Molina Montiel, Miriam del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-24 15:10:00', 'Seguimiento de proceso, se indico al usuario a como reestablecer su contraseña por medio del reinicio de su equipo dee trabajo', 'Seguimiento de proceso', '2026-02-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000412');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000414', 'ACTUALIZAR ESTADO DE DOCUMENTOS EN SIRE', '2026-02-23 17:54:00', 'Buenas tardes
Solicito su amable apoyo para actualizar el estado de los documentos que se enlistan a continuación a RECHAZADO de la solicitud a nombre de la empresa VERACRUZ ADVENTURES:
PROGRAMA DE MANTENIMIENTO
RELACION DE EQUIPO PROPIO O A CARGO
POLIZAS DE SEGUROS.
Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-24 13:00:00', 'Se cambió a 3 el ESTADO en EDIV2.CONTRATOS_SOLICITUD_DETALLE y a 1 en CONTRATOS_SOLICITUD_FLUJO.', 'Modificación en BD', '2026-02-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000414');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000425', 'CAMBIO DE FECHA REQUISICION', '2026-02-24 12:26:00', 'Buenas tardes
Me pueden ayudar con un cambio de fecha en la requisición 133423, por favor.
Dice:
Fecha 29/01/2026
Debe decir: 
Fecha 28/02/2026
Saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gómez Hernández, Carlos Ignacio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-25 10:26:00', 'Se realizo el cambio de fecha en INVENTARIO.REQUISICIONES de 29/01/2026 a 28/02/2026', 'Modificación en BD', '2026-02-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000425');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000404', 'MODIFICAR MONTO 2026', '2026-02-23 12:47:00', 'Por este medio solicito de su apoyo para el ajuste del monto en la solicitud 380 para que en el estado de presupuesto en el año 2026 se ajuste el monto a: $39,530,810.28 (se multiplico  $3,294,234.19 *12 meses,  que es el monto de las mensualidades por  los 12 meses contando el mes de diciembre 2025 que falta y de enero a noviembre 2026). Para que permita sacar los pagos del contrato.
Quedo atenta a cualquier indicación.
Se anexa captura de pantalla como evidencia.',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-25 10:12:00', 'Se modifico en INVENTARIO.SOLCONTPRESUPUESTO el registro para poder comprometer', 'Modificación en BD', '2026-02-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000404');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000383', 'REQUISICION', '2026-02-19 12:09:00', 'Buen día:
Solicito su apoyo para que sea puesta en estado ABIERTA la requisición No. 133447 así como su investigación de mercado correspondiente con Núm.. 10658.Esto debido a modificaciones que se tienen que realizar.
Agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-24 16:51:00', 'Se modificó el ESTADO a 0 en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO y se cambió el SELECCIONADO a 0 en PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-02-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000383');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000423', 'Solicitud de acceso y privilegios de sistema siip', '2026-02-24 10:43:00', 'Estimados
Por medio de la presente, solicito de la manera más atenta su apoyo para gestionar el acceso y la configuración de privilegios en el sistema sippv2 para mi auxiliar a cargo, la Lic. Adelita Redondo Reyes.
Con el objetivo de que pueda desempeñar sus funciones de manera óptima, requiero que se le otorguen exactamente los mismos permisos y niveles de acceso que tiene actualmente mi otro auxiliar, el Lic. Luis Fernando Monroy León. Específicamente, es necesario que la Lic. Redondo cuente con facultades para ingresar y operar en los apartados de manifiestos, control de carga, especiales y catálogos, entre otros.
Para facilitar la configuración y servir como referencia directa de los módulos requeridos, adjunto a este correo una captura de pantalla con el detalle de los accesos actuales. Quedo a su entera disposición en caso de que se requiera alguna validación adicional para completar este proceso.
Agradezco de ante mano su atención y apoyo.
Atentamente,
P.D. El correo del usuario en cuestión es auxcontrol4@puertodeveracruz.com.mx
Atentamente Soporte Técnico',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Flores Bretón, Daniel José'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-24 15:43:00', 'Se dio de alta al usuario en SIIP y se compartieron credenciales de acceso mediante correo electrónico.', 'Modificación en BD', '2026-02-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000423');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000427', 'CAMBIO DE FECHA INV. DE MERCADO', '2026-02-24 12:50:00', 'Buenos días estimados,
Me pueden ayudar con modificar la fecha en la inv. de mercado 10645, ya que se cambio la fecha de requisición al día de hoy pero ya no permite guardar.
Dice: 
Fecha 05/02/2026
Debe decir: 
Fecha 24/02/2026
Saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gómez Hernández, Carlos Ignacio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-25 15:55:00', 'Se realizo el cambio de fecha en INVENTARIO.INVMERCADO de 05/02/2026 a 24/02/2026', 'Modificación en BD', '2026-02-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000427');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000424', 'Eliminación de archivo en bóveda', '2026-02-24 12:14:00', 'Por medio del presente solicito su apoyo para la eliminación de la factura con terminación *5007 del proveedor Aeroméxico (1064), con número de folio 865551, ya que me aparece duplicada en la bóveda.


De antemano gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-25 12:50:00', 'Se eliminaron los registros de CFDCONNECT.CFD_RECEPCION y CFD_CUSTOMDATA, y los archivos de la bóveda.', 'Modificación en BD', '2026-02-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000424');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000428', 'Eliminación de archivo en bóveda', '2026-02-24 13:43:00', 'Por medio del presente solicito su apoyo para la eliminación de la factura con terminación *9902 del proveedor Aeroméxico (1064), con número de folio 86559, ya que me aparece duplicada en la bóveda.


Gracias de antemano,',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-25 12:52:00', 'Se eliminaron los registros de CFDCONNECT.CFD_RECEPCION y CFD_CUSTOMDATA, y los archivos de la bóveda.', 'Modificación en BD', '2026-02-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000428');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000439', 'APOYO CON FOLIO UUID NO VISUALIZADO EN LA VENTANA DE COMPLEMENTOS', '2026-02-25 16:55:00', 'Hola buena tarde Equipo de sistemas-
Me apoyan, identifiqué que en SIIP contratos no se visualiza el folio fiscal (UUID).
Sin embargo, en mediport si se ve timbrado.
Quedo de su amable apoyo para que en SIIP se logre visualizar el UUID.
Cliente: QUALITAS COMPAÑIA DE SEGUROS S.A. DE C.V.
Folios SIIP: 2476
gracias',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-26 15:55:00', 'En FACTURACION.COMPLEMENTOS_PAGO se modificaron los campos IMPRESA ,FOLIO_COMP_TIMBRADO y UUID_COMPLEMENTO', 'Modificación en BD', '2026-02-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000439');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000441', 'CAMBIO DE PARTIDA PRESUPUESTAL', '2026-02-26 09:56:00', 'Buenos días estimados.
Se solicita de su amable apoyo para poder realizar el cambio de partida presupuestal de la requisición 133438
Dice: Partida 33604
Debe decir: Partida 38401
Se adjunta imagen para pronta referencia, tanto en el sistema como en su impresión.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-26 13:56:00', 'En INVENTARIO.REQUISICIONES se modificaron los campos de PARTIDA = ''38401'' y ID_MOVS = ''117'' a PARTIDA = ''33604'' y ID_MOVS = ''137''', 'Modificación en BD', '2026-02-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000441');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000451', 'Cambio de estado en estimaciones en sistema Integral', '2026-02-26 17:17:00', 'Buenas tardes,
Por este medio se solicita su valioso apoyo  referente al Contratista JESUS HITLER DE LOS SANTOS PERALTA con número de Contrato ASPN-GI-CS-62601-012-25 en el Sistema Integral dentro del Menú Ingeniería, submenú Estimaciones, a fin de cambiar el estado de "Terminada" por el estado "Abierta" de las Estimaciones 1N, 2N y 3N.
Agradeciendo de antemano sus finas atenciones, reciba un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-27 12:17:00', 'Seguimiento de proceso, se comento al usuario el flujo para poder abrir estimaciones y el problema actual en el contrato especifico', 'Seguimiento de proceso', '2026-02-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000451');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000437', 'MODIFICACION DE PAGO', '2026-02-25 14:18:00', 'BUENAS TARDES, SOLICITO SU APOYO CON LA MODIFICACION DE LA FECHA DE LIBERACION DEL PAGO 84914, YA QUE ESTE CUENTA CON FECHA DE LIBERACION DE 25/02/2026 SIENDO LA FECHA CORRECTA 27/02/2026,',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-03 11:08:00', 'Seguimiento de proceso, se corrigio el problema presentado en la fecha', 'Seguimiento de proceso', '2026-03-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000437');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000461', 'CAMBIO FECHA DE REQUISICION', '2026-03-02 12:58:00', 'Buenos días estimados,
Les solicito su ayuda para modificar la fecha recepción de la requisición: 133423.
Dice:
F. Recepción: 27/02/2026.
Debe decir:
F. Recepción: 24/02/2026
Saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gómez Hernández, Carlos Ignacio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-03 15:16:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-03-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000461');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000469', 'CAMBIO DE FACTURA EN MEDIPOR Y SIIP', '2026-03-03 09:27:00', 'Buen día,,

Por medio del presente, solicito de su amable apoyo para realizar el cambio de factura en MEDIPORT y SIIP del folio 86546 de fecha 23/02/2026 del contrato 36598.

Lo anterior, a fin de dar cumplimiento a lo solicitado por el área de finanzas 

Agradezco de antemano el apoyo 

Saludos!',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-03 17:27:00', 'Se reemplazó el archivo de la bóveda.', 'Modificación en BD', '2026-03-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000469');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000475', 'Carga de complementos de pago', '2026-03-03 11:55:00', 'Por medio de la presente solicito su apoyo para la carga de complementos de pago del proveedor CFE (45) ya que presenta el siguiente error: 
Comparto los archivos para su verificación.
Gracias de antemano.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-04 11:18:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000475');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000479', 'carga de complemento de pago', '2026-03-03 13:12:00', 'Buenas tardes
Por favor su apoyo con la carga del complemento de pago adjunto lo anterior debido a que se refleja una diferencia entre lo pagado y el complemento, siendo el total correcto.
- Se adjunta pdf y xml
De antemano agradezco la atención, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-04 09:12:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000479');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000478', 'Actualización de Programa de Inversión en el sistema Integral', '2026-03-03 13:07:00', 'Buenas tardes
Por este medio se solicita amablemente el cambio  en el Sistema Integral del Programa de Inversión "2513J3E0001" vigente en el ejercicio 2025 al  "2613J3E0001" actualmente vigente.
Agradeciendo de antemano sus atenciones.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-04 09:07:00', 'Se modifico el campo CLAVEPI en OBRAS.CNTOVIGENTES y en OBRAS.DISTRCONTRATOS', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000478');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000487', 'USUARIO SIIPV2.', '2026-03-04 09:41:00', 'Estimados
Por medio de la presente, solicito de la manera más atenta su apoyo para gestionar el acceso y la configuración de privilegios en el sistema sippv2 para mi auxiliar a cargo, la Lic. Diana Isabel Morales Tronco.
Con el objetivo de que pueda desempeñar sus funciones de manera óptima, requiero que se le otorguen exactamente los mismos permisos y niveles de acceso que tiene actualmente mi otro auxiliar, el Lic. Luis Fernando Monroy León. Específicamente, es necesario que la Lic. Diana cuente con facultades para ingresar y operar en los apartados de manifiestos, control de carga, especiales y catálogos, entre otros.
Para facilitar la configuración y servir como referencia directa de los módulos requeridos, adjunto a este correo una captura de pantalla con el detalle de los accesos actuales. Quedo a su entera disposición en caso de que se requiera alguna validación adicional para completar este proceso.
Agradezco de ante mano su atención y apoyo.
Atentamente,
P.D.
Correo del usuario en cuestión: secoperaciones@puertodeveracruz.com.mx
Atentamente
Soporte Técnico',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes'),
  (select id from solicitantes_mesa where nombre = 'Flores Bretón, Daniel José'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-04 13:41:00', 'Se copiaron los privilegios del usuario auxcontrol3 al usuario secoperaciones.', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000487');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000468', 'CAMBIO DE FECHA EN REQUISICIÓN EN INV. DE MERCADO', '2026-03-02 18:23:00', 'Buena tarde, se solicita apoyo para realizar el cambio de fecha en la req. 133465 e Inv. de mercado 10674, la nueva fecha de ambas sería del 27/02/2026.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'de la Cruz Castillo, Alejandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-04 17:03:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES y en INVENTARIO.INVMERCADO.', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000468');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000466', 'cambio de fecha a requisicion', '2026-03-02 16:17:00', 'Buen día, favor de apoyarme si se puede en calidad de urgencia a modificar una fecha de requisición de numero 133457 a la fecha diga 24/febrero 2026, de igual manera la investigación de mercado con numero 10668 sea igual la fecha 24/02/2026, ambas llevan como rubro la adquisición de bocadillos para la Reunión de subcomité de seguridad e higiene de la asipona ver.

saludos y gracias.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Vega Martínez, Cristian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-05 10:03:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES y en INVENTARIO.INVMERCADO.', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000466');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000485', 'CAMBIO DE FECHA EN PEDIDO', '2026-03-03 17:05:00', 'Buenas tardes

Solicito de su amable apoyo para realizar el cambio de fecha en el pedido 37243 de fecha 03 de marzo de 2026.

La fecha correcta debe ser 27 de febrero de 2026.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Vega Martínez, Cristian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-05 10:03:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES y en INVENTARIO.INVMERCADO.', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000485');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000486', 'Cambio de estado en pedido', '2026-03-03 17:12:00', 'Buenas tardes

Solicito de su amable apoyo para realizar el cambio de fecha en el pedido 37243 de fecha 03 de marzo de 2026.

La fecha correcta debe ser 27 de febrero de 2026.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-04 17:06:00', 'Se revirtió el ESTADO a 1 en INVENTARIO.PEDIDOS y se quitó el valor en USERNAME_AUTORIZO y FECHA_AUTORIZO.', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000486');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000477', 'CAMBIO DE FECHA DE REQUISICIÓN', '2026-03-03 12:29:00', 'Buenas tardes, 
Solicito su amable apoyo con el cambio de fecha de la requisición 133456 y su Investigación de Mercado 10667. Favor de colocarles la siguiente fecha: 24/02/2026. 
Agradezco de antemano su apoyo. 
Saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cuervo Bermudez, Darian Alexa'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-05 09:52:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES y en INVENTARIO.INVMERCADO.', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000477');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000491', 'SOLICITUD DE CAMBIO DE FECHA EN REQUISICIÓN Y IM', '2026-03-04 12:15:00', 'Buenas tardes estimados 
Por medio del presente solicito de su apoyo para realiza el cambio de fecha de la requisición no. 133446, al igual que en la Investigación de Mercado no. 010657. 
Siendo la nueva fecha el día 27/02/2026
De antemano agradezco el apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-04 17:15:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES y en INVENTARIO.INVMERCADO.', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000491');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000490', 'Apoyo modificación de comprobación de viáticos', '2026-03-04 11:48:00', 'Buenas tardes estimados 
Por medio del presente solicito de su apoyo para realiza el cambio de fecha de la requisición no. 133446, al igual que en la Investigación de Mercado no. 010657. 
Siendo la nueva fecha el día 27/02/2026
De antemano agradezco el apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-04 16:48:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION e INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-03-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000490');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000494', 'ESTIMACIONES', '2026-03-04 16:17:00', 'Relativo al contrato ASPN-GI-CO-62602-005-25, No me puedo visualizar la estimacion 5N para supervisar',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Rosas Toledano, Edgar Omar'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-05 13:17:00', 'Seguimiento de proceso, el usuario indico que ya no presenta el problema con las estimaciones', 'Seguimiento de proceso', '2026-03-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000494');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000497', 'AGREGAR REQUISITOS EN SOLICITUD DEL SIRE', '2026-03-05 09:49:00', 'Buenos días, Por este medio solicito su amable apoyo para agregar algunos requisitos en la solicitud del prestador TRANSMODAL, S.A. DE C.V. en la plataforma SIRE, los cuales se detallan a continuación:
1) Página web empresarial
2) Fotografía representante legal

Sin otro particular, agradezco su amable apoyo y aprovecho a enviar un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-05 16:49:00', 'Se agregaron los requisitos en EDIV2.CONTRATOS_SOLICITUD_DETALLE y CONTRATOS_SOLICITUD_FLUJO.', 'Modificación en BD', '2026-03-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000497');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000500', 'ABRIR SOLICITUD DE JUSTIFICACIÓN DE INCIDENCIAS SOLICITUD: 16071', '2026-03-05 12:00:00', 'Buenas tardes estimados,

por medio del presentes se solicita su apoyo para abrir o en su caso eliminar la solicitud de justificación de incidencias con solicitud 16071, lo anterior a que se modificará la información capturada.

De antemano gracias.

Saludos,',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Illescas Guevara, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-06 10:00:00', 'Se eliminaron los registros de EDIV2.DOCUMENTO, FLUJODOCUMENTO, INCIDENCIAS, JUSTIFICA_INCIDENCIA y JUSTIFICA_INCIDENCIA_DETALLE.', 'Modificación en BD', '2026-03-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000500');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000470', 'Error en la carga de nota de credito', '2026-03-03 10:36:00', 'Buenos días
Por medio de la presente, solicito su apoyo con el siguiente error que se refleja al validar la nota de crédito del contrato con No. de solicitud 403, ya que este mes se registra una penalización de la cual no se están reflejando el calculo de las retenciones aplicables.
Quedo a la espera de sus comentarios, saludos cordiales
CARGA DE FACTURA',
  (select id from ventanas_mesa where nombre = 'DETALLE DE PAGOS DEL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-04 11:16:00', 'En INVENTARIO.FOLIO_FACTURA se modificaron los campos RETENIDO = ''15'', IMPUESTO_RETENIDO = ''224'', RETENIDO1 = ''3'', IMPUESTO_RETENIDO1 = ''210'', MONTOFACTURA = ''2002'' asi como se ajusto el reporte cprresercont.rdf', 'Modificación en BD', '2026-03-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000470');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000495', 'MODIFICACION EN REQUISICION TABLERO PRESUPUESTAL', '2026-03-04 17:56:00', 'Buenas tardes,
Derivado a la actualización de datos en la requisición 133456 se solicita RETIRAR LA AUTORIZACIÓN PRESUPUESTAL de dicha requisición con el fin de poder realizar las modificaciones correspondientes por parte del área requirente y posterior a esto pueda ser visualizada nuevamente por parte de la Jefatura de Presupuesto y Contabilidad para su validación.
De ante mano muchas gracias.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-06 16:10:00', 'En INVENTARIO.REQUISICIONES se modifico el campo APRUEBA_CONTA de 1 a 0', 'Modificación en BD', '2026-03-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000495');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000506', 'Actualización de Fianza de Cumplimiento en Integral', '2026-03-05 18:05:00', 'Buenas tardes,
Por este medio se solicita amablemente la actualización de la fianza de cumplimiento del Contrato ASPN-GI-CO-62601-009-25 del contratista INMOBILIARIA Y CONSTRUCTORA CATOR S.A. DE C.V., para lo cual se adjunta la carátula de la misma.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-06 17:00:00', 'En OBRAS.CNTOVIGENTES se modifico el campo FIANZACUMPLIMIENTONUM y el campo FIANZACUMPLIMIENTOIMPORTE', 'Modificación en BD', '2026-03-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000506');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000311', 'FOLIO EN MODULO DE LICITACIONES QUE NO TIENE CONFIGURADO RAAP', '2026-02-09 18:42:00', 'Buenas tardes, 
Por medio del presente derivado de la reunión que tuvo verificativo el día de hoy en la oficina de la Jefatura del Departamento de Recursos Materiales, se comparte el folio No. 458 del contrato que no tiene configurado el RAAP de acuerdo al modulo de licitaciones en el centro de costos 996 partida presupuestal 32303.',
  (select id from ventanas_mesa where nombre = 'ESTADO DE SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-02-10 13:00:00', 'Seguimiento de proceso, se le indico al usuario el nuevo procedimiento a seguir para el manejo de partidas presupuestales', 'Seguimiento de proceso', '2026-03-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000311');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000504', 'Modificación de Memorandum en Integral', '2026-03-05 15:57:00', 'Buenas tardes
Por este medio se informa que el Memorándum de Anticipo se genera con las iniciales del Jefe de Departamento de Concursos y Contratos anterior (AHA) por lo que se solicita la actualización con las iniciales de un servidor (SRC).
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-06 10:57:00', 'Seguimiento de proceso, se modifico la etiqueta B_7 en el reporte rpsolcontratomemo', 'Seguimiento de proceso', '2026-03-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000504');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000511', 'Borrar solicitud de Convenio', '2026-03-06 15:12:00', 'Buenas tardes
Por este medio se envía pantalla de "solicitud de convenio que no afecta el monto" erróneo en Integral, misma que no puedo borrar por el Estado de Convenio "2. Finanzas" como a continuación se detalla: ASPN-GI-CO-62602-002-25',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-09 09:12:00', 'En OBRAS.VERSIONESCONTRATO se modifcaron los campos ESTADOCONV = 0, USUARIOTRAMITA = '''', FECHATRAMITA = NULL, USUARIOFINANZAS = '''', FECHAFINANZAS = NULL', 'Modificación en BD', '2026-03-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000511');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000515', 'Quitar retención en Carátula de Contrato en Anticipo', '2026-03-06 17:36:00', 'Buenas tardes 
Por este medio se solicita amablemente que quiten una retención que apareció automáticamente en la Carátula del Anticipo 2026 (marcada con amarillo) del contrato  ASPN-GI-CO-62601-009-25 del contratista INMOBILIARIA Y CONSTRUCTORA CATOR S.A. DE C.V., toda vez que no aplica,  a continuación se muestra una imagen de la carátula:',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-09 14:36:00', 'Seguimiento de proceso, se modifico la unidad de programa CF_ANTICIPO para pasar vPorcResico de 1 a 0 en rpsolcontratocaratula', 'Seguimiento de proceso', '2026-03-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000515');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000513', 'SOLICITUD CAMBIO DE FECHA.', '2026-03-06 18:02:00', 'Buena tarde, por medio del presente solicito su apoyo para cambio de fecha de la orden 37251 con proveed. servicios asociados layun al 18/02/2026.

Gracias. Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-10 11:59:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDOS', 'Modificación en BD', '2026-03-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000513');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000522', 'NOTIFICACION DE NO TIMBRADO', '2026-03-09 16:10:00', 'Buena tarde
Agradecemos el apoyo con el timbrado de la nota de egreso 18576 folio 15688
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-10 15:10:00', 'En FACTURACION.VTNOTASCREDITO se modifico el campo MONTO asi como en FACTURACION.FACTURAS_TIMBRADOR se regreso el campo TIMBRADO a 0', 'Modificación en BD', '2026-03-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000522');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000505', 'error al subir factura', '2026-03-05 16:41:00', 'Solicito el apoyo para verificar el tema, ya que no Le permite cargar la factura en el sistema MEDIPORT a la contratista

Adjunto imagen',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Martínez Pardo, Missael Abraham'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-06 13:41:00', 'Se comparó el UUID_RELACION en INVENTARIO.FOLIO_FACTURA con el FOLIO RELACIONADO de la FACTURA emitada por la empresa externa. Se identificó que la estaban relacionando a una factura perteneciente a otro contrato (ya finalizado) de la misma empresa. Se solicitó volver a timbrar con la relación al folio fiscal correcto, y ya el usuario pudo cargar correctamente.', 'Seguimiento de proceso', '2026-03-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000505');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000525', 'CAMBIO DIRECTA CON CONTRATO', '2026-03-09 17:48:00', 'Buenas tardes 
Por este medio solicito de su apoyo para el cambio en tipo de Adjudicación del pedido no. 37247, mismo que debe decir Directa Contrato. Cabe mencionar que dicho pedido, ya se encuentra en estado ABIERTO 
Cualquier duda o comentario, quedo a su disposición 
Saludos Cordiales .',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-10 17:00:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1', 'Modificación en BD', '2026-03-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000525');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000529', 'Cambio de estado en pedido', '2026-03-10 09:19:00', 'Por medio del presente solicito su apoyo para que reviertan el pedido No.37257 a estado de trámite, ya que no se generó ninguna póliza y no me permite hacer ningún cambio.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-10 16:19:00', 'En INVENTARIO.PEDIDOS se modificaron los estados ESTADO de 2 a 1, FECHAAUTOR05 = NULL, USERNAME_AUTORIZO05 = ''''', 'Modificación en BD', '2026-03-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000529');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000523', 'Facturas Medi-Port CTO. ASPN-GI-CO-62602-011-25', '2026-03-09 16:47:00', 'A quien corresponda: 
Buenas tardes, por medio del presente solicito su apoyo para dar captura de facturas en el sistema medi-port por parte de la contratista, ya que argumentan no poder seguir con el tramite de su estimación 1N.
Referente a contrato No.  ASPN-GI-CO-62602-011-25, del rubro: " SERVICIO DE LIMPIEZA Y DESAZOLVE DE RED PLUVIAL, SANITARIA, FOSAS SÉPTICAS Y BIODIGESTORES EN EL INTERIOR DEL PUERTO Y ÁREAS DE TERRENOS GANADOS AL MAR EN EL PUERTO DE VERACRUZ".  Contratista:  SERVICIOS ECOLÓGICOS DE VERACRUZ, S.C. DE R.L. DE C.V.
Anexo Captura de pantalla, del proceso en el cual no lograron avanzar',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Anell Ortiz, Enrique'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-10 16:47:00', 'Seguimiento de proceso, se indico al usuario como realizar el tramite de la estimacion', 'Seguimiento de proceso', '2026-03-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000523');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000532', 'DECIMALES EN LA ESTIMACIÓN', '2026-03-10 12:43:00', 'Buenas tardes,
En referencia al contrato ASPN-GI-CS-62601-021-25 en la estimación 1-N...
Solicito de su apoyo con el habilitado de mas decimales en el área de "Estimado" ya que por concepto de pago la estimación es de $692,552.69, y en el sistema al no dejar ingresar los decimales que se necesitan arroja la estimación de $692,552.42, teniendo una diferencia de 0.27 centavos
Gracias anexo captura',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Hernández Cornejo, Angelli'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-11 11:43:00', 'Seguimiento de proceso, se indico al usuario como realizar el tramite de la estimacion', 'Seguimiento de proceso', '2026-03-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000532');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000534', 'ABRIR CONVENIO', '2026-03-10 14:41:00', 'Buenas tardes,
Solicito de su apoyo para que me puedan "Abrir" el procedimiento de Modificaciones Al Contrato del contrato No. ASPN-GI-CS-62903-001-24, convenio número 1, ya que la captura del convenio antes de comprometer el saldo restante del contrato original en 2026 y marca error al área de finanzas, por lo cual me solicitaron recapturar pero al querer borrar la solicitud me aparece el siguiente mensaje',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Cornejo, Angelli'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-11 12:00:00', 'En OBRAS.VERSIONESCONTRATO se modifcaron los campos ESTADOCONV = 0, USUARIOTRAMITA = '''', FECHATRAMITA = NULL, USUARIOFINANZAS = '''', FECHAFINANZAS = NULL', 'Modificación en BD', '2026-03-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000534');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000541', 'El incremento del contrato no se visualiza', '2026-03-11 12:19:00', 'Buenos días estimado

Por este medio se informa que al guardar la Solicitud de convenio por monto y fecha por concepto fuera del catálogo, tal como se muestra a continuación el incremento de ".00", el concepto agregado es el de clave 1:   Contrato ASPN-GI-CS-62601-008-25',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-12 11:19:00', 'Se cambio el campo IMPORTETOTAL en OBRAS.SOLCNTOVIGENTES, asi como el campo IMPORTETOTALNUEVO en OBRAS.VERSIONESCONTRATO', 'Modificación en BD', '2026-03-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000541');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000544', 'permisos de viaticos', '2026-03-11 13:22:00', 'Se solicita los privilegios para realizar viáticos , esto debido a que s eme encomendó una comisión y necesito tramitar los viáticos correspondientes.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'González Cerezo, Cristina'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-12 11:22:00', 'Se dio de alta al usuario en módulo de viáticos.', 'Modificación en BD', '2026-03-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000544');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000542', 'Seguimiento incidencia INC 2026-000451', '2026-03-11 12:50:00', 'Buenos días 
Por este medio se solicita nuevamente el cambiar el Estado de "Tramitada" a "Abierta" de las estimaciones 1-N, 2N, 3NF ya que desde el ejercicio pasado el Contratista terminó sus trabajos y se encuentra en proceso de pago:',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-11 17:50:00', 'Se modifico el campo FECHAENTREGA en OBRAS.ESTIMACIONES', 'Modificación en BD', '2026-03-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000542');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000549', 'Adición de Fianza de Cumplimiento en Integral', '2026-03-12 09:57:00', 'Buenos días estimado 
Por este medio se solicita amablemente la adición de los datos de la Fianza de Cumplimiento en el Integral, en los Contratos ASPN-GI-CO-35101-001-25 de CONSTRUCTORA SACOSTA, S.A. DE C.V. y 
ASPN-GI-CO-62602-001-25 de OBRAS, PROYECTOS Y CONSTRUCCION DEL GOLFO, S.A. DE C.V., toda vez que al generar folio de Anticipo solo contempla la carga de la Fianza de Anticipos:
 Se adjuntan al presente las fianzas de cumplimiento de los contratos mencionados.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-06 17:00:00', 'En OBRAS.CNTOVIGENTES se modifico el campo FIANZACUMPLIMIENTONUM y el campo FIANZACUMPLIMIENTOIMPORTE para ambos contratos. Contrato  ASPN-GI-CO-62602-001-25--5202055.6  ---2352831   Contrato ASPN-GI-CO-35101-001--3471-35920-8        --1938793.3', 'Modificación en BD', '2026-03-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000549');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000536', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 133476 E INVESTIGACIÓN DE MERCADO 10684.', '2026-03-10 17:32:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 133476.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 10/03/2026
F. REQUIERE: 10/03/2026
F. RECEPCIÓN: 10/03/2026
DEBE DECIR: 29/12/2025
Asimismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10684, dentro del apartado "Investigación de Mercado", ya que emana de la Requisición antes descrita.
La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 10/03/2026
DEBE DECIR: 26/12/2025
También se solicita se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10684, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA ACT: 10/03/2026
DEBE DECIR: 26/12/2025
FECHA COTIZACIÓN: 10/03/2026
DEBE DECIR: 24/12/2025
Quedo atenta a cualquier duda o comentario al respecto.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-11 12:32:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICION, INVESTIGACIONMERCADO, PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-03-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000536');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000556', 'Apoyo en el sistema integral', '2026-03-12 12:43:00', 'Buena tarde
Solicitando el apoyo para poder hacer la transferencia de los conceptos correspondientes, ya que estos a la hora de cargar en sistema integral aparecen en el apartado de conceptos de convenio y es necesario que los conceptos que abajo describo en el apartado normal
alb-03 / SUMINISTRO  Y  COLOCACIÓN DE  PINTURA  IMPERMEABLE  ELASTOMÉRICA, EN  COLOR INSTITUCIONAL,  COMO IMPERMEABILZANTE EN MURO  CON  ACABADO  RUGOSO.  A  2 MANOS. LA PRIMERA MANO A MODO DE SELLADOR CON 4 PARTES DE  AGUA  POR  1  DE  PINTURA,  LA  SEGUNDA  MANO  SOLAMENTE PINTURA.  CONSULTAR  FICHA  TÉCNICA  DEL  PRODUCTO.  INCLUYE: RASPADO DE PINTURA ANTERIOR, TRABAJOS A NIVEL DE PISO, MANO DE   OBRA,   EQUIPO  Y  HERRAMIENTA  LMPIEZA,  EQUIPO  DE PROTECCIÓN  PERSONAL  Y  TODO  LO  NECESARIO  PARA  SU  CORRECTA EJECUCIÓN, (P.U.O.T.).
rej-04 / SUMINISTRO Y COLOCACIÓN  DE CABLE DE ACERO INOXIDABLE  CAL, 3/16"A  3  HILOS,  CONSIDERANDO  LAS  GRAPAS  NECESARIAS  PARA TENSAR  EL  CABLE  QUE  RECIBIRÁ  LA  CONCERTINA.  EL  MATERIAL ESTARA   BAJO   RESGUARDO   EN   EL   ESPACIO   QUE   ASIPONA DESIGNE.  INCLUYE:  SUMINISTROS  DE  MATERIAL,  ACARREO  DESDE SITIO  DE  RESGUARDO,  MANIOBRAS,  TRABAJOS  A  MÁXIMO  12 METROS  DE  ALTURA,  ANDAMIOS,  MANO  DE  OBRA,  EQUIPO  Y HERRAMIENTA,   CARGA,   LIMPIEZA,   EQUIPO   DE   PROTECCIÓN PERSONAL  Y  TODO  LO  NECESARIO  PARA  SU  CORRECTA  EJECUCIÓN, (P.U.O.T.).
rej-05 / SUMINISTRO Y COLOCACIÓN DE CONCERTINA DE ACERO INOXIDABLE DE 0.45 METROS DE DIÁMETRO,  NAVAJA LARGA EFECTO ANZUELO DE  8  PUNTAS.  EL  MATERIAL  ESTARA  BAJO  RESGUARDO  EN  EL ESPACIO  QUE  ASIPONA  DESIGNE.  INCLUYE  SUMINISTROS  DE MATERIAL,  ACARREO  DESDE  SITIO  DE  RESGUARDO,  MANIOBRAS, TRABAJOS A MÁXIMO 12 METROS DE ALTURA, ANDAMIOS, MANO DE OBRA, EQUIPO Y HERRAMIENTA, CARGA, IIMPIEZA, EQUIPO DE PROTECCIÓN  PERSONAL  Y  TODO  LO  NECESARIO  PARA  SU  CORRECTA EJECUCIÓN, (P.U.O.T.)
1 F.C. / EMBOQUILLADO EN MUROS DE 3 CM.DE ESPESOR CON MORTERO CEMENTO-ARENA, PROP. 1:4. INCLUYE: ACABADO CEPILLADO. CURADO Y DESPERDICIOS, TRABAJOS A MAXIMO 2 METROS DE ALTURA, ANDAMIO, MANO DE OBRA, EQUIPO Y HERRAMIENTA, CARGA, IIMPIEZA, EQUIPO DE PROTECCIÓN PERSONAL Y TODO LO NECESARIO PARA SU CORRECTA EJECUCION, (P.U.O.T.).
Quedo al pendiente de su apoyo',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Molina Hernández, Javier Alexis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-13 10:43:00', 'En OBRAS.CPTOSCONTRATADOS se cambiaron los conceptos indicados de C a N', 'Modificación en BD', '2026-03-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000556');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000546', 'Carga de complementos de pago', '2026-03-11 18:20:00', 'Por medio del presente solicito su apoyo para la carga de complementos de pago del proveedor CFE (45) ya que me presenta el siguiente error:
Asimismo, adjunto los complementos para su revisión.
Gracias de antemano y quedo en espera de su amable respuesta.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-13 12:06:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-03-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000546');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000484', 'error en la cantidad de salida - movimientos de almacén', '2026-03-03 16:52:00', 'Buenas tardes
En relación al movimiento de almacén 38068, solicito su apoyo con la partida 2 combustible gasolina ya que refleja tres requisiciones siendo la correcta la 133396 y siendo la cantidad correcta 4671.19, contrario a la que aparece en la salida.
Quedo a la espera de sus comentarios, saludos cordiales',
  (select id from ventanas_mesa where nombre = 'INFORME DE SALIDA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Movimientos de Almacen'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-04 16:48:00', 'En INVENTARIO.DETMOVALMS se cambio el valor del campo 36737.6 a 4671.19 y en INVENTARIO.DETMOVALMSREQ se modifico el registro con el id 133396 de 14829.05 a 4671.19 en el campo cantidad y se eliminaron los registros sobrantes. --1        ALMGRAL        1        38068        2        003-001-006-003        132790        1        8033.47
--1        ALMGRAL        1        38068        2        003-001-006-003        133395        1        13875.08', 'Modificación en BD', '2026-03-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000484');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000568', 'Actualización de Fianza de Cumplimiento en Integral', '2026-03-13 18:07:00', 'Buenas tardes estimado
Por este medio se solicita amablemente la Actualización de las Fianzas de Cumplimiento (Adjuntas)  en el Sistema Integral de los siguientes contratos  ASPN-GI-CS-62903-003-25 del Contratista  TECNOLOGIA URBANA Y AMBIENTAL DE MEXICO, S.A. DE C.V. y el  ASPN-GI-CO-62602-010-25 del Contratista POLITO ROBLES LUCERO DEL CARMEN.
Agradeciendo de antemano, recibe un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-16 12:00:00', 'En OBRAS.CNTOVIGENTES se modifico el campo FIANZACUMPLIMIENTONUM y el campo FIANZACUMPLIMIENTOIMPORTE para ambos contratos. Contrato  "--1325-28609-4        174005.69 --ASPN-GI-CS-62903-003-25
--2643182-0000        18933270.44 --ASPN-GI-CO-62602-010-25', 'Modificación en BD', '2026-03-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000568');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000574', 'BAJA DE SOLICITUD EN EL SIRE', '2026-03-17 10:38:00', 'BUEN DÍA 
SE SOLICITA SU AMABLE APOYO PARA DAR DE BAJA LA SOLICITUD A NOMBRE DE FRANCISCO JAVIER ROMERO SOTO QUE SE ENCUENTRA EN EL SIRE.
MUCHAS GRACIAS',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-18 09:38:00', 'Se cambió el ESTADO a 4 en EDIV2.CONTRATOS_SOLICITUD.', 'Modificación en BD', '2026-03-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000574');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000580', 'ERROR AUTORIZAR PAGOS', '2026-03-17 12:26:00', 'Buen dia,
solicito su apoyo ya que el sistema SIIP no esta permitiendo autorizar pagos arrojándonos el siguiente mensaje de error',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-18 11:26:00', 'Seguimiento de proceso, se verifico el estatus de las sesiones activas y se dieron de baja para desbloquear los recursos ocupados', 'Seguimiento de proceso', '2026-03-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000580');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000579', 'ACTUALIZACION DE CARGO PARA CARATULAS DE ESTIMACIONES', '2026-03-17 11:31:00', 'De la manera mas amable solicito la actualizacion del cargo del Ing. Oscar Hilario Morales Hernandez, mismo que actualmente esta registrado como "Coordinador de proyectos", dicho cargo se ha actualizado fungiendo ahora como "Encargado para atender los asuntos del la Jefatura del Departamento de Mantenimiento".
Sin otro particular quedo pendiente de la atención.
Saludos',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/Integral'),
  (select id from solicitantes_mesa where nombre = 'Rosas Toledano, Edgar Omar'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-17 16:31:00', 'Seguimiento de proceso, se cambio temporalmente el campo NOMBRE en NOMINA.PUESTOS de ''COORDINADOR DE PROYECTOS'' a ''ENCARGADO DE LA JEFATURA DE MANTENIMIENTO''', 'Seguimiento de proceso', '2026-03-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000579');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000573', 'SOLICITUD DE ACCESOS Y CREDENCIALES SISTEMA SIIPV // DEI 182459 // KARLA VICTORIA CANO VELEZQUEZ', '2026-03-17 10:15:00', 'DEPARTAMENTO DE INFORMATÍCA 
DEPARTAMENTO DE SOPORTE TÉCNICO
Estimados ingenieros, por medio del presente solicito su apoyo a fin de otorgar los permisos a la LIC. KARLA VICTORIA CANO VELEZQUEZ, NO DEI 182459 quien funcionalmente realizará funciones de auxiliar administrativo en suplencia de la L.C.F. ELISA MONTERO.
Dentro los acceso se solicita amablemente:
Acceso al SIIPV (compras) copiar perfil de ELISA.
Muchas gracias por el apoyo.
correo usuaria Karla: auxadmonrm
correo usuaria Elisa: auxadmonrm1
Atte. Soporte Técnico',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-17 15:15:00', 'Se dio de alta al usuario en CONTROL.USUARIOS y se proporcionaron credenciales de acceso mediante correo electrónico.', 'Modificación en BD', '2026-03-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000573');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000585', 'reasignacion de comprador en requisición 133456', '2026-03-17 15:24:00', 'Estimados ingenieros, su apoyo por favor con la reasignación de comprador como sigue:
Requisición 1335456 
Dice:
Comprador:45 ELISA MARGARITA MONTERO OTAL
Debe decir:
Comprador: 27 EIRA DANAÉ SARDIÑA AGUIRRE
Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-18 12:24:00', 'Se cambió el COMPRADOR de 45 a 27 en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-03-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000585');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000586', 'CAMBIO DE FECHA EN PEDIDO', '2026-03-17 15:40:00', 'Buenas tardes 
Por medio del presente, solicito de su amable apoyo para realizar el cambio de fecha en el pedido 37248 de fecha 06 de marzo de 2026.
La fecha correcta debe ser: 27 de febrero de 2026.
Agradezco de antemano el apoyo. 
Saludos!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-18 13:40:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-03-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000586');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000582', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 133476 E INVESTIGACIÓN DE MERCADO 10684', '2026-03-17 12:52:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 133476.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 29/12/2025
F. REQUIERE: 29/12/2025
F. RECEPCIÓN: 29/12/2025
DEBE DECIR: 17/03/2026
Asimismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10684, dentro del apartado "Investigación de Mercado", ya que emana de la Requisición antes descrita.
La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 26/12/2025
DEBE DECIR: 17/03/2026
También se solicita se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10684, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA ACT: 26/12/2025
DEBE DECIR: 17/03/2026
FECHA COTIZACIÓN: 24/12/2025
DEBE DECIR: 17/03/2026
Sin más por el momento, agradezco su apoyo de antemano.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-18 13:15:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES, INVESTIGACIONMERCADO y PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-03-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000582');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000589', 'REDONDEO DE POLIZA', '2026-03-17 17:10:00', 'Buena tarde, solicito su apoyo con la modificación del importe de la casilla "monto" colocando el monto "$7,325.00", el cual así mismo deberá verse reflejado en el modulo "Bancos"',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-18 15:33:00', 'En INVENTARIO.PAGOS se modifico el campo MONTO de 7324.81 a 7325, este mismo cambio se realizo en BANCOS.MOVIMIENTOS para el campo MOVMONTO y en CONTA.POLIZAS se ajustaron los montos para la poliza 91-3-C-2026 asi como en CONTA.MOVIMIENTOS se ajusto el monto de 7324.81 a 7325 para cargo y abono', 'Modificación en BD', '2026-03-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000589');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000593', 'Solicitud para habilitar en apartado de viáticos', '2026-03-17 18:59:00', 'Buenas tardes, Ingeniero

Por medio del presente, me permito solicitar de su amable apoyo, toda vez que una servidora estará comisionada para asistir al evento denominado EXPOMAR 2026, a realizarse del 23 al 27 de marzo del presente año.

No obstante, al tratarse de mi primera comisión, no cuento con el apartado correspondiente habilitado en el sistema. Por lo anterior, agradeceré su apoyo para realizar el trámite necesario a fin de que dicho apartado sea habilitado.

Quedo atenta a cualquier información adicional que se requiera.

Sin otro particular, le envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-18 13:00:00', 'Se dio de alta al usuario en módulo de viáticos.', 'Modificación en BD', '2026-03-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000593');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000537', 'Cambio de estado en pedido.', '2026-03-10 18:04:00', 'Por medio del presente solicito su apoyo para que reviertan el pedido No.37269 a estado de trámite, ya que no me permite hacer ningún cambio y me marca este error.
Quedo en espera de su atenta respuesta,',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-18 12:45:00', 'Se eliminó el registro de INVENTARIO.DETDISTRMONTOXCC para que pudiera volver a tramitar el pedido.', 'Modificación en BD', '2026-03-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000537');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000583', 'SUBIR COMPLEMENTOS DE PAGO', '2026-03-17 12:53:00', 'Buenas tardes por medio del presente pido el apoyo para poder subir los complementos de pago que enseguida se describen

Adjunto los archivos',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-18 16:34:00', 'Se hizo uso del candado ''des''.', 'Modificación en BD', '2026-03-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000583');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000563', 'CARGA EN PAPEL COMPLEMENTO DE PAGO', '2026-03-13 11:23:00', 'Buenas tardes 

Solicito de su amable apoyo para realizar la carga en papel del complemento de pago detallado a continuación:


Lo anterior derivado de que es un pago que se realizó en moneda extranjera (USD) 

Agradezco de antemano el apoyo 

Saludos!!',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-18 13:49:00', 'Se hizo uso del candado ''des''.', 'Modificación en BD', '2026-03-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000563');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000594', 'CAMBIO DE TIPO DE ADJUDICACIÓN EN PEDIDO', '2026-03-18 08:56:00', 'Buenos días 
Solicito de su amable apoyo para realizar el cambio de tipo de adjudicación en el pedido 37248 con tipo de adjudicación :Directa con pedido servicio/compra. 
Favor de realizar el cambio a Directa con Contrato. 
Agradezco de antemano el apoyo 
Saludos!!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-20 12:39:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1', 'Modificación en BD', '2026-03-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000594');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000596', 'SOLICITUD CAMBIO DE FECHA.', '2026-03-18 11:09:00', 'Buen día, por medio del presente solicito su apoyo para el cambio de fecha a 11/03/2026 del siguiente contrato 37292:',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-20 12:37:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS del 17/03/2026 a 11/03/2026.', 'Modificación en BD', '2026-03-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000596');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000616', 'cambio de fecha en requisición', '2026-03-19 13:09:00', 'BUENAS TARDES, 

AGRADEZCO SU AMABLE APOYO PARA REALIZAR EL CAMBIO DE TODAS LAS FECHAS EN LA REQUISICIÓN 133487 Y SU INVESTIGACIÓN DE MERCADO 10693 A LA FECHA 24/02/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-20 16:33:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO a 24/02/2026.', 'Modificación en BD', '2026-03-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000616');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000603', 'CAMBIO DE FECHA EN PEDIDO', '2026-03-18 13:06:00', 'Buenas tardes

Por medio del presente, solicito de de su amable apoyo para realizar el cambio de fecha en los pedidos 37297 y  37298, ambos de fecha 18 de marzo de 2026.

La fecha correcta para ambos pedidos es :27 de febrero de 2026.

Agradezco de antemano el apoyo 

Saludos!!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-20 15:47:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS a 27/02/2026.', 'Modificación en BD', '2026-03-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000603');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000592', 'cambio de fechas de requisicion', '2026-03-17 18:24:00', 'muy buena tarde por medio de la presente solicito me ayuden a hacer cambio de fecha de la requisición 133473 y de la investigación de mercado 10681 que todo quede con fecha de 09/03/2026.

de antemano muchas gracias. saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Serena Silván, Cinthya Araceli'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-20 12:36:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO a 09/03/2026.', 'Modificación en BD', '2026-03-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000592');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000620', 'CAMBIO DE FACTURA EN MEDIPOR Y SIIP', '2026-03-19 17:41:00', 'Buenas tardes

Solicito de su amable apoyo para sustituir la factura en bóveda del folio 86692, del proveedor POLISECOM. Lo anterior por solicitud de parte del área de finanzas. 


Agradezco de antemano el apoyo 

Saludos!!',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-23 10:03:00', 'Se realizó el cambio en los archivos de la bóveda.', 'Modificación en BD', '2026-03-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000620');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000621', 'Alta en Obras como Residente', '2026-03-20 10:49:00', 'Solicito apoyo para dar de alta en el SIIP como residente de obra, de los siguientes contratos:
ASPN-GI-CO-62602-002-25,  ASPN-GI-CO-62602-004-25,  ASPN-GI-CO-62602-010-25 y
ASPN-GI-CO-62602-011-25. 
Anexo captura de pantalla para su apoyo.',
  (select id from ventanas_mesa where nombre = 'PERSONAS AUTIRIZADAS PARA FIRMAR CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Anell Ortiz, Enrique'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-20 15:49:00', 'En OBRAS.USUARIOS se actualizo el registro para el usuario cmantenimiento2 y en OBRAS.FIRMAS_CONTRATO se modifico el campo RESOBRA a 69683 para los 4 contratos', 'Modificación en BD', '2026-03-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000621');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000610', 'Cambio de estado en pedido de servicios 37269', '2026-03-19 11:04:00', 'Buen día

Por medio de la presente solicito el cambio de estado del pedido 37269, actualmente esta en estado autorizado, se solicita se cambie a estado ABIERTO.


Así mismo se solicita, la apertura de la póliza presupuestal No. 58 generada al momento de la autorización.


Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-23 15:45:00', 'Se eliminó el registro de INVENTARIO.DETDISTRMONTOXCC para que pudiera volver a tramitar el pedido.', 'Modificación en BD', '2026-03-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000610');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000609', 'Cambio de estado en recepciones de material 40829 y 40831', '2026-03-19 10:50:00', 'Buen dia

Por medio de la presente, solicito su apoyo con el cambio de estado de los registros 40829 y 40831, en ek apartado de recepcion de materuiales.

Actualmente aparecen con estado parcialmente facturado, se solicita se cambie a estado ABIERTO.


Quedo a la espera de sus comentarios, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-23 16:22:00', 'Se cambió el ESTADO a 1 en INVENTARIO.EMBARQUES.', 'Modificación en BD', '2026-03-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000609');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000598', 'APOYO CON SISTEMA INTEGRAL', '2026-03-18 11:47:00', 'SOLICITO MESA DE AYUDA PARA IMPRIMIR EL ACTA Y LA CONSTANCIA DE FINIQUITO DEL CONTRATO NUMERO ASPN-GI-CO-62602-015-24 YA QUE AL MOMENTO DE OPRIMIR EL BOTON DONDE DICE IMPRIMIR ACTA E IMPRMIR CONSTANCIA SALE UNA LEYENDA MARCANDO ERROR.
SE ADJUNTA CAPTURA DE PANTALLA DEL ERROR
SIN MAS POR EL MOMENTO QUEDO ATENTO A CUALQUIER DUDA O COMENTARIO.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES PARA FINIQUITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Ronces Rodríguez, Elias Armando'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-19 09:47:00', 'Seguimiento de proceso, se indico al usuario que el encargado en el puesto de SUP_API en OBRAS.FIRMAS_CONTRATO provocaba el error pues se encontraba en estado ''B'' en NOMINA.EMPLEADOS', 'Seguimiento de proceso', '2026-03-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000598');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000600', 'acceso al SIIPV2', '2026-03-18 12:03:00', 'Buen dia, solicito su apoyo para habilitar el sistema V2 para el ingreso de las incidencias.
gracias.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Domínguez, Laura Irene'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-20 17:18:00', 'Se proporcionaron credenciales de acceso a SIIP mediante correo electrónico.', 'Modificación en BD', '2026-03-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000600');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000631', 'CAMBIO DE FECHA', '2026-03-23 11:58:00', 'Buenas tardes
Por medio del presente pido su apoyo para el cambio de fecha del siguiente pedido,
37308 a fecha 12/03/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-20 15:47:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS de 23/03/2026 a 12/03/2026.', 'Modificación en BD', '2026-03-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000631');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000627', 'CANCELACION DE UNA PARTIDA EN DETALLE DE COMPROBACION DE VIATICOS', '2026-03-23 09:46:00', 'Buen día equipo.

El motivo del correo es para cancelar un apartado o rubro en el modulo de detalle comprobación de viáticos, lo anterior para corregir el comprobante de factura. Marcada en color amarillo

Adjunto evidencia.

saludos',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-23 14:46:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-03-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000627');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000635', 'activar nuevamente', '2026-03-23 16:34:00', 'en el SIIP para realizar mi formato de incidencias de la primera quincena de marzo, se realizo pero se cambiara el contexto y no tengo el numero de incidencia  solo tengo el numero de solicitud 2594325   API-JI-230326-2593594

POR FAVOR DE  DEJARLA EN ABIERTA PARA PODER MODIFICARLA',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-24 16:34:00', 'Se eliminaron los registros de EDIV2.INCIDENCIA, DOCUMENTO, FLUJODOCUMENTO, JUSTIFICA_INCIDENCIA_DETALLE, JUSTIFICA_INCIDENCIA.', 'Modificación en BD', '2026-03-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000635');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000643', 'Autorizar la recepción de CFDIS', '2026-03-24 12:02:00', 'Hola buenas tardes

Por medio de la presente se solicita su apoyo para autorizar la factura en el apartado recepción de CFDI, lo anterior debido a que existe complementos de pago pendientes por el proveedor COMISIÓN FEDERAL DE ELECTRICIDAD, de los cuales estamos a la espera de su recepción.

86781, 86783, 86784,86785 y 86786.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-24 17:09:00', 'Se cambió temporalmente el ESTADO a 5 en INVENTARIO.FOLIO_COMPLEMENTOS.', 'Modificación en BD', '2026-03-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000643');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000630', 'Traslado de Monto al 2026', '2026-03-23 11:06:00', 'Buenos días
Por este medio se solicita amablemente su apoyo para  que  del contrato ASPN-GI-CS-62601-007-24 del Contratista CONSORCIO CONSTRUCTOR CORDOVA & GONZALEZ, S.A. DE C.V. se traslade al ejercicio 2026 el importe de 2023,
image.png
lo anterior para que todo el monto pendiente se encuentre en el ejercicio 2026.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'DISTRIBUCION DE MONTOS PRESUPUESTALES ANUALES DEL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-24 10:06:00', 'Se modifico en la tabla OBRAS.DISTRCONTRATOS para los registros 2024 y 2026 los campos MONTOPEND, IVAPEND y MONTOTOTAPEND', 'Modificación en BD', '2026-03-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000630');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000644', 'CAMBIAR ESTATUS, CANCELADO A ABIERTO || APARTADO INCIDENCIAS: Solicitud 16216', '2026-03-24 12:10:00', 'Hola buena tarde Equipo.
Me apoyan abriendo mi solicitud de incidencia número 16216. Ya que requiero hacer unas correcciones para su trámite de manera correcta.


Muy atenta, gracias de antemano





Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-24 17:10:00', 'Se eliminaron los registros de EDIV2.INCIDENCIA, DOCUMENTO, FLUJODOCUMENTO, JUSTIFICA_INCIDENCIA_DETALLE, JUSTIFICA_INCIDENCIA.', 'Modificación en BD', '2026-03-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000644');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000646', 'CANCELACION DE COMPLEMENTO DE PAGO.', '2026-03-24 13:19:00', 'Buenos días estimados a quien corresponda.

Agradeceríamos su amable en CANCELAR, el siguiente complemento de pago.

Numero consecutivo: 2499
Folio SIIP timbrado: 2497

Por favor, desvincular la factura para realizar el nuevo complemento de pago (y asignar la factura de nuevo).


Quedamos atentos a cualquier comentario.
Saludos cordiales..',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-24 17:10:00', 'Se cambió a 1 en CANCELADO y a 03 el MOTIVO_CANCELACION en CFDCONNECT.CFD_EMISION. Y se cambió a 4 el ESTADO en FACTURACION.COMPLEMENTOS_PAGO y en FACTURACION.DETCOMPLEMENTOS_PAGO se elimino el registro asociado', 'Modificación en BD', '2026-03-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000646');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000653', 'APOYO CON FOLIO UUID NO VISUALIZADO EN LA VENTANA DE COMPLEMENTOS.', '2026-03-24 16:02:00', 'Buenos días estimados a quien corresponda.

Agradeceríamos su amable en CANCELAR, el siguiente complemento de pago.

Numero consecutivo: 2499
Folio SIIP timbrado: 2497

Por favor, desvincular la factura para realizar el nuevo complemento de pago (y asignar la factura de nuevo).


Quedamos atentos a cualquier comentario.
Saludos cordiales..',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-25 11:02:00', 'Se cambió a 1 en IMPRESA, y se colocó el FOLIO_COMP_TIMBRADO y el UUID_COMPLEMENTO en FACTURACION.COMPLEMENTOS_PAGO', 'Modificación en BD', '2026-03-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000653');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000640', 'ERROR EN ACUMULADO - FERROSUR MES DE AGOSTO 2025', '2026-03-24 11:18:00', 'Hola buen día estimados.
Su amable apoyo con la revisión del registro en sistema PIS facturación, ya que no me arroja el acumulado correcto en el MUELLAJE FERROVIARIO. Vale la pena comentar que los registros aún no han sido timbrados. 
Sin embargo, agradeceremos sus comentarios ya que se esta presentando en el mes de registro -Agosto 2025- y aún debemos registrar septiembre, octubre y noviembre. El monto de unidades que debía aparecer es: 27,186.
Muy atenta y gracias de antemano.',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-24 16:18:00', 'Seguimiento de proceso, el usuario solicito la cancelacion de la mesa', 'Seguimiento de proceso', '2026-03-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000640');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000642', 'ERROR EN ACUMULADO y TARIFA - FERROSUR SEPTIEMBRE 2025 || Muellaje Ferroviario', '2026-03-24 12:01:00', 'Hola buena tarde estimados.
Agradeceremos su amable apoyo en revisar el acumulado y el subtotal marcado líneas abajo, ya que se esta realizando el cálculo incorrectamente, en la ventana de Facturación de Muellaje FFCC. 
Acumulado BN
Dice: 27,186 - Debe decir: 31,443
Subtotal por tarifa BN
Dice: $ 3,217,326.88 - Debe decir: $ 2,783,901.56 
Ejemplo: Septiembre Bahía Norte 5,196 ingresos
De como debe quedar el cálculo de la tarifa por rango de acuerdo a la cantidad de equipo ferroviario que ingreso al puerto.
Agradeceremos su amable apoyo en revisar el acumulado marcado líneas abajo, ya que se está realizando el cálculo incorrectamente.
Acumulado BS
Dice: 38,588 - Debe decir: 44,584
Haciendo hincapié que el cálculo de la tarifa se visualiza correcto.
Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-25 11:01:00', 'Se modifico el procedimiento en FACTURACION.PKG$PAGOMUELLAJEFFCC llamado FNCALCULO_MUEFERROVIARIO', 'Modificación en BD', '2026-03-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000642');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000614', 'ACTUALIZACION FORMATO RESGUARDO DE BIENES MUEBLES', '2026-03-19 12:01:00', 'Buenas tardes 
Solicito de su amable apoyo para ver si es viable la actualización del formato Resguardo de Bienes Muebles ASPN-VER-GAF-F-33, en la sección final del documento, para que al momento de hacer la consulta de impresión del formato si visualicen los siguientes nombres:
Elaboró: Juan Pedro Gutiérrez Uscanga -Coordinador de Bienes Muebles
Revisó: Luis Alberto Mora Utrera- Jefe de Departamento de Recursos Materiales
Recibió- Que aparezca el nombre del usuario que se consultó.',
  (select id from ventanas_mesa where nombre = 'ACTIVOS FIJOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Activo Fijo'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-20 11:01:00', 'Seguimiento de proceso, se modifico el reporte acrp_resg_consulta2 agregando campos de texto fijo y un campo variable F_4 con codigo nuevo para el nombre', 'Seguimiento de proceso', '2026-03-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000614');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000639', 'CAMBIO DIRECTA CONTRATO', '2026-03-24 11:09:00', 'Buenos días:
Por este medio solicito de su apoyo para el cambio de Adjudicación en los contratos: 37100, 37098, 37094 y 37250   los cual debe decir: DIRECTA CONTRATO.
Los cuales se encuentran en estado abierto para que puedan realizar las modificaciones solicitadas.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-25 12:09:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1 para todos los pedidos', 'Modificación en BD', '2026-03-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000639');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000624', 'CAMBIO DE TIPO DE ADJUDICACIÓN EN PEDIDO', '2026-03-20 16:05:00', 'Buenas tardes 

Por medio del presente, solicito de su amable apoyo para realizar el cambio de tipo de adjudicación en los pedidos 37297 y 37298 los cuales aparecen con la adjudicación: Directa con pedido Servicio/Compra


El tipo de adjudicación correcta debe ser : Directa con contrato. 

Agradezco de antemano el apoyo

Saludos!!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-25 12:09:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1 para todos los pedidos', 'Modificación en BD', '2026-03-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000624');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000660', 'NOTIFICACION DE NO TIMBRADO', '2026-03-25 10:56:00', 'Buen día
Agradecemos el apoyo con el timbrado de la nota de egreso 18584, folio 15694.
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-25 17:56:00', 'En FACTURACION.VTNOTASCREDITO se modifico el campo MONTO asi como en FACTURACION.FACTURAS_TIMBRADOR se regreso el campo TIMBRADO a 0', 'Modificación en BD', '2026-03-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000660');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000623', 'DUPLICIDAD DE IVA POR PAGAR NO COBRADO EN POLIZA DE INGRESO 17/03/2026', '2026-03-20 11:02:00', 'Buenos dias estimados,
se solicita su apoyo con la poliza de ingresos por facturacion del dia 17/03/2026,
ya que se considera un monto por $52,721.52 y el monto correcto es $28,468.31, del N° Cuenta 211731911000002  IVA X PAGAR NO COBRADO
Dicho IVA, pertenece a las cuentas por cobrar pagadas y se identificó que el iva esta siendo duplicado en la factura 983631 de KANSAS CITY SOUTHERN DE MÉXICO. 
Quedo atento a sus comentarios y/o dudas al respecto.',
  (select id from ventanas_mesa where nombre = 'EXPORTACION DE POLIZAS A CONTABILIDAD'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Illescas Guevara, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-26 10:30:00', 'En FACTURACION.MOVIMIENTOS se modifica el campo MOVMONTO y en FACTURACION.POLIZAS se modifico el campo POLIZAMONTOCARGOS para la poliza (1073 - 3 - ''I'' - 2026)', 'Modificación en BD', '2026-03-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000623');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000622', 'DUPLICIDAD DE IVA POR PAGAR NO COBRADO EN POLIZA DE INGRESO 17/03/2026', '2026-03-20 10:57:00', 'Buenos dias estimados,
se solicita su apoyo con la poliza de ingresos por facturacion del dia 17/03/2026,
ya que se considera un monto por $52,721.52 y el monto correcto es $28,468.31, del N° Cuenta 211731911000002  IVA X PAGAR NO COBRADO
Dicho IVA, pertenece a las cuentas por cobrar pagadas y se identificó que el iva esta siendo duplicado en la factura 983631 de KANSAS CITY SOUTHERN DE MÉXICO. 
Quedo atento a sus comentarios y/o dudas al respecto.',
  (select id from ventanas_mesa where nombre = 'EXPORTACION DE POLIZAS A CONTABILIDAD'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Illescas Guevara, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-26 10:25:00', 'Seguimiento de proceso, incidencia duplicada', 'Seguimiento de proceso', '2026-03-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000622');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000664', 'ACTUALIZACIÓN DE TASA DE RECARGOS EN SIIP FACTURACIÓN', '2026-03-25 12:53:00', 'Buenas tardes
El presente es para solicitar su apoyo para la actualización de la tasa de interés en sistema SIIP FACTURACIÓN.
La tasa de 1.47% Se sustituye por 2.07% que será la actual conforme con la RESOLUCIÓN MISCELÁNEA FISCAL PARA 2026.',
  (select id from ventanas_mesa where nombre = 'FACTURACION X MUELLAJE DE MERCANCIA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Serrano Berriozabal, Jose Luis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-26 11:53:00', 'En FACTURACION.TARIFAS se modifico el campo PORCINTERES01 de 1.47 a 2.07', 'Modificación en BD', '2026-03-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000664');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000667', 'Corrección de cantidades - Estimacion Contratista', '2026-03-25 18:27:00', 'Se solicita de su apoyo para corregir cantidades en la carátula de la estimación 08N, del contrato No.  ASPN-GI-CO-62602-004-25, de rubro:  MANTENIMIENTO DE ALMACENES Y CASETAS DEL PUERTO DE VERACRUZ, que realiza la contratista: EDIFICACIONES CARRETERAS Y PUERTOS MX, S.A. DE C.V.
El importe acumulado de la estimación 7 más el importe ejecutado de la estimación 8, presenta una diferencia menor al calculo realizado en el concentrado. Por lo que se solicita de su apoyo para corregir el calculo en el sistema Integral.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Anell Ortiz, Enrique'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-26 16:00:00', 'En OBRAS.ESTIMACIONES se modifico en el campo IMPORTE_EJECUTADO para la estimacion 8 de 21498888.11 a 21755870.48', 'Modificación en BD', '2026-03-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000667');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000663', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 133496 E INVESTIGACIÓN DE MERCADO 10700.', '2026-03-25 12:21:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 133496.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 25/03/2026
F. REQUIERE: 25/03/2026
F. RECEPCIÓN: 25/03/2026
DEBE DECIR: 20/03/2026
Asimismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10700, dentro del apartado "Investigación de Mercado", ya que emana de la Requisición antes descrita.
La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 25/03/2026
DEBE DECIR: 20/03/2026
También se solicita se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10700, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA ACT: 25/03/2026
DEBE DECIR: 20/03/2026
FECHA COTIZACIÓN: 25/03/2026
DEBE DECIR: 19/03/2026
Sin otro particular, agradezco su apoyo de antemano.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-26 10:21:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES, INVESTIGACIONMERCADO y PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-03-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000663');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000665', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 133498 E INVESTIGACIÓN DE MERCADO 10701.', '2026-03-25 12:56:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 133498.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 25/03/2026
F. REQUIERE: 25/03/2026
F. RECEPCIÓN: 25/03/2026
DEBE DECIR: 20/03/2026
Asimismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10701, dentro del apartado "Investigación de Mercado", ya que emana de la Requisición antes descrita.
La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 25/03/2026
DEBE DECIR: 20/03/2026
También se solicita se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10701, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA ACT: 25/03/2026
DEBE DECIR: 20/03/2026
FECHA COTIZACIÓN: 25/03/2026
DEBE DECIR: 19/03/2026
Sin otro particular, agradezco su apoyo de antemano.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-26 10:56:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES, INVESTIGACIONMERCADO y PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-03-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000665');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000673', 'Solicitud de autorización de pagos', '2026-03-26 12:39:00', 'Buen dia, por medio de la presente se solicita el apoyo para que el dpto. de contabilidad pueda autorizar pagos a realizar al proveedor: Comisión Federal de Electricidad, ya que cuenta con complementos de pago pendientes. 
Folios Pendientes: 
- 86786
- 86785
- 86783 
Al ser un servicio primordial para la entidad se solicita su pronta atención. 
Quedo a la espera de algún comentario',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-27 11:39:00', 'Se cambió temporalmente el ESTADO a 5 en INVENTARIO.FOLIO_COMPLEMENTOS.', 'Modificación en BD', '2026-03-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000673');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000675', 'DETALLE DE REQUISICION 133485', '2026-03-26 14:05:00', 'Buen dia estimados.

El motivo del presente es para solicitar de su apoyo con añadir en el modulo de detalle de requisiciones, específicamente junto al articulo, donde dice servicios generales, ya que debe indicar  Servicio de Maniobras con personal y equipo destinado a la descarga de víveres, en calidad de “Ayuda Humanitaria” , es decir:



dice: servicios generales

debe decir:  Servicio de Maniobras con personal y equipo destinado a la descarga de víveres, en calidad de “Ayuda Humanitaria”.

sin mas por el momento, reciba un cordial saludo',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-27 13:00:00', 'Se cambió la DESCRIPCION en INVENTARIO.DETREQUIS.', 'Modificación en BD', '2026-03-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000675');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000562', 'DISTRIBUCIÓN EN LAS FACTURAS 86596 Y 86591', '2026-03-13 10:54:00', 'Buenos días
Por medio de la presente, solicito su apoyo con la distribución de las facturas 86596 y 86591 de la siguiente manera:
86596: $36,782.37
86591: $47,187.12
Cabe mencionar que el pedido 37226, se entra distribuido en 2 centro de costos como se muestra en la siguiente imagen.
A una servidora le permitió validar las facturas sin mayor problema, sin embargo, en el Depto. de Contabilidad no le refleja en la póliza del pasivo.  
Solicito su apoyo para su revisión, cualquier detalle estaré pendiente.',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-17 17:41:00', 'En INVENTARIO.DISTRMONTOXCC se modifico el campo MONTOFACT para el cc 992 y en INVENTARIO.DETDISTRMONTOXCC se ajusto el campo MONTOFACT para ambas facturas logrando que la suma de los 4 registros dieran el monto total correcto', 'Modificación en BD', '2026-03-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000562');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000666', 'CAMBIO DIRECTA CONTRATO', '2026-03-25 17:05:00', 'Buenas tardes:
Por este medio solicito de su apoyo para el cambio de Adjudicación en los contratos: 35052, 37243 y 37186   los cual debe decir: DIRECTA CONTRATO.
Los cuales se encuentran en estado abierto para que puedan realizar las modificaciones solicitadas.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-30 15:55:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1 para todos los pedidos', 'Modificación en BD', '2026-03-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000666');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000674', 'CAMBIO DE FECHA EN REQUISICION 133485 // APOYO HUMANITARIO', '2026-03-26 13:46:00', 'Buen día estimados

En relación al seguimiento del servicio de maniobra que se genero para el apoyo humanitario que fue embarcado en los buques de la ARM de México. sobre el particular, solicito de su apoyo para el cambio de la fecha de elaboración de la requisición 133485:

dice: 17-03-2026
debe decir: 02-02-2026

ADJUNTO IMAGEN DE REFERENCIA

Lo anterior para el seguimiento administrativo correspondiente al servicio generado.



saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-30 16:49:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-03-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000674');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000684', 'cambio de fecha en requi', '2026-03-27 11:36:00', 'Buen día 

Agradezco se realice el cambio de fecha en la requisición 133486 así como en la investigación de mercado 10692 todas a la fecha 06 de marzo de 2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-30 16:57:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-03-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000684');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000692', 'HABILITACIÓN DE FOLIO PARA SOLICITUD DE VIÁTICOS EN EL SIIPV', '2026-03-27 18:24:00', 'Solicito de su amable apoyo para habilitar los folios para llevar a cabo solicitud de viáticos en el SIIPV.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Fernández Velázquez, Málory Alanis'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-30 15:00:00', 'Se dio de alta al usuario en módulo de viáticos.', 'Modificación en BD', '2026-03-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000692');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000691', 'REEMPLAZO DE FACTURA Y XML EN EL MODULO VIATICOS', '2026-03-27 17:29:00', 'Buen dia equipo

El motivo del presente es solicitar de su apoyo con el reemplazo de los archivos PDF (FACTURA) Y XML del rubro 8 dentro del modulo de comprobación de viatico del folio 5037. Comparto/adjunto documentación correspondiente para que se elimine el anterior y se puedan añadir nuevamente. Lo anterior ya que no se visualiza al momento de la descarga.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-30 15:29:00', 'Se cargó manualmente el PDF al servidor y se colocó la ruta en INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-03-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000691');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000695', 'CAMBIO DIRECTA CONTRATO', '2026-03-30 11:00:00', 'Buenos días:
Por este medio solicito de su apoyo para el cambio de adjudicación del contrato: 37052.
Debe decir: DIRECTA CONTRATO.
Ya se encuentra en estado abierto para las modificaciones solicitadas.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-30 16:14:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1', 'Modificación en BD', '2026-03-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000695');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000696', 'Actualización de Fianza de Cumplimiento en Integral', '2026-03-30 12:03:00', 'Buenos días, 
Por este medio se solicita amablemente la actualización de la Fianza de cumplimiento de los siguientes Contratos:
ASPN-GI-CS-62601-010-25
ASPN-GI-CO-62601-017-25
ASPN-GI-CO-62601-017-25
De antemano muchas gracias',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-31 11:03:00', 'En OBRAS.CNTOVIGENTES se modifico el campo FIANZACUMPLIMIENTONUM y el campo FIANZACUMPLIMIENTOIMPORTE para los 3 contratos --CHUBB FIANZAS MONTERREY, ASEGURADORA DE CAUCION SA 2377032 69255.26 nidcontrato=''ASPN-GI-CS-62601-021-25'' --CHUBB FIANZAS MONTERREY, ASEGURADORA DE CAUCIÓN, S.A. 2378403 4185369.15 nidcontrato=''ASPN-GI-CO-62601-017-25'' --ASEGURADORA ASERTA, S.A. DE C.V. 4066-12774-3 158504.41 nidcontrato=''ASPN-GI-CS-62601-010-25''', 'Modificación en BD', '2026-03-30 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000696');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000697', 'CAMBIO DE FECHA PARA REQUISICION E INVESTIGACIÓN DE MERCADO', '2026-03-30 12:15:00', 'Buenas tardes 
agradezco su amable apoyo para realizar cambio de fecha en la requisición 133487 así como la investigación de mercado 010693 todas con fecha de 17 de febrero de 2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-03-31 09:15:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-03-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000697');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000701', 'Solicitud de apoyo con facturas en mediport', '2026-03-30 16:44:00', 'Buenas tardes, solicito su apoyo para poder subir una factura a mediport debido a que me manda el siguiente error:
Orden: 37350
Fatura: 86855

Gracias, quedo atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-31 15:44:00', 'Se eliminó el registro de CFDCONNECT.CFD_RECEPCION y CFD_CUSTOM_DATA. Y se eliminó el archivo de la bóveda.', 'Seguimiento de proceso', '2026-03-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000701');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000707', 'Solicitud de apoyo para la validación de facturas', '2026-03-31 10:30:00', 'Buen día, solicito su apoyo para poder subir una factura para validación, pues al tratar de hacerlo aparece el siguiente error: 
Factura: 86861
Orden: 37266
Se debio haber validado la factura en el folio: 86678, sin embargo, no hay registro de ella, como si hubiese sido eliminada, por tal motivo se aparece el error.
Quedo atenta a sus comentarios, gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-31 17:30:00', 'Se eliminó el registro de CFDCONNECT.CFD_RECEPCION y CFD_CUSTOM_DATA. Y se eliminó el archivo de la bóveda.', 'Modificación en BD', '2026-03-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000707');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000710', 'Actualizar importes en el Sistema Integral', '2026-03-31 12:17:00', 'Buenas tardes estimado
Por este medio se solicita amablemente actualizar en el Sistema Integral el monto del Anticipo 2026 del contrato ASPN-GI-CO-62601-017-25 del Contratista SYMMETRIC ENGINEERING CONSTRUCTION SUPERVISION, S.A. DE C.V. de un monto incorrecto de $39,063,445.19 al monto correcto de $39,063,445.31, mismo que se detalla a continuación:',
  (select id from ventanas_mesa where nombre = 'ANTICIPOS DEL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-01 11:17:00', 'En INVENTARIO.DETFACTURASOBRA se modifico el campo PRECIOUNITARIO, tambien en INVENTARIO.FACTURASOBRA se cambio el valor en MONTO y en INVENTARIO.FOLIO_FACTURA se modificaron los campos MONTO, IMPUESTO y MONTOFACTURA', 'Modificación en BD', '2026-03-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000710');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000713', 'CAMBIAR ESTATUS DE ESTIMACION EN SISTEMA DE TRAMITADA A ABIERTA', '2026-03-31 14:29:00', 'Buena tarde,
De la manera mas atenta solicito su apoyo para que se me brinde apoyo y poder cambiar el estatus de 2 estimaciones correspondientes al contrato ASPN-GI-CO-62601-012-25 correspondiente a la construcción de un sistema de apartarrayos para la nueva aduana de Veracruz. Las estimaciones en cuestión son la 2 y la 3, el sistema a mi ya no me permite volver a abrirlas ya que no coinciden con el año que actualmente esta corriendo, sin embargo, se requiere hacer modificaciones a estas.
Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Gallardo Reyes, Efrain'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-01 13:00:00', 'Se modifico el campo FECHAENTREGA en OBRAS.ESTIMACIONES para las 2 estimaciones', 'Modificación en BD', '2026-03-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000713');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000711', 'Solicitud de apoyo para subir complementos de pago.', '2026-03-31 12:42:00', 'Buen día, solicito su apoyo para poder subir los complementos de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serian los siguientes folios: 
  
Esto es lo que aparece: 

Gracias, quedo atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-01 14:00:00', 'Se hizo uso del candado ''des''.', 'Modificación en BD', '2026-03-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000711');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000688', 'SUSTITUIR REQUISITO EN EL SIRE', '2026-03-27 16:21:00', 'Buenas tardes, por este medio solicito su apoyo para sustituir un requisito en la plataforma SIRE del prestador MARÍA DE LOS ÁNGELES BOCANEGRA TOSTADO, como se detalla a continuación:

Como dice: 
CV EMPRESARIAL Y CATALOGO DE SERVICIO

Como debe de decir: 
DOS CARTAS DE RECOMENDACION


Sin otro particular, envió un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-30 12:21:00', 'Se eliminó el requisito de EDIV2.CONTRATOS_BITACORA_FLUJO, CONTRATOS_SOLICITUD_FLUJO y CONTRATOS_SOLICITUD_DETALLE. Además, se dio de alta el requisito de DOS CARTAS DE RECOMENDACION para este contrato.', 'Modificación en BD', '2026-03-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000688');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000715', 'Solicitud de apoyo con el candado de complementos.', '2026-03-31 16:10:00', 'Buenas tardes, solicito su apoyo para quitar el candado de complementos de pago del proveedor CFE y en cuanto se realice el pago se regrese el candado, seria del siguiente folio: 

Gracias, quedo atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-01 15:43:00', 'Se cambió temporalmente el ESTADO a 5 en INVENTARIO.FOLIO_COMPLEMENTOS.', 'Modificación en BD', '2026-03-31 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000715');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000717', 'Ampliar número de caracteres en Integral', '2026-04-01 11:41:00', 'Buenos días estimado
Por este medio se solicita u valioso apoyo a fin de agregar más caracteres el campo  Importe asignado subsecuente dentro de la Carátula del Contrato ASPN-GI-CO-62601-016-25 en el Sistema Integral:
Saludos cordiales
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-01 16:41:00', 'En el reporte rpsolcontratocaratula se modifico el campo de texto F_CONTRATOEROGACION2 ajustando la formula CF_EROGACIONES2 para cambiar la mascara de formato de $999,999,990.90 a $999,999,999,990.90', 'Modificación en BD', '2026-04-01 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000717');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000718', 'SOLICITUD CAMBIO DE FECHA.', '2026-04-01 13:07:00', 'Buena tarde, por medio del presente solicito su apoyo para cambio de fecha al 09/03/2026 del siguiente pedido: 37356',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-07 11:47:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDO de 01/04/2026 a 09/03/2026', 'Modificación en BD', '2026-04-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000718');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000723', 'AYUDA FACTURA EN BOVEDA', '2026-04-01 16:07:00', 'Buenas tardes, por medio del presente solicito su apoyo para borrar una factura que se encuentra en boveda, adjunto al presente se envían los archivos de facturacion electronica. 
Quedo atenta. Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-07 12:53:00', 'Se eliminaron los archivos de la bóveda y los registros de CFDCONNECT.CFD_RECEPCION y CFD_CUSTOM_DATA.', 'Modificación en BD', '2026-04-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000723');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000737', 'CAMBIO DE TIPO DE ADJUDICACIÓN EN PEDIDO', '2026-04-06 17:24:00', 'Buenas tardes
Me podrían apoyar con el cambio de tipo de adjudicación en el contrato 37099, se encuentra directa con pedido. 
debe ir como: directa con contrato. 
Agradezco de antemano el apoyo
Saludos!!',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-07 16:09:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1', 'Modificación en BD', '2026-04-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000737');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000727', 'SOLICITUD PARA MODIFICAR FECHA REQUISICIÓN E INVESTIGACIÓN DE MERCADO', '2026-04-01 19:05:00', 'Buenas tardes, 

Por medio del presente solicito su colaboración para realizar la modificación en la requisición No. 133505 e investigación de mercado  010706 / 2026.

Dice: 01/04/2026

Debe decir: 04/03/2026

Agradeciendo de ante',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-03 09:13:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-04-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000727');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000728', 'Carga de complemento de pago.', '2026-04-06 08:56:00', 'Buenos días

Por medio de la presente, solicito su apoyo para la carga de los complementos de pago adjuntos, lo anterior debido a que en ambos se tiene una diferencia de 1 centavo, por tal motivo envía ERROR al internar cargar los archivos PDF y XML.

 

Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-07 15:38:00', 'Se hizo uso del candado ''des''.', 'Modificación en BD', '2026-04-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000728');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000739', 'HABILITAR CANDADO COMPLEMENTO DE PAGO', '2026-04-06 18:06:00', 'Buenas tardes

Solicito de su amable apoyo para habilitar el candado de los complementos de pago, poder subir la factura de un proveedor e ir avanzando en recabar las firmas, debido a que es un pago con carácter de urgente. 

el folio de factura es 86897, el complemento de pago pendiente es: 12603

agradezco de antemano el apoyo 

Saludos!',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-08 13:03:00', 'Se cambió temporalmente el ESTADO a 5 en INVENTARIO.FOLIO_COMPLEMENTO.', 'Modificación en BD', '2026-04-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000739');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000751', 'Apoyo con acceso SIIP', '2026-04-07 17:39:00', 'Buen día,

Por medio del presente solicito su apoyo para poder ingresar a la diferentes plataformas y obtener los permisos correspondientes.

SIIP - acceso a Requisiciones, Investigación de Mercado

Agradezco el apoyo. Saludos cordiales.

Atentamente: Soporte Técnico
correo del usuario: jdpromoción@puertodeveracruz.com.mx',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-08 12:39:00', 'Se proporcionaron credenciales de acceso a SIIP mediante correo electrónico.', 'Modificación en BD', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000751');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000714', 'FALLA EN CARGA DE ESTIMACION', '2026-03-31 14:32:00', 'Buena tarde,
De la manera mas atenta solicito su apoyo, la empresa que lleva el contrato ASPN-GI-CO-62601-012-25 referente a la construcción de un sistema de apartarrayos en la nueva aduana de Veracruz reporta que al momento de querer generar/cargar la estimación 4 no se guarda, agregan un concepto, su volumen y al dar enter no queda registrado por lo que no han podido generar en sistema dicha estimación.
Quedo atento, gracias.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Gallardo Reyes, Efrain'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-01 12:00:00', 'Seguimiento de proceso, se comento el metodo para registrar nueva estimacion', 'Seguimiento de proceso', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000714');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000745', 'CAMBIO DE FECHA DE PEDIDO', '2026-04-07 12:31:00', 'BUENAS TARDES
POR MEDIO DEL PRESENTE SOLICITO SU AMABLE APOYO PARA REALIZAR UN CAMBIO DE FECHA EN EL PEDIDO NO. 37373 EL CUAL DEBE DE TENER  LA FECHA DE 12/03/2026
QUEDO EN ESPERA DE SUS COMENTARIOS, MUCHAS GRACIAS.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-08 13:02:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS de 07/04/2026', 'Modificación en BD', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000745');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000678', 'CAMBIO DE FACTURA EN MEDIPORT//SIIP', '2026-03-26 16:38:00', 'Buenas tardes, 

Solicito de su amable apoyo para realizar el cambio de factura en el folio de pago: 86755 de fecha 19/03/2026 del proveedor Distribuidora Ferreval SA de CV. En la bóveda de MEDIPOR y SIIP. 

Lo anterior a solicitud del área de finanzas. Se subirá la versión de la página del SAT 

Quedo atento 

Saludos!',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-03-27 15:38:00', 'Se reemplazaron los archivos de la bóveda.', 'Modificación en BD', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000678');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000753', 'Solicitud de cambio de usuario en el pedido 37356', '2026-04-07 17:59:00', 'Buenas tardes
Por medio de la presente, solicito su apoyo con el cambio de usuario, para que en el apartado REVISADO aparezca el nombre de una servidora, que mi compañera Alessandra Crivelli ahora pertenece a la Gerencia Comercial.
Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Servicios'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-08 15:59:00', 'Se modifico el registro en INVENTARIO.PEDIDOS para el campo USERNAME_ALTA', 'Modificación en BD', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000753');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000744', 'APOYO PARA CAMBIO DE PROVEEDOR EN COTIZACION Y PEDIDO', '2026-04-07 12:11:00', 'BUENAS TARDES

POR MEDIO DEL PRESENTE SOLICITO EL APOYO PARA CAMBIAR EL PROVEEDOR EN COTIZACIÓN NO. 38066 Y PEDIDO NO. 37372 POR LO QUE COMPARTO EL NO. DE PROVEEDOR "109825 EDER GONZALEZ CASTELAN"
QUEDO A SUS ORDENES PARA CALQUIER DUDA O COMENTARIO.',
  (select id from ventanas_mesa where nombre = 'COTIZACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cotizaciones'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-08 10:11:00', 'Se cambió el PROVEEDOR de 109668 a 109825. Se duplicó la cotización cambiando el número de FOLIO y el PROVEEDOR en INVENTARIO.COTIZACIONES, se colocó en PROVEINVESTIGACIONMERCADO el número de cotización en el registro correcto. Se eliminó el registro original en COTIZACIONES permitiendo modificar el proveedor en PEDIDOS y DETCOTIZACIONES.', 'Modificación en BD', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000744');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000763', 'Solicitud de apoyo para subir complementos de pago.', '2026-04-08 12:27:00', 'Buen día, solicito su apoyo para poder subir complementos de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Seria el siguiente folio: 
 

Esto es lo que aparece:

De igual manera, le adjunto los complementos de pago pendientes de subir.
Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-09 11:15:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000763');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000764', 'Solicitud de acceso a Sistema Integral', '2026-04-08 12:42:00', 'Buena tarde
Por este medio solicito las contraseñas de:
-) Sistema Integral
saludos',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/Integral'),
  (select id from solicitantes_mesa where nombre = 'Morales Hernandez, Oscar Hilario'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-08 17:42:00', 'Se actualizo el usuario en SERVICIO.CONTACTOS01 y SERVICIO.USUARIOS y en OBRAS.USUARIOS', 'Modificación en BD', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000764');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000761', 'Solicitud de acceso a SSIPV', '2026-04-08 12:10:00', 'Buena tarde

Por este medio solicito las contraseñas de:
-) SIIPV

saludos',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Morales Hernandez, Oscar Hilario'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-08 17:10:00', 'Se proporcionaron credenciales de acceso a SIIP mediante correo electrónico.', 'Seguimiento de proceso', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000761');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000756', 'REQUISICION', '2026-04-08 09:51:00', 'Buen día:
Solicito su apoyo para la modificación de fecha en la requisición No. 133507 referente al mantenimiento de los elevadores de la ASIPONA, la cual debe modificarse con fecha del 27 febrero.
De igual manera la investigación de mercado correspondiente con el numero 10708, modificar la fecha al 27 de febrero y la fecha de cotización del proveedor debe ser modificada al 12 de febrero.


ESTA REQUISICION FUE GENERADA CON FECHA 06 DE ABRIL Y LAS MODIFICACIONES SOLICITADAS SON PARA AJUSTAR A LOS PROCEDIMIENTOS DEL DEPARTAMENTO DE RECURSOS MATERIALES.

Agradezco la atención.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-08 16:51:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES, INVESTIGACIONMRECADO y PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000756');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000762', 'INVESTIGACION DE MERCADO', '2026-04-08 12:23:00', 'Buena tarde:
Solicito su apoyo para modificacion de la investigacion de mercado No. 10708 correspondiente a la Requisicion No. 133507.

Los cambios a modfiicar son los Articulos de Ley a aplicar siendo los siguientes:

-Se cambia el Art. 26 por el Art. 35
-Se cambia el Art. 42 por el Art  55

Agradezco la atencion.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Molina Montiel, Miriam del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-09 10:44:00', 'Seguimiento de proceso, solicitud atendida.', 'Seguimiento de proceso', '2026-04-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000762');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000771', 'CARGA DE FACTURA PROVEEDOR EDENRED', '2026-04-09 09:24:00', 'Buen día 

Por medio de la presente, solicito su apoyo con la carga de la factura 86992, el motivo es el error que se presenta en la siguiente imagen:

* Mismo que se presenta de manera mensual.

Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-09 16:24:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-04-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000771');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000783', 'DISTRIBUCIÓN EN LAS FACTURAS 86885 y 86886', '2026-04-09 16:31:00', 'Buenas tardes
Por favor me pueden apoyar con la distribución de las facturas 86885 y 86886, ya que no es posible realizar ese movimiento, quedo atenta a sus comentarios.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CATALOGO DE DEPARTAMENTOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-10 15:30:00', 'En INVENTARIO.DETDISTRMONTOXCC se ajusto el campo MONTOFACT para ambas facturas logrando que la suma de los registros dieran el monto total correcto', 'Modificación en BD', '2026-04-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000783');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000792', 'CAMBIO DE FECHA', '2026-04-09 18:06:00', 'Buenas tardes.

Se solicita de su amable apoyo para realizar el cambio de fecha de lo que se presenta a continuación:

  IM      -     REQ

10722   -   133523   ambas a la fecha 16/03/2026

10723   -  133524    ambas a la fecha 20/03/2026

De ante mano muchas gracias por el apoyo.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-10 13:00:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-04-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000792');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000778', 'CAMBIO DE FECHA CONTRATO', '2026-04-09 13:06:00', 'Buenas tardes:

Por este medio solicito de su apoyo para el cambio de fecha del contrato:37377.
Debe decir: 24/03/2026.

Ya se encuentra en estado de tramite para realizar las modificaciones solicitadas.
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-10 15:58:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-04-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000778');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000794', 'Modificación de Fianza de Cumplimiento', '2026-04-10 10:10:00', 'Buenos días, por este medio se solicita amablemente del Contrato ASPN-GI-CO-62602-009-25 correspondiente al Contratista Boskalis Marine Contracting and Offshore Services, S.A. de CV. modificar el número de fianza de cumplimiento 2026, misma que se adjunta.

Saludos',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-10 17:10:00', 'En OBRAS.CNTOVIGENTES se modifico el campo FIANZACUMPLIMIENTONUM y el campo FIANZACUMPLIMIENTOIMPORTE', 'Modificación en BD', '2026-04-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000794');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000795', 'CAMBIO DE FECHA', '2026-04-10 10:43:00', 'Buenos días:
Por este medio solicito de su apoyo para el cambio de fecha de la requisición: 133526 así como su investigación de mercado:010725/2026.
Debe decir: 20/02/2026.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-10 16:12:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO de la fecha 10/04/2026 a 20/02/2026.', 'Modificación en BD', '2026-04-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000795');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000779', 'ELIMINAR REGISTROS VIATICOS', '2026-04-09 13:10:00', 'BUENAS TARDES 
SE SOLICITA SE ELIMINEN LOS REGISTROS DE LOS VIATICOS, DE ANTEMANO, GRACIAS.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'González Vidrio, Isis'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-10 09:10:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-04-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000779');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000797', 'CAMBIO DE FECHA EN REQUISICIÓN E INVESTIGACIÓN DE MERCADO', '2026-04-10 12:46:00', 'Buenas Tardes, solicito su apoyo en el cambio de fecha:
 -De requisición 133515 a 9 de Abril del presente.
- Investigación de Mercado 010715/2026 a 9 de Abril del presente.

Agradezco la atención, quedo atenta.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Villalba Rojas, Briseiri Aylin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-13 09:25:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-04-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000797');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000793', 'SOLICITUD DE INFORMACIÓN SIPOT 1ER TRIMESTRE 2026', '2026-04-09 21:12:00', 'Buenas tardes,

Por instrucción de la C.P. Cándida Gutiérrez Luna Subgerente de Finanzas, y con la finalidad de cumplir en tiempo y forma con la presentación de la información del SIPOT, referente a los conceptos de representación y gastos de viaje erogados por esta Entidad correspondientes al primer trimestre de 2026 (01/01/2026 a 31/03/2026), solicito de la manera más atenta su apoyo para proporcionarnos esta información.


Quedo a sus órdenes, saludos.',
  (select id from ventanas_mesa where nombre = 'SIPOT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-10 13:00:00', 'Se hizo entrega de la documentación del SIPOT mediante correo electrónico.', 'Seguimiento de proceso', '2026-04-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000793');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000804', 'APOYO PARA ELIMINAR REGISTROS VIATICOS.', '2026-04-10 18:47:00', 'Buenas tardes ingeniero, 

Por medio del presente, solicito de su amable apoyo para eliminar las siguientes facturas del sistema SIIP del usuario: sgdmercado, por favor 

- 99.94
-289.98
-239.93

Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-13 12:00:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION.', 'Seguimiento de proceso', '2026-04-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000804');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000798', 'RECLASIFICACIÓN ASIENTO CONTABLE EN PÓLIZA Y ESTRUCTURA PROGRAMÁTICA (RECAUDACIÓN 09-04-2026)', '2026-04-10 13:20:00', 'Buena tarde,
estimados todos,
Derivado de la refacturación de los folios 985205, 985206, 985207, 985209, 985210 de fecha 31/03/2026, se genera un saldo a favor de la empresa SERVICIOS Y ALMACENES DE VERACRUZ, S.A. DE C.V., del cual se efectúa el día 09/04/2026 el folio SIP ANTICIPO 985630 por la cantidad de $ 7,169.82.
De acuerdo a la revisión de reportes por la recaudación del día 09/04/2026 se detecta que el movimiento de la liquidación arriba mencionada, el SIIP no generó la póliza por la afectación presupuestal correspondiente, tanto en la PÓLIZA DE RECAUDACIÓN como en la ESTRUCTURA PROGRAMÁTICA en corte de Caja (Tarifario).
Sobre el particular agradeceremos su apoyo, para visualizar el siguiente registro contable.
                                        CARGO        ABONO
 8141-10111-11-0000     $ 7,169.82
 8151-10111-11-0000                          $ 7,169.82
De antemano anticipo mis agradecimientos.
Sin otro particular, reciban un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Illescas Guevara, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-14 13:03:00', 'Se agrego en FACTURACION.MOVIMIENTOS los registros faltantes asi como en FACTURACION.FACTPPINGRESODOCTO, en este ultimo se personalizo el ID_MOVS obteniendo el maximo del periodo y ejercicio actual + 1', 'Modificación en BD', '2026-04-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000798');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000816', 'Solicitud de apoyo para subir complemento de pago.', '2026-04-13 18:34:00', 'Buenas tardes, solicito su apoyo para quitar el candado en el complemento de pago de DHL, del folio

Pues me aparece el siguiente error:

Quedó atenta a sus comentarios, gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-14 13:15:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-04-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000816');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000814', 'APOYO CAMBIO TEMPORAL EN VIATICOS', '2026-04-13 16:53:00', 'Buenas tardes ingeniero, 

Por medio del presente solicito de su amable apoyo para realizar un cambio temporal para la firma en mi comprobación de viáticos, cambiando al Director General, por el Gerente Comercial, quedo atenta y adjunto captura de pantalla de lo mencionado, muchas gracias. 

Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-14 16:53:00', 'Se modificó la función VIATICOS.BDAUTORIZADOR. Se cambió el open curdir por open curjefe.', 'Seguimiento de proceso', '2026-04-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000814');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000813', 'Solicitud de apoyo para subir complementos de pago.', '2026-04-13 16:53:00', 'Buen día, solicito su apoyo para poder quitar el candado de los complementos de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serian los siguientes folios: 

Esto es lo que me aparece: 


Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-14 16:05:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-04-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000813');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000817', 'CAMBIO DE FECHA', '2026-04-13 18:43:00', 'Buenas tardes:

Por este medio solicito de su apoyo para el cambio de fecha del pedido: 37383.
Debe decir: 07/04/2026.

El pedido se encuentra en estado tramite para que puedan realizar el cambio solicitado.

Quedo atenta.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-15 13:00:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-04-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000817');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000829', 'Apoyo SIIP', '2026-04-14 15:57:00', 'Se solicita apoyo para habilitar la aplicación SIIP (incidencias) al compañero Jorge Antonio Morales Mavil',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Santiago Peña, Laryssa Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-15 10:57:00', 'Se dio de alta al usuario en SIIP.', 'Modificación en BD', '2026-04-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000829');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000805', 'Apoyo para contratista para cargar su complementos de pago', '2026-04-10 19:25:00', 'Buen día
Esperando se encuentren bien, solicito su apoyo para que la contratista SEAPROD pueda subir sus complementos de pago a la plataforma. 

Quedo atenta a sus comentarios. Saludos.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Fernández, Lluvia del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-14 13:15:00', 'Se hizo manualmente la carga de los archivos. El error "CRP20261 El valor del campo ImporteDR o que corresponde a Traslado no se encuentra entre el límite inferior y superior permitido" ocurre al exceder la cantidad de decimales ImporteDR="51662.840000".', 'Modificación en BD', '2026-04-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000805');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000835', 'Complemento de Pago ASPN-GI-CS-62601-017-25', '2026-04-15 10:19:00', 'Buenos días 

Por este medio se informa que respecto al contrato ASPN-GI-CS-62601-017-25 del contratista SEAPROD, el contratista no puede cargar en Mediport su complemento de pago toda vez que aparece en $0:

Se anexan el complemento de pago en XML y PDF

Agradeciendo de antemano sus finas atenciones, reciba un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-15 15:19:00', 'Se hizo manualmente la carga de los archivos. El error "CRP20261 El valor del campo ImporteDR o que corresponde a Traslado no se encuentra entre el límite inferior y superior permitido" ocurre al exceder la cantidad de decimales ImporteDR="51662.840000".', 'Modificación en BD', '2026-04-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000835');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000833', 'ESTIMACION ERRONEA', '2026-04-15 09:25:00', 'Buen día,
Requiero apoyo referente a una estimación del contrato ASPN-GI-CO-62602-012-25, al momento de imprimir las caratulas del sistema se carga automático un convenio el cual no existe para este contrato, esto ocurre en todas las estimaciones, 2,3 y 4.
Quedo atento.',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Gallardo Reyes, Efrain'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-15 13:25:00', 'Seguimiento de proceso, se modifico el reporte Supervision.rdf para quitar los campos de convenio para evitar que se muestren al generar los reportes de cada estimacion', 'Seguimiento de proceso', '2026-04-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000833');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000843', 'AJUSTE PARA EL MONTO DEL CONTRATO CON SOLITUS 362 PARA EL 2026.', '2026-04-15 16:25:00', 'BUENAS TARDES
POR MEDIO DE LA PRESENTE SOLICITO SU APOYO CON LA ASIGNACIÓN DEL PRESUPUESTO CORRESPONDIENTE AL EJERCICIO FISCAL 2026 DEL CONTRATO CON FOLIO NO. 362, DEBIDO A QUE TIENE UN MONTO PARA EL 2026 DE $    4,309,240.00, SIN EMBARGO, SE TIENE DISPONIBLE EN EL PRESUPUESTO LA CANTIDAD DE $ 3,988,667.61, POR LO ANTERIOR, SE REQUIERE SE AJUSTE A LO REAL DISPONIBLE.
PROVEEDOR: ADMINISTRADORA DE RECURSOS Y OPERACIONES, S.A. DE C.V.
CONTRATO: GAF-LPEN-CS-005/24',
  (select id from ventanas_mesa where nombre = 'ESTADO DE SOLICITUDES DEL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Solicitud de Contrato de Prestadores'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-16 11:25:00', 'En INVENTARIO.SOLCONTPRESUPUESTO se modificaron los campos MONTOPENDIENTE a 3988667.61, IVAPEND a 638186.82, TOTALPEND a 4626854.43 y posteriormente se agregaron los montos restantes para completar lo programado para el año', 'Modificación en BD', '2026-04-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000843');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000839', 'SALIDA DE SIIP 2 001011009030, 001011009034 y 001011009035', '2026-04-15 11:30:00', 'Buenos días 
Área     Edificio principal.
Lugar   Área común de recursos materiales.
Detalles: Los 3 artículos reflejado en  esta incidencia ya fueron entregados, pero siguen reflejados en el sistema. Referente de insumos consumible para la entidad ASIPONA Veracruz
001-011-009-030
001-011-009-034
001-011-009-035
Quedo en pendiente a su búsqueda del detalle y a su disposición para proceder para arreglo del tema.
Atte. Alejandro.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Movimientos de Almacen'),
  (select id from solicitantes_mesa where nombre = 'Arresola Martínez, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-15 16:30:00', 'Se cambió la EXISTENCIA a 13 en INVENTARIO.EXISTENCIAS. Necesitaban existencia 0 pero la requisición 133533 requería cantidad 13.', 'Modificación en BD', '2026-04-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000839');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000810', 'CORRECCIÓN DE IVA X PAGAR NO COBRADO EN PÓLIZA DE INGRESO POR FACTURACIÓN 10/04/2026', '2026-04-13 15:05:00', 'Buenas tardes,
    estimados todos,
  Por medio de la presente se solicita su apoyo con la Póliza de ingreso del día 10/04/2025, ya que en el I.V.A. X PAGAR 16% NO COBRADO (N° cuenta:211731911000002) se refleja un importe de $5,910,730.67 y el monto correcto es $2,992,219.18, dicho I.V.A. provienen de las Cuentas por Cobrar Pagadas, mismas que fueron cobradas a la empresa FERROSUR S.A. DE C.V. que a continuación se detallan:
COBRO-FACTURA
464121-984733
464120-984732
464118-984781
464117-984780
464112-984783
464110-984782
464099-984785
464097-984784
464094-984901
464093-984891
De antemano anticipo mi agradecimiento y quedo atento a cualquier adicional.
Sin otro particular, reciban un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'EXPORTACION DE POLIZAS A CONTABILIDAD'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Illescas Guevara, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-17 15:56:00', 'En FACTURACION.MOVIMIENTOS se modifica el campo MOVMONTO y en FACTURACION.POLIZAS se modifico el campo POLIZAMONTOCARGOS para la poliza (577,576,481,476,466- 4 - ''I'' - 2026). Esto se debio a que se comprobo la diferencia entre los valores de las polizas de las facturas con', 'Modificación en BD', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000810');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000845', 'MODIFICACION REQUI', '2026-04-15 16:48:00', 'Buena tarde, solicito su apoyo con la modificación en sistema de la fecha correspondiente a la requi 133525 ya que tiene como fecha el dia "15/04/2026" siendo la fecha correcta "09/04/2026", adjunto captura mostrando la fecha solicitada
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-17 15:14:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000845');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000821', 'SUBIR NOTA DE CRÉDITO', '2026-04-14 08:55:00', 'Buenos días 

Me podrían apoyar en subir la nota de crédito del folio de factura 86955, ya que se emitió con atributos fiscales diferentes a los que tiene el sistema, pero que son válidos y se autorizaron por el área de finanzas. 

Agradezco de antemano el apoyo
Saludos!!',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-17 13:31:00', 'Se cambió el METODO_PAGO a PUE y el FORMA_PAGO a 15 en INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000821');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000859', 'APOYO EN SISTEMA SIIP', '2026-04-17 10:56:00', 'Buenos dias, solicito su apoyo con el estado de las solicitudes de pago 86978 y 86979 las cuales cuentan con el estado de "parcial pagado" y no permite desaplicarlos
adjunto imagen de la solicitud 86979',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-17 15:56:00', 'En INVENTARIO.FACTURAS se cambiaron los campos ESTADO y MONTOPAGADO a 0, en el esquema de CONTA se eliminaron los registros relacionados a las polizas (2026-4-D-270,271) en las tablas ESTPROGPPEGRESODOCTO, MOVIMIENTOS y POLIZAS', 'Modificación en BD', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000859');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000860', 'AGREGAR REQUISITO A SOLICITUD EN SIRE', '2026-04-17 12:05:00', 'Buen día

Solicito su amable apoyo para agregar el requisito EDOS DE CUENTAS BANCARIAS a la solicitud en el SIRE a nombre de MARIA DE LOS ANGELES BOCANEGRA TOSTADO.

mUCHAS GRACIAS',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-20 10:05:00', 'Se agregó el requisito de la solicitud de contrato en EDIV2.CONTRATOS_SOLICITUD_DETALLE y CONTRATOS_SOLICITUD_FLUJO.', 'Modificación en BD', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000860');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000830', 'no permite generar folio', '2026-04-14 16:02:00', 'Buenas Tardes 
solicito apoyo debido a que no me deja generar folio en el sistema de ASIPONA para la estimacion no 25 de la empresa capital humano, no de contrato ASP-GI-CS-62601-001-24',
  (select id from ventanas_mesa where nombre = 'ESTADO DE LA ESTIMACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Contreras Martínez, Karla Teresa'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-15 13:02:00', 'Seguimiento de proceso, se modifico el procedimiento dentro del boton Autorizar para permitir que si no hay anticipo en el año, se pueda recurrir al ultimo anticipo del contrato', 'Seguimiento de proceso', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000830');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000831', 'APOYO CON RETIRO DE MONTO EN ESTIMACION', '2026-04-14 16:22:00', 'Buena tarde,
Necesito apoyo para poder editar la estimación 5 y 6 del contrato ASPN-GI-CO-60602-003-25,
Al ser estimaciones del periodo de diciembre 2025 no debería a parecer un monto en la casilla de pendiente por amortizar, ese monto seria para 2026, sin embargo, la empresa no puede editar ese monto ya que es el sistema quien automáticamente lo arroja.
Gracias.',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Gallardo Reyes, Efrain'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-15 11:22:00', 'Seguimiento de proceso, se modifico el reporte Supervision.rdf para mostrar el campo de PEND. AMORTIZAR en 0 al generar los reportes de cada estimacion', 'Seguimiento de proceso', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000831');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000862', 'APOYO PARA ELIMINAR REGISTROS VIATICOS', '2026-04-17 15:27:00', 'Por medio del presente, solicito de su amable apoyo para eliminar la siguiente factura del sistema SIIP del usuario: auxcomercial1, por favor 

- 346.00

Saludos cordiales, .',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-20 11:27:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION, de INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000862');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000864', 'APOYO PARA ELIMINAR REGISTROS VIATICOS.', '2026-04-17 15:32:00', 'Por medio del presente, solicito de su amable apoyo para eliminar la siguiente factura del sistema SIIP del usuario: auxcomercial1, por favor 

- 415.03
- 192.50

Saludos cordiales, .',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-20 09:32:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION, de INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-04-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000864');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000870', 'SOLICITUD PARA CAMBIAR TEMPORALMENTE', '2026-04-17 17:28:00', 'Buenas tardes ingeniero, 

Por este medio del presente solicito de su amable apoyo para cambiar temporalmente el nombre de autoriza que sea por parte del Gerente Comercial, en lugar del Director General, por favor, quedo atenta. 

Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-20 15:28:00', 'Se modificó la función VIATICOS.BDAUTORIZADOR. Se cambió el open curdir por open curjefe.', 'Modificación en BD', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000870');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000873', 'HABILITACION DE VIATICOS EN EL SIIPV', '2026-04-20 09:05:00', 'Buenos días, por este medio solicito amablemente se me habiliten los viáticos en la plataforma SIIPV debido a que voy a atender una comisión y dicha solicitud debe de estar entregada al área correspondiente el día de hoy.

Agradezco de antemano su apoyo y envio un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-21 09:05:00', 'Se dio de alta al usuario en módulo de viáticos.', 'Modificación en BD', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000873');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000834', 'CONCEPTOS DEL CONTRATO ASPN-GI-CO-62602-012-25', '2026-04-15 09:44:00', 'Buen día,
En seguimiento al apoyo obtenido el día de ayer para corregir errores en las estimaciones del contrato antes mencionado se anexa catalogo de conceptos requerido para su revisión.
Quedo atento.',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Gallardo Reyes, Efrain'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-15 17:44:00', 'En OBRAS.CPTOSESTIMADOS para la estimacion 4-N se realizo el cambio de concepto del 15 al 26, incluyendo los capitulos y subcapitulos. Tambien en OBRAS.CPTOSCONTRATADOS se modifico el valor del campo PUNITARIO para el concepto 15', 'Modificación en BD', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000834');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000770', 'ANEXO 5 DE LA EMPRESA FUM KILLER PLUSS', '2026-04-08 16:36:00', 'Solicito de su apoyo para la rechazar el Anexo 5. Tabla de Aspectos Ambientales en el SIRE ya que al momento de rechazar me envía el siguiente error.

Muchas gracias de antemano.

Saludos.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Colorado García, Inocente'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-09 13:36:00', 'Se corrigió el tamaño de la variable vDetalleServicio de 100 a 180 en EDIV2.PACK_CONTRATOS_SERVICIOS.noficiaCancelacion().', 'Modificación en BD', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000770');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000880', 'AGREGAR OFICINAS EN SOLICITUD DE VIATICOS Y ACTIVIDADES', '2026-04-20 10:39:00', 'buenos días, por este medio solicito su apoyo para resolver error en la plataforma SIIPV ya que intento agregar una oficina para mi comisión y no me lo permite al igual que al grabar las actividades que se desempeñaran. Mucho agradecere, dicha solicitud sea atendida lo más pronto posible debido a la premura de la comision a desempeñas.


Sin otro particular, quedo atenta a sus comentarios en la extension 72924 y aprovecho a enviar un cordial saludo.Buenos días,por este medio solicito su valioso apoyo para',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'León Martínez, María Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-21 09:39:00', 'Se agregó la oficina Centro Expositor Puebla en DGPORT.TIPO_OFICINA.', 'Modificación en BD', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000880');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000867', 'Solicitud de apoyo con distribución en el centro de costos del pedido: 37311', '2026-04-17 16:14:00', 'Sería de la siguiente manera:
CENTRO DE COSTOS
996) Gerencia de Administración y Finanzas - MONTO: 1
991) Dirección general - MONTO: 761

Quedó al pendiente, muchas graciass!',
  (select id from ventanas_mesa where nombre = 'DISTRIBUCION DE CENTRO DE COSTOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-20 12:18:00', 'En INVENTARIO.DETDISTRMONTOXCC se ajusto el campo MONTOFACT para la factura del pedido logrando que la suma de los registros dieran el monto total correcto, creando el segundo registro con el otro centro de costos. Esto mismo se replico en INVENTARIO.DISTRMONTOXCC', 'Modificación en BD', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000867');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000853', 'BAJAR FACTURAS DE COMPROBACION DE VIATICOS', '2026-04-16 16:37:00', 'Buenas tardes

Solicito de su amable apoyo para bajar del sistema de SIIP unas facturas que se subieron para hacer comprobación de viáticos pero que no pueden ser visualizadas.

Muestra la siguiente leyenda:



Muchas gracias',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'González Cerezo, Cristina'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-20 16:22:00', 'Se cargaron los archivos manualmente al servidor y se agregaron las rutas en INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000853');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000884', 'APOYO PARA TIMBRAR COMPLEMENTO DE PAGO - Kansas', '2026-04-20 11:00:00', 'Hola buen día estimado equipo.
Agradecería su amable apoyo en el sistema SIPP-Facturación en la ventana de complementos de pago:
Cliente: KANSAS CITY SOUTHERN DE MEXICO, S.A. DE CV.
FOLIO: 2528
El sistema no permite realizar el timbrado del complemento, agradecería su amable apoyo en timbrar el complemento de pago de igual forma.
muchas gracias!',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-21 11:00:00', 'Seguimiento de proceso, el problema se presentaba al momento de generar el archivo correspondiente tras el timbrado del complemento de pago', 'Seguimiento de proceso', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000884');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000869', 'Solicitud de apoyo para cambio de fecha', '2026-04-17 17:18:00', 'Buenas tardes, solicito su apoyo para poder cambiar la fecha de los siguientes pedidos:

Pedido: 37391
Fecha Solicitada: 03/02/2026

Pedido 37392: 
Fecha solicitada: 20/02/2026

Graciass, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-21 16:09:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Seguimiento de proceso', '2026-04-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000869');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000887', 'Solicitud de apoyo para comprometer recursos', '2026-04-15 15:38:00', 'Buenos días
Por este medio se solicita amablemente comprometer los siguientes montos a los nuevos contratos que se detallan:   Contrato: ASPN-GI-CO-62602-001-26
Monto:  $9,137,976.80 
Contrato: ASPN-GI-CO-62602-002-26
Monto:  $8,882,645.17',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-21 12:14:00', 'En OBRAS.DISTRCONTRATOS se colocó temporalmente el valor indicado en el campo MONTO, asi como tambien se calculo el IVA y el valor MONTOTOTAL para cada contrato, luego el valor restante original se coloco en el campo', 'Modificación en BD', '2026-04-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000887');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000722', 'APOYO CON REPORTE DE VENCIMIENTOS - MARZO 2026', '2026-04-01 16:03:00', 'Hola buena tarde equipo,
Detectamos que en el reporte de Cuentas por Cobrar Ordenado por Vencimientos, las facturas de Ferrosur y Kansas se visualizan con montos en ceros. Cabe recalcar que dicho reporte fue descargado el día de ayer 31-03-2026.
Nos apoyan ya que no esta arrojando el importe de las facturas emitidas, y por tal razón montos errados en el reporte.
muy amables
Muchas gracias de antemano.',
  (select id from ventanas_mesa where nombre = 'REPORTE DE CUENTAS POR COBRAR'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Cuentas por Cobrar'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-02 15:03:00', 'Seguimiento de proceso, se modifico en el reporte crcob032.rdf la consulta principal, agregando el tipo MUE. FERROVIARIO con los tipos dinamicos  B. NORTE o B. SUR y en TOTALFORMULA se agregaron los bloques para el calculo del mismo tipo', 'Seguimiento de proceso', '2026-04-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000722');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000825', 'REQUISICION', '2026-04-14 11:04:00', 'Buen día:
Solicito su apoyo para poner en estado abierto la Requisición No. 133507, ya que por solicitud de los departamentos  de Contabilidad y Recursos Materiales se requiere efectuar modificaciones en el planteamiento del gasto del recurso debiendo reflejarlo como (plurianual) 
Quedo atenta a sus comentarios e indicaciones.
Saludos',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-22 09:21:00', 'Seguimiento de proceso, mesa atendida por llamada telefonica', 'Seguimiento de proceso', '2026-04-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000825');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000881', 'CAMBIO DE FECHA EN PEDIDO', '2026-04-20 10:43:00', 'Buenas tardes

Por medio del presente, solicito de su amable apoyo para realizar un cambio de fecha en el pedido 37397 con fecha 20/04/2026.

La fecha correcta debe ser : 10 de abril de 2026.

Gracias por el apoyo 
Saludos!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-22 16:44:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-04-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000881');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000894', 'SOLICITUD PARA REMPLAZAR CFDIS EN FOLIOS DE MEDORT', '2026-04-21 12:00:00', 'Buenos días, 
Por medio del presente solicito su colaboración para remplazar el CFDI (PDF Y XML) que se encuentra cargado en el portal mediport en los folios de solicitud de pago 87002 y 87003 correspondientes al proveedor GRUPO ARICAE, S. DE R.L. DE C.V. 
folio 87002  (DICIEMBRE 2025) CFDI: 1A39B99F-4BA2-4345-9D10-5CF974885188
folio 87003 (ENERO 2026) CFDI: 444D15AA-3250-4E10-AF84-C031586785BF
Nota: Se adjuntan ambos cfdi para pronta referencia. 
Lo anterior debido a la revisión realizada por el Depto. de Contabilidad y presupuesto a la versión impresa del CFDI, donde nos indican verbalmente que el QR no se puede leer. 
Agradeciendo de antemano su colaboración, les envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Validación de CFDI'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-22 17:59:00', 'Seguimiento de proceso, se realizo el cambio de archivos en boveda', 'Seguimiento de proceso', '2026-04-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000894');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000877', 'SEGUIMIENTO A MESA DE AYUDA', '2026-04-20 10:13:00', 'Buenos dias Ing. 

Por medio del presente y en segumiento a la mesa de ayuda  REQ 2025-003265,  solicito de su muy amable apoyo para volver a cambiar el estatus de los complementos de pago, 

De antemano agradezco su amable apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-22 15:42:00', 'Se cambió el estado a 0 de los registros en INVENTARIO.FOLIO_COMPLEMENTOS.', 'Modificación en BD', '2026-04-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000877');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000908', 'NOTIFICACION DE NO TIMBRADO', '2026-04-22 13:30:00', 'Buena tarde
Agradecemos el apoyo con el timbrado de la nota de egreso 18634, folio 15740.
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-23 09:30:00', 'En FACTURACION.VTNOTASCREDITO se modifico el campo MONTO asi como en FACTURACION.FACTURAS_TIMBRADOR se regreso el campo TIMBRADO a 0', 'Modificación en BD', '2026-04-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000908');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000910', 'Actualización de Memo ASPN-GI-CO-62602-002-26', '2026-04-22 15:40:00', 'Buenas tardes 

Por este medio se solicita actualizar los montos de las fianzas en el Memo del contrato.

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-23 10:40:00', 'En OBRAS.CNTOVIGENTES se modifico el campo FIANZAANTICIPORS para el contrato ASPN-GI-CO-62602-001-26 y para el contrato ASPN-GI-CO-62602-002-26 el campo FIANZAANTICIPOIMPORTE', 'Modificación en BD', '2026-04-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000910');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000902', 'NO APARECE FOLIO PARA COMPROBACIÓN DE VIÁTICOS', '2026-04-22 11:07:00', 'Buenas tardes, solicito de su valioso apoyo a fin de que pueda realizar la comprobación de viáticos correspondiente.

Dentro del apartado "Solicitud de viáticos" sí me aparece el folio con el estatus de "en comprobación".

Sin embargo, dentro del apartado "Comprobación de viáticos" no me aparece el folio de la comisión a comprobar. 

Folio: 4736

Adjunto imágenes para pronta referencia.

Quedo atenta de sus comentarios, saludos.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'López Paz, Adriana Mar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-23 09:07:00', 'La comprobación no se generó automáticamente. El usuario tuvo que utilizar un nuevo folio, colocar el foliosol con F9 y hacer clic en grabar para generar la comprobación.', 'Seguimiento de proceso', '2026-04-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000902');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000911', 'Ajustes en Integral', '2026-04-22 15:51:00', 'Buenas tardes 
+Por este medio se solicita su valioso apoyo a fin de regresar al F10 en el menú - ingeniería - contratos, captura el contrato ASPN-GI-CS-62601-004-26.
+Respecto al contrato ASPN-GI-CS-62601-003-26 favor de actualizar en el menú Jurídico - Control de Contratos - Solicitud los Datos de las fianzas en la carátula mismos que se detallan a continuación:',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-23 10:51:00', 'En SERVICIO.SOLCONTJURIDICO74 se modificaron los campos GARANTIARSCUMPLIMIENTO, GARANTIASRSANTICIPOS , GARANTIASNOFIANZACUMP, GARANTIASNOFIANZAANT, GARANTIASIMPORTEFIANZACUMP, GARANTIASIMPORTEFIANZAANT, GARANTIASRSCONTINGENCIA, GARANTIASNOFIANZACONT, GARANTIASIMPORTEFIANZACONT para el contrato ASPN-GI-CS-62601-003-26 y para el contrato ASPN-GI-CS-62601-004-26 se elimino el registro', 'Modificación en BD', '2026-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000911');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000907', 'Solicitud de apoyo para subir complemento de pago.', '2026-04-22 13:10:00', 'Buenas tardes, solicito su apoyo para quitar el candado en el complemento de pago de DHL, del folio



Pues me aparece el siguiente error:


Quedó atenta a sus comentarios, gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-23 09:16:00', 'Se hizo uso del candado ''des'' por error de cantidad superior de decimales en un campo.', 'Seguimiento de proceso', '2026-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000907');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000913', 'SOLICITUD PARA REGISTRAR VIÁTICOS', '2026-04-22 17:55:00', 'Buenas tardes.

Solicito de su apoyo para que me habiliten en el SII el apartado para registrar viáticos.

Muchas gracias de antemano por su apoyo.

Saludos.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Colorado García, Inocente'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-23 12:55:00', 'Se dio de alta al usuario en módulo de viáticos.', 'Modificación en BD', '2026-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000913');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000916', 'APOYO CON ALTA DE OFICINA PARA SOLICITUD DE VIATICOS', '2026-04-23 10:55:00', '|BUEN DIA DE SU APOYO PARA DAR DE ALTA LAS OFICINAS DE SEDEMA EN EL SIIPV YA QUE EL DÍA DE MAÑANA TENGO UNA COMISIÓN A LA CIUDAD DE XALAPA',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Colorado García, Inocente'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-23 15:55:00', 'Se dio de alta la oficina en DGPORT.TIPO_OFICINA.', 'Modificación en BD', '2026-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000916');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000906', 'Verificación de incidencias', '2026-04-22 12:51:00', 'Buenas tardes, solicito verificación de incidencias del usuario secoperaciones2 asignado a Ileana Vazquez Ruiz.
favor de verificar a donde llegan sus incidencias tramitadas, ya que no puedo visualizarlas en mi usuario de Gerente.
Favor de atender a la brevedad. 
Gracias',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Ramos Leyva, José Manuel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-22 17:51:00', 'Seguimiento de proceso, el problema se presentaba debido a que el usuario tenia un supervisor incorrecto en NOMINA.EMPLEADOS1 y se solicito a RH la actualizacion', 'Seguimiento de proceso', '2026-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000906');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000918', 'Carga de facturas de amortización', '2026-04-23 11:43:00', 'Buenas tardes 

Por este medio se solicita su valioso apoyo a fin de realizar la carga de facturas en Integral del contrato  ASPN-GI-CS-62601-012-25 JESUS HITLER DE LOS SANTOS PERALTA. Toda vez que al Contratista le genera error. 

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-23 16:43:00', 'Se cargó manualmente con el usuario de la empresa las notas de crédito que presentaban problema.', 'Seguimiento de proceso', '2026-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000918');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000841', 'Carga de Catálogo de Conceptos Integral > Ingeniería > Contratos > Captura', '2026-04-15 15:38:00', 'Buenas tardes,
Por este medio se solicita su valioso apoyo a fin de indicar el proceso y/o solucionar el error toda vez que al realizar la Captura de los datos en dicho menú dentro del apartado de Ingeniería en el Integral, al importar el archivo .txt del catálogo de conceptos el sistema no realiza la acción y al darle clic a guardar, el integral borra todos los datos capturados.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-16 12:38:00', 'Seguimiento de proceso, se verifico el proceso de carga de conceptos y se determino que el flujo de registro de solicitudes de contrato a consultas es Caratula y 1 concepto dummy -> Salir y volver a cargar -> Comprobar resultados -> Carga de conceptos tras importar -> Salir y volver a cargar -> Comprobar resultados', 'Seguimiento de proceso', '2026-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000841');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000883', 'Borrar un proveedor', '2026-04-20 10:59:00', 'Borrar al proveedor llamado ADOSA , ya que surgieron cambios de información',
  (select id from ventanas_mesa where nombre = 'PROVEEDORES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Hernández Chacha, Valeria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-22 16:09:00', 'Se comunicó con el licenciado Juan Pedro (auxadmonrm4) para que realizara el cambio de nombre del proveedor.', 'Seguimiento de proceso', '2026-04-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000883');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000812', 'Mi pc no visualiza recibos de nómina', '2026-04-13 16:42:00', 'Al ingresar al sistema SIIPV2 en el apartado de recibos de nómina y seleccionar la opción "VER PDF" no realiza ninguna acción el equipo o por lo menos no algo que yo visualice.',
  (select id from ventanas_mesa where nombre = 'RECIBOS DE NOMINA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Recibos de Nomina'),
  (select id from solicitantes_mesa where nombre = 'Verdejo Grajales, Jonathan'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-14 16:42:00', 'No se podía descargar recibo de nómina probablemente por una desconfiguración que afectó el acceso de su máquina al servidor, se solucionó reiniciando.', 'Seguimiento de proceso', '2026-04-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000812');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000897', 'Acceso a SIIPV02 para la justificación de incidencias de asistencia.', '2026-04-22 08:50:00', 'Por medio de la presente, solicito amablemente se me otorgue acceso al sistema SIIPV02 para la justificación de incidencias de asistencia.
Debido a una promoción interna, mi nombre de usuario ha sido actualizado de ''cecologia'' a ''jdseguridad''. No he podido acceder a la plataforma mencionada.
Agradecería su apoyo para resolver esta situación y poder acceder al sistema con mi nuevo usuario.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Aguilar Heredia, Juan de Dios'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-22 17:00:00', 'Se dio de alta al usuario en SIIP y se asignaron privilegios.', 'Modificación en BD', '2026-04-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000897');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000938', 'ELIMINAR VIATICO', '2026-04-24 13:27:00', 'hola buenas tarde por medio del presente solicito su amable apoyo para borrar la siguiente factura 12.50 del usuario jdexpansion',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-27 08:27:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION y de INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-04-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000938');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000931', 'USUARIO SIIPV | RICARDO GOMEZ', '2026-04-24 11:14:00', 'Buen día, 


Solicitamos de su apoyo para restaurar o se habilite el usuario de SIIPV. Con la finalidad de dar seguimiento a sus funciones.

Nuevo colaborador: 

    Ricardo Gómez Rodriguez: coperaciones2@puertodeveracruz.com.mx',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Sarmiento Aquino, Adriana Monserrat'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-27 08:14:00', 'Se dio de alta al usuario en SIIP.', 'Modificación en BD', '2026-04-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000931');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000947', 'APOYO PARA ELIMINAR FACTURA EN COMPROBACIÓN DE VIATICOS', '2026-04-25 15:21:00', 'BUEN DÍA,
SE SOLICITA SU APOYO PARA ELMINAR FACTURA DE COMPROBACIÓN DE VIATICOS DEL DG.
SE SEÑALA LA FACTURA CON No. DE COMPROBANTE 1023 Y CON MONTO 3´090 PESOS QUE SE DESEA ELIMINAR.
DE ANTEMANO MUCHAS GRACIAS.
SALUDOS CORDIALES.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Pulido López, Rey David'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-27 08:27:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION y de INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-04-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000947');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000942', 'SOLICITUD DE ELIMINACION DE FACTURA', '2026-04-24 17:28:00', 'hola buenas tardes solicito de su ayuda para eliminar la factura de 0.11 del usuario jdexpansion',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-27 15:28:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION y de INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-04-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000942');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000952', 'APOYO PARA TIMBRAR COMPLEMENTO DE PAGO - Kansas || 27-04-2026', '2026-04-27 09:51:00', 'Hola buen día estimado equipo.
Agradecería su amable apoyo en el sistema SIPP-Facturación en la ventana de complementos de pago: 
Cliente: KANSAS CITY SOUTHERN DE MEXICO, S.A. DE CV.
FOLIO: 2544
El sistema no permite realizar el timbrado del complemento, agradecería su amable apoyo en timbrar el complemento de pago de igual forma.
muchas gracias!',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 09:51:00', 'En FACTURACION.COMPLEMENTOS_PAGO se agrego la informacion faltante a los campos FOLIO_COMP_TIMBRADO y UUID_COMPLEMENTO', 'Modificación en BD', '2026-04-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000952');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000955', 'APOYO PARA TIMBRAR COMPLEMENTO DE PAGO - Ferrosur || 27-04-2026', '2026-04-27 10:32:00', 'Hola buen día estimado equipo.
Agradecería su amable apoyo en el sistema SIPP-Facturación en la ventana de complementos de pago: 
Cliente: FERROSUR, S.A. DE C.V.
FOLIO: 2548
El sistema no permite realizar el timbrado del complemento, agradecería su amable apoyo en timbrar el complemento de pago de igual forma.',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-27 15:32:00', 'Seguimiento de proceso, se mando a timbrar nuevamente el complemento mientras se comento la instruccion de powershell que falla en encontrarlo', 'Seguimiento de proceso', '2026-04-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000955');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000959', 'Baja de Factura en el Formato Comprobación de Viáticos', '2026-04-27 12:10:00', 'Se solicita de su amable apoyo para la Baja de Factura en el Formato Comprobación de Viáticos con un monto de $1,337.24, con usuario ccomercial2',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Fernández Velázquez, Málory Alanis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 11:10:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION y de INVENTARIO.FOLIO_FACTURA y se corrigio la secuencia en ambas tablas.', 'Modificación en BD', '2026-04-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000959');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000953', 'SOLICITUD DE ELIMINACION DE FACTURA', '2026-04-27 09:58:00', 'Buenos días por medio de la presente solicito el apoyo para  la eliminación de las facturas:
  11.15
  .64
  .11
Del usuario jdexpansion',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 09:58:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION y de INVENTARIO.FOLIO_FACTURA y se corrigio la secuencia en ambas tablas.', 'Modificación en BD', '2026-04-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000953');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000929', 'Cambio de fecha a investigación de mercado SIIP', '2026-04-24 11:03:00', 'se solicita su cambio de fecha de Investigación de mercado con número 10737 en la pagina del SIIP, cambiar a fecha 23 de abril del presente.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Hernández Chacha, Valeria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 15:02:00', 'Se realizó el cambio de fechas en INVENTARIO.INVESTIGACIONMERCADO', 'Modificación en BD', '2026-04-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000929');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000971', 'DESBLOQUEO DE SIIP -FACTURACION- VENTANA DE DEPOSITOS EN GARANTIA Y COBROS', '2026-04-27 17:35:00', 'Buenas tardes estimados a quien corresponda.
Agradecería su amable apoyo, desbloqueando el modulo siguiente ya que marca error en:
DEPOSITOS EN GARANTIA Y COBROS.',
  (select id from ventanas_mesa where nombre = 'COBROS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 16:00:00', 'Seguimiento de proceso, se eliminaron las sesiones duplicadas', 'Seguimiento de proceso', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000971');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000962', 'Solicitud de apoyo para subir complementos de pago', '2026-04-27 13:16:00', 'Buenas tardes, solicito su apoyo para poder subir complementos de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serían los siguientes folios: 
12776
12779
Pues me aparece el siguiente error: De igual manera, le adjunto los complementos de pago pendientes de subir.
Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 13:09:00', 'Seguimiento de proceso, se hizo uso del candado ''des'' por error de fechas diferentes en el sistema.', 'Seguimiento de proceso', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000962');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000969', 'SOLICITUD DE RELACIÓN DE CFDI DE FACTURACIÓN DE INGRESOS Y NOTAS DE CRÉDITO', '2026-04-27 16:42:00', 'Buenas tardes,
  estimados todos,
Por medio de la presente, se solicita su apoyo para proporcionar vía correo electrónico, la relación de CFDI de Ingreso y Notas de Crédito emitidos; correspondientes a los periodos ENERO, FEBRERO Y MARZO 2026. (Reportes mensuales de manera individual)
Sin otro que añadir, reciban un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Reportes'),
  (select id from solicitantes_mesa where nombre = 'Illescas Guevara, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 12:42:00', 'Seguimiento de proceso, se genero el reporte solictado de facturas y notas de credito', 'Seguimiento de proceso', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000969');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000951', 'SIIP Autorización de ingreso y activación de privilegios de operación', '2026-04-27 09:45:00', 'Buen día.
Me permito solicitar su apoyo para que me sea autorizado el ingreso al sistema SIIP y la activación de los privilegios de operación que correspondan.
Agradezco de antemano su apoyo, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Dominguez Barros, JoseLuis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-27 16:45:00', 'Se dio de alta al usuario en SIIP.', 'Modificación en BD', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000951');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000808', 'ERROR EN MODULO DE LICITACIONES/CONVOCATORIAS INVITACIONES O LICITACIONES', '2026-04-13 12:09:00', 'Buenos días:
Por este medio solicito de su apoyo ya que en el Modulo de Licitaciones en la pestaña convocatorias licitaciones o invitaciones en estado al seleccionar tramitar me arroja un mensaje de nuevo perfil y no me permite continuar.
Anexo captura de pantalla como evidencia:
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'ESTADO DE CONVOCATORIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-14 12:09:00', 'Seguimiento de proceso, se modifico la forma CPEDOCONVOCATORIA en la unidad de programa TRAMITAR para comentar las lineas 77, 78 y 79 para evitar el error presentado', 'Seguimiento de proceso', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000808');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000961', 'ERROR AL TRAMITAR EN MODULO LICITACIONES CONVOCATORIAS', '2026-04-27 12:45:00', 'Por este medio solicito de su apoyo ya que en el modulo de licitaciones en la pestaña:
-CONVOCATORIAS INVITACIONES LICITACIONES, en el apartado de estado en tramitar me arroja el siguiente error, y no me permite continuar con la captura de la convocatoria.
Anexo evidencia.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'ESTADO DE CONVOCATORIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 11:45:00', 'Seguimiento de proceso, se modifico la forma CPEDOCONVOCATORIA en la unidad de programa TRAMITAR para comentar las lineas 77, 78 y 79 para evitar el error presentado', 'Seguimiento de proceso', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000961');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000909', 'SUBIR NOTA DE CRÉDITO', '2026-04-22 15:36:00', 'Buenos días 
me podrían apoyar en subir la nota de crédito del folio de factura 86993, ya que cuenta con atributos fiscales distintos a los que tiene el sistema, pero que son válidos 
agradezco de antemano el apoyo 
Saludos!',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 11:10:00', 'Seguimiento de proceso, se hizo uso del candado ''des'' por error de atributos diferentes en el sistema.', 'Seguimiento de proceso', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000909');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000937', 'SUBIR NOTA DE CRÉDITO', '2026-04-24 12:26:00', 'Buenos días 
Me podrían apoyar en subir la nota de crédito del folio de factura 87055, ya que se emitió con atributos fiscales diferentes a los que tiene el sistema, pero que son válidos y se autorizaron por el área de finanzas.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 11:11:00', 'Seguimiento de proceso, se hizo uso del candado ''des'' por error de atributos diferentes en el sistema.', 'Seguimiento de proceso', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000937');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000977', 'Apoyo con cancelación de facturas en siip', '2026-04-28 11:47:00', 'Buenas tardes de su apoyo ya que por error adjunte mal una factura para la comprobación de viáticos, y no me deja ponerle la opción de borrar 5083',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Monroy Leon, Luis Fernando'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-28 16:47:00', 'Se elimino el registro de VIATICOS.VTCOSDETCOMPROBACION y de INVENTARIO.FOLIO_FACTURA asi como el archivo en la boveda', 'Modificación en BD', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000977');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000981', 'SOLICITUD DE CAMBIO DE FECHA EN PEDIDOS', '2026-04-28 13:14:00', 'Buenas tardes estimados
Por medio del presente solicito de su amable apoyo para el cambio de fecha en los siguientes pedidos: 
    37412.- Nueva fecha: 15/04/26
    37414 - Nueva fecha: 11/03/26
    37415 - Nueva fecha: 13/03/26
    37416 - Nueva fecha: 26/03/26
    37417 - Nueva fecha: 26/03/26
    37418 - Nueva fecha: 09/04/26
De antemano agradezco el apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-29 11:14:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS en el folio 37412,37414,37415,37416,37417,37418 de 28/04/2026 a 15/04/2026,11/03/2026,13/03/2026,26/03/2026,26/03/2026,09/04/2026 respectivamente', 'Modificación en BD', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000981');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000985', 'APOYO PARA ELIMINAR FACTURA EN COMPROBACIÓN DE VIATICOS.', '2026-04-28 16:28:00', 'SE SOLICITA SU APOYO PARA ELMINAR FACTURA DE COMPROBACIÓN DE VIATICOS DEL DG.
SE SEÑALA LA FACTURA CON No. DE COMPROBANTE 1520 Y CON MONTO DE 17.77 DLS QUE SE DESEA ELIMINAR.
DE ANTEMANO MUCHAS GRACIAS.
SALUDOS CORDIALES.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Altamirano Landa, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-29 11:28:00', 'Seguimiento de proceso, el usuario pudo realizar la accion sin problemas dentro del sistema', 'Seguimiento de proceso', '2026-04-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000985');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000979', 'CORRECCIÓN DE IVA X PAGAR NO COBRADO EN PÓLIZA DE INGRESO POR FACTURACIÓN 27/04/2026.', '2026-04-28 12:16:00', 'Buenas tardes,
    estimados todos,
  Por medio de la presente se solicita su apoyo con la Póliza de ingreso por facturación del día 27/04/2025, ya que en el I.V.A. X PAGAR 16% NO COBRADO (N° cuenta:211731911000002) se refleja un importe de $1,925,545.28 y el monto correcto es $1,129,552.03, dicho I.V.A. provienen de las Cuentas por Cobrar Pagadas, mismas que fueron cobradas a la empresa FERROSUR S.A. DE C.V. que a continuación se detallan:
COBRO-FACTURA
464639-985827
464640-985829
464641-985830
464642-985831
De antemano anticipo mi agradecimiento y quedo atento a cualquier adicional.
Sin otro particular, reciban un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'EXPORTACION DE POLIZAS A CONTABILIDAD'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Illescas Guevara, Miguel Angel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-29 10:16:00', 'En FACTURACION.MOVIMIENTOS se modifica el campo MOVMONTO y en FACTURACION.POLIZAS se modifico el campo POLIZAMONTOCARGOS para la poliza (1367,1366,1343,1342- 4 - ''I'' - 2026). Esto se debio a que se comprobo la diferencia entre los valores de las polizas de las facturas (Diario) con la cuenta CONTACLAVE del iva contra las polizas de las CTAXCOB que se encuentran visibles en FACTURACION.DETCOBROS', 'Modificación en BD', '2026-04-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000979');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000986', 'Solicitud de apoyo para cambio de fecha', '2026-04-28 17:50:00', 'Buenas tardes, solicito su apoyo para poder cambiar la fecha de los siguiente pedido:

Pedido: 37422
Fecha Solicitada: 23/04/2026

Gracias, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-29 15:50:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS en el folio 37422 de 28/04/2026 a 23/04/2026', 'Modificación en BD', '2026-04-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000986');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000984', 'Salida de existencia inventario.', '2026-04-28 16:23:00', 'Buenas tardes 
Se detalla lo siguiente:
Área           edificio principal.
Lugar         6 piso dpto. recursos materiales.
detalles     Para realizar salida de inventario de existencia almacén de 2 montacarga de patín hidráulico (003-001-004-024), el cual si se refleja en inventario pero al realizar la salida no permite continuar con la terminación total de la salida de suministro general.',
  (select id from ventanas_mesa where nombre = 'MOVIMINETOS DE ALMACEN X ENTRADAS/SALIDAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Movimientos de Almacen'),
  (select id from solicitantes_mesa where nombre = 'Arresola Martínez, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-29 11:23:00', 'En INVENTARIO.DETREQUIS se modifico el valor del campo CANTIDADREC de 0 a 2 para la REQUISICION = 133119 asi como en INVENTARIO.REQUISICIONES', 'Modificación en BD', '2026-04-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000984');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000849', 'BORRAR UNA REQUISICIÓN', '2026-04-16 12:30:00', 'SE SOLICITA BORRAR REQUISICIÓN CON NUMERO 133540 , YA QUE AL MOMENTO DE BORRARLA SE CONGELA LA PAGINA',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Hernández Chacha, Valeria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-17 10:30:00', 'Se elimino de manera manual de las tablas INVENTARIO.DETREQUIS y INVENTARIO.REQUISICIONES', 'Modificación en BD', '2026-04-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000849');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000992', 'SOLICITUD DE CAMBIO DE FECHA EN CONTRATO', '2026-04-29 10:54:00', 'Buenos días 
Por medio del presente, solicito de su amable apoyo, para el cambio de fecha en el contrato de servicios no. 37426, siendo la nueva fecha el día 30/03/2026
De antemano agradezco el apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-29 15:54:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS en el folio 37426 de 29/04/2026 a 30/03/2026', 'Modificación en BD', '2026-04-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000992');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000996', 'SOLICITUD DE CORRECCCIÓN TEMPORAL SIIP', '2026-04-29 12:43:00', 'Buenas tardes ingeniero, 
Por medio del presente solicito de su amable apoyo para cambiar temporalmente la firma del Director General por la del Gerente de Comercialización para realizar la impresión de mis viáticos, por favor 
Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-20 15:28:00', 'Se modificó la función VIATICOS.BDAUTORIZADOR. Se cambió el open curdir por open curjefe.', 'Modificación en BD', '2026-04-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000996');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000990', 'CAMBIO DE FECHA', '2026-04-29 09:12:00', 'Buen día por medio del presente solicito su apoyo para el cambio de fecha del pedido
37424 con fecha 21/04/2026

Agradeciendo su pronta respuesta quedo atento a sus comentarios
Saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-30 16:06:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000990');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000972', 'Cambio de fecha a investigación de mercado', '2026-04-27 17:43:00', 'Se solicita cambio de fecha a 27 de abril del presente de la Investigación de mercado con número 133542',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Hernández Chacha, Valeria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-30 12:16:00', 'Se realizó el cambio de fechas en INVENTARIO.INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-05-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000972');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000995', 'CAMBIO DE FECHA', '2026-04-29 12:39:00', 'Buenas tardes estimados.
Se solicita de su amable apoyo para poder realizar el cambio de fecha en investigacciones de mercado como en requisiciones a como se solicita a continuación.
REQ                                  IM         
133523         16/03/2026 
133524         20/03/2026                
133506         09/04/2026         10707         09/04/2026
133567         09/04/2026         10759         09/04/2026
Sin otro particular, se envía un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-30 12:07:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-05-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000995');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001020', 'MOMENTOS CONTABLES PRESUPUESTALES', '2026-05-04 11:43:00', 'Buenos días:
Por favor su apoyo para el cambio en monto de los momentos contables presupuestales de la Póliza Diario 477 del mes de abril 2026.

DICEN: 53,439.35
DEBEN DECIR: 53,439.36',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-05 10:43:00', 'En CONTA.MOVIMIENTOS se modifico el campo MOVMONTO para todos los registros indicados, asi como en CONTA.POLIZAS se modificaron los campos POLIZAMONTOCARGOS y POLIZAMONTOABONOS', 'Modificación en BD', '2026-05-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001020');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001021', 'solicitud de eliminar factura', '2026-05-04 11:47:00', 'Buenos días, solicito su apoyo para eliminar el registro por el monto de $814.00 en la comprobación de viáticos del Subgerente de Administración Dr. Jose Miguel Alvarado',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Flores Saldaña, Andrea'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-05 10:47:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA, VIATICOS.VTCOSDETCOMPROBACION y los archivos de la bóveda. Se renombraron los registros para mantener la secuencia.', 'Modificación en BD', '2026-05-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001021');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000970', 'CAMBIO DE FECHA EN PEDIDO', '2026-04-27 17:30:00', 'Buenas tardes 

Por medio del presente, solicito de su amable apoyo para realizar el cambio de fecha en el pedido 37408 con fecha 27/04/2026.

La fecha correcta debe ser: 27  de febrero de 2026.

agradezco de antemano el apoyo 

Saludos!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-05 09:46:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000970');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001023', 'Monto en cuenta contable a proveedor', '2026-05-04 13:16:00', 'Buenas tardes, 
Se solicita su apoyo con el cambio de monto en el momento contable presupuestal de la siguiente cuenta:  211210111001508
Dice:  157,009.82
Debe decir:  157,009.83
Los totales también deberán ser impactados
Dice:   292,893.72  
Debe decir:   292,893.73  
Gracias',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Montero Otal, Elisa Margarita'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-05 10:43:00', 'En CONTA.MOVIMIENTOS se modifico el campo MOVMONTO para el registro indicado, asi como en CONTA.POLIZAS se modificaron los campos POLIZAMONTOCARGOS y POLIZAMONTOABONOS', 'Modificación en BD', '2026-05-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001023');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001030', 'CAMBIO DE FECHA', '2026-05-04 17:04:00', 'Buenas tardes estimados.
Solicito de su amable apoyo para poder realizar el cambio de fecha de lo mencionado a continuación:
REQ  133571  AL 19/03/2026
IM 10764  AL 19/03/2026
De ante mano muchas gracias.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-05 17:24:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO del 04/05/2026 a 19/03/2026.', 'Modificación en BD', '2026-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001030');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001003', 'PROBLEMAS CON EL FOLIO 87018', '2026-04-30 11:29:00', 'Buen día 
Por medio de la presente, solicito su apoyo con la factura con folio 87018, lo anterior debido a que no aparece en el SIIP, no fue borrado por una servidora, solo se intento autorizar para procesar el pago.
Proveedor: SUPERVISION TECNICA DEL NORTE, S.A. DE C.V..
De antemano gracias, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-01 09:29:00', 'Seguimiento de proceso, se verifico en sistema que la factura fue eliminada por otro usuario en una fecha posterior', 'Seguimiento de proceso', '2026-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001003');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001041', 'HABILITACION "COMPROBACION DE VIATICOS" SIIPV2', '2026-05-06 11:19:00', 'Buenos días, por este medio solicito su amable apoyo para habilitar el apartado de "Comprobación de viáticos" en mi portal SIIPV2.

Sin otro particular, aprovecho a enviar un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-06 16:19:00', 'Se asignaron privilegios de Comprobación de viáticos.', 'Modificación en BD', '2026-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001041');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001038', 'Error Mediport', '2026-05-06 09:07:00', 'Buenas tardes

Por este medio se solicita su valioso apoyo con el siguiente error en Mediport referente al Contrato ASPN-GI-CS-62601-003-26 de ARGO CONSULTORES AMBIENTALES SA DE CV:',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-06 13:07:00', 'La empresa volvió a timbrar su factura corrigiendo la diferencia de 41 centavos.', 'Modificación en BD', '2026-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001038');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001035', 'ABRIR CANDADO DEL PROVEEDOR 45 COMISION FEDERAL DE ELECTRICIDAD', '2026-05-05 11:31:00', 'Estimados ingenieros, su apoyo con abrir el candado para liberar el pago del proveedor 45 COMISION FEDERAL DE ELECTRICIDAD, a fin de poder realizar el pago correspondiente a la factura folio 87053.

Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-05 16:31:00', 'Se cambió temporalmente a 5 el ESTADO en INVENTARIO.FOLIO_COMPLEMENTO.', 'Modificación en BD', '2026-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001035');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001040', 'Solicitud de apoyo para subir complemento de pago.', '2026-05-06 10:39:00', 'Buenas tardes, solicito su apoyo para poder subir complementos de pago de GRUPO MAS en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serían los siguientes folios: 



Pues me aparece el siguiente error: 



De igual manera, le adjunto los complementos de pago pendientes de subir.
Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-06 15:39:00', 'Se hizo uso del candado ''des'' por error en diferencia de fecha.', 'Seguimiento de proceso', '2026-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001040');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000988', 'Solicitud de apoyo para subir complemento de pago.', '2026-04-29 09:04:00', 'Buenas días, solicito su apoyo para quitar el candado en el complemento de pago de DHL, del folio:

Pues me aparece el siguiente error:


De igual manera le adjunto el complemento de pago que se intenta subir.
Quedó atenta a sus comentarios, gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-30 12:36:00', 'Se hizo uso del candado ''des'' por error en cantidad de dígitos decimales.', 'Seguimiento de proceso', '2026-05-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000988');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001039', 'DIFERENCIA DE MONTO AL VALIDAR LA FACTURA', '2026-05-06 10:07:00', 'Por medio de la presente solicito su apoyo para validar la factura con folio 87102, ya que presenta una diferencia de 14 centavos por debajo del pedido 37424 a lo pagado al proveedor: DISTRIBUIDORA JUGUETRON, S.A. DE C.V.

Anexo imagen del error y archivos de facturación para mayor referencia',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-07 10:45:00', 'Se hizo uso del candado ''des'' por diferencia de 14 centavos.', 'Seguimiento de proceso', '2026-05-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001039');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001054', 'CAMBIO DIRECTA CONTRATO', '2026-05-07 10:47:00', 'Por este medio solicito de su apoyo para el cambio de Adjudicación: DIRECTA /CONTRATO
Para el contrato: 37386 el cual ya se encuentra en estado abierto para que puedan realizar las modificaciones solicitadas.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-08 09:47:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-05-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001054');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001056', 'COBRO INTERES MUELLAJE IMPORTACION', '2026-05-07 12:04:00', 'Buen día
En el módulo de MUELLAJE facturación del SIP, no se visualiza la fecha de fin de operaciones del buque ID 260433, ZHEN HUA 26 .
Afectando lo anterior, al cobro de interés moratorio.
Quedamos atentos, para cualquier duda o comentario.
Saludos',
  (select id from ventanas_mesa where nombre = 'FACTURACION X MUELLAJE DE MERCANCIA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Muellaje'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-08 11:04:00', 'Seguimiento de proceso, se verifico mediante el procedimiento F_CalculaInteres que el viaje no contaba con ningun movimiento en OPERACIONES.MOV_BUQUES (Esto es necesario para el campo Fin Op, Unidad de programa MUESTRADATOS)', 'Seguimiento de proceso', '2026-05-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001056');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000637', 'DAR DE BAJA DORMATOS DE CARTAS EN EL SIRE', '2026-03-24 09:05:00', 'BUEN DÍA 

DEL DEPARTAMENTO DE CALIDAD NOS REPORTAN QUE HAN DETECTADO QUE LOS PRESTADORES DE SERVICIOS QUE SUBEN REQUISITOS EN EL SIRE, DESCARGAN DEL MISMO SIRE UNOS BOSQUEJOS PARA CARTAS ANEXOS, INFORMANDO QUE DICHAS CARTAS SE ENCUENTRAN CARGADAS EN EL SIRE, MIS SOLICITUDES, ANEXOS.

SE SOLICITA DAR DE BAJA DICHOS FORMATOS, PUESTO QUE CONTIENEN INFORMACIÓN OBSOLETA.

MUCHAS GRACIAS',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-04-27 10:42:00', 'Se modificó MasterPageFormas.master del tablero Contratos. Se dejó comentado el fragmento que mostraba la opción de Formatos en el side bar.', 'Modificación en BD', '2026-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000637');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001036', 'Error Mediport', '2026-05-05 12:33:00', 'Buenos días, 

Por este medio se solicita su valioso apoyo referente al contratista  SG CIMENTACIONES del contrato: ASP-GI-CO-62601-015-25, el cual no le permite cargar sus estimación:

Agradeciendo de antemano sus finas atenciones, reciba un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-05 17:33:00', 'El UUID RELACIONADO del archivo que estaban intentando cargar corresponde a un anticipo anterior. Se pidió retimbrar con la relación correcta, la correspondiente al anticipo actual.', 'Seguimiento de proceso', '2026-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001036');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001067', 'SE SOLICITAN LOS ACCESOS SIIP (PERFIL COMPRADOR)', '2026-05-08 12:25:00', 'Estimados Ingenieros, buen día.
Por medio del presente, solicito el apoyo para generar los accesos en sistema SIIP para la Lic. Rosa Isela Fierro Escobedo, Auxiliar Administrativo con correo electrónico; auxadmon@puertodeveracruz.com.mx con los mismos atributos que en su momento tenía el perfil de la Lic. Alessandra Durante Crivelli.
Agradeciendo su atención, quedo atento. saludo cordial.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-11 09:25:00', 'Seguimiento de proceso, se genero el usuario para el sistema SIIP', 'Seguimiento de proceso', '2026-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001067');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001061', 'CAMBIO EN REQUISICION', '2026-05-07 21:53:00', 'Buenas tardes estimados.
Se solicita de su amable apoyo para realizar el cambio de fecha de la siguiente requisición:
133571 a la fecha 19-03-2026
De igual forma se solicita agregar texto en el apartado resultados y conclusiones de la Investigación de Mercado 010764 (era la 10759) como se muestra en el documento adjunto.
Sin otro particular, se envía un cordial saludo.
De ante mano, muchas gracias.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-05 17:24:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES del 04/05/2026 a 19/03/2026 y en INVENTARIO.INVESTIGACIONMERCADO se modifico el campo CONCLUSIONES', 'Modificación en BD', '2026-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001061');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001063', 'CAMBIO DE FECHA DEL PEDIDOS', '2026-05-08 09:53:00', 'Buenas tardes
Por medio de la presente solicito su apoyo con el cambio de fecha de los siguientes pedidos:
-37433 fecha solicitada:10/04/2026
-37446 fecha solicitada:29/04/2026
Sin otro particular, envio un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-11 08:50:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS de 04/05/2026 a 10/04/2026 y el segundo pedido de 07/05/2026 a 29/04/2026', 'Modificación en BD', '2026-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001063');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001065', 'Baja de Facturas en el Formato Comprobación de Viáticos.', '2026-05-08 12:01:00', 'Solicito su valioso para dar de baja las siguientes facturas en el Formato Comprobación de Viáticos:
806237, 9169 y 57.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Fernández Velázquez, Málory Alanis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-08 17:01:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION y de INVENTARIO.FOLIO_FACTURA y se corrigio la secuencia en ambas tablas.', 'Modificación en BD', '2026-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001065');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001069', 'CAMBIO DE FECHA', '2026-05-08 15:30:00', 'Buenas tardes por medio del presente solicito el apoyo con el cambio de fecha del seguirte pedido 
PEDIDO/ORDEN 37450 CON FECHA DE 06/MARZO/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-11 11:07:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS de 08/05/2026 a 06/03/2026', 'Modificación en BD', '2026-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001069');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001057', 'SUBIR COMPLEMENTOS DE PAGO', '2026-05-07 12:08:00', 'Buenas tardes 
Solicito su apoyo para poder subir los complementos de pago de siguiente proveedor',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-11 08:50:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001057');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001073', 'PRIVILEGIO', '2026-05-08 17:23:00', 'Buena tarde compañeros


Por este medio solicito de su apoyo para acceder al modulo de viáticos que se encuentra en el SIIPV2, mi usuario es IVARGAS por comisión a la ciudad de México.

Quedo atenta de su respuesta.

Saludos',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Vargas Zapata, Maria Isabel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-11 11:23:00', 'Se dio de alta en módulo de viáticos y se asignaron privilegios.', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001073');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001070', 'APOYO EN APERTURA PARA CARGA DE FACTURA', '2026-05-08 16:26:00', 'SE SOLICITA EL AMABLE APOYO CON APERTURA PARA CARGA DE FACTURA, TOD AVEZ QUE, EXISTE UN COMPLEMENTO PENDIENTE POR PARTE DEL PROVEEDOR GRUPO METROPOLITANO. LO ANTERIOR, CON LA FIANLIDAD DE REALIZAR LOS PAGOS CORRESPONDIENTES, YA QUE ES UN SERVICIO PRIORITARIO PARA LA ENTIDAD. 

ASIMISMO, CABE RESALTAR QUE FUE SOLICITADO AL PROVEEDOR, MISMO QUE SE ENCUENTRA EN PROCESO DE ENVÍO.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-11 11:55:00', 'Se cambió temporalmente el ESTADO a 5 en INVENTARIO.FOLIO_COMPLEMENTO.', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001070');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001086', 'SOLICITUD DE CAMBIO DE NOMBRE DE USUARIO SIIP', '2026-05-11 11:13:00', 'BUEN DIA POR MEDIO DEL PRESENTE, SE SOLICITA EL AMABLE APOYO CON EL CAMBIO DE NOMBRE DE MI USUARIO SIIPV, TODA VEZ QUE AL IMPRIMIR LOS FORMATOS SALE CON NOMBRE DE LA PERSONA ANTERIOR AL PUETSO. 

MUCHAS GRACIAS.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-11 17:13:00', 'Se cambió el NOMBRE y el TRABNUM en INVENTARIO.USUARIOS para corregir el nombre que aparece en el reporte de PEDIDOS. No se puede dar de baja un usuario de INVENTARIO.USUARIOS porque tiene restricción en la tabla INVENTARIO.BITACORA.', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001086');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001092', 'ACESO PARA EL MODULO DE VIATICOS', '2026-05-11 15:09:00', 'Visualizo con mi usuario el modulo de viaticos pero no tengo los privilegios por lo cual solicto el apoyo',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Garcia Lopez, Elvira del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-12 10:09:00', 'Se dio de alta en módulo de viáticos.', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001092');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001093', 'COLOCACIÓN DE COMPROBACIÓN DE VIATICOS', '2026-05-11 15:38:00', 'SE COLOCO LA INFORMACIÓN CORRESPONDIENTE AL APARTADO DE DETALLE DE LA COMPROBACION DE VIATICOS DEL MONTO $425 , PERO NO APARECE EN LA LISTA Y AL VOLVERLO A COMPROBAR , APARECE LA VENTANA QUE NO SE PUEDE MODIFICAR EL REGISTRO QUE HAN SIDO CARGADOS LOS ARCHIVOS XML Y PDF.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Hernández Chacha, Valeria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-12 10:38:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001093');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001080', 'SOLICITUD DE ACTUALIZACIÓN DE LLAVES DE ACCESO', '2026-05-11 09:05:00', 'BUEN DÍA,

POR MEDIO DEL PRESENTE SOLICITO SU AMABLE APOYO CON LA ACTUALIZACIÓN DE LAS LLAVES DE ACCESO PARA LOS SITEMAS SIIPV, MEDIPORT Y MESA DE AYUDA, TODA VEZ QUE DERIVADO DEL MOVIMIENTO INTERNO DE SU SERVIDOR: JOSE GABRIEL MORFINEZ ANAYA A LA JEFATURA DE LO CONTENCIOSO, ME FUE ASIGNADO EL CORREO INSTITUCIONAL jdcontencioso@puertodeveracruz.com.mx, NO OBSTANTE, NO ME ES POSIBLE INGRESAR A LAS PLATAFORMAS INSTITUCIONALES CON MIS NUEVAS CREDENCIALES, TENIENDO QUE RECURRIR A LA ANTERIOR: ccontratos2@puertodeveracruz.com.mx.

SIN OTRO PARTÍCULAR, QUEDO PENDIENTE DE SUS COMENTARIOS.

SALUDOS.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Díaz Ortíz, Oscar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-11 16:05:00', 'Se dio de alta al usuario en SIIP y se compartieron credenciales de acceso mediante correo electrónico.', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001080');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000991', 'Apoyo con falla en el SIIP', '2026-04-29 09:51:00', 'Buenos días, solicito su apoyo con un fallo en el SIIP, en el área de PEDIDOS -> CONDICIONES COMERCIALES, cuando edito el texto para que coincida con mi pedido de servicios, le doy a modificar, tramitar e imprimir; la hoja de pedido de servicios que me genera no sale modificada: 
Como referencia, me encuentro realizando el pedido: 37425
Quedó atenta a sus comentarios, le agradezco.
Saludos.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-29 13:51:00', 'Se modifico en INVENTARIO.CONTROLES el campo CLAUSULAS asi como en INVENTARIO.PEDIDOS en el campo de PENALIZACION de manera temporal', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000991');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000994', 'CAMBIO DE FECHA Y DETALLE EN IMPRESION', '2026-04-29 12:23:00', 'Por este medio solícito de su apoyo para el cambio de fecha del contrato: 37423 para cambio de fecha debe decir: 30/03/2026.
Así como del contrato: 37430 cambio de fecha debe decir: 10/04/2026.
Aprovecho para comentar que a la hora de imprimir los contratos no se ven reflejadas las condiciones comerciales que se modificaron anexo evidencia de lo anterior.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-04-29 17:23:00', 'Se modifico en INVENTARIO.CONTROLES el campo CLAUSULAS asi como en INVENTARIO.PEDIDOS en el campo de PENALIZACION de manera temporal', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000994');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001042', 'Apoyo con falla en el SIIP', '2026-05-06 11:20:00', 'Buenos días, desde el día lunes se ha presentado un problema con el SIIP, siendo este que en el apartado de pedidos cuando se selecciona alguna de las cotizaciones previamente realizadas no aparece la información relacionada (requisición, proveedor, observaciones, etc.), tal como se presenta en la siguiente imagen: 
Mostrando image.png
Quedó atenta a sus comentarios, le agradezco.
Saludos.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-06 16:20:00', 'Se modifico en INVENTARIO.CONTROLES el campo CLAUSULAS asi como en INVENTARIO.PEDIDOS en el campo de PENALIZACION de manera temporal', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001042');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001071', 'Apoyo con SIIP', '2026-05-08 16:38:00', 'Buenas tardes, tratando de continuar con una comprobación en el apartado de PEDIDOS, seleccione una que habia realizado anteriormente en COTIZACIONES, sin embargo me encuentro con que no aparecen los detalles de la cotización en el área de PEDIDO, de tal manera:',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-11 10:38:00', 'Se agrego manualmente el registro en INVENTARIO.DETPEDIDOS, INVENTARIO.DISTRPEDIDOS y se actualizaron los campos CANTIDADORD en INVENTARIO.DETREQUIS, INVENTARIO.REQUISICIONES y tambien se cambio el ESTADO de 4 a 5', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001071');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001074', 'ELIMINACION DE FACTURA EN COMPROBACION DE VIATICOS', '2026-05-08 17:51:00', 'BUENAS TARDES, POR ESTE MEDIO SOLICITO SU APOYO PARA EIIMINAAR UNA FACTURA EN LA PLATOFORMA SIIPV PARA LA REALIZACION DE UNA COMPROBACION DE VIATICOS. SE DETALLA ACONTINUACION LOS DATOS DE LA MISMA:
RUBRO: 4
DESCRIPCION:CONSUMO DE ALIMENTOS 
MONTO:177.52

SIN OTRO PARTICULAR, ENVIO UN CORDIAL SALUDO.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Garcia Saldaña, Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-11 11:51:00', 'Se eliminó el registro de VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001074');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001007', 'CAMBIO DE FECHA DEL PEDIDO 37427', '2026-04-30 13:12:00', 'Buenas tardes

Por medio de la presente, solicito su apoyo con el cambio de fecha del pedido 37427.

Fecha solicitada: 37427.

Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-01 11:12:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001007');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001099', 'Solicitud de apoyo para subir complementos de pago.', '2026-05-12 10:14:00', 'Buenos días,  solicito su apoyo para quitar el candado en el complemento de pago de CFE, del folio

Pues me aparece el siguiente error:

De igual manera le adjunto el complemento pendiente de subir.
Quedó atenta a sus comentarios, gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-13 12:34:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001099');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001087', 'CAMBIO DE ESTADO DE RECEPCION DE MATERALES A TRAMITE', '2026-05-11 11:21:00', 'SE SOLICITA EL AMABLE APOYO CON EL CAMBIO DE ESTADO EN EL APARTADO DE RECEPCIÓN DE MATERIALES, DE LOS EMBARQUES 41210 Y 41212, CORRESPONDIENTE AL PROVEEDOR GRUPO MAS, YA QUE ACTUALMENTE SE ENCUENTRA PARCIALMENTE FACTURADO, POR LO QUE SE SOLICITA EL CAMBIO A ESTADO ABIERTO.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE MATERIALES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-12 14:00:00', 'Se cambió a 1 (abierto) el ESTADO en INVENTARIO.EMBARQUES.', 'Modificación en BD', '2026-05-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001087');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001094', 'cambio de fecha en la requisición e investigación de mercado', '2026-05-11 15:46:00', 'Buenas tardes, 

Solicito tenga a bien cambiar las fechas en la requisición e investigación de mercado con numero Req. 133577 e investigación de mercado 010770 agradezco que todas las fechas sean 04/05/202



Gracias',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-12 13:27:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-05-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001094');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001100', 'SOLICITUD DE APOYO CON CARGA DE COMPLEMENTOS', '2026-05-12 10:15:00', 'BUEN DÍA, SE SOLICITA EL AMABLE APOYO CON LA CARGA DE LOS SIGUIENTES COMPLEMENTOS: 






DERIVADO DE LA DIFERENCIA DE LA FECHA ESPERADA Y DE LA QUE TIENE EL COMPLEMENTO DE PAGO. 

SE ADJUNTAN LOS ARCHIVOS PARA PRONTA REFERENCIA.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-13 11:18:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001100');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001095', 'CARGA ERRONEA DE ARCHIVO TXT', '2026-05-11 16:13:00', 'Buenas tardes,

De la manera más atenta solicito su apoyo para eliminar la carga del txt con fecha de alta 11 de mayo de 2026 realizada en el apartado importación de avisos, debido a que no se procesaron los datos correctamente.

Cualquier duda quedo a  la orden.

Saludos.',
  (select id from ventanas_mesa where nombre = 'AVISOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cuentas por Pagar'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-12 13:13:00', 'Se eliminaron los registros de INVENTARIO.NOTIFICA_AVISO con la FECHA_ALTA de 11/05/2026.', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001095');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001104', 'Baja de Factura en el Formato Comprobación de Viáticos.', '2026-05-12 10:58:00', 'Se solicita de su amable apoyo para bajar del Formato Comprobación de Viáticos del monto de 63.90.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Fernández Velázquez, Málory Alanis'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-13 09:58:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, VIATICOS.VTCOSDETCOMPROBACION y de la bóveda. Se renombraron los registros para conservar la secuencia.', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001104');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001116', 'Solicitud de apoyo para cambio de fecha', '2026-05-13 10:29:00', 'Buenas tardes, solicito su apoyo para poder cambiar la fecha de los siguiente pedido:

Pedido: 37409
Fecha Solicitada: 17/04/2026


Gracias, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-13 17:29:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001116');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001115', 'SOLICITUD DE MODIFICACION EN ACTA ENTREGA RECEPCIÓN', '2026-05-13 10:21:00', 'Estimados,
Espero que se encuentren bien.
Por medio del presente, solicito su apoyo para modificar el acta de entrega-recepción del módulo de licitaciones, correspondiente al embarque no. 38209.
En el apartado de "Recibe", se debe sustituir al Contralmirante Leyva por el Ing. Gabriel Hernández, cuyo número de empleado es 69386.
De antemano agradezco el apoyo, 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'DETALLES DE PAGOS EL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Licitaciones'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-13 17:21:00', 'Se modifico en INVENTARIO.DETSOLCONTRATOS y en INVENTARIO.MOVALMS el campo TRABNUM_RECIBE de 40246 a 69386', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001115');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001108', 'Apoyo con falla en el SIIP', '2026-05-12 13:28:00', 'Buen día, solicito su apoyo con un error que esta ocurriendo en el SIIP, pues en la orden #37432 me esta agregando 44 unidades de vuelos en el apartado de PEDIDO como se presenta en la siguiente imagen:
Cuando yo originalmente solo puse 1 en el apartado de COTIZACIÓN, esto causa un problema pues nos deja sin unidades de vuelos.
Como referencia me encuentro realizando la orden 37432.
Quedó atenta de sus comentarios.
Le agradezco de antemano su apoyo y le envió saludos.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-13 11:28:00', 'Se modifico el registro en INVENTARIO.DETPEDIDOS, INVENTARIO.DISTRPEDIDOS con la cantidad de 46 a 1 y se actualizaron los campos CANTIDADORD en INVENTARIO.DETREQUIS, INVENTARIO.REQUISICIONES y tambien se cambio el ESTADO de 5 a 4', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001108');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001119', 'NO TIMBRADO DE NOTA DE EGRESO', '2026-05-13 13:31:00', 'Buena tarde
Agradecemos el apoyo con el timbrado de la nota de egreso 18665, folio 15768
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-14 09:31:00', 'En FACTURACION.VTNOTASCREDITO se modifico el campo MONTO asi como en FACTURACION.FACTURAS_TIMBRADOR se regreso el campo TIMBRADO a 0', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001119');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001118', 'SOLICITUD DE CAMBIO DE FECHA EN PEDIDO', '2026-05-13 13:04:00', 'BUEN DÍA, POR MEDIO DEL PRESENTE SE HACE LA SOLICITUD DE CAMBIO DE FECHA EN PEDIDO 37470 QUEDANDO CON FECHA 04/05/2026.

MUCHAS GRACIAS',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-14 09:04:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS de 13/05/2026 a 04/05/2026.', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001118');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001084', 'CAMBIO DE NOTA DE CRÉDITO EN SISTEMA', '2026-05-11 10:09:00', 'Buenos días 



solicito de su amable apoyo ya que en días pasados levante la mesa de ayuda terminación 937 para subir una nota de crédito, al momento de subirla, seleccioné los archivos incorrectos, por lo que solicito nuevamente su apoyo para habilitar la nota de crédito del folio de factura 87055 del proveedor 105868 y poder subir los archivos correctos. 

Le agradezco de antemano el apoyo 

Saludos!!',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-12 15:12:00', 'Se eliminaron los registros de CFDCONNECT.CFD_RECEPCION, CFD_CUSTOM_DATA y los archivos de la bóveda.', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001084');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001107', 'USUARIO Y CONTRASEÑA PARA SISTEMA INTEGRAL', '2026-05-12 13:22:00', 'Solicito apoyo para generar usuario para Sistema Integral.
Estado / Subestado:        
Asignada a un grupo
-
Pendiente',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/Integral'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Domínguez, Laura Irene'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-13 09:22:00', 'Se agrego el registro en SERVICIO.CONTACTOS01 y en SERVICIO.USUARIOS32, asi como tambien se agregaron los registros de permisos en SERVICIO.CONTACTO_PERMISO16', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001107');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001117', 'ELIMINACION DE FACTURA EN COMPROBACION DE VIATICOS', '2026-05-13 12:53:00', 'Por medio del presente solicito de su amable apoyo, para que se realice la eliminación del sistema SIIP de las siguientes facturas:

254
654
789
987
Del usuario:jdexpansion 

Muchas gracias saludos cordiales',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-14 10:53:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA y de VIATICOS.VTCOSDETCOMPROBACION.', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001117');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001120', 'CAMBIO DE FECHA', '2026-05-13 15:27:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido de servicios: 37466

Debe decir: 07/05/2026.


Quedo atenta a sus indicaciones.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-14 12:27:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001120');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001123', 'Apoyo con falla en el SIIP', '2026-05-14 10:39:00', 'Buen día, solicito su amable apoyo con una falla que se esta presentando en el SIIP, pues al momento de autorizar un pedido me aparece que no hay presupuesto y no me relaciona el pedido a ninguna póliza, como se presenta en la siguiente imagen: 
Sin embargo, lo consulte y si existe el presupuesto en la partida que se esta utilizando, la partida #37104, de igual manera le comparto la imagen en donde se puede visualizar el presupesto:
Mostrando image.png
Como referencia me encuentro en la orden: 37471
Quedó atenta a sus comentarios, le agradezco.
Saludos.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-14 15:39:00', 'Se revirtió el ESTADO en INVENTARIO.PEDIDOS a 1 (tramitado) y se eliminó el valor de FECHAAUTORIZA y USUAUTORIZA.', 'Modificación en BD', '2026-05-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001123');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001121', 'AUTORIZACION PARA CRM', '2026-05-13 15:36:00', 'Por medio del presente solicito su amable apoyo para habilitar en CRM a las licenciadas:
Malory Alanis Fernández Velázquez
Alessandra Durante Crivelli
Esto debido a que es parte de sus funciones el registro en el sistema.
Agradezco de antemano la atención y quedo atenta a sus comentarios.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Haruel Aguirre, Lizbeth'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-14 12:36:00', 'Se agrego el registro en SERVICIO.CONTACTOS01 y en SERVICIO.USUARIOS32, asi como tambien se agregaron los registros de permisos en SERVICIO.CONTACTO_PERMISO16', 'Modificación en BD', '2026-05-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001121');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001142', 'Cambio Nombres de encargados CTO. 004-25', '2026-05-15 12:28:00', 'A quien corresponda:
Solicito de su apoyo para realizar cambios de nombre en el puesto de Residente y Jefe de Departamento de Mantenimiento en el contrato de obra No. ASPN-GI-CO-62602-004-25 a cargo de la empresa EDIFICACIONES CARRETERAS Y PUERTOS MX, S.A. DE C.V.
Debe decir:
Residente: ING. ENRIQUE ANELL ORTIZ
Jefe de Departamento de Matenimiento: ING. OSCAR HILARIO MORALES HERNANDEZ  
ANEXO IMAGEN DEL ESTADO ACTUAL DE SISTEMA:',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Obras (Extranet)'),
  (select id from solicitantes_mesa where nombre = 'Anell Ortiz, Enrique'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-18 11:28:00', 'En OBRAS.FIRMAS_CONTRATO se modifico el campo RESOBRA de 69579 a 69659', 'Modificación en BD', '2026-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001142');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001127', 'Complemento de Pago Mediport', '2026-05-14 15:27:00', 'Buen día,
Comparto lo comentado en la llamada. Actualmente presentamos un error al intentar subir el complemento de pago en el portal MediPort, ya que el sistema muestra diferencias en los importes del complemento emitido.
La facturación fue realizada directamente desde la página del SAT; sin embargo, el sistema no realiza el descuento de las facturas de egreso relacionadas, por lo que continúa apareciendo un saldo “pendiente”.
Adjunto el complemento de pago emitido el mismo día en que se recibió el recurso, así como la evidencia del mensaje mostrado por el portal, para su revisión y apoyo con las indicaciones correspondientes
Folio Fiscal
Monto Pago
Fecha Pago
FFD5C032-381C-4D81-AA10-03F19401A835
$714,880.00
08/05/2026
Sin más por el momento, quedo pendiente de sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-15 13:27:00', 'Se realizó manualmente la carga del complemento de pago debido a un error de Diferencia en Importe anterior e Importe insoluto. El sistema contemplaba los valores únicamente para el complemento de pago; mientras que, el complemento, contemplaba los importes dentro del contrato antes y después del pago.', 'Seguimiento de proceso', '2026-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001127');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001150', 'Eliminación de 2 facturas en comprobación de viáticos', '2026-05-15 16:07:00', 'Se solicita de su apoyo para la eliminación de 2 facturas ingresadas al programa SIIP #5098 de la comprobación de viáticos de Daniel González Dominguez:

La factura $220
La factura $575',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'González Dominguez, Daniel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 13:07:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, VIATICOS.VTCOSDETCOMPROBACION y los archivos de la bóveda. Se renombraron los registros para mantener la secuencia.', 'Modificación en BD', '2026-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001150');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001144', 'CARGA DE COMPLEMENTO DE PAGO', '2026-05-15 12:36:00', 'Buenas tardes

Por medio de la presente, solicito su amable apoyo con la carga del complemento de pago del folio 12769 del proveedor EDENRED.

Se adjunta complemento de pago.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 09:28:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001144');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001132', 'CAMBIO DE FECHA', '2026-05-14 17:34:00', 'Buenas tardes por medio del presente solicito el apoyo con el cambio de fecha del seguirte pedido 

PEDIDO/ORDEN 37477 CON FECHA DE 04/MAYO/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 13:06:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001132');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001139', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 133585 E INVESTIGACIÓN DE MERCADO 10776.', '2026-05-15 10:36:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 133585.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 15/05/2026
F. REQUIERE: 15/05/2026
F. RECEPCIÓN: 15/05/2026
DEBE DECIR: 08/05/2026
Asimismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10776, dentro del apartado "Investigación de Mercado", ya que emana de la Requisición antes descrita.
La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 15/05/2026
DEBE DECIR: 08/05/2026
También se solicita se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10776, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA ACT: 15/05/2026
DEBE DECIR: 08/05/2026
FECHA COTIZACIÓN: 15/05/2026
DEBE DECIR: 07/05/2026
Quedo atenta a cualquier comentario al respecto.
Agradeciendo su apoyo de antemano, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 13:06:00', 'Se realizó el cambio de fechas en INVENTARIO.INVESTIGACIONMERCADO, REQUISICIONES y PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001139');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001140', 'CAMBIO DE FECHA', '2026-05-15 10:37:00', 'Buenos días estimados.

Solicito de su amable apoyo para realizar el cambio de fecha de la requisición 133571 a la fecha 19/03/2026.

De ante mano muchas gracias.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 13:09:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001140');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001148', 'CAMBIO DE FECHA', '2026-05-15 15:39:00', 'Por este medio solicito de su apoyo para el cambio de fecha de los siguientes pedidos:

-37487-Debe decir: 24/04/2026.



Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 13:15:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001148');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001152', 'Solciitud de apertura en comprobacion de viaticos SIIP', '2026-05-15 17:11:00', 'Solciitud de apertura en comprobacion de viaticos SIIP',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'González Dominguez, Daniel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 12:11:00', 'Se revirtió el estado en VTCOSCOMPROBACION de 2 (tramitado) a 1 (abierto).', 'Modificación en BD', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001152');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001146', 'SOLICITUD EN CAMBIO DE FECHA DE PEDIDOS', '2026-05-15 14:17:00', 'BUEN DÍA, POR MEDIO DEL PRESENTE SE HACE LA SOLICITUD DE CAMBIO DE FECHA EN LOS SIGUIENTES PEDIDOS:

37484 QUEDANDO CON FECHA 29/04/2026.
37472 QUEDANDO CON FECHA 16/03/2026.

MUCHAS GRACIAS',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 13:16:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001146');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001145', 'SOLICITUD EN CAMBIO DE FECHA DE PEDIDOS', '2026-05-15 13:26:00', 'Buenas tardes estimados

Por medio del presente solicito de su apoyo, para el cambio de fecha en el pedido de servicios no. 37482, siendo la nueva fecha, el día 23/04/2026 

De antemano agradezco el apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 10:38:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001145');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001151', 'Solicitud de apoyo para cambio de fecha', '2026-05-15 16:37:00', 'Buenas tardes, solicito su apoyo para poder cambiar la fecha de los siguiente pedido:

Pedido: 37488
Fecha Solicitada: 20/03/2026


Gracias, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 12:17:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001151');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001159', 'ACCESO A SIIP MIGRACIÓN DE INFORMACIÓN', '2026-05-18 10:07:00', 'Buen día estimados, por este medio tengo a bien solicitar la migración de la información que se tenia en coperaciones2 por lo que respecta SIIP, toda vez que, al momento de ingresar al SIIP con el usuario jdcontrol me dice que no existe ese usuario. Adjunto para pronta referencia captura de pantalla.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Rosas, Jorge Israel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 17:07:00', 'Se dio de alta al usuario en CONTROL.USUARIOS.', 'Modificación en BD', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001159');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001154', 'Cambio de fecha', '2026-05-15 19:06:00', 'Buena tarde, por medio del presente solicito su apoyo para cambiar fecha de la requisición 133579 a 13/05/2026.
Agradezco de antemano el apoyo. Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-18 13:04:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES de 12/05/2026 a 13/05/2026', 'Modificación en BD', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001154');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001161', 'ELIMINACION DE FACTURA', '2026-05-18 10:36:00', 'Por medio del presente solicito de su amable apoyo para que se realice la eliminación del sistema SIIP de las siguientes facturas.

1203
5895

Muchas gracias, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-18 16:36:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001161');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001165', 'Actualización Deducciones Integral', '2026-05-18 15:16:00', '‌Buenos días estimado 
Por este medio se solicita amablemente agregar al contrato ASPN-GI-CO-62602-001-26 de DESARROLLO EQUIPOS MOVILES Y CONSTRUCCIONES DE VERACRUZ, S.A. DE C.V. las retenciones siguientes: 
7- Deducción del dos por ciento al millar.
8- Deducción del cinco por ciento al millar.
Agradeciendo de antemano sus finas atenciones, reciba un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Obras Externos'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-19 13:16:00', 'En OBRAS.DEDUCCIONES se agrego el registro para el NidValor 7 y 8', 'Modificación en BD', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001165');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001164', 'Error Mediport', '2026-05-18 14:51:00', 'Buenas tardes Licenciado
Por este medio se envía error que aparece en el Mediport   "Aleph Ingenieros Consultores, S.A. de C.V." contrato ASPN-GI-CS-62601-016-25.  
Agradeciendo de antemano sus finas atenciones, 
Reciba un cordial saludo',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-19 11:51:00', 'Se cargó manualmente el archivo de la empresa haciendo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001164');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001169', 'CAMBIO DIRECTA CONTRATO', '2026-05-18 17:15:00', 'Por este medio solicito de su apoyo para el cambio de adjudicación: DIRECTA CONTRATO de los siguientes contratos:
-37391
-37426
-37355
-37469
Los cuales ya se encuentran en estado abierto para que se realicen las modificaciones solicitadas.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-19 16:15:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1 para todos los pedidos', 'Modificación en BD', '2026-05-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001169');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001170', 'CAMBIO DE FECHA REQUISICIÓN', '2026-05-18 18:13:00', 'Buenas tardes estimados, 
Por medio del presente, se solicita su amable apoyo para el cambio de fecha de la requisición 133591 elaborada por mi compañero con usuario CCONTROL2 del dia de hoy 18/05/2026 al 16/05/2026. 
Sin mas por el momento, agradecemos su valioso apoyo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Piña Pereda, Ximena'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-19 17:59:00', 'Se realizó el cambio de fecha en INVENTARIO.REQUISICIONES de 18/05/2026 al 16/05/2026', 'Modificación en BD', '2026-05-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001170');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001160', 'CAMBIO DE FECHA', '2026-05-18 10:08:00', 'Buenos días por medio del presente solicito el apoyo con el cambio de fecha del seguirte pedido 
PEDIDO/ORDEN 37489 CON FECHA DE 28/abril/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-19 17:49:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDOS de 18/05/2026 al 28/04/2026', 'Modificación en BD', '2026-05-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001160');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001167', 'Solicitud de apoyo para subir complementos de pago.', '2026-05-18 16:17:00', 'Buenas tardes, solicito su apoyo para poder quitar el candado de los complementos de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serian los siguientes folios: 

Esto es lo que me aparece: 

De igual manera le adjunto los complementos de pago pendientes de subir.

Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-19 13:12:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001167');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001162', 'Solicitud de apoyo para subir complemento de pago.', '2026-05-18 10:59:00', 'Buenas días, solicito su apoyo para quitar el candado en el complemento de pago de DHL, del folio:

Pues me aparece el siguiente error:

De igual manera le adjunto el complemento de pago que se intenta subir.
Quedó atenta a sus comentarios, gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-19 16:49:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001162');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001166', 'Solicitud de apoyo con factura en mediport', '2026-05-18 15:52:00', 'Buenas tardes, solicito su apoyo para poder subir una factura a mediport:
Orden: 37490
Con el siguiente folio: 

Debido a que me manda el siguiente error:

De igual manera adjunto la factura pendiente de subir, agradezco su apoyo.
Quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-19 15:44:00', 'Se eliminaron los registros de CFDCONNECT.CFD_RECEPCION y CFD_CUSTOM_DATA.', 'Modificación en BD', '2026-05-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001166');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000411', 'documentos firmados sin E.firma', '2026-02-23 16:10:00', 'revisando documentacion de la empresa VERACRUZ ADVENTURES S.A. DE C.V. se presenta un error en el SIRE donde ya aparecen firmados algunos documentos que un servidor verifica.

Cabe mencionar que los documentos PROGRAMA DE MANTENIMIENTO, RELACION DE EQUIPO PROPIO O A CARGO y POLIZAS DE SEGUROS se iban a rechazar por incluir embarcaciones que no estaban previstas en el contrato. (anexo captura)',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Atencio Casanova, Samuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-02-24 15:10:00', 'Se quitó el rol 161 (Contratos Operaciones Firma) y se dejó unicamente el 145 (Contratos Operaciones) para que pudiera rechazar correctamente el detalle de la solicitud.', 'Modificación en BD', '2026-05-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000411');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001183', 'CAMBIO DIRECTA CONTRATO', '2026-05-19 17:22:00', 'Por este medio solicito de su apoyo para el cambio de Adjudicación DIRECTA CONTRATO de los siguientes contratos:
-37408
-37433
-37397
Los cuales ya se encuentran en estado abierto para las modificaciones solicitadas.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-20 12:22:00', 'En INVENTARIO.PEDIDOS se modifico el campo TIPOADJ de 0 a 1 para todos los pedidos', 'Modificación en BD', '2026-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001183');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001180', 'SOLICITUD DE CAMBIO DE FECHA EN PEDIDO', '2026-05-19 15:42:00', 'Buenas tardes 

Por medio del presente solicito de su apoyo para el cambio de fecha en el pedido 37498, siendo la nueva fecha el día 24/04/26. 

De antemano agradezco el apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-20 13:49:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDOS de 19/05/2026 al 24/04/2026', 'Modificación en BD', '2026-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001180');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001188', 'USUARIO Y CONTRASEÑA DE SIIP', '2026-05-20 08:11:00', 'BUEN DÍA SOY DENET HUERTA JEFE DE SEÑALAMIENTO MARÍTIMO, SOLICITO SU AYUDA PARA SABER MI USUARIO Y CONTRASEÑA PARA INGRESAR AL SIIP.
SALUDOS Y BUEN DIA.


usuario: jdmaritimo1@puertodeveracruz.com.mx
Nombre: Denet Darina Huerta Huesca',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'de Trafico Maritimo, Centro de Control'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-20 13:00:00', 'Se proporcionaron credenciales de acceso a SIIP mediante correo electrónico.', 'Seguimiento de proceso', '2026-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001188');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001187', 'USUARIO Y CONTRASEÑA DE SIIP', '2026-05-20 08:00:00', 'BUENOS DIAS, SOY ADRIANA TERAN ANDRADE; OPERADOR RADARISTA
SOLICITO AMABLEMENTE SU AYUDA PARA SABER MI USUARIO Y CONTRASEÑA PARA INGRESAR AL SIIP. 
MUCHAS GRACIAS POR SU AYUDA
SALUDOS


usuario: aradarista2@puertodeveracruz.com.mx
Nombre: Adriana Teran Andrade
Atentamente Soporte Técnico',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'de Trafico Maritimo, Centro de Control'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-20 13:00:00', 'Se dio de alta al usuario en CONTROL.USUARIOS.', 'Modificación en BD', '2026-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001187');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001179', 'Solicitud de apoyo para subir complementos de pago.', '2026-05-19 13:38:00', 'Buenas tardes, solicito su apoyo para poder quitar el candado de los complementos de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serian los siguientes folios: 
Pues me aparece el siguiente error: 
De igual manera le adjunto los complementos de pago pendientes de subir.
Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-20 15:06:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001179');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001191', 'Solicitud de atributos de facturación', '2026-05-20 11:18:00', 'Buenos días
Por medio de la presente, se solicita su apoyo para habilitar en el modulo catalogo de proveedores los apartados: DATOS, TELEFONOS, EJECUTIVOS, CONDICIONES, MONEDA y DOCUMENTOS, sean habilitados para mi compañero Juan Manuel Calva, lo anterior, forma parte nuestras actividades en el Dpto. de Recursos Materiales.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-21 09:18:00', 'Se asignaron todos los privilegios de la ventana PROVEEDORES/ACREEDORES en módulo de Compras.', 'Modificación en BD', '2026-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001191');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001182', 'SOLICITUD DE MODIFICACIÓN DE PERSONAL EN LA INV. DE MERCADO No. 10776', '2026-05-19 16:56:00', 'En relación a la Inv. de Mercado No. 69378 correspondiente a la requisición No. 133585, dentro del apartado “C. Comp.” se solicita apoyo para cambiar nombre del personal que “elaboro” como se muestra a continuación:
Dice:
Elaboro: Miguel Agustín Verde Cassou.
Debe decir:
Elaboro: Carolina Guadalupe Madrazo Millán.
Quedo atenta a cualquier comentario al respecto.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'INVESTIGACION DE MERCADO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-21 11:22:00', 'Se cambió el USER_ELABORA por el solicitado en INVENTARIO.INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-05-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001182');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001196', 'SOLICITUD CAMBIO DE FECHA EN PEDIDO', '2026-05-20 12:54:00', 'BUEN DÍA, POR MEDIO DEL PRESENTE SE HACE LA SOLICITUD DE CAMBIO DE FECHA EN PEDIDO CON NO. DE ORDEN 37499 QUEDANDO CON FECHA 15/05/2026.

MUCHAS GRACIAS.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-21 09:25:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001196');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001194', 'CAMBIO DE FECHA', '2026-05-20 12:32:00', 'hola muy buena tarde por medio del presente solicito me ayuden a cambiar la fecha de la requi 133576, y de la investigación de mercado 10769 ya que la fecha que requiero es del día 8 de mayo de 2026.
sin mas por el momento quedo a sus ordenes.
saludos.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Serena Silván, Cinthya Araceli'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-21 09:08:00', 'Se realizó el cambio de fecha en INVENTARIO.INVESTIGACIONMERCADO y REQUISICIONES.', 'Modificación en BD', '2026-05-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001194');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001211', 'APOYO ARCHIVO TXT PARA NAFIN', '2026-05-22 09:18:00', 'Buen dia, solicito su apoyo con revisión en sistema SIIP ya que este mismo me proporciona un documento txt para subir a NAFIN pero al cargarlo recibimos que hay un error dentro de la estructura del documento, se extrajo nuevamente el archivo y permaneció el error',
  (select id from ventanas_mesa where nombre = 'EXPORTACION DE FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-22 13:18:00', 'En INVENTARIO.MOVALMS se cambio el valor del campo NUMACTA de 34669 a 35861 asi como el campo SUBALMACEN de 1 a 2 en INVENTARIO.DETSOLCONTRATOS', 'Modificación en BD', '2026-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001211');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001205', 'CAMBIO DIRECTA - CONTRATO', '2026-05-21 10:45:00', 'Solicito su amable apoyo para modificar en el Modulo de Compras, en Pedido, en ADJUDICACIÓN, debe decir: DIRECTA CON CONTRATO del contrato de servicios no. de orden 37384.
Se encuentra en estado ABIERTO para que se puedas hacer las modificaciones solicitadas. 
Quedo atento a sus comentarios, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-22 17:38:00', 'Se cambió el TIPOADJ de 0 a 1 en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001205');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001206', 'Solicitud de apoyo para cambio de fecha', '2026-05-21 13:07:00', 'Buenas tardes, solicito su apoyo para poder cambiar la fecha del siguiente pedido:
Pedido: 37509
Fecha Solicitada: 14/05/2026
Gracias, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-25 09:48:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001206');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001212', 'APOYO CON FOLIO UUID NO VISUALIZADO EN LA VENTANA DE COMPLEMENTOS', '2026-05-22 10:47:00', 'Hola buena tarde Equipo de sistemas-
Me apoyan, identifiqué que en SIIP contratos no se visualiza el folio fiscal (UUID).
Sin embargo, en mediport si se ve timbrado.
Fecha de timbrado: 20-05-2026
Quedo de su amable apoyo para que en SIIP se logre visualizar el UUID.
Cliente: CIF ALMACENAJES Y SERVICIOS SA DE CV
Folios SIIP: 2558',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-22 17:47:00', 'En FACTURACION.COMPLEMENTOS_PAGO se completo el registro para el FOLIO_COMP = 2558', 'Modificación en BD', '2026-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001212');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001204', 'DESBLOQUEO DE SIIP -FACTURACION- VENTANA DE GARANTIAS', '2026-05-21 10:24:00', 'Buenos días estimados a quien corresponda.

Agradecería su amable apoyo, desbloqueando la ventana de garantías, ya que envía mensajes de error, como a continuación se muestra:
Quedo atenta.
Saludos cordiales...',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Depósitos en garantía'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-22 09:24:00', 'Seguimiento de proceso, se verifico el estado de las sesiones para Facturacion', 'Seguimiento de proceso', '2026-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001204');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001210', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 133585', '2026-05-21 18:10:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 133585.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
F. RECEPCIÓN: 21/05/2026
DEBE DECIR: 08/05/2026
Quedo atenta a cualquier duda o comentario al respecto.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-22 16:45:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-05-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001210');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001220', 'IMPOSIBILIDAD DE ACCESO A MEDIPORT Y TICKETS', '2026-05-25 09:23:00', 'BUEN DÍA,



LAS PLATAFORMAS MEDIPORT Y TICKETS DE MANTENIMIENTO NO ME PERMITEN INGRESAR CON MIS CREDENCIALES DE ACCESO.

QUEDO PENDIENTE.

SALUDOS CORDIALES.',
  (select id from ventanas_mesa where nombre = 'MEDIPORT'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Díaz Ortíz, Oscar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-25 15:23:00', 'Se proporcionaron credenciales de acceso a Mediport mediante correo electróncio.', 'Seguimiento de proceso', '2026-05-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001220');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001202', 'VERIFICAR PROVILEGIOS DEL MODULO COMPROBACION DE VIATICOS', '2026-05-21 09:30:00', 'Buen dia
La semana pasada se solicito privilegios del modulo de Solicitud de viaticos
el presente es para preguntar si con esto se tiene activo la comprobacion o en caso contrario solicito que me den acceso a este modulo porque de acuerdo a lo realizado me dice que el folio 5121 no pertenece a este departamento y en teoria recuerdo haberle dado guardar.
Y el folio consecutivo 5122 muestra datos y ese mismo folio le aparece el acceso al Usuario MVARGAS
Por lo que tambien me solicita ella que la mencione en esta mesa para hacer la misma revision.

Anexo pantalla para referencia.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Garcia Lopez, Elvira del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-21 17:30:00', 'Solicitud atendida mediante llamada telefónica. El usuario se apoyó con un compañero para resolver su problema.', 'Seguimiento de proceso', '2026-05-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001202');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001227', 'Apoyo - Comprobación de viáticos', '2026-05-25 13:03:00', 'Apoyo con el cambio del archivo de factura que se muestra en imagen de la comprobación de viáticos con folio 5084.

El área de contabilidad comenta que no puede visualizar el archivo.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Santiago Peña, Laryssa Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-25 17:03:00', 'Se cargaron manualmente los archivos requeridos al servidor y se agregó la ruta en los registros de INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-05-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001227');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001136', 'Actualización de monto del ejercicio 2026', '2026-05-14 18:42:00', 'Buenas tardes
Por este medio se solicita por favor distribuir del monto de obra de 2025 al 2026 la cantidad de $380,601.04 de la estimación finiquito del contrato ASPN-GI-CO-60601-010-24 como se detalla a continuación:',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-15 13:00:00', 'En OBRAS.SOLDISTRCONTRATO asi como en OBRAS.DISTRCONTRATO se agrego el registro con el monto solicitado, restando a 2025 el monto de 2026', 'Modificación en BD', '2026-05-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001136');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001240', 'REPORTE DE CUENTAS POR COBRAR EMITIDAS 2025', '2026-05-26 15:59:00', 'Buenas tardes
El presente es para solicitar su apoyo con un reporte de cuentas por cobrar emitidas del 1 de enero al 31 de diciembre 2025. que incluya: nombre o razón social del cliente, concepto, importe, antigüedad, y fecha de pago en su caso.  En Excel. Para entrega a la Auditoria Superior de la Federación.
Quedo atento por cualquier duda sobre lo solicitado.
Saludos.',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Serrano Berriozabal, Jose Luis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-27 12:59:00', 'Seguimiento de proceso, se genero el reporte solicitado', 'Seguimiento de proceso', '2026-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001240');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001232', 'SOLICITUD DE CAMBIO DE FECHA EN PEDIDO', '2026-05-25 17:20:00', 'Buenas tardes 

Por medio del presente solicito de su apoyo para el cambio de fecha en el pedido 37513, siendo la nueva fecha el día 19/05/26. 

De antemano agradezco el apoyo 
Saludos Cordiales .',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-27 17:24:00', 'Se realizó el cambio de fecha en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001232');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001245', 'Solicitud de apoyo para subir complementos de pagos.', '2026-05-27 09:03:00', 'Buenos días, solicito su apoyo para poder quitar el candado de los complementos de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serian los siguientes folios: 


Pues me aparece el siguiente error:

De igual manera le adjunto los complementos de pago pendientes de subir.

Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-28 10:21:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001245');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001224', 'SOLICITUD DE PRIVILEGIOS APARTADO REQUISICIONES', '2026-05-25 11:03:00', 'Buen día 


Se solicita apoyo para generar privilegios en modulo de requisiciones al usuario cferroviario@puertodeveracruz.com.mx',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Muñoz Morales, Alejandra de Jesus'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-28 11:19:00', 'Se dio de alta al usuario en módulo de COMPRAS. Se creó el registro manualmente debido a que el nombre excedía el límite de caractéres (32, siendo el máx. 30).', 'Modificación en BD', '2026-05-27 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001224');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001249', 'SOLICITUD DE APOYO CON CARGA DE COMPLEMENTOS', '2026-05-27 15:36:00', 'BUEN DÍA, SE SOLICITA EL AMABLE APOYO CON LA CARGA DE LOS SIGUIENTES COMPLEMENTOS: 

ASIMISMO, UNO DE LOS APARTADOS DE LOS COMPLEMENTOS DEL PROVEEDOR GRUPO METROPOLITANO DE AGUA Y SANEAMIENTO, PRESENTA $00.00 LO CUAL NO COINCIDE CON LO PAGADO.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-28 12:37:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001249');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001261', 'CAMBIO EN REQUISICION', '2026-05-28 12:41:00', 'Buenas tardes estimados.

Se solicita de su amable apoyo para poder realizar el cambio de fecha de la requisición 133602 a la fecha 27/05/2026

Asi como realizar el cambio de MEDIO dentro de la IM 10790.
Dice: 
MEDIO: 2. COMPRANET

Debe decir:
MEDIO:  8. COMPRAS MX',
  (select id from ventanas_mesa where nombre = 'INVESTIGACION MERCADO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-29 09:08:00', 'Se cambió el ID_MEDIO de 2 a 8 en INVENTARIO.PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001261');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001238', 'Actualización Integral fecha final contrato', '2026-05-26 15:22:00', 'Buenas tardes
Por este medio se solicita amablemente cambiar la fecha de termino del 16 de septiembre de 2026 al 17 de septiembre de 2026: (ASPN-GI-CS-62601-005-26)',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-29 10:02:00', 'En SERVICIO.SOLCONTJURIDICO74 se modifico el campo FFINEJECUCION de 16/09/26 a 17/09/26', 'Modificación en BD', '2026-05-28 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001238');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001265', 'APOYO CON FOLIO UUID NO VISUALIZADO EN LA VENTANA DE COMPLEMENTOS.', '2026-05-28 16:21:00', 'Hola buena tarde Equipo de sistemas-
Me apoyan, identifiqué que en SIIP facturación no se visualiza el folio fiscal (UUID).
Sin embargo, en mediport si se ve timbrado.
Fecha de timbrado: 28-05-2026
Quedo de su amable apoyo para que en SIIP se logre visualizar el UUID.
Cliente: IKUSI MEXICO SA DE CV
Folios SIIP: 2567',
  (select id from ventanas_mesa where nombre = 'COMPLEMENTOS DE PAGO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-29 15:21:00', 'En FACTURACION.COMPLEMENTOS_PAGO se agrego la informacion faltante a los campos FOLIO_COMP_TIMBRADO y UUID_COMPLEMENTO', 'Modificación en BD', '2026-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001265');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001276', 'CAMBIO DIRECTA CONTRATO', '2026-05-29 12:30:00', 'Por este medio solicito de su apoyo para el cambio de Adjudicación del contrato: 37385.
Debe decir: DIRECTA CONTRATO.
Ya se encuentra en estado abierto para las modificaciones solicitadas.
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-01 11:30:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001276');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001275', 'Solicitud de apoyo para cambio de fecha', '2026-05-29 12:19:00', 'Buenas tardes, solicito su apoyo para poder cambiar la fecha del siguiente pedido:

Pedido: 37517
Fecha Solicitada: 08/05/2026


Gracias, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-01 12:56:00', 'Se realizo el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001275');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001257', 'Error Mediport', '2026-05-28 09:53:00', 'Buenas tardes 

Por este medio se solicita amablemente eliminar las facturas cargadas en el folio 87179 en el Contrato ASPN-GI-CO-62601-017-25 SYMMETRIC ENGINEERING CONSTRUCTION SUPERVISION, S.A. DE C.V.

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-01 09:29:00', 'Se eliminó el registro de CFDCONNECT.CFD_RECEPCION, CFD_CUSTOM_DATA y se modificó el ESTADO a 0 y el UUID en INVENTARIO.FOLIO_FACTURA. Se eliminaron los registros de la bóveda.', 'Modificación en BD', '2026-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001257');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001274', 'CAMBIO DE FECHA', '2026-05-29 12:03:00', 'Por este medio solcito de su apoyo para el cambio de fecha del pedido de servicios: 37516/2026.
Debe decir: 24/02/2026.

Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-01 12:41:00', 'Se realizo el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001274');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001280', 'Actualización Integral - Proyectos de Inversión', '2026-05-29 14:36:00', 'Buenas tardes 
Por este medio se solicita su valioso apoyo para actualizar el INTEGRAL respecto al Proyecto de Inversión  2413J3E0001 - Recinto Logístico de la Tercera Región Naval ya que no aparece en el Catálogo como se detalla a continuación:',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-01 12:00:00', 'Seguimiento de proceso, se verifico que el dato ya se encontraba en sistema', 'Seguimiento de proceso', '2026-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001280');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001279', 'SOLICITUD DE CAMBIO DE FECHA EN REQUISICIÓN Y IM', '2026-05-29 13:42:00', 'Buenas tardes estimados 

Por medio del presente solicito de su apoyo, para realizar el cambio de fecha de las siguientes requisiciones e investigaciones de mercado 

    REQ: 133604 e IM: 10794 = Nueva fecha .- 08 de Mayo de 2026
    REQ: 133605 e IM: 10796 = Nueva fecha .- 08 de Mayo de 2026

De antemano agradezco el apoyo
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-01 10:23:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001279');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001248', 'SOLICITUD DE APOYO EN EL SIIPV2', '2026-05-27 12:51:00', 'Buenas tardes.

Por medio del presente solicito de su apoyo para que en la plataforma SIIPV2 me sea habilitado la pestaña de compras, esto debido a que en el mes próximo necesitaré utilizarla.

Agradezco de antemano su apoyo.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Acceso al modulo de Compras'),
  (select id from solicitantes_mesa where nombre = 'Colorado García, Inocente'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-05-28 15:23:00', 'Se dio de alta al usuario en módulo de COMPRAS.', 'Modificación en BD', '2026-05-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001248');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001282', 'Cambio de fecha', '2026-05-29 16:43:00', 'Buena tarde, por medio del presente solicito su amable apoyo para el cambio de fecha de la REQUISICION 133606, de fecha 29/05/2026 a 28/05/2026
De antemano agradezco el apoyo.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-01 12:55:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES de 29/05/2026 a 28/05/2026', 'Modificación en BD', '2026-06-01 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001282');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001291', 'VIATICOS', '2026-06-02 13:00:00', 'Buenas tardes:
Solicito su apoyo para que sea eliminada una factura de consumo de alimentos de la comprobación de visticos de la Ing. Kaleb Al Aissa Garcia Contreras con Núm.. de folio 5108.
Los datos son los siguientes:
Monto $148.00
Folio de factura 24470
Emisor: ABT2
Fecha de comprobación 14 de mayo 2026     
Agradezco la atención y quedo atenta a sus comentarios',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-03 12:00:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, de VIATICOS.VTCOSDETCOMPROBACION y los archivos de la bóveda.', 'Modificación en BD', '2026-06-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001291');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001293', 'SOLICITUD PARA DAR DE BAJA VIATICOS', '2026-06-02 13:53:00', 'Buenas tardes ingeniero, 
Por medio del presente solicito de su amable apoyo para dar de baja la siguiente factura ya que esta duplicada perteneciente al folio
5078
Folio de solicitud: 4718
    36.01',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-03 12:53:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, de VIATICOS.VTCOSDETCOMPROBACION y los archivos de la bóveda.', 'Modificación en BD', '2026-06-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001293');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001297', 'MONTOS EN ESTRUCTURA PROGRAMATICA Y MOMENTOS CONTABLES PRESUPUESTAL', '2026-06-02 17:20:00', 'Buenas tardes:
Por favor su apoyo para realizar el cambio de montos en la póliza DIARIO 387 del mes de mayo, tanto en estructura programática como en momentos contables presupuestal. Adjunto pantallas y hoja de trabajo Excel.',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-03 15:20:00', 'En CONTA.MOVIMIENTOS se modifico el campo MOVMONTO asi como en CONTA.ESTPROGEGREDOCTO para todos los registros indicados, asi como en CONTA.POLIZAS se modificaron los campos POLIZAMONTOCARGOS y POLIZAMONTOABONOS', 'Modificación en BD', '2026-06-02 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001297');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001277', 'Corrección de pólizas', '2026-05-29 12:34:00', 'Buenas tardes, solicito su apoyo con la corrección de dos pólizas 404 y 405 (tambien la 444) de tipo diario ya que al generarlas estas no cuentan con Estructura Programática, a continuación comparto instrucciones para la corrección de las pólizas
Poliza  Diarios 404 :
Favor agregar la siguiente estructura únicamente modificando los importes de  "-68,019.75" y "68,019.75" a "-238,655.00" y "238,655.00" 
Poliza  Diarios 405 : 
Favor agregar la siguiente estructura manteniendo los importes mostrados en el ejemplo
Agradezco su atento apoyo
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Aplicacion de Pólizas'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-03 12:51:00', 'En CONTA.ESTPROGPPEGRESODOCTO se agregaron los registros para ambas polizas indicadas', 'Modificación en BD', '2026-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001277');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001303', 'Solicitud de apoyo para subir complementos de pagos.', '2026-06-03 09:22:00', 'Buenos días, solicito su apoyo para poder quitar el candado de los complementos de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serian los siguientes folios: 
Pues me aparece el siguiente error:
De igual manera le adjunto los complementos de pago pendientes de subir.
Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-03 15:38:00', 'Se habilitó la carga de los complementos de pago.', 'Seguimiento de proceso', '2026-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001303');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001273', 'Solicitud de apoyo para subir complemento de pago.', '2026-05-29 11:41:00', 'Buenas días, solicito su apoyo para quitar el candado en el complemento de pago de DHL, del folio:
Pues me aparece el siguiente error:
De igual manera le adjunto el complemento de pago que se intenta subir.
Quedó atenta a sus comentarios, gracias.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-03 13:05:00', 'Se habilitó la carga de los complementos de pago.', 'Seguimiento de proceso', '2026-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001273');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001300', 'SOLICITUD DE BAJA DE FACTURA', '2026-06-02 17:30:00', 'Por medio del presente solicito de su amable apoyo para dar de baja la siguiente factura ya que esta duplicada perteneciente al folio
5078
Folio de solicitud: 4718
    18.27
Del usuario gcomercializacion, muchas gracias',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-03 15:30:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, VIATICOS.VTCOSDETCOMPROBACION y de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001300');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001309', 'SOLICITUD DE HABILITACIÓN DE USUARIO', '2026-06-03 13:13:00', 'Buenas tardes ingeniero, 
Por medio del presente solicito de su amable apoyo para habilitar el usuario gcomercializacion, para realizar un cierre de viáticos, quedo atenta, muchas gracias. 
Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-04 12:13:00', 'Se cambió la contraseña y se mantuvo el usuario activo en SIIP mientras terminaban sus comprobación de viáticos.', 'Modificación en BD', '2026-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001309');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001208', 'ABRIR POLIZAS', '2026-05-21 16:49:00', 'Buenas tardes, solicito su poyo para abrir los siguientes folios de pago que se encuentran en estado autorizado: 87094 y 87038
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas Obra/Habilitacion de folios'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-03 11:54:00', 'Seguimiento de proceso, se brindo apoyo al usuario para realizar la apertura mediante sistema', 'Seguimiento de proceso', '2026-06-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001208');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001324', 'Adecuación de Anticipos en INTEGRAL', '2026-06-04 11:44:00', 'Buenos días estimados
Por este medio se solicita su valioso apoyo para modificar en la generación de los anticipos, el rubro de IVA 14 (IVA 16%) que aparece por default, por el rubro de IVA 16 (IVA Pagado 16%).
Aprovecho la ocasión para enviar un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'ANTICIPOS DEL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-04 16:44:00', 'Seguimiento de proceso, se realizo la modificacion en la forma de cobB120.fmb en la unidad de programa Aplicar, donde se modifico el valor de la variable vimp_iva de 14 a 16', 'Seguimiento de proceso', '2026-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001324');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001326', 'INTEGRAL', '2026-06-04 12:26:00', 'Buenas tardes, por este medio se solicita amablemente la adecuación en Integral en el apartado de Captura y consulta de contratos la fecha de término debe decir  17/09/2026: (ASPN-GI-CS-62601-005-26)
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-04 17:26:00', 'Se modifico en OBRAS.CNTOVIGENTES el campo FECHATERMINO de 16/09/2026 a 17/09/2026', 'Modificación en BD', '2026-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001326');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001299', 'FORMATO DE VACACIONES EN SIIP', '2026-06-02 17:23:00', 'Cheque el SIPP para ver mis vacaciones y al momento de imprimir me sale en blanco',
  (select id from ventanas_mesa where nombre = 'VACACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Suarez Herrera, Jose Gabriel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-03 15:23:00', 'Se imprimió con éxito la solicitud de vacaciones y se comunicó mediante llamada telefónica.', 'Seguimiento de proceso', '2026-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001299');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001325', 'MOMENTOS EN ESTRUCTURA PROGAMATICA', '2026-06-04 12:06:00', 'Buena tarde, solicito su apoyo para agregar los momentos de estructura programática a la siguiente póliza: Cheques 15 del periodo de junio 
Anexo evidencia de la póliza y ejemplo de la estructura para agregar
Poliza
Favor agregar la siguiente estructura programática:
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-04 17:06:00', 'En CONTA.ESTPROGPPEGRESODOCTO se agregaron los registros para ambas polizas indicadas', 'Modificación en BD', '2026-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001325');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001316', 'ELIMINACION DE POLIZAS', '2026-06-03 16:13:00', 'Buena tarde solicito su apoyo con la eliminación de las siguientes pólizas:
*Diarios 170 mayo 
*Diarios 83 junio',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Pólizas Armonizadas'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-04 17:43:00', 'Se eliminaron las polizas indicadas en CONTA.POLIZAS, CONTA.MOVIMIENTOS y en CONTA.ESTPROGPPEGRESODOCTO', 'Modificación en BD', '2026-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001316');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001317', 'ELIMINACION DE POLIZAS', '2026-06-05 10:35:00', 'Buena tarde solicito su apoyo con la eliminación de las siguientes pólizas:
*Diarios 136 mayo 
*Diarios 84 junio',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Pólizas Armonizadas'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-05 10:35:00', 'Se eliminaron las polizas indicadas en CONTA.POLIZAS, CONTA.MOVIMIENTOS y en CONTA.ESTPROGPPEGRESODOCTO', 'Modificación en BD', '2026-06-04 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001317');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001307', 'SOLICITUD DE ELIMINACION DE POLIZA PRESUPUESTAL', '2026-06-03 11:22:00', 'Buenos días, solicito su amable apoyo para  eliminación de las siguientes pólizas presupuestales:
MAYO P-91
JUNIO P-5
Esto con motivo de que se le hicieron modificaciones en la requisición de servicios y en el pedido no. 37299, del proveedor 
Quedo atento a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Pólizas Armonizadas'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-05 09:19:00', 'Se eliminaron las polizas indicadas en CONTA.POLIZAS, CONTA.MOVIMIENTOS y en CONTA.ESTPROGPPEGRESODOCTO', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001307');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001336', 'CAMBIO DE FECHA CONTRATO', '2026-06-04 17:07:00', 'Por este medio solicito de su apoyo para el cambio de fecha del contrato: 37531.
Debe decir: 09/04/2026.

El contrato se encuentra en estado tramite para que se puedan realizar las modificaciones solicitadas.

Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-05 15:08:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001336');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001335', 'SOLICITUD DE CAMBIO DE FECHA EN PEDIDO', '2026-06-04 17:03:00', 'BUEN DÍA, POR MEDIO DEL PRESENTE SE HACE LA SOLICITUD DE CAMBIO DE FECHA EN PEDIDO CON NO. DE ORDEN 37529 QUEDANDO CON FECHA 27/05/2026.

MUCHAS GRACIAS.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-05 15:06:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001335');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001298', 'CAMBIO DE FECHA', '2026-06-02 17:21:00', 'Buenas tardes por medio del presente solicito el apoyo con el cambio de fecha de las siguientes requisiciones 

REQUISICION 133597 CON FECHA DE 25/05/2026
REQUISICION 133599 CON FECHA DE 26/05/2026



Quedo atento a sus comentarios',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-05 15:56:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001298');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001338', 'Actualización Integral', '2026-06-04 18:14:00', 'Buenas tardes
Por este medio se solicita amablemente la habilitación de los campos:
- Carta del Artículo 51
- Respuesta de cumplimiento del SAT 
En los contratos ASPN-GI-CS-62601-005-26 y  ASPN-GI-CS-62601-006-26
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-05 13:00:00', 'Se modifico en SERVICIO.SOLCONTJURIDICO74 los campos CARTAARTICULO51 y CARTARESPUESTASAT', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001338');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001222', 'ABRIR EL CANDADO PARA SUBIR FACTURAS', '2026-05-25 09:32:00', 'Buenos días por medio del presente pido su apoyo para subir las facturas del siguiente pedido, ya que el proveedor tiene complementos pendientes:

Comparto imagen del complemento pendiente,

Agradezco su pronta respuesta',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-05 16:04:00', 'Se cambió temporalmente a 5 el ESTADO en INVENTARIO.FOLIO_COMPLEMENTOS.', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001222');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001216', 'ABRIR EL CANDADO PARA SUBIR FACTURAS', '2026-05-22 15:43:00', 'Buenas tardes por medio del presente solicito su apoyo para poder subir las facturas del siguiente proveedor ,
Quedo atento a sus comentarios 
saludos',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-05 16:05:00', 'Se cambió temporalmente a 5 el ESTADO en INVENTARIO.FOLIO_COMPLEMENTOS.', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001216');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001203', 'REQUISICION', '2026-05-21 09:39:00', 'Buenos días:
Con el gusto de saludarles, solicito su apoyo para dejar en estado ABIERTO la Requisición No. 133587, así como su Investigación de Mercado con No. 10778.
Lo anterior para realizar modificaciones en las fechas de elaboración que quedarían al día 20 de mayo al igual que correcciones en la captura de los datos de la cotización del proveedor OFIX S.A. DE C.V. 

Quedo atenta a sus comentarios no sin antes agradecer su atención.      

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES E INVESTIGACIONMERCADO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Estado'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-05 16:02:00', 'Se realizó el cambio de fechas y se modificó la información en INVENTARIO.PROVEEINVESTIGACIONMERCADO según lo requerido por el usuario.', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001203');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001346', 'CAMBIO DIRECTA CONTRATO', '2026-06-05 12:28:00', 'Por este medio solicito de su apoyo para el cambio de adjudicación en el contrato: 37532.
Debe decir: DIRECTA CONTRATO.
Se encuentra en estado ABIERTO para que puedan realizar las modificaciones solicitadas.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-08 10:28:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001346');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001106', 'REVISION DEL DETALLE DE FACTURA-OBRA', '2026-05-12 12:37:00', 'Buenas tardes,
De la manera más atenta, solicito su apoyo para revisar el cálculo que realiza el sistema en el detalle de facturas del módulo de compras, esto en el caso particular de ret. de IVA. Se ha detectado que los montos no corresponden a los capturados en Integral, ni a los importes proporcionados en la factura y nota de crédito.
Asimismo, al momento de autorizar el pago, el sistema no genera los importes correctos en la póliza contable.
Agradezco de antemano su apoyo.
Cualquier duda o comentario quedo a la orden.',
  (select id from ventanas_mesa where nombre = 'DETALLE DE FACTURAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pagos'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-13 11:37:00', 'Seguimiento de proceso, se realizo la modificacion en la forma de cpdetfacobra.fmb en el bloque de datos DETFACTURAS para el campo TOTALRETENIDO1, donde se modifico la formula de la propiedad FORMULA para hacer la operacion de calculo sobre el subtotal resultante entre el NETO menos el ANTICIPO (antes se calculaba sobre el NETO unicamente)', 'Seguimiento de proceso', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001106');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001333', 'cambio de fecha en requisiciones e invest de mercado', '2026-06-04 15:06:00', 'Buenas tardes, por el presente se solicita el cambio de fechas para las siguientes investigaciones de mercado:

Cambiar fechas de estas requisiciones, para quedar con fecha del 08 de mayo 2026
133603/2026 adquisición de boyas, conos y defensas
133607/2026 adquisición de radios VHF / DSC

Cambiar fechas de estas Inv. Mercado, para quedar con fecha del 08 de mayo 2026
010792/2026 adquisición de boyas, conos y defensas
010795/2026 adquisición de radios VHF / DSC',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Ortiz Morales, Cesar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-05 15:59:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001333');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001281', 'CAMBIO DE ESTATUS PAGO FUTURO', '2026-05-29 15:07:00', 'Buenas tardes:
Por favor su apoyo para el cambio de estatus del pago futuro generado desde modulo de viáticos, en el modulo de pagos futuros FOLIO 2731 debe quedar en estado C (CANCELADO) y en el modulo conversión a cheques debe ser eliminado. Adjunto pantallas',
  (select id from ventanas_mesa where nombre = 'PAGOS FUTUROS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Bancos'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-01 13:07:00', 'En BANCOS.PAGOSFUTUROS se modifico el registro en el campo PAGESTADO de A a C y en BANCOS.DETPAGOSFUTUROS se eliminaron los registros asociados', 'Modificación en BD', '2026-06-05 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001281');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001351', 'SIIP', '2026-06-05 16:30:00', 'BUENAS TARDES
SE SOLICITA SU APOYO , YA QUE LA LIC. KAREN GOMEZ DE EXT: 73120, NO PUEDE CARGAR LAS FACTURAS PARA REALIZAR SU COMPROBACION DE VIATICOS.
GRACIAS, SALUDOS',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Ríos, Verania Lizette'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-08 11:30:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-06-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001351');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001330', 'APOYO NOMBRE EN REQUISICION', '2026-06-04 13:53:00', 'Buenas tardes,
Por medio del presente, se solicita su amable apoyo para realizar el cambio de nombre de gerente en la REQUISICION 133615 referente al SERVICIO DE COLOCACIÓN DE CARPAS, MONTAJE Y DESMONTAJE DE STANDS PARA EL EVENTO DEL FESTIVAL DEL MAR 2026:
De: Lic. Adrián García Saldaña
       Gerente de Comercialización
A: Mtra. Andrea Molina Blancas
     Encargada de la Gerencia de Comercialización
Esto para poder estar en posibilidad de pasar la requisición al área correspondiente en la fecha que se generó el día 03/06/2026.
Sin más por el momento, se agradece el apoyo brindado.',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-05 12:53:00', 'Se modifico en INVENTARIO.REQUISICIONES el campo TRABNUM_SOLICITO de 40249 a 69690', 'Modificación en BD', '2026-06-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001330');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001347', 'MODIFICACIÓN DE FECHA DE INVESTIGACIÓN DE MERCADO', '2026-06-05 12:33:00', 'Por medio del presente solicito de su apoyo para que en la investigación de mercado 10804 de la plataforma SIIPV2 sea modificada la fecha del 01/04/2026 para el 04/05/2026.

Muchas gracias de antemano.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Colorado García, Inocente'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-08 16:08:00', 'Se realizó el cambio de fechas en INVENTARIO.INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001347');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001343', 'CAMBIO DE FECHA EN PEDIDO', '2026-06-05 11:15:00', 'Buenos días, 

Por medio del presente, solicito de su amable apoyo para realizar el cambio de fecha en el pedido con número de orden 37533 de fecha 05 de junio de 2026.

La fecha correcta debe ser :27 de mayo de 2026.

agradezco de antemano el apoyo 

saludos!!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-08 16:07:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001343');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001341', 'CAMBIO DE FECHA', '2026-06-05 10:58:00', 'Buenas tardes por medio del presente solicito el apoyo con el cambio de fecha del siguiente pedido

PEIDO 37530 CON FECHA DE 09/04/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-08 14:14:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001341');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001354', 'SOLICITUD DE CAMBIO DE FECHA DE LA REQUISICIÓN 133624 E INV. DE MERCADO 10809', '2026-06-05 18:25:00', 'Buena tarde estimados, 

Por este medio, tengo a bien solicitar su apoyo a fin de que se pueda cambiar la fecha a la REQUISICIÓN 133624 e INV. DE MERCADO 10809, quedando ambas con fecha 18/05/2026.

Quedo atenta a sus comentarios.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Ramirez, Jeimmy'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-08 16:17:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001354');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001349', 'convenio DRAGADOXTIEMPO', '2026-06-05 15:05:00', 'Buenas tardes estimados, solicito su apoyo ya que al momento de generar el convenio por tiempo a la hora de cargar los conceptos no me deja guardar. (ASPN-GI-CO-62602-009-25)',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Briano Rangel, Isaac Giovanni'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-08 10:05:00', 'Seguimiento de proceso, el usuario logro generar la modificacion de convenio de manera correcta', 'Seguimiento de proceso', '2026-06-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001349');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001360', 'RECHAZAR REQUISITO SIRE', '2026-06-08 11:19:00', 'Buenos días:
Por favor su apoyo para rechazar el requisito Edos. Financieros del prestador GRUPO ETTORE SA DE CV, del modulo de Mediport ,Prestador de Servicios, Solicitudes Pendientes ... Si pueden poner el motivo seria: ADICIONAL A LO PRESENTADO FAVOR DE ADJUNTAR EL ESTADO DE RESULTADOS.
Adjunto pantalla',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-08 15:19:00', 'Se comunicó mediante llamada telefónica que el botón de rechazar funciona correctamente pero no desaparece una vez presionado.', 'Seguimiento de proceso', '2026-06-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001360');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001374', 'PROBLEMAS CON EL SIP', '2026-06-09 09:11:00', 'BUEN DIA SOLICITO APOYO PARA ARREGLAR  DETALLE CON EL SIPP YA QUE  AL MOMENTO DE  REALIZAR MIS INCIDENCIAS  SOLO ME APARECEN LAS QUINCENAS PASADAS  DEL 2025',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACIÓN DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Vizcarra Barra, Daniel Benito'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-09 17:11:00', 'Se comunicó mediante llamada telefónica el funcionamiento de la ventana de justificación de incidencias. El usuario no tenía incidencias pendientes por justificar.', 'Seguimiento de proceso', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001374');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001377', 'Convenio por ampliación de tiempo', '2026-06-09 09:48:00', 'Buenos días Ingeniero
Por este medio se informa que al querer autorizar el convenio por ampliación de plazo del contrato ASPN-GI-CO-62602-009-25 de BOSKALIS MARINE CONTRACTING AND OFFSHORE SERVICES, S.A. DE C.V. el Integral solicita la autorización de Finanzas.',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-09 13:48:00', 'Seguimiento de proceso, el usuario logro generar el tramite y autorizacion del convenio', 'Seguimiento de proceso', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001377');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001369', 'APOYO EN CAMBIO DE CONTRASEÑA (ASISTENTE)', '2026-06-08 16:00:00', 'Buenas tardes Ing. 

Solicito su amable apoyo para el cambio de contraseña del SIIP de la Lic. Ileana Vazquez Ruiz. 

Quedo al pendiente de cualquier comentario. 

Gracias. 

Saludos. 

Usuario: secoperaciones2',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Ramos Leyva, José Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-09 14:00:00', 'Se colocó una nueva contraseña al usuario en SIIP > Catálogo de usuarios.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001369');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001364', 'SOLICITUD PARA INGRESO AL SIIP', '2026-06-08 15:28:00', 'Buenas tardes ingeniero, 

Por medio del presente solicito de su amable apoyo para habilitar el ingreso al SIIP del usuario SECCOMERCIAL, ya que no puedo ingresar para justificar las incidencias, quedo atenta, adjunto captura de lo mencionado: 

Saludos,',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Jimenez, Phecda Monserrat'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-09 10:28:00', 'Se colocó una nueva contraseña al usuario en SIIP > Catálogo de usuarios.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001364');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001382', 'ADECUACION DE CONCEPTOS A CONVENIO', '2026-06-09 12:21:00', 'Buena tarde,
En seguimiento a la llamada del día de hoy por la mañana, se solicita de la manera mas amable poder pasar un concepto que aparece como normal a convenio, toda vez que se requiere cerrar el contrato y poder cargar las ultimas estimaciones.
Contrato: ASPN-GI-CO-62601-014-25
Rubro: LIMPIEZA SUBACUÁTICA AL CONTORNO DE LOS MUELLES, INCLUYENDO RASQUETEO Y RETIRO DE CONCHUELA EN PANTALLA DE DEFENSAS DE LOS MUELLES UBICADOS DENTRO DE LA BAHÍA SUR Y MUELLE DE PESCADORES.
Contratista: TENORIO DOMINGUEZ ZITLALY
Se requiere pasar el concepto 2 que corresponde a ".RASQUETEO Y RETIRO DE CONCHUELA EN PANTALLA DE DEFENSAS DE LOS MUELLES UBICADOS DENTRO DE LA BAHIA SUR" a convenio para poder realizar las estimaciones pendientes como 1-C y 2-C.
Gracias.',
  (select id from ventanas_mesa where nombre = 'ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Estimaciones'),
  (select id from solicitantes_mesa where nombre = 'Gallardo Reyes, Efrain'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-10 11:21:00', 'En OBRAS.CPTOSCONTRATADOS se pasaron ambos conceptos de tipo N a tipo C', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001382');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001381', 'CAMBIO DE FECHA', '2026-06-09 11:55:00', 'BUENOS DIAS 

Agradezco se haga cambio de fecha de la requisición 133444/2026 y su investigación de mercado de mercado 010654 todas las fechas a 05 de junio de 2026

agradezco su amable apoyo',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-10 11:12:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001381');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001378', 'CAMBIO DE FECHA EN REQUISICIÓN 133619', '2026-06-09 09:49:00', 'buenos días. Solicito de su apoyo para cambiar la fecha en la requisición 133619. tiene fecha de 04 de junio del 2026 favor a cambiar a la fecha del 04 de mayo del 2026.

Muchas gracias de antemano por su apoyo.


saludos!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Colorado García, Inocente'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-10 11:05:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001378');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001362', 'CAMBIO DE FECHA DEL PEDIDOS', '2026-06-08 13:33:00', 'Buenas tardes

Por medio de la presente solicito apoyo para el cambio de fecha de los siguientes pedidos: 

Orden: 37536 fecha: 02/06/2026
Orden: 37538 fecha: 19/03/2026

De antemano agradezco la atención, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-10 11:15:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001362');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001370', 'VALIDACION COMPLEMENTOS DE PAGO POR ERROR', '2026-06-08 16:45:00', 'BUEN DÍA, POR ESTE MEDIO SOLICITO EL AMABLE APOYO CON LA VALIDACIÓN DE COMPLEMENTOS DE PAGO EN MEDIPORT, DEL PROVEEDOR GROPO METROPOLITANO DE AGUA Y SANEAMIENTO, TODA VEZ QUE PRESENTAN DIFERENCIAS DE FECHA ENTRE EL DÍA DEL PAGO Y EL DEL COMPLEMENTO.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-09 16:01:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001370');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001365', 'SOLICITUD DE MODIFICACIÓN EN ATRIBUTOS DE NOTA DE CREDITO || MEDIPORT', '2026-06-08 15:35:00', 'Buenas tardes, 


Por medio del presente solicito su colaboración para modificar la forma de pago y el método de pago del folio de factura No. 87327 (tipo nota de crédito) en el portal mediport


Debe decir:

FORMA DE PAGO: 15

METODO DE PAGO:  PUE


Agradeciendo de antemano su valiosa colaboración, quedo atenta. 


Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-09 10:35:00', 'Se cambió el METODO_PAGO a PUE y la FORMA_PAGO a 15 en INVENTARIO.FOLIO_FACTURAS.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001365');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001387', 'SOLICITUD DE BAJA DE FACTURAS', '2026-06-09 15:27:00', 'Buenas tardes ingeniero, 

Por medio del presente solicito de su amable apoyo para dar de baja de la siguiente cuenta JDEXPANSION, del folio de comisión 4722, quedo atenta, muchas gracias

-27.39

-63.89

Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Jimenez, Phecda Monserrat'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-10 13:27:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, VIATICOS.VTCOSDETCOMPROBACION y de la bóveda. Se modificaron los archivos para mantener la secuencia.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001387');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001391', 'Alta nuevo usuario SIIPV', '2026-06-09 17:03:00', 'Estimado equipo Informatica
Por medio de la presente solicito su apoyo para la asignación de usuario al sistema SIIPV para la auxiliar de control y almacenaje de nuevo ingreso Licda. Yahaira Alin Acosta Ramos con numero de empleado 69694.  estos con los permisos y atribuciones con las que contaba la compañera Adriana Monserrat Sarmiento Aquino.
Quedo pendiente a cualquier comentario u observación.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/Nuevos Ingresos/SIIP- nuevo ingreso'),
  (select id from solicitantes_mesa where nombre = 'Gomez Rodriguez, Ricardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-10 12:03:00', 'Se colocó una nueva contraseña al usuario en SIIP > Catálogo de usuarios.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001391');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001368', 'NO SE GUARDAN MIS INCIDENCIAS', '2026-06-08 15:58:00', 'SOLICITÓ DE SU AMABLE APOYO PARA PODER GUARDAR MIS INCIDENCIAS YA QUE NO ME PERMITE GUARDAR.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACIÓN DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Fernández Velázquez, Málory Alanis'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-09 10:58:00', 'Se reactivó el usuario en EDIV2.USUARIOS. El error se ocasionaba porque el usuario se encontraba inactivo.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001368');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001380', 'SIIPV2 NO DEJA CAPTURAR INCIDENCIAS', '2026-06-09 10:58:00', 'NO ME DEJA CARGAR LAS INCIDENCIAS LA PLATAFORMA',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACIÓN DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Sánchez Valenzuela, Cesar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-09 17:58:00', 'Se reactivó el usuario en EDIV2.USUARIOS. El error se ocasionaba porque el usuario se encontraba inactivo.', 'Modificación en BD', '2026-06-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001380');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001373', 'Activar apartado de vacaciones en siip', '2026-06-09 09:08:00', 'Hola buenos días, compañeros 
Me podrían apoyar con activarme mis dias de vacaciones en sistema siip se tuvieron que abrir el dia 3 de junio 2026
Quedo atenta
Saludos!!',
  (select id from ventanas_mesa where nombre = 'VACACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Flores Lopez, Patricia Elizabeth'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-09 16:08:00', 'Seguimiento de proceso. Los días de vacaciones no estaban liberados porque tenía que finalizar la quincena para iniciar su nuevo periodo.', 'Seguimiento de proceso', '2026-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001373');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001388', 'SOLICITUD DE APOYO CON SIIP', '2026-06-09 15:40:00', 'Buenas tardes, 

Por medio del presente solicito de su apoyo ya que no puedo guardar incidencias:',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACIÓN DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Jimenez, Phecda Monserrat'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-10 10:40:00', 'Se reactivó el usuario en EDIV2.USUARIOS. El error se ocasionaba porque el usuario se encontraba inactivo.', 'Modificación en BD', '2026-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001388');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001396', 'SOLICITUD PARA IMPRESIÓN DE VACACIONES', '2026-06-10 11:22:00', 'Buen día ingeniero, 
Por medio del presente solicito de su amable apoyo para habilitarme la impresión de las vacaciones en SIP ya que me aparece como error, muchas gracias, adjunto evidencia. 
Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'ASIGNACION VACACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Vacaciones'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-11 10:22:00', 'Seguimiento de proceso. Se modifico el procedimiento CF_JEFE_INMEDIATO en repvacsol para incluir bloques BEGIN-EXCEPTION en las evaluaciones vAuxSGer y vAuxGere', 'Seguimiento de proceso', '2026-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001396');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001395', 'SOLICITUD DE HABILITACIÓN DEL SISTEMA DE VIÁTICOS', '2026-06-10 10:13:00', 'Buen día,

Por este medio solicito su amable apoyo con la habilitación del apartado de viáticos, toda vez que tengo programada una comisión para el día viernes, no obstante, al entrar al apartado, no se muestran precargados mis datos ni el número de folio.

Quedo pendiente.

Saludos Cordiales.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Morfinez Anaya, José Gabriel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-10 15:13:00', 'Se dio de alta al usuario en módulo de viáticos.', 'Modificación en BD', '2026-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001395');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001398', 'AGREGAR AL CATALOGO DE BANCOS', '2026-06-10 11:37:00', 'Buen día 
El presente es para solicitar su apoyo para hacer la siguiente actualización al catalogo de bancos en SIIP COMPRAS
Agregar:
Banco: KAPITAL BANK
Número de Institución: 40128
Clave Transfer: KAPITAL
Banco: MERCADO PAGO W
Número de Institución: 90722
Clave Transfer: MERCA
Modificar:
Banco: Banco Internacional - cambiar por HSBC
Número de Institución: 40021
Clave Transfer: BITAL',
  (select id from ventanas_mesa where nombre = 'BANCOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Serrano Berriozabal, Jose Luis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-11 10:37:00', 'Seguimiento de proceso. Se dieron de alta los bancos solicitados y sus modificaciones', 'Seguimiento de proceso', '2026-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001398');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001403', 'Habilitar MOSULOS EN SIIPV2', '2026-06-10 17:04:00', 'BUENAS TARDES ESTIMADOS
POR INDICACIONES SUPERIORES REQUIERO APOYO PARA HABILITAR MODULOS EN SISTEMA SIIPV2 DE COMPRAS, MODULO DE REQUISICIONES Y MODULO DE INVESTIGACION DE MERCADO YA QUE SE REQUIRE REALIZAR UNA REQUI DE MTTO A AIRES ACONDICIONADOS PARA NUVO CONTRATO',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Briano Rangel, Isaac Giovanni'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-11 12:04:00', 'Se dio de alta al usuario en módulo de Compras.', 'Modificación en BD', '2026-06-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001403');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001404', 'Solicitud de apoyo para cuadrar volúmenes', '2026-06-10 17:18:00', 'Buenas tardes
Por este medio se solicita su valioso apoyo para solucionar el siguiente error en el Contrato ASPN-GI-CO-62602-009-25:

Mostrando IMG-20260610-WA0006.jpg

De ante mano muchas gracias.',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras/Contratos'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-11 12:18:00', 'Seguimiento de proceso. Se cambio el procentaje de anticipo en OBRAS.ESTIMACIONES en el campo POR_ANTICIPO de 65.367958 a 65.3679572 y luego regresado a 65.367957 por instrucciones de Finanzas', 'Seguimiento de proceso', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001404');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001393', 'Solicitud de apoyo para subir complemento de pago', '2026-06-10 09:07:00', 'Buenos días, solicito su apoyo para poder quitar el candado del complemento de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Seria el siguiente folio: 

Pues me aparece el siguiente error:

De igual manera le adjunto el complemento de pago pendiente de subir.

Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-11 09:50:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001393');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001394', 'CAMBIO DE FECHA EN PEDIDO', '2026-06-10 09:13:00', 'buenos días 
solicito de su amable apoyo para realizar un cambio de fecha en el pedido con número de orden : 37543 de fecha 09 de junio de 2026.
La fecha correcta debe ser 29 de enero de 2026.
gracias
Saludos!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-12 13:44:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001394');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001383', 'CARGA DE COMPLEMENTO DE PAGO', '2026-06-09 13:11:00', 'Buenas tardes

Por medio de la presente, solicito su apoyo para la carga del complemento de pago adjunto, debido a que no fue posible validar el archivo enviando el siguiente error:',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-11 16:12:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001383');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001384', 'CARGA DE COMPLEMENTO DE PAGO', '2026-06-09 13:15:00', 'Buenas tardes

Por medio de la presente, solicito su apoyo con la carga del complemento de pago adjunto, lo anterior, debido a que presenta el siguiente error al cargar el archivo:',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-11 16:12:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001384');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001411', 'SOLICITUD DE APOYO CON SIIP', '2026-06-11 15:52:00', 'Hola buenas tardes por medio de la presente solicito de su amable apoyo, para acceder al sistema SIIP del usuario :

usuario:gcomercializacion 

para la solicitar unos boletos de avión, si es tan amable que pueda quedar para el día de hoy

quedo atenta, muchas gracias',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Jimenez, Phecda Monserrat'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-12 12:52:00', 'Se dio de alta al usuario en CONTROL.USUARIOS y en módulo de viáticos.', 'Modificación en BD', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001411');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001407', 'CAMBIO DE FECHAS EN REQUISICION', '2026-06-11 10:12:00', 'BUENAS TARDES SOLICITO SU APOYO PARA CAMBIOS DE FECHA DE DE REQUISICION Y DE INVESTIGACION DE MERCADO AL DIA 16 DE ABRIL DE 2026, PARA RUBRO DE  EL SERVICIO DE MANTENIMIENTO PREVENTIVO, CORRECTIVO, APLICACIÓN DE PINTURA ANTICORROSIVA, INSTALACIÓN Y/O REUBICACIÓN DE EQUIPOS DE AIRE ACONDICIONADO, ASI COMO EL SUMINISTRO DE MATERIALES Y REFACCIONES PARA EQUIPOS DE AIRE ACONDICIONADO DE LA ADMINISTRACION DEL SISTEMA PORTUARIO NACIONAL VERACRUZ, S.A. DE C.V.
No. GAF-LPEN-CS-011/26
NO- DE REQUISICION 133633
NO DE INVESTIGACION DE MERCADO- 10813
CON FECHA DEL 16 DE ABRIL la requisición y la investigación  
gracias',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Briano Rangel, Isaac Giovanni'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-12 13:38:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001407');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001409', 'APOYO EN CAMBIO DE FECHA DE PEDIDO', '2026-06-11 11:25:00', 'Buenas tardes 

Por medio del presente solicito de su apoyo para el cambio de fecha del contrato 37546, siendo la nueva fecha el 30/01/2026

De antemano agradezco el apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-12 11:42:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001409');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001410', 'CAMBIO DE FECHA EN REQUISICIÓN E INVESTIGACIÓN DE MERCADO // CONTRATO DE FUMIGACIÓN', '2026-06-11 11:59:00', 'Buen día estimados,

Por este medio les solicito su amable apoyo en cambiar las fechas de un procedimiento de Requisición en el SIIP, de esta manera:

# de Requisición: 133583 / 2026, dice 14/05/2026, debe decir 13/05/2026

# de Investigación: 010774 / 2026, dice 14/05/2026, debe decir 13/05/2026

Sin más por el momento, les agradezco su atención.
Saludos.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Loperena Dominguez, Sergio Adolfo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-12 11:11:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-11 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001410');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001417', 'SOLICITUD DE ACCESOS SIIP', '2026-06-12 10:51:00', 'Buenos días,

Solicito de su apoyo para tener los acceso de SIIP.

Mi nombre es Karla Camila Meneses López, usuario: auxcontrol4.

Agradezco el apoyo, saludos.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Redondo Reyes, Adelita'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-12 17:51:00', 'Se dio de alta al usuario en CONTROL.USUARIOS.', 'Modificación en BD', '2026-06-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001417');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001400', 'SOLICITUD DE APOYO CON CARGA DE COMPLEMENTO', '2026-06-10 12:34:00', 'BUEN DÍA, SE SOLICITA EL AMABLE APOYO CON LA CARGA DEL COMPLEMENTO ADJUNTO, TODA VEZ QUE AL INTENTAR VALIDARLO MARCA EL SIGUIENTE ERROR:',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-12 13:36:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-12 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001400');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001200', 'NOTIFICACIONES NUEVOS MONTOS DE FIANZAS', '2026-05-20 17:59:00', 'BUENAS TARDES.
DE LA MANERA MÁS ATENTA SE SOLICITA, SE PUEDAN VISUALIZAR NOTIFICACIONES POR CORREO ELECTRÓNICO CADA VEZ QUE EL ÁREA DE CONTABILIDAD CAPTURA UN NUEVO MONTO DE FIANZA EN EL SIIP.
LAS NOTIFIACIONES LLEGARÍA A UN SERVIDOR Y LAS LICS. JENNIFER CASTILLO MORALES Y ADRIANA MAR LÓPEZ PAZ.
ANTERIORMENTE SE RELIZABA EN EL CORREO DE OUTLOOK.',
  (select id from ventanas_mesa where nombre = 'NOTIFICACIONES'),
  (select id from categorias_mesa where nombre = '/Servicios/Correo Electrónico'),
  (select id from solicitantes_mesa where nombre = 'Becerra Reyes, Jose Aubert'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-21 16:59:00', 'Seguimiento de proceso. Se modifico la forma que envia los correos para utilizar el proceso de servicio.sendmail', 'Seguimiento de proceso', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001200');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001268', 'NOTIFICACIONES NUEVOS MONTOS DE FIANZAS.', '2026-05-28 17:52:00', 'BUENAS TARDES.
EN ALCANCE A LA MESA DE AYUDA DE FECHA 20 DE MAYO DEL AÑO EN CURSO, NUEVAMENTE Y DE LA MANERA MÁS ATENTA SE SOLICITA, SE PUEDAN VISUALIZAR NOTIFICACIONES POR CORREO ELECTRÓNICO CADA VEZ QUE EL ÁREA DE CONTABILIDAD CAPTURA UN NUEVO MONTO DE FIANZA EN EL SIIP.
LAS NOTIFICACIONES LLEGARÍA A UN SERVIDOR Y LAS LICS. JENNIFER CASTILLO MORALES Y ADRIANA MAR LÓPEZ PAZ.
SIMILAR A LAS QUE ANTERIORMENTE SE RELIZABA EN EL CORREO DE OUTLOOK E IGUAL A LAS QUE ACTUALMENTE SE REPORTAN EN GMAIL PARA EL VENCIMIENTO DE CONTRATOS, FIANZAS Y SEGUROS. 
ESPERANDO CONTAR CON SU VALIOSO APOYO, GRACIAS.',
  (select id from ventanas_mesa where nombre = 'NOTIFICACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Becerra Reyes, Jose Aubert'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-05-29 16:52:00', 'Seguimiento de proceso. Se modifico la forma que envia los correos para utilizar el proceso de servicio.sendmail', 'Seguimiento de proceso', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001268');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001421', 'Solicitud de apoyo para subir un complemento de pago.', '2026-06-12 13:51:00', 'Buenas tardes, para poder quitar el candado del complemento de pago del proveedor CASTELAN VALDES MIGUEL en MEDIPORT, pues existe una diferencia de $0.01, por lo cual no me deja proseguir.
Sería el siguiente folio: 


Me aparece el siguiente error:


De igual manera me permito adjuntar el complemento de pago que se esta intentando subir.
Sin mas que añadir, le mando un saludo y le agradezco.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-15 12:01:00', 'Se hizo el ajuste en INVENTARIO.FOLIO_COMPLEMENTOS_RELACION.', 'Seguimiento de proceso', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001421');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001278', 'SOLICITUD DE CAMBIO EN FIRMANTE (SOL. PAGO Y PEDIDOS) VIATICOS ETC...', '2026-05-29 13:41:00', 'Estimados Ingenieros, buena tarde.
Por medio del presente, mucho agradeceré realizar los cambios en SIIP módulo de compras en los formatos de (solicitud de pago F-30, pedido de servicios F-46, pedido de compra F-16), así como todos aquellos formatos donde figure el Dr. Jose Miguel Alvarado Raymond, Subgerente de Administración conforme a lo siguiente:
DICE:
MTRO. JOSE MIGUEL ALVARADO RAYMOND
SUBGERENTE DE ADMINISTRACIÓN
DEBE DECIR:
DR. JOSE MIGUEL ALVARADO RAYMOND
SUBGERENTE DE ADMINISTRACIÓN',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-01 09:41:00', 'Seguimiento de proceso. Se indico el cambio a RH', 'Seguimiento de proceso', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001278');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001432', 'cambio en justificacion de COMPRAS', '2026-06-15 10:09:00', 'Buenas tardes solicito su apoyo para el cambio de justificación de la requisición No* 133633, con investigación de mercado 10813 con el siguiente texto:  Realizar el mantenimiento integral de los sistemas de aire acondicionado instalados en los edificios administrativos de la ASIPONA Veracruz, con el objetivo de garantizar su confiabilidad operativa, prevenir fallas mediante la detección oportuna de anomalías, optimizar su desempeño y eficiencia energética, prolongar la vida útil de sus componentes y asegurar condiciones térmicas adecuadas y la funcionalidad de las áreas de trabajo y servicio',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Briano Rangel, Isaac Giovanni'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-15 17:09:00', 'Se modificó el texto en OBSERVACIONES de INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001432');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001431', 'Cambio de fecha en solicitud de viáticos 4776', '2026-06-15 10:01:00', 'Buenos días, estimados.

Solicito de su valioso apoyo a fin de que la fecha que aparece en los viáticos con No. de Folio 4776 (17 de junio de 2026), se cambie al día 12 de junio de 2026.

Quedo atenta, saludos!',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'López Paz, Adriana Mar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-15 16:01:00', 'Se modificó la FECHASAL y FECHAREG en VIATICIOS.VTCOSSOLICITUD.', 'Modificación en BD', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001431');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001435', 'atributos', '2026-06-15 11:40:00', 'Solicito los atributos para realizar requisiciones e investigación de mercados',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Cruz González, Gerardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-15 17:14:00', 'Se creó el usuario en INVENTARIO.USUARIOS.', 'Modificación en BD', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001435');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001433', 'CAMBIO DE FECHA DE PEDIDO', '2026-06-15 10:55:00', 'Buenos días, solicito su amable apoyo para realizar un cambio de fecha en el pedido 37548, tiene la fecha  12/06/2026, debe tener 28/05/2026, quedo en espera de sus comentarios, muchas gracias.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-16 11:07:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001433');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001439', 'SOLICITUD DE BAJA DE FACTURAS', '2026-06-15 13:57:00', 'Buenas tardes, 

Por medio del presente solicito de su amable apoyo para bajar las siguientes facturas del rubro 4742, de mi usuario auxcomercial1, muchas gracias: 

-793.00
-91.00

Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-15 13:57:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, de VIATICOS.VTCOSDETCOMPROBACION y de la bóveda. Se modifcaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001439');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001441', 'ELIMINAR SOLICITUD DE SIRE', '2026-06-15 16:55:00', 'SOLICITO SU APOYO PARA DAR DE BAJA LA SOLICITUD DE LA EMPRESA TRANSMODAL EN EL SIRE.

MUCHAS GRACIAS.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-16 11:55:00', 'Se cambió el ESTADO a 4 en EDIV2.CONTRATOS_SOLICITUD.', 'Modificación en BD', '2026-06-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001441');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001420', 'SUSTITUCION DE FACTURAS EN EL FOLIO 87332', '2026-06-12 12:51:00', 'Buen dia

Por medio de la presente, solicito su apoyo para sustituir las facturas validadas en el folio 87332, lo anterior, debido a que no fue posible la lectura del QR de la factura, por lo que sustituye por la descargada directamente desde el portal del SAT.

Sin otro particular, envio un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-15 16:06:00', 'Se reemplazaron los archivos en la bóveda.', 'Modificación en BD', '2026-06-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001420');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001451', 'BAJA DE SOLICITUD EN SIRE', '2026-06-16 10:28:00', 'BUENOS DÍAS, 

SOLICITO SU APOYO PARA DAR DE BAJA LA SOLICITUD QUE SE ENCUENTRA EN EL SIRE A NOMBRE DE LA EMPRESA SOLUMASUR, S.A. DE C.V. DEL SERVICIO DE LANCHAJE.

GRACIAS',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-16 17:28:00', 'Se cambió el ESTADO a 4 en EDIV2.CONTRATOS_SOLICITUD.', 'Modificación en BD', '2026-06-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001451');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2026-001453', 'CAMBIO DE FECHA DE PEDIDO', '2026-06-16 11:30:00', 'Buenos días, solicito su amable apoyo para hacer un cambio de fecha en el pedido 37547, debe de tener la fecha del 30/01/2026, quedo en espera de sus comentarios, muchas gracias.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 09:30:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2026-001453');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001461', 'SOLICITUD PRIVILEGIOS SIIPV', '2026-06-16 15:33:00', 'buenas tardes
solicito de su apoyo para que los siguientes correos de usuario tengan autorizado ingresar a Siipv, mediport y Pis

Tecnico portuario Cesar Josue Gonzalez Lária
correo: tportuario6@puertodeveracruz.com.mx

Tecnico portuario Christopher León Roldan
correo: tportuario5@puertodeveracruz.com.mx',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones'),
  (select id from solicitantes_mesa where nombre = 'Salgado Navarro, Agustin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 10:33:00', 'Se dio de alta a los usuarios en SIIP y se proporcionaron credenciales de acceso mediante correo electrónico.', 'Modificación en BD', '2026-06-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001461');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2026-001459', 'solicitud de modificación de fecha requisición 133648', '2026-06-16 13:58:00', 'buena tarde 

se solicita su apoyo para realizar cambio de fecha de requisición 133648 la fecha que debe tener es del 22 de mayo 2026.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Muñoz Morales, Alejandra de Jesus'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 11:58:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-06-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2026-001459');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001458', 'DAR DE BAJA SOLICITUD EN SIRE', '2026-06-16 13:00:00', 'BUEN DÍA, 

SOLICITO DAR DE BAJA LA SOLICITUD EN SIRE DE LA EMPRESA FUM KILLER PLUSS, S.A. DE C.V.

Muchas gracias',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 11:00:00', 'Se cambió el ESTADO a 4 en EDIV2.CONTRATOS_SOLICITUD.', 'Modificación en BD', '2026-06-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001458');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001465', 'CAMBIO DE FECHA EN PEDIDO', '2026-06-16 16:22:00', 'Buenas tardes 

Por medio del presente, solicito de su amable apoyo para realizar un cambio de fecha en el pedido con número de orden 37558 y de fecha 16 de junio de 2026.

La fecha correcta debe ser: 30 de enero de 2026.

gracias',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedido'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 11:22:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001465');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001472', 'SOLICITUD DE CAMBIO DE', '2026-06-16 18:08:00', 'Buenas tardes ingeniero,


Por medio del presente solicito de su amable apoyo para realizar el cambio de persona que autoriza por la Mtra. Andrea Molina Blancas Encargada de atender los asuntos de Comercialización, en el lugar del DG, quedo atenta, muchas gracias, adjunto evidencia de lo mencionado: 


Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 16:00:00', 'Se modificó la función BDAUTORIZADOR del esquema de VIATICOS para que se mostrara el jefe inmediato al imprimir.', 'Modificación en BD', '2026-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001472');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001474', 'SOLICITUD DE CAMBIO DE PROVEEDOR', '2026-06-16 18:31:00', 'Buenas tardes, por medio del presente, solicito su amable apoyo para hacer cambio de proveedor en la cotización y el pedido numero 37546,  proveedor : "Corporación Integral de Comercio Exterior"
Quedo pendiente de sus comentarios.',
  (select id from ventanas_mesa where nombre = 'COTIZACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Cotizaciones'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 17:00:00', 'Se realizó el cambio de proveedor. 1.- Se duplicó en COTIZACIONES, el duplicado tenía el folio máximo y el nuevo proveedor correcto. 2.- Se cambió el proveedor en DETCOTIZACIONES y PEDIDOS. 3.- Se eliminó el registro original en COTIZACIONES y se cambió el folio del registro nuevo al del original.', 'Modificación en BD', '2026-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001474');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001471', 'SOLICITUD DE BAJA DE FACTURA', '2026-06-16 18:04:00', 'Buenas tardes, por este medio requiero de su amable apoyo para dar de baja la siguiente factura de la cantidad de $563.00 del rubro 4742, que pertenece a mi usuario, quedo atenta, muchas gracias. 

Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 13:00:00', 'Se eliminó el registro de VIATICOS.VTCOSDETCOMPROBACION.', 'Modificación en BD', '2026-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001471');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001478', 'CORRECCION DE POLIZA', '2026-06-17 12:40:00', 'Buena tarde, solicito su apoyo con la corrección de la póliza 274 de Diarios del periodo de julio,
adjunto imagen de la póliza solicitando de favor corregir el importe resaltado en rojo y sustituirlo por el importe anotado a un costado (156,161.08)
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Captura de pólizas'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-17 17:40:00', 'Se modifico en CONTA.MOVIMIENTOS el campo MOVMONTO', 'Modificación en BD', '2026-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001478');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001463', 'SOLICITUD DE APOYO CON LA COMPROBACIÓN DE VIÁTICOS Y PLATAFORMA MESA DE AYUDA', '2026-06-16 15:52:00', 'BUENA TARDE,
POR ESTE MEDIO SOLICITO SU AMABLE APOYO, TODA VEZ QUE AL SUBIR MIS FACTURAS DENTRO DE MI COMPROBACIÓN DE VIÁTICOS NO ME PERMITE VISUALIZARLOS MARCANDO UN ERROR.
NO SE OMITE SEÑALAR QUE SE GUARDARON LOS ARCHIVOS EN UNIDADES DIFERENTES DEL EQUIPO A EFECTO DE SUBSANAR EL ERROR SIN TENER EXITO.
FOLIO DE SOLICITUD: 4778
FOLIO DE COMPROBACIÓN: 5137
USUARIO: PAMELA ISIDORO CERVANTES / CCONTRATOS2@PUERTODEVERACRUZ.COM.MX
FINALMENTE, CON LO QUE RESPECTA A LA PLATAFORMA MESA DE AYUDA, SIGUEN APARECIENDO LOS DATOS DEL LIC. JOSE GABRIEL MORFINEZ ANAYA, POR LO QUE SOLICITO SU APOYO CON LA ACTUALIZACIÓN.
AGRADEZCO DE ANTEMANO EL APOYO BRINDADO.
SALUDOS CORDIALES.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Isidoro Cervantes, Pamela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-17 12:52:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION, de INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001463');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001464', 'SOLICITUD CAMBIO DE FECHA EN PEDIDO', '2026-06-16 16:22:00', 'BUEN DÍA, POR ESTE MEDIO SE SOLICITA EL APOYO CON CAMBIO DE FECHA DEL MODULO DE PEDIDO DE LAS SIGUIENTES ORDENES:
-37560 CON FECHA 05/06/2026
-37559 CON FECHA 04/06/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-18 09:42:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS en el folio 37560 de 16/06/2026 a 05/06/2026 y en el folio 37559 de 16/06/2026 a 04/06/2026', 'Modificación en BD', '2026-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001464');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001493', 'CAMBIO DIRECTA CONTRATO', '2026-06-17 17:05:00', 'Por este medio solicito de su apoyo para el cambio de adjudicación del contrato: 37547
Debe decir: DIRECTA CONTRATO.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-18 16:05:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-06-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001493');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001480', 'VALIDACION COMPLEMENTOS DE PAGO POR ERROR', '2026-06-17 13:17:00', 'BUEN DÍA, SE SOLICITA EL AMABLE APOYO CON LA VALIDACI''ÓN EN COMPLEMENTO DE PAGO, CON MOTIVO DE QUE MARCA ERROR EN CENTAVO. 
GRACIAS.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-18 13:08:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001480');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001501', 'CAMBIO DIRECTA CON CONTRATO', '2026-06-18 11:43:00', 'Buenos días estimados 
Por medio del presente, solicito su apoyo para cambiar el estatus de adjudicación del contrato no. 37562. El nuevo estatus debe ser: "Directa con contrato".
De antemano agradezco el apoyo 
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Domínguez Vera, Michelle'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-19 09:43:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001501');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001491', 'ERROR EN CARGA DE VIATICOS', '2026-06-17 15:57:00', 'Buena tarde compañeros, solicito su amable apoyo, al cargar mis viaticos y darle guardar para poder cargar las facturas, me arrojo el siguiente mensaje que adjunto a continuacion; las facturas en las cuales me aparece el error fueron las que adjunto a continuacion para que en su defecton las borren y pueda volver a capturarlas.
agradezco el apoyo y quedo atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Haruel Aguirre, Lizbeth'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-18 13:57:00', 'Seguimiento de proceso. Se revisó que los archivos se cargaron correctamente.', 'Seguimiento de proceso', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001491');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001496', 'ERROR EN FOLIO EN COMPROBACIÓN DE VIATICOS', '2026-06-17 17:37:00', 'Buenas tardes estimados. 
Se solicita de su amable apoyo para modificar dentro del módulo de Viáticos / Comprobación de Viáticos, el No. de Comprobante y el Monto cargado en el registro "Ref 7" del folio 5131, misma que se adjunta al presente para su pronta referencia.
Debe decir:
Comprobante: A547
Monto: $108.00',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-18 12:37:00', 'Se eliminó el registro de VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para conservar la secuencia.', 'Modificación en BD', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001496');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001489', 'AGREGAR IMFORMACIÓN EN OBSERVACIONES PEDIDO 37379', '2026-06-17 15:53:00', 'Buenas tardes, 
me podrían apoyar agregando en el pedido 37379  en la sección de observaciones (marcado con punto rojo) la siguiente información:
"PUBLICACIÓN EN EL DOF DE LA CONVOCATORIA NO.10/2026"
Lo anterior ya que se requiere por parte del área de finanzas para que se vea reflejado en su póliza contable',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-18 13:53:00', 'Se colocó el texto solicitado en OBSERVACIONES de INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001489');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001488', 'Solicitud de apoyo con factura en mediport', '2026-06-17 15:35:00', 'Buenas tardes, solicito su amable apoyo, pues existe un problema con los QR de las facturas con folios #87345 y #87343 del proveedor SCH EXHIBICIONES, por ello se solicita eliminar los archivos actualmente en bóveda y sustituirlos por los siguientes adjuntos.

Quedó atenta a sus comentarios.
Le agradezco y le mando saludos.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-19 09:05:00', 'Se reemplazaron los PDF de la bóveda.', 'Modificación en BD', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001488');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001476', 'Solicitud de apoyo para subir complementos de pago.', '2026-06-17 09:53:00', 'Buenos días, solicito su apoyo para poder quitar el candado de los complementos de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serían los siguientes folios:
Pues me aparece el siguiente error:
De igual manera le adjunto los complementos de pago pendientes de subir.
Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-18 15:58:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001476');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001506', 'CAMBIO DIRECTA CONTRATO', '2026-06-18 15:47:00', 'Por este medio solicito de su apoyo para el cambio de adjudicación del contrato:37402.
Debe decir: Directa Contrato.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-19 10:47:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001506');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001508', 'CAMBIO DIRECTA CONTRATO', '2026-06-18 15:58:00', 'Por este medio solicito de su apoyo para el cambio de Adjudicación del contrato:37557.
Debe decir: Directa Contrato.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-19 10:58:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-06-18 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001508');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001510', 'SOLICITUD DE PRIVILEGIOS EN PORTAL SIIPV', '2026-06-18 16:25:00', 'Buenas tardes.
Solicito de su amable apoyo para otorgarme los privilegios para realizar solicitud de insumos al usuario auxcontrol6.
Saludos.',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Acosta Ramos, Yahaira Alin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-19 13:25:00', 'Se asignaron los privilegios de Movimiento de Almacén y Solicitudes de Salidas.', 'Modificación en BD', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001510');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001507', 'MONTOS EN ESTRUCTURA PROGRAMATICA Y MOMENTOS CONTABLES PRESUPUESTAL', '2026-06-18 15:58:00', 'Buenas tardes:
Por favor su apoyo para realizar el cambio de montos en la póliza DIARIO 97 del mes de junio, tanto en estructura programática como en momentos contables presupuestal. Adjunto pantallas y hoja de trabajo Excel.',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Captura de pólizas'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-19 10:58:00', 'En CONTA.MOVIMIENTOS se modifico el campo MOVMONTO asi como en CONTA.ESTPROGEGREDOCTO para todos los registros indicados, asi como en CONTA.POLIZAS se modificaron los campos POLIZAMONTOCARGOS y POLIZAMONTOABONOS', 'Modificación en BD', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001507');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001481', 'SUSTITUCION DE FACTURAS EN EL FOLIO 87436', '2026-06-17 13:26:00', 'Buen dia

Por medio de la presente, solicito su apoyo para sustituir las facturas validadas en el folio 87436, lo anterior, debido a que no fue posible la lectura del QR de la factura, por lo que sustituye por la descargada directamente desde el portal del SAT.

Sin otro particular, envio un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-22 09:06:00', 'Se reemplazó el PDF en bóveda.', 'Modificación en BD', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001481');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001492', 'SOLICITUD DE MODIFICACIÓN EN FECHA DE REQUISICIÓN', '2026-06-17 16:08:00', 'Buenas tardes, 

Por medio del presente solicito su colaboración para realizar una modificación en la fecha de elaboración del contrato de servicios con número de orden 37565

Debe decir: 22/05/2026

Agradeciendo de antemano su colaboración, le envío un cordial saludo',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-22 09:12:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001492');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001520', 'MONTOS EN ESTRUCTURA PROGRAMATICA Y MOMENTOS CONTABLES PRESUPUESTAL', '2026-06-19 10:52:00', 'Buenos días:
Por favor su apoyo para realizar el cambio de montos en la póliza DIARIO 225 del mes de junio, tanto en estructura programática como en momentos contables presupuestal. Adjunto hoja de trabajo Excel. Las marcadas en verde son las que se deben de agregar. Gracias.',
  (select id from ventanas_mesa where nombre = 'POLIZA VS ESTRUCTURA PROGRAMATICA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad/Captura de pólizas'),
  (select id from solicitantes_mesa where nombre = 'Reyes Jiménez, Jocelyn Aurora'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-19 10:58:00', 'En CONTA.MOVIMIENTOS se modifico el campo MOVMONTO asi como en CONTA.ESTPROGEGREDOCTO para todos los registros indicados, asi como en CONTA.POLIZAS se modificaron los campos POLIZAMONTOCARGOS y POLIZAMONTOABONOS', 'Modificación en BD', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001520');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001356', 'Problemas para subir complemento de pago en Mediport', '2026-06-06 11:41:00', 'EL CONTRATISTA  INGENIERIA Y CONSULTORIA AMBIENTAL DE VERACRUZ, S.A DE C.V Contrato: ASPN-GI-CS-62601-002-26; YA QUE PRESENTA PROBLEMAS PARA SUBIR COMPLEMENTO DE PAGO.
SE ANEXA COMPLEMENTO DE PAGO EN PDF Y XML',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-22 14:52:00', 'Se realizó manualmente la carga del complemento de pago debido a un error de Diferencia en Importe anterior e Importe insoluto. El sistema contemplaba los valores únicamente para el complemento de pago; mientras que, el complemento, contemplaba los importes dentro del contrato antes y después del pago.', 'Modificación en BD', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001356');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001519', 'SOLICITUD PARA BORRAR REGISTROS DE LA COMPROBACIÓN DE VIÁTICOS NO. 5141', '2026-06-19 10:41:00', 'Buenos días,
Por medio del presente solicito su amable apoyo para eliminar/borrar los registros en su totalidad que a continuación se indican de la comprobación de viáticos No.5141:
1.       1. Rubro 4 “Consumo de alimentos (viáticos) $188.00
2.Rubro 2 “Taxis (comprobante con req.fiscal) $173.52
3.  Rubro 2 “Taxis (comprobante con req.fiscal)” $152.55
Quedo atenta a cualquier duda o comentario al respecto.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-19 15:41:00', 'Se eliminaron los registros de VTCOSDETCOMPROBACION, FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001519');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001473', 'APLICAR CANDADO PARA VALIDACION DE PROCESO DE PAGO', '2026-06-16 18:31:00', 'Buenas tardes, solicito su apoyo con error generado al intentar autorizar pago dentro del modulo de compras en el apartado de pagos, esto con el proveedor 1480 en el pago 85657
adjunto evidencia de error:
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-18 09:14:00', 'Seguimiento de proceso, se realizo un ajuste en el procedimiento VALIDAEJERCIDO para poder evitar la evaluacion del pago en la forma CPPPAGOS.fmb', 'Seguimiento de proceso', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001473');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001525', 'Error Mediport', '2026-06-19 12:20:00', 'Buenos días estimado 
Por este medio se solicita su valioso apoyo a fin de cargar la factura de ingreso del  ASPN-GI-CO-62602-005-25 VIAS Y EDIFICACIONES DEL GOLFO toda vez que presenta el siguiente error en Mediport:',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-22 10:04:00', 'Seguimiento de proceso, se cargo de manera manual el archivo con el usuario del contratista en el folio 87438', 'Seguimiento de proceso', '2026-06-19 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001525');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001500', 'Cambio de fecha y autorizacion REQUIS', '2026-06-18 11:33:00', 'Buen día, por medio del presente solicito su apoyo para cambio de fecha de las siguientes requisiciones al 08/05/2026:
De igual manera su apoyo para que en las tres se modifique el firman en autorización  A la Lic. Lizbeth Haruel Aguirre  :
Y en las IM cambiar también a la misma fecha 08/05/2026:
Y los firmantes si pudieran ser modificados de la sig manera:
Elabora: Alessandra Durante
Aprueba: Lizbeth Haruel
De antemano se agradece el apoyo brindado. Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Durante Crivelli, Alessandra'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-19 17:00:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS asi como momentaneamente se cambio el titular en NOMINA.DEPARTAMENTOS, en INVENTARIO.REQUISICIONES se cambio el campo TRABNUM_SOLICITO', 'Modificación en BD', '2026-06-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001500');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001538', 'CAMBIO DE FECHA EN PEDIDO', '2026-06-22 10:51:00', 'Buenos días 

Solicito de su amable apoyo para realizar el cambio de fecha en el pedido con número de orden 37586 y de fecha 22 de junio de 2026.

La fecha correcta debe ser: 13 de mayo de 2026.

agradezco de antemano el apoyo 
saludos!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-22 14:51:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001538');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-000838', 'Ajuste de Monto Comprometido', '2026-04-15 11:09:00', 'Buenos días estimado
Por este medio se solicita su valioso apoyo a fin de comprometer en el Contrato ASPN-GI-CS-62903-001-25 del siguiente Contrato:',
  (select id from ventanas_mesa where nombre = 'CAPTURA Y CONSULTA DE CONTRATOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Contabilidad'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-22 13:56:00', 'En OBRAS.DISTRCONTRATOS se modifico el monto en MONTOPEND para poder comprometer', 'Modificación en BD', '2026-06-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-000838');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001556', 'Usuario incorrecto en el portal SIIP', '2026-06-23 11:08:00', 'El nombre de empleado no es el mío, aparece el nombre de mi compañero Carlos Ignacio Gomez Hernández y no me permite hacer mi tramite para justificar mis incidencias. 

nombre de usuario

cproteccion 
contraseña
Proteccion*26',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/Nuevos Ingresos'),
  (select id from solicitantes_mesa where nombre = 'Martínez Alemán, Fernando'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-23 16:08:00', 'Seguimiento de proceso. Se comentó mediante el cierre de la mesa que el usuario utilizado pertenecía al trabajador anterior, entonces requiere levantar una mesa solicitando su nuevo usuario.', 'Seguimiento de proceso', '2026-06-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001556');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001549', 'NO ME DEJA INGRESAR A SIIPV2', '2026-06-23 09:11:00', 'BUENA TARDE,

POR ESTE MEDIO SOLICITO SU APOYO TODA VEZ QUE AL CAPTURAR MI CONTRASEÑA DE SIIPV2, ME APARECE UN MENSAJE QUE LA CONTRASEÑA NO ES CORRECTA.

QUEDO PENDIENTE.

SALUDOS CORDIALES.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/Nuevos Ingresos'),
  (select id from solicitantes_mesa where nombre = 'Morfinez Anaya, Jose Gabriel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-23 16:08:00', 'Se pidió mediante llamada telefónica que intentara reiniciar para refrescar el ldap.', 'Seguimiento de proceso', '2026-06-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001549');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001524', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN 133655 E INVESTIGACIÓN DE MERCADO 10831.', '2026-06-19 12:13:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se gestionen diversas modificaciones de fecha en la Requisición No. 133655.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 19/06/2026
F. REQUIERE: 19/06/2026
F. RECEPCIÓN: 19/06/2026
DEBE DECIR: 11/06/2026
Asimismo, solicito se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10831, dentro del apartado "Investigación de Mercado", ya que emana de la Requisición antes descrita.
La modificación es con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA: 19/06/2026
DEBE DECIR: 11/06/2026
También se solicita se lleven a cabo las modificaciones de fecha en la Investigación de Mercado No. 10831, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA ACT: 19/06/2026
DEBE DECIR: 11/06/2026
FECHA COTIZACIÓN: 19/06/2026
DEBE DECIR: 10/06/2026
Sin otro particular, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 12:33:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES, INVESTIGACIONMERCADO y PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001524');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001530', 'MODIFICACIÓN DE FECHA EN INVESTIGACIÓN DE MERCADO 10832 CORRESPONDIENTE A LA REQUISICIÓN 133656.', '2026-06-19 15:46:00', 'Por medio del presente, solicito amablemente su apoyo a fin de que se a cabo las modificaciones de fecha en la Investigación de Mercado No. 10832, dentro del apartado "Proveedores de la Investigación de Mercado", ya que emana de la Requisición antes descrita.
Con los datos que se muestran a continuación (se adjunta imagen para su pronta referencia):
FECHA COTIZACIÓN: 19/06/2026
DEBE DECIR: 18/06/2026
Sin más por el momento, envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 12:19:00', 'Se realizó el cambio de fechas en INVENTARIO.PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001530');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001531', 'CAMBIO DE FECHA DE PEDIDO', '2026-06-19 16:52:00', 'Buenas tardes, solicito su amable apoyo para realizar un cambio de fecha en el pedido 37583 tiene la fecha de: 37583 y debe tener 15/06/2026. 
Quedo atento a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 12:59:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001531');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001516', 'MODIFICACIÓN EN ATRIBUTOS DE FOLO DE NOTA DE CREDITO || MEDIPORT', '2026-06-19 10:07:00', 'Buenos días, 
Por medio del presente solicito de su colaboración para modificar en MEDIPORT los atributos de facturación del folio de la nota de crédito:
Forma de pago
Dice: 99
Debe decir: 03
Método de pago
Dice: PPD
Debe decir: PUE
Agradeciendo de antemano su colaboración. 
Le envío un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 15:54:00', 'Se realizó el cambio de METODO_PAGO y FORMA_PAGO en INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001516');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001545', 'SOLICITUD DE PERMISOS DEL MEDIPORT', '2026-06-22 16:15:00', 'Buenas tardes ingeniero, 

Por medio del presente solicito de su amable apoyo para habilitar los permisos del mediport, derivado que estaré llevando actividades relacionadas con los PSP y PSC, agradezco de su amable apoyo y adjunto los links de los permisos mencionados, gracias: 

- https://www.mediport.com.mx/mediportV2/Inicio/MPAcceso.aspx
- https://www.mediport.com.mx//contratos/Formas/bienvenida.aspx

Saludos cordiales,',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/Mediport'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-23 13:15:00', 'Se asignó el 148 Contratos Comercialización al usuario 100513 en EDIV2.USUARIOS_ROLES.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001545');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001544', 'apoyo con cambio de fecha para la requicisión', '2026-06-22 12:57:00', 'numero de requisición 133627 debe de quedar con fecha 8 de mayo',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'García Sosa, Samuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 12:59:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001544');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001566', 'PRIVILEGIOS SIIP V2', '2026-06-23 17:14:00', 'Buen día, 
Solicito el apoyo correspondiente para generar mi usuario y contraseña para tener acceso al SIIP V2. 

Agradezco sus atenciones.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/Nuevos Ingresos/SIIP- nuevo ingreso'),
  (select id from solicitantes_mesa where nombre = 'Carmona Najera, Joseline'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 12:14:00', 'Se dio de alta en CONTROL.USUARIOS y se compartieron credenciales de acceso mediante correo electrónico.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001566');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001574', 'SOLICITUD DE PRIVILEGIOS SIIP', '2026-06-24 11:02:00', 'MEDIANTE LA PRESENTE SOLICITO CREDENCIALES DE ACCESO PARA SIIP',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Trujillo Melchor, Omar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-25 09:02:00', 'Se dio de alta en CONTROL.USUARIOS y se compartieron credenciales de acceso mediante correo electrónico.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001574');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001571', 'ERROR AL CARGAR INCIDENCIAS', '2026-06-24 09:55:00', 'Al darle guardar dice guardado y en automático tira este mensaje y aunque le des "yes" borra todo.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Trujillo Melchor, Omar'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 13:55:00', 'Se reactivó el usuario Mediport en EDIV2.USUARIOS.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001571');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001561', 'solicitud para alta de nuevo usuario.', '2026-06-23 16:26:00', 'Solicito del apoyo para alta de nuevo usuario ya que el usuario pertenecía al encargado anterior de la Coordinación de Protección, para así poder justificar las incidencias en el sistema SIIPV2.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Martínez Alemán, Fernando'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 11:26:00', 'Se dio de alta al usuario en CONTROL.USUARIOS y se proporcionaron credenciales de acceso a SIIP mediante correo electrónico.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001561');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001580', 'PRIVILEGIOS INTEGRAL', '2026-06-24 12:51:00', 'POR ESTE MEDIO SOLICITO DE SU AYUDA PARA OBTENER LOS ACCESOS AL SISTEMA INTEGRAL',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Trujillo Melchor, Omar'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-24 17:51:00', 'Se actualizo el usuario en SERVICIO.USUARIOS32 y en SERVICIO.CONTACTOS01', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001580');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001581', 'justificacion de incidencias', '2026-06-24 15:30:00', 'Buenas tardes.

Por medio del presente solicito  de su amable apoyo, que el sistema SIIP no me deja  realizar la justificación de mis incidencias del usuario seccomercial 

nota: ya se había levantado una mesa de ayuda

muchas gracias quedo atenta.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Jimenez, Phecda Monserrat'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-25 10:30:00', 'Se reactivó el usuario Mediport en EDIV2.USUARIOS.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001581');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001577', 'CAMBIO DIRECTA CONTRATO', '2026-06-24 11:10:00', 'Por este medio solicito de su apoyo para el cambio de Adjudicación de los siguientes contratos:
-37558
-37556
Debe decir: Directa Contrato.
Ya se encuentran en estado abierto para las modificaciones solicitadas.
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-24 16:10:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001577');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001505', 'Asignación usuario para empresa ARICAE', '2026-06-18 14:40:00', 'por medio del presente solicito de su apoyo para dar de alta a la empresa ARICAE en el sistema integral, para la realizar la carga de estimaciones.
Que se necesita para realizar dicho proceso, quedo pendiente de su contestación
Sin mas por el momento y agradeciendo su atención.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/Integral'),
  (select id from solicitantes_mesa where nombre = 'Anell Ortiz, Enrique'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-19 10:00:00', 'Seguimiento de proceso. Se comentó mediante el cierre de la mesa el proceso de generacion de usuarios para empresas contratistas', 'Seguimiento de proceso', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001505');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001567', 'Solicitud de apoyo con factura en mediport', '2026-06-23 17:20:00', 'Buenas tardes, solicito su amable apoyo, pues existe un problema con el QR de la factura con folio #87476 del proveedor OFIX S.A. DE C.V., por ello se solicita eliminar los archivos actualmente en bóveda y sustituirlos por los siguientes adjuntos.

Quedó atenta a sus comentarios.
Le agradezco y le mando saludos.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-24 12:52:00', 'Se reemplazó el PDF en bóveda.', 'Modificación en BD', '2026-06-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001567');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001186', 'Error Mediport', '2026-05-19 17:57:00', 'Buenas tardes 
Por este medio se solicita su valioso apoyo a fin de cargar en Mediport las facturas que se anexan al presente, respecto del contratista  SYMMETRIC ENGINEERING CONSTRUCTION SUPERVISION, S.A. DE C.V. Le Notifico que ha sido autorizada su estimacion No. 2-N del Contrato de obra: ASPN-GI-CO-62601-017-25 con el No. de Folio 87179.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-24 12:57:00', 'Seguimiento de proceso, se realizo la carga manual del archivo de la factura', 'Seguimiento de proceso', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001186');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001543', 'Error Mediport', '2026-06-22 12:57:00', 'Buenas tardes
Por este medio se informa que referente al Contrato ASPN-GI-CO-62602-005-25 Vías y Edificaciones del Golfo, S.A. de C.V.  las Facturas de las estimaciones 7N, 8N y 9N no se visualizan en el Sistema MEDIPORT.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-22 16:57:00', 'Seguimiento de proceso, se verifico que los archivos se muestren correctamente en sistema', 'Seguimiento de proceso', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001543');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001555', 'Error Integral y Mediport', '2026-06-23 10:50:00', 'Buenos días  
Por este medio se solicita ayuda urgente toda vez que desde la tarde de ayer el Mediport aparentemente recibe las facturas pero en el Integral no se visualizan en todos los contratos, lo que imposibilita el trámite de pago:
Error Mediport:',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-23 15:50:00', 'Seguimiento de proceso, se verifico que los archivos se cargan y muestran correctamente en sistema', 'Seguimiento de proceso', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001555');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2026-001534', 'ELIMINAR FACTURA DE BOVEDA', '2026-06-22 09:39:00', 'Buenos días 
Estoy intentando subir una factura al folio 87502 de MEDIPORT y no me permite validarla, ya que me sale el error de que la factura ya se encuentra en bóveda, ¿me podrán apoyar para realizar la carga?
Adjunto XML y PDF',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-22 15:39:00', 'El error surgía por problema temporal en bóveda. El usuario cargó sus facturas correctamente.', 'Seguimiento de proceso', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2026-001534');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select '2026-06-22 10:19:00', 'ELIMINAR FACTURA DE BOVEDA', '2026-06-22 10:19:00', 'Buenos días 
Estoy intentando subir una factura al folio 87503 de MEDIPORT y no me permite validarla, ya que me sale el error de que la factura ya se encuentra en bóveda, ¿me podrán apoyar para realizar la carga?
Adjunto XML y PDF',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-22 14:19:00', 'El error surgía por problema temporal en bóveda. El usuario cargó sus facturas correctamente.', 'Seguimiento de proceso', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = '2026-06-22 10:19:00');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001584', 'VALIDACION COMPLEMENTOS DE PAGO POR ERROR', '2026-06-25 09:03:00', 'BUEN DÍA, SE SOLICITA EL APOYO CON LA VALIDACIÓN DE UNOS COMPLEMENTOS POR ERROR EN LA FECHA DE PAGO. 
GRACIAS.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-26 09:10:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001584');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001588', 'Actualización Integral - Finiquitos', '2026-06-25 10:12:00', 'Buenos días Estimado
Por este medio, se informa que el Sistema Integral no permite Finiquitar el contrato ASPN-GI-CO-62601-005-24   Construcción de la VIP Ingeniería, S.A. de C.V.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-25 15:12:00', 'Se modifco el procedimiento pkg_armonizacont.armonizar2 para incluir el contrato a finiquitar', 'Modificación en BD', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001588');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001589', 'Actualización Integral - Finiquito', '2026-06-25 10:18:00', 'Buenos días Estimado
Por este medio, se informa que el Sistema Integral no permite Finiquitar el contrato ASPN-GI-CO-62602-010-24  Grupo Constructor Piro, S.A. de C.V.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'CALCULO DE ESTIMACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-25 15:18:00', 'Se modifco el procedimiento pkg_armonizacont.armonizar2 para incluir el contrato a finiquitar', 'Modificación en BD', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001589');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001585', 'APOYO PARA SUBIR UNA FACTURA A MEDIPORT', '2026-06-25 09:14:00', 'Buenos días, solicito su amable apoyo para subir a MEDIPORT una factura correspondiente al proveedor CENTRO DE ESTUDIOS CRISTOBAL COLON, por un monto de 3500 con folio de factura 87506, el pedido es 37394, el cual consta de 3 servicios, las facturas se emitieron con los siguientes atributos:
Método de pago: PUE
Forma de pago: TRANSFERENCIA ELECTRONICA DE FONDOS
Uso de CFDI: GASTOS EN GENERAL 
Derivado de lo anterior, ya se realizaron 2 pagos de 3, y para proceder con el 3er pago me sale un error de complemento.
solicito su amable apoyo para cargar la factura y el XML, quedo pendiente para hacerles llegar los archivos correspondientes.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-26 11:19:00', 'Se cambió el ESTADO en INVENTARIO.FOLIO_COMPLEMENTO debido a que no aplicaba para este caso particular.', 'Modificación en BD', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001585');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001583', 'Cambio de fecha a requisición', '2026-06-24 16:15:00', 'Buen día, por este medio solicito de la manera mas atenta apoyarme con el cambio de fecha de la requisición 133661 y de la investigación de mercado 010837,  a la fecha del 19 de junio de 2026.
Sin otro particular agradezco las atenciones quedo atenta.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Villalba Rojas, Briseiri Aylin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-26 11:05:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001583');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001587', 'COMPROBACION DE VIATICOS', '2026-06-25 09:50:00', 'Buen día equipo.
El motivo del presente es haciendo referencia a la comprobación de viáticos con numero 5143, el cual se solicita el apoyo con la eliminación del rubro 2 señalado dentro del cuadro color rojo (ADJUNTO EVIDENCIA), lo anterior por estar errónea.
Sin otro particular, reciban un saludo.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-25 16:50:00', 'Se eliminó el registro en VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001587');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001596', 'CAMBIO DE FECHA', '2026-06-25 13:58:00', 'Buenas tardes estimados.
Se solicita de su amable apoyo para poder realizar el cambio de fecha de la Investigación de Mercado No. 10779 que se encuentra dentro del módulo de Compras en el SIIP.
Dice: 15/05/2026
Debe decir: 25/06/2026
Sin otro particular, de antemano muchas gracias.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Díaz Centurion, Karla Fabiola'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-26 09:58:00', 'Se realizó el cambio de fechas en INVENTARIO.INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001596');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001599', 'ABRIR MODULO DE JUSTIFICACION DE INCIDENCIAS', '2026-06-25 16:33:00', 'Hola buenas tardes estimados a quien corresponda.
Por favor, apoyarme, en el modulo de justificacion de incidencias, poniendo en estado ABIERTA,  el numero de solicitud: 16757, para poder modificar los datos.
gracias',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Landeros Hernández, Brenda Marlem'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-26 13:33:00', 'Se eliminaron los registros en EDIV2.DOCUMENTO, FLUJODOCUMENTO, INCIDENCIA, JUSTIFICA_INCIDENCIA y JUSTIFICA_INCIDENCIA_DETALLE.', 'Modificación en BD', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001599');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001595', 'MODIFICACION PAGO EN SISTEMA', '2026-06-25 12:58:00', 'BUENAS TARDES, SOLICITO SU APOYO CON LA MODIFICACION DEL PAGO 85490 EL CUAL PERTENECE A LA POLIZA 206 DE CHEQUES DE MAYO, YA QUE ESTE TIENE MARCADA LA CASILLA DE USO DE COMPLEMENTO, POR LO QUE SOLICITO NOS APOYEN CON RETIRAR LA SELECCION DE DICHA CASILLA YA QUE FUE MARCADA POR ERROR
ADJUNTO CAPTURA DEL PAGO MENSIONADO:


SALUDOS CORDIALES',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-25 17:58:00', 'Se cambió el valor de REQUIERE_COMP a 0 y se quitó el folio de FOLIO_COMP en INVENTARIO.PAGOS.', 'Modificación en BD', '2026-06-25 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001595');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'INC 2026-001610', 'Error Incidencias', '2026-06-26 10:12:00', 'El Sistema SIIPV2 no permite guardar y tramitar las incidencias.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-26 17:12:00', 'Se cambió el valor de REQUIERE_COMP a 0 y se quitó el folio de FOLIO_COMP en INVENTARIO.PAGOS.', 'Modificación en BD', '2026-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'INC 2026-001610');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001594', 'APLICAR CANDADO PARA VALIDACION DE PROCESO DE PAGO', '2026-06-25 11:54:00', 'Buenas tardes, solicito su apoyo con error generado al intentar autorizar los pagos dentro del modulo de compras en el apartado de pagos, esto con el proveedor 10119 en los pagos 85735, 85736 y 85737
adjunto evidencia de error:',
  (select id from ventanas_mesa where nombre = 'PAGOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras'),
  (select id from solicitantes_mesa where nombre = 'Gerrero Serrano, Diego'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-06-26 09:54:00', 'Seguimiento de proceso, se realizo un ajuste en el procedimiento VALIDAEJERCIDO para poder evitar la evaluacion de los pagos en la forma CPPPAGOS.fmb', 'Seguimiento de proceso', '2026-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001594');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001609', 'SUSTITUCION DE FACTURAS EN EL FOLIO 87458', '2026-06-26 09:34:00', 'Buen dia

Por medio de la presente, solicito su apoyo para sustituir las facturas validadas en el folio 87458, lo anterior, debido a que no fue posible la lectura del QR de la factura, por lo que sustituye por la descargada directamente desde el portal del SAT.
- Se adjunta factura.
De antemano agradezco la atención, saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-29 10:00:00', 'Se reemplazó el PDF en bóveda.', 'Modificación en BD', '2026-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001609');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001605', 'CAMBIO DE FECHA EN PEDIDO', '2026-06-25 18:13:00', 'Buenas tardes 
Solicito de su amable apoyo para realizar el cambio de fecha en el pedido con número de orden 37592 de fecha 25 de junio de 2026.

La fecha correcta debe ser: 24 de junio de 2026.

Agradezco de antemano el apoyo 
Saludos!',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-29 10:00:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001605');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001611', 'Solicitud de apoyo para cambio de fecha', '2026-06-26 11:15:00', 'Buenos días, solicito su apoyo para poder cambiar la fecha del siguiente pedido:

Pedido: 37594
Fecha Solicitada: 11/06/2026
Pedido: 37595
Fecha Solicitada: 19/06/2026

Gracias, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-29 09:45:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001611');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001617', 'Borrar una factura del SIIP viáticos', '2026-06-26 15:12:00', 'Buenas tardes.



Para solicitar atentamente su apoyo para borrar un registro en la comprobación de viáticos de folio 5147 del montó de $625 pesos, esto debido a que se va a subir nuevamente la factura.
Agradezco de antemano la atención y quedo atenta a cualquier duda al respecto.

Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Chavez Ramos, Selene'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-29 10:12:00', 'Se eliminó el registro en VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001617');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001608', 'Solicitud de apoyo para subir complementos de pago.', '2026-06-26 09:33:00', 'Buenos días, solicito su apoyo para poder quitar el candado de los complementos de pago de CFE en mediport, pues existe una diferencia en las fechas por lo cual no me deja proseguir. 
Serían los siguientes folios:




Pues me aparece el siguiente error:

De igual manera le adjunto los complementos de pago pendientes de subir.

Le agradezco, quedó atenta a sus comentarios.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velazquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-29 09:35:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-06-26 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001608');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001619', 'ELIMINAR FACTURA DE SIIP', '2026-06-26 17:09:00', 'Buena tarde,
Solicito de su amable apoyo para eliminar una factura de la comprobación de viáticos (folio 4749), la factura que se necesita bajar es de un total de $419, esto con el fin de subir la factura correcta correspondiente a ese consumo.
Agradezco su apoyo.
Saludos.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'González Cerezo, Cristina'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-29 12:09:00', 'Se eliminó el registro en VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-06-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001619');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001622', 'SOLICITUD PARA BORRAR REGISTROS DE LA COMPROBACIÓN DE VIÁTICOS NO. 5141.', '2026-06-29 10:29:00', 'Buenos días,
Por medio del presente solicito su amable apoyo para eliminar/borrar los registros en su totalidad que a continuación se indican, de la comprobación de viáticos No.5141:
1. Rubro 4 “Consumo de alimentos (viáticos)” $825.00.
Quedo atenta a cualquier duda o comentario al respecto.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-29 17:29:00', 'Se eliminó el registro en VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-06-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001622');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001635', 'ACTIVIACION DEL MODULO DE VIATICOS SIIP', '2026-06-29 16:57:00', 'Buena tarde,
Solicito su apoyo con el fin de activarme el modulo de viáticos en el aplicativo SIIP,
Gracias!!',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Morales Mavil, Jorge Antonio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-30 13:57:00', 'Se dio de alta al usuario en módulo de viáticos.', 'Modificación en BD', '2026-06-29 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001635');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001633', 'APOYO PARA MODIFICACIÓN DE FECHA EN INV. DE MERCADO', '2026-06-29 17:52:00', 'SOLICITO AMABLEMENTE APOYO A FIN DE QUE SE MODIFIQUE LA FECHA DE LA INVESTIGACIÓN DE MERCADO NO.10847.
DEBE TENER FECHA DE 24/06/2026
SE ADJUNTA IMAGEN AL PRESENTE PARA SU PRONTA REFERENCIA:',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-02 09:24:00', 'Se realizó el cambio de fechas en INVENTARIO.INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-07-01 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001633');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001631', 'CAMBIO DE FECHA', '2026-06-29 15:42:00', 'Buenas tardes por medio del presente solicito el apoyo con el cambio de fecha del siguiente pedido
PEIDO 37598 CON FECHA DE 22/06/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-02 09:32:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-07-01 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001631');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001656', 'no se guarda la justificación de incidencias', '2026-07-03 09:55:00', 'Buen día, solicito de su amable apoyo ya que intento guardar la justificación de incidencias y al dar guardar me indica que se guardaron correctamente y posteriormente me arroja una ventana que dice que si quiero guardar los cambios realizado9d pero al darle OK me saca y no guarda la justificación.

Anexo captura de pantalla para pronta referencia.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Padrón Ramón, Juan Vicente'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-03 13:55:00', 'Se reactivó el usuario Mediport para habilitar la justificación de incidencias.', 'Modificación en BD', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001656');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001665', 'ELIMINACION DE FACTURA EN SIIP', '2026-07-03 15:03:00', 'Buena tarde equipo.
El presente es para solicitar el apoyo con la eliminación de una factura con número de comprobante D3BB con un total de importe de $100.00 pesos, ubicada en el modulo de comprobación de viáticos folio 5143, lo anterior por instrucciones del departamento de contabilidad.
*adjunto referencia.
saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-06 12:03:00', 'Se eliminó el registro en VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001665');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001636', 'ACCESO A SISTEMAS', '2026-06-29 18:45:00', 'Buenas tardes:
Solicito su apoyo para que se le asignen privilegios de acceso a los sistemas SIIPV2 e Integral al Arq. Eric Baraquiel Hernández Canseco, quien a partir del día de hoy ocupa la Jefatura de Construcción adscrita a la Gerencia de Ingeniería.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-06-30 17:45:00', 'Se dio de alta al usuario en SIIP y se actualizaron los datos del usuario en SERIVICIO.USUARIOS32 y en SERVICIO.CONTACTOS01', 'Modificación en BD', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001636');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001645', 'CREACION DE CUENTA SIIPV2', '2026-07-02 10:49:00', 'Buen dia, solicito de la manera mas atenta, la creación de usuario y contraseña para el sistema SIIPV2.
Mi correo es el siguiente:  cproyectosing5@puertodeveracruz.com.mx
Por su atencion, gracias.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Ramos Morales, Ismael'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-02 17:49:00', 'Se dio de alta al usuario en SIIP.', 'Seguimiento de proceso', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001645');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001668', 'Actualizacion de datos en SIIPV', '2026-07-04 10:45:00', 'El buque DON GASPAR con Viaje 260421 es un remolcador que no paga atraque ni puerto, en sistema SIPV aparece que si debe de pagar puerto, y el sistema no me permite asignar exento de pago. de su apoyo en poder corregir ese dato. debe de decir exento puerto SI como aparece el atraque.',
  (select id from ventanas_mesa where nombre = 'ARRIBO DE BUQUES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones/Arribos y Zarpes de Buques'),
  (select id from solicitantes_mesa where nombre = 'Goméz Rodríguez, Ricardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-06 15:00:00', 'Se cambió el EXCENTO_PUERTO a S en OPERACION.BUQUES.', 'Modificación en BD', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001668');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001667', 'aviso de arribo no se actualizada en el acta de programación', '2026-07-04 10:14:00', 'en atención a la mesa de ayuda 1661, los cambios ya se ven reflejados en el aviso de arribo, sin embargo esos cambios no se reflejan a la hora de programar la asignación de muelles ni en el acta de programación de buques. De su apoyo en esta cuestión.',
  (select id from ventanas_mesa where nombre = 'ACTA DE PROGRAMACION'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Goméz Rodríguez, Ricardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-06 15:00:00', 'Se colocó el BUQUE (de 0 a 12104) en OPERACION.VIAJES.', 'Modificación en BD', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001667');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001666', 'MANIFIESTO (NO DEFINIDO)', '2026-07-04 09:50:00', 'Al llegar la solicitud samm3, en el nombre del buque aparece no definido.',
  (select id from ventanas_mesa where nombre = 'SAM M3'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Almacenes/Manifiestos'),
  (select id from solicitantes_mesa where nombre = 'Laurent García, Ximena'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-06 15:00:00', 'Se colocó el BUQUE (de 0 a 12104) en OPERACION.VIAJES.', 'Modificación en BD', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001666');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001644', 'CREACION DE USUARIO SISTEMA INTEGRAL', '2026-07-02 10:48:00', 'Buen dia, solicito de la manera mas atenta, la creación de usuario y contraseña para el sistema INTEGRAL.
Mi correo es el siguiente:  cproyectosing5@puertodeveracruz.com.mx
Por su atencion, gracias.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Ramos Morales, Ismael'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-02 17:49:00', 'Se actualizaron los datos del usuario en SERIVICIO.USUARIOS32 y en SERVICIO.CONTACTOS01', 'Modificación en BD', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001644');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001649', 'SOLICITUD PARA ACCESO A PERMISOS MEDIPORT', '2026-07-02 13:52:00', 'Hola buenas tardes ingeniero,
Por medio del presente requiero de su amable apoyo para habilitar los permisos del MEDIPORT marcados en naranja, para hacer los trámites necesarios, muchas gracias. 
Anexo captura para mayor referencia:',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-03 11:52:00', 'Se otorgó el privilegio 168 (Comercialización Reportes) en EDIV2.USUARIO_ROLES al usuario 100513 (ABBELLO).', 'Modificación en BD', '2026-07-03 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001649');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001676', 'FALLO EN SIIP', '2026-07-06 12:52:00', 'Buen día,
Quisiera saber si me pueden apoyar con el aplicativo SIIP, ya que me aparece una pantalla sobre un error en la aplicación, 
Gracias!',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Seguridad de la Información/Solicitud de privilegios/SIIP'),
  (select id from solicitantes_mesa where nombre = 'Morales Mavil, Jorge Antonio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-07 09:52:00', 'El sistema estuvo caído temporalmente. Se comunicó al usuario que ya se encontraba restablecido.', 'Seguimiento de proceso', '2026-07-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001676');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001674', 'SOLICITUD PARA CAMBIO DE FECHA EN REQUISICION 133671', '2026-07-07 16:12:00', 'BUENA TARDE EQUIPO
EL MOTIVO DEL PRESENTE ES PARA SOLICITAR EL CAMBIO DE FECHA EN LA REQUISICIÓN 133671, EL CUAL DICE 30/06/2026 Y DEBE DECIR 26/06/2026, LO ANTERIOR DEBIDO A INSTRUCCIONES POR EL DEPARTAMENTO DE RECURSOS MATERIALES.
SIN MAS POR EL MOMENTO, RECIBAN UN CORDIAL SALUDO.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 12:58:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001674');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001670', 'Solicitud de apoyo para subir complemento de pago.', '2026-07-06 10:40:00', 'Buenos días, solicito su apoyo para poder quitar el candado y poder subir complementos de pago del proveedor CFE, con los siguientes folios:
Pues me aparece el siguiente error:
De igual manera le adjunto los complementos.
Quedó atenta a sus comentarios.
Le agradezco y le mando saludos.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velázquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-07 11:10:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-07-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001670');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001671', 'Cambio de fecha a requisición', '2026-07-07 11:54:00', 'Buenos días, estimados.
Solicito su amable apoyo en el cambio de fecha de la requisición 133705 y la investigación de mercado 010884 al 17 de junio de 2026, servicio de animación y ambientación en atención al evento del día del padre.
Agradezco las atenciones, quedo atenta.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Villalba Rojas, Briseiri Aylin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-08 10:54:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-07-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001671');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001655', 'cambio de fecha en una requisicion', '2026-07-03 09:48:00', 'cambiar la fecha de la requisición  numero 133627 y la investigacion de mercado 10881 deviendo ser la fecha 08 de mayo 2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'García Sosa, Samuel'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-03 13:48:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES', 'Modificación en BD', '2026-07-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001655');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001679', 'Correccion en siip', '2026-07-06 16:34:00', 'cambiar la fecha de la requisición  numero 133627 y la investigacion de mercado 10881 deviendo ser la fecha 08 de mayo 2026',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Morales Mavil, Jorge Antonio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-07 11:34:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-07-06 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001679');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001672', 'CAMBIO DIRECTA CONTRATO', '2026-07-07 12:27:00', 'Por este medio solicito de su apoyo para el cambio de Adjudicación del contrato: 37586.
Debe decir: DIRECTA CONTRATO.
EL Contrato se encuentra en estado abierto para que se puedan realizar las adecuaciones solicitadas.
Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Control de Contratos'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-07 17:27:00', 'Se cambió el TIPOADJ en INVENTARIO.PEDIDOS de 0 a 1.', 'Modificación en BD', '2026-07-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001672');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001673', 'CAMBIO DE FECHA REQUI/INVESTIGACION', '2026-07-07 12:34:00', 'Por este medio solcito de su apoyo para el cambio de fecha de la requisición 133704 así como su investigación de mercado 010883/2026.
Debe decir: 15/06/2026.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-07 17:34:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-07-07 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001673');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001675', 'ABRIR COMPROBACION DE VIATICOS', '2026-07-07 17:51:00', 'Buena tarde,
Solicito de su amable apoyo para abrir una comprobación de viáticos con el numero de folio 4749, esto con el objetivo de subir de nuevo una factura faltante.
Agradezco de antemano el apoyo.
Saludos.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Gonzalez Cerezo, Cristina'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-08 12:51:00', 'Se cambió el STATUS a 1 en VIATICOS.VTCOSCOMPROBACION.', 'Modificación en BD', '2026-07-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001675');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001646', 'ERROR EN INFORME DE ENTRADA', '2026-07-02 11:19:00', 'Buenas tardes
solicito de su amable apoyo ya que en el informe de entrada número 38329, aparecen dos entradas, una al almacén general y otra al virtual, sin embargo, únicamente se seleccionó el almacén general, por otro lado, al ser bienes del capitulo 5000 (activos) no se refleja el número inventario asignado, el cual es necesario que se presente en dicho informe para futuras revisiones. 
Adjunto PDF de informe de entrada. 
gracias',
  (select id from ventanas_mesa where nombre = 'SOLICITUDES DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedido'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-07 16:03:00', 'Se realizaron cambios en la forma cpdetactfij y cpsubdetsolcont, y en el reporte. Al pasar de cpsubdetsolcont mandaba subpartida + 1000. Se modificó para tomar en cuenta la partida (subpartida + (1000*partida)). Ej: Para partida 5 y subpartida 3, Activo Fijo tendrá partida 5003.', 'Modificación en BD', '2026-07-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001646');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001669', 'imprimir reporte por empleado en estado de baja', '2026-07-07 11:34:00', 'Buen día, derivado a una solicitud de información, agradezco me apoyes para imprimir el reporte de capacitación por empleado, del personal que se encuentra de baja.
La ruta para realizarlo es la siguiente:  
Recursos Humanos - capacitación - Rep. de Cursos x Empleado y ahí sale una ventana en la que se pone el año y pide el año inicial y el año final y el numero de empleado. y es ahí donde ya no puedo realizar la descarga del las personas servidoras públicas que ya no están activas. 
Agradezco su amable apoyo y quedo atenta a su respuesta.',
  (select id from ventanas_mesa where nombre = 'REPORTE DE CURSOS X EMPLEADO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Recursos Humanos/Capacitacion'),
  (select id from solicitantes_mesa where nombre = 'Bravo Bravo, Yadira'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-07 16:34:00', 'Se modificaron los grupos de registros LOV_EMPLEADO_DESC y en LOV_EMPLEADO_CVE para eliminar la restriccion de estado <> ''B'', replicando el mismo ajuste en el reporte rhcurempleados.rdf', 'Modificación en BD', '2026-07-08 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001669');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001678', 'ACCESO A SISTEMAS', '2026-07-08 12:18:00', 'Solicito su apoyo para que le sean asignados privilegios de acceso al SISTEMA INTEGRAL al Ing. ALONSO RODRIGUEZ GALAN, personal de reciente ingreso y quien funge como Jefe del Departamento de Proyectos adscrito a la Gerencia de Ingeniería.
Agradezco la atención.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-08 17:18:00', 'Se actualizaron los datos del usuario en SERIVICIO.USUARIOS32 y en SERVICIO.CONTACTOS01', 'Modificación en BD', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001678');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001651', 'SUSTITUIR FACTURAS EN BÓVEDA', '2026-07-02 15:45:00', 'Buenas tardes 
¿me podrían apoyar cambiando en bóveda las facturas de los folios siguientes??
87528  UUID: 5957CAA9-5C0D-4C93-AE73-693FACD818DC
87529  UUID: 49B93CDA-CF75-4805-A1FB-E6A9B78E9010
87534  UUID: D4A575F5-3094-4358-9322-3D74FF99D28D
Agradezco de antemano el apoyo 
saludos!',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-09 16:06:00', 'Se reemplazaron los archivos en bóveda.', 'Modificación en BD', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001651');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001693', 'SOLICITUD DE APERTURA DE COMISIONES', '2026-07-09 11:39:00', 'Buen día ingeniero, 
Por medio del presente solicito de su amable apoyo para abrir los siguientes folios de solicitud de viáticos derivado que el usuario seccomercial requiere realizar algunos cambios, por favor, muchas gracias.
Saludos cordiales, 
    gcomercializacion 
4785 
4786
     sgdmercado 
4787
4788',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-09 16:39:00', 'Se revirtió el STATUS a 1 y se quitaron los valores en las columnas de autorización, trámite y conta en VIATICOS.VTCOSSOLICITUD.', 'Modificación en BD', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001693');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001688', 'Solicitud de apoyo para cambio de fecha', '2026-07-08 17:26:00', 'Buenas tardes, solicito su amable apoyo para el cambio de fecha de una requisición, sería la siguiente:
-133712 con fecha 26/06/2026
Sin más por el momento, agradezco de antemano la atención que se sirva brindar al presente. 
Quedó atenta a sus comentarios.
Reciba un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velázquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 12:58:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001688');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001694', 'CAMBIO DE FECHA DE PEDIDO', '2026-07-09 11:57:00', 'BUENOS DIAS 
SOLICITO SU AMABLE APOYO PARA HACER UN CAMBIO DE FECHA EN EL PEDIDO 37583 DEL PROVEEDOR FREDY VILLALOBOS ECHEVERRIA, TIENE LA FECHA 15/05/2026 DEBE DE TENER LA FECHA DE 14/05/2026, QUEDO AL PENDIENTE DE SUS COMENTARIOS, MUCHAS GRACIAS',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 13:04:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001694');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001681', 'CAMBIO DE FECHA EN REQUI E INV', '2026-07-08 12:55:00', 'Por este medio solicito de su apoyo para el cambio de fecha de la requisición: 133704/2026 así como de su investigación de mercado 010883/2026, debe decir: 12/06/2026.
Quedo atenta a sus indicaciones.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 12:52:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001681');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001682', 'SOLCIITUD DE APOYO CON CAMBIO DE FECHA EN PEDIDOS', '2026-07-08 13:04:00', 'Buen día, 
Por este medio, se solicita el amable apoyo con el cambio de fecha a los siguientes pedidos con no. de orden: 
-37630 con fecha 01/07/2026
-37631 con fecha 01/07/2026
-37629 con fecha 01/07/2026
Sin más por el momento, agradezco de antemano la atención que se sirva brindar al presente. 
Reciba un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 13:01:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001682');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001685', 'Solicitud de apoyo para subir complemento de pago.', '2026-07-08 13:58:00', 'Buenas tardes, solicito su amable apoyo para subir un complemento de pago del proveedor OFIX S.A. DE C.V. a MEDIPORT, pues me aparece lo siguiente: 
De igual manera me permito adjuntar el complemento de pago correspondiente.
Quedó atenta a sus comentarios.
Le agradezco y le envío saludos.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velázquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 13:03:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-07-09 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001685');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001696', 'Solicitud de apoyo para cambio de fecha', '2026-07-09 16:56:00', 'Buenas tardes, solicito su amable apoyo para subir un complemento de pago del proveedor OFIX S.A. DE C.V. a MEDIPORT, pues me aparece lo siguiente: 
De igual manera me permito adjuntar el complemento de pago correspondiente.
Quedó atenta a sus comentarios.
Le agradezco y le envío saludos.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velázquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 15:58:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-07-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001696');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001698', 'APOYO PARA MODIFICACIÓN DE FECHA EN INV. DE MERCADO.', '2026-07-09 17:46:00', 'SOLICITO AMABLEMENTE APOYO A FIN DE QUE SE MODIFIQUE LA FECHA DE LA INVESTIGACIÓN DE MERCADO NO.10891.
DEBE TENER FECHA DE 22/06/2026
SE ADJUNTA IMAGEN AL PRESENTE PARA SU PRONTA REFERENCIA: 
EN LA SIGUIENTE CAPTURA DEBE DECIR LO SIGUIENTE:
FECHA ACT: 22/06/2026
FECHA COTIZACIÓN  02/06/2026  :',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 15:58:00', 'Se realizó el cambio de fechas en INVENTARIO.INVESTIGACIONMERCADO y PROVEINVESTIGACIONMERCADO.', 'Modificación en BD', '2026-07-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001698');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001702', 'AGREGAR OBSERVACIONES EN EL PEDIDO 37550', '2026-07-10 11:57:00', 'BUENOS DÍAS 
POR MEDIO DEL PRESENTE, SOLICITO SU AMABLE APOYO PARA AGREGAR DENTRO DEL APARTADO OBSERVACIONES DEL NO. DE ORDEN 37550 EL SEGUIENTE TEXTOS: SERVICIO ESPECIALIZADO PARA EL SUMINISTRO E INSTALACION DE UN SISTEMA DE ALARMA Y DETECTORESINALAMBRICOS DE TEMPERATURA, HUMO Y CALOR',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-13 09:57:00', 'Se realizó el cambio en INVENTARIO.OBSERVACIONES.', 'Modificación en BD', '2026-07-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001702');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001703', 'Solicitud eliminación de factura en SIIP', '2026-07-10 12:10:00', 'Buen día, 
Me podrían apoyar eliminando una factura en el sistema SIIP 
El folio de la comisión es 4783 y la factura es la No. 1515A por $54.
Muchas gracias.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Morales Mavil, Jorge Antonio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-10 17:10:00', 'Se eliminaron los registros de VIATICOS.VTCOSDETCOMPROBACION, INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda. Se modificaron los registros para mantener la secuencia.', 'Modificación en BD', '2026-07-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001703');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001704', 'MODIFICACIÓN DE FECHA EN REQUISICIÓN E INV DE MERCADO', '2026-07-10 12:19:00', 'SOLICITO AMABLEMENTE APOYO A FIN DE QUE SE MODIFIQUE LA FECHA DE REQUISICIÓN NO. 133714 Y DE LA INVESTIGACIÓN DE MERCADO NO.10891.


EN LA REQUISICIÓN DEBE TENER FECHA DE 01/07/2026

SE ADJUNTA IMAGEN AL PRESENTE PARA SU PRONTA REFERENCIA: 



EN LA SIGUIENTE CAPTURA DE LA INVESTIGACIÓN DE MERCADO DEBE DECIR LO SIGUIENTE:

FECHA: 01/07/2026',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Castillo Morales, Jennifer'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-13 12:58:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-07-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001704');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001708', 'SOLICITUD PARRA BORRAR REGISTRO EN LA COMPROBACIÓN DE VIÁTICOS No. 5156', '2026-07-10 13:36:00', 'Buen día, por medio del presente solicito su amable apoyo para eliminar el registro de una carga de factura por la cantidad de $900 junto con sus archivos PDF y XML.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Gosset Laborie, Maria Fernanda'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-13 12:36:00', 'Se eliminó el registro de INVENTARIO.FOLIO_FACTURA y los archivos de la bóveda.', 'Modificación en BD', '2026-07-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001708');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001701', 'Solicitud de apoyo para modificar en sistema integral el numero de contrato asignado', '2026-07-10 11:34:00', 'Buenos días de la manera mas amable solicito su valioso apoyo para indicarnos como podemos cambiar el numero de contrato  ASPN-GI-CO-62601-008-26  asignado al rubro: CONSTRUCCION DE LA UNIDAD NAVAL DE PROTECCION PORTUARIA (UNAPROP) EN LA ADMINISTRACION DEL SISTEMA PORTUARIO NACIONAL VERACRUZ 2DA ETAPA dentro del sistema integral, en la sección de jurídico>solicitud lo anterior debido a un error de dedo.
Sin mas por el momento quedo atento a cualquier duda o comentario.',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-10 16:34:00', 'Seguimiento de proceso, se indico al usuario como realizar el cambio requerido', 'Seguimiento de proceso', '2026-07-10 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001701');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001707', 'Actualización Integral - Finiquito', '2026-07-10 12:44:00', 'Buenas tardes,
Por este medio se solicita su valioso apoyo a fin de resolver la problemática en el Integral que no permite finiquitar el siguiente contrato:  ASPN-GI-CO-62601-008-25 de  UMA TABLESTACA Y ACEROS, S.A. DE C.V., con un saldo por cancelar de $1.48.
Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-13 10:44:00', 'En OBRAS.CNTOVIGENTES se cambio el campo estado de 2 a 3', 'Modificación en BD', '2026-07-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001707');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001699', 'Monto comprometido Integral', '2026-07-09 17:57:00', 'Buenas tardes, 
Por este medio se solicita descomprometer el monto de $104,328,796.55 del presente ejercicio, del Contrato ASPN-GI-CO-62601-016-25 de GAMI INGENIERIA E INSTALACIONES, S.A. DE C.V. YA QUE LA EMPRESA CONTRATISTA NO REALIZARÁ TRABAJOS EXTRAORDINARIOS QUE IMPACTABAN ESE MONTO.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-13 11:07:00', 'Se crearon con una poliza que contiene una estructura programatica con los momentospp 8221 positivo y 8241 negativo en el esquema de CONTA', 'Modificación en BD', '2026-07-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001699');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001709', 'Solicitud de apoyo para cambio de fecha', '2026-07-10 17:03:00', 'Buenas tardes, por la presente me permito solicitar su amable apoyo para un cambio de fecha dentro de un pedido, sería el siguiente:
-37643 FECHA SOLICITADA: 01/07/2026
Le agradezco, quedó atenta a sus comentarios.
Saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velázquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-13 15:55:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-07-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001709');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001710', 'SALIDAS A GRANEL DE INSUMOS SIN REFLEJARSE EL EL MONTO REAL', '2026-07-10 17:04:00', 'Área                  Edificio principal

Lugar               Piso 6 en área común de recursos materiales

detalles          no se descuenta la salida a granel al realizar la salida de los siguiente artículos 001 011 007 011 y  001 011 001 013, los mont0 se reflejan el en sipp2 el problema que se va descontando',
  (select id from ventanas_mesa where nombre = 'SALIDAS DE ALMACEN'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Movimientos de Almacen'),
  (select id from solicitantes_mesa where nombre = 'Arresola Martínez, Alejandro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-13 15:04:00', 'Se ajustaron las existencias en INVENTARIO.EXISTENCIAS porque el inventario se había cargado al subalmacen virtual.', 'Modificación en BD', '2026-07-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001710');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001713', 'SOLICITUD DE INFORMACIÓN SIPOT 2DO TRIMESTRE 2026', '2026-07-13 10:57:00', 'Buenos días,
Por instrucción de la C.P. Cándida Gutiérrez Luna Subgerente de Finanzas, y con la finalidad de cumplir en tiempo y forma con la presentación de la información del SIPOT, referente a los conceptos de representación y gastos de viaje erogados por esta Entidad correspondientes al p​segundo trimestre de 2026 (01/0​4/2026 a 3​0/0​4/2026), solicito de la manera más atenta su apoyo para proporcionarnos esta información.
Quedo a sus órdenes, saludos.',
  (select id from ventanas_mesa where nombre = 'SIPOT'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-13 17:57:00', 'Se compartió documentación del SIPOT mediante correo electrónico.', 'Seguimiento de proceso', '2026-07-13 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001713');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001719', 'SUSTITUCION DE FACTURAS EN EL FOLIO 87585', '2026-07-13 17:57:00', 'Hola buenas tardes
Por  medio de la presente, solicito su amable apoyo con la sustitución de la facturas adjuntas ya que las que están validadas presentan un error en la lectura del código QR.
Sin otro particular, envio un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación'),
  (select id from solicitantes_mesa where nombre = 'Quiroz Mártinez, María del Carmen'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-14 16:57:00', 'Se reemplazaron los archivos en bóveda.', 'Modificación en BD', '2026-07-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001719');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001722', 'VIATICOS', '2026-07-14 11:05:00', 'Buenos días:
Solicito su apoyo para que le sean asignados privilegios al sistema de viáticos a la Ing. Lluvia del Carmen Gutiérrez Fernández, quien actualmente se desempeña como Coordinadora de Seguimiento Ambiental de obra, en sustitución de la Ing. Abril Estefanía Correa García.
Agradezco la atención. 
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-15 10:05:00', 'Se dio de alta al nuevo usuario en SIIP y se compartieron credenciales de acceso mediante correo electrónico. Ya estaba dado de alta en viáticos.', 'Modificación en BD', '2026-07-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001722');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001718', 'Solicitud de apoyo para subir complementos de pago', '2026-07-13 17:30:00', 'Buenas tardes, mediante la presente me permito solicitar su amable apoyo para subir los complementos de pago del proveedor CFE.
Pues presentan el siguiente problema: 
Serían los siguientes folios: 
De igual manera, le adjunto los complementos de pago pendientes de subir.
Quedó atenta a sus comentarios.
Le agradezco.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Cano Velázquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-14 13:43:00', 'Se hizo uso del candado ''des''.', 'Seguimiento de proceso', '2026-07-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001718');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001724', 'SOLICITUD PARA ACTUALIZACION DE USUARIO Y CONSTRASEÑA INTEGRAL', '2026-07-14 12:49:00', 'Buen día
Solicito el apoyo para actualizar el usuario y contraseña para ingresar al portal INTEGRAL.
Quedo atenta a sus comentarios. Saludos.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Fernández, Lluvia del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-14 17:36:00', 'Se actualizaron los datos del usuario en SERIVICIO.USUARIOS32 y en SERVICIO.CONTACTOS01', 'Modificación en BD', '2026-07-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001724');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001721', 'Solicitud para añadir nombre a sistema integral', '2026-07-14 10:36:00', 'Buen día
Solicito su apoyo para añadir el nombre del Arq.ERIC BARAQUIEL HERNANDEZ CANSECO en el sistema integral para firma. 
Quedo atenta a cualquier duda o comentario. Saludos.',
  (select id from ventanas_mesa where nombre = 'INTEGRAL'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Fernández, Lluvia del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-14 17:36:00', 'Se actualizo el registro del usuario en OBRAS.USUARIOS', 'Modificación en BD', '2026-07-14 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001721');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001726', 'SOLICTUD DE MODIFICACIÓN REQUISICIÓN 133717', '2026-07-14 16:03:00', 'Buen día
Solicito su apoyo para añadir el nombre del Arq.ERIC BARAQUIEL HERNANDEZ CANSECO en el sistema integral para firma. 
Quedo atenta a cualquier duda o comentario. Saludos.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'González Cadena, David Alfonso'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-15 12:32:00', 'Se realizó el cambio de fechas en INVENTARIO.REQUISICIONES e INVESTIGACIONMERCADO.', 'Modificación en BD', '2026-07-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001726');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001730', 'DESBLOQUEO DE SIIP -FACTURACION- VENTANA DE GARANTIAS', '2026-07-15 10:10:00', 'Buenos días estimados a quien corresponda.
Agradecería su amable apoyo, desbloqueando la ventana de garantías, ya que envía mensajes de error, como a continuación se muestra:',
  (select id from ventanas_mesa where nombre = 'DEPOSITOS EN GARANTIA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Depósitos en garantía'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-15 17:10:00', 'Seguimiento de proceso, se realizo el desbloqueo de usuarios en facturacion', 'Seguimiento de proceso', '2026-07-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001730');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001716', 'ESTATUS FACTURA ATRAQUE Y NOTA DE EGRESO', '2026-07-13 11:43:00', 'Estimados compañeros ,buen día
Derivado de la observación del folio SIP 986885, como factura AUTORIZADA en el módulo de atraque.
Solicitamos el apoyo de la cancelación de la nota de egreso 18647 - folio 15752  ( comprobante emitido con errores sin relación ) -  y cambio de estatus de AUTORIZADO a COBRADO del folio 986885.
Lo anterior con la finalidad de efectuar mediante el procedimiento de cancelación de factura,  el folio antes mencionado y emisión de la nueva factura y respectiva nota de egreso.
Cualquier duda , quedamos a sus órdenes.
Saludos',
  (select id from ventanas_mesa where nombre = 'FACTURACION'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Atraque'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-14 09:18:00', 'En CFDCONNECT.CFD_EMISION se paso el regitro del folio 15752  a Cancelado = 1 y Motivo_Cancelacion = 02, en FACTURACION.VTFACTURAS se cambio de 1 a 3 para poder cancelar la factura 986885', 'Modificación en BD', '2026-07-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001716');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001739', 'SOLICITUD PARA HABILITAR EN EL SIIP EL APARTADO DE VIATICOS', '2026-07-15 17:28:00', 'Solicito su amable apoyo para que se me habilite, en el SIIP el apartado de VIATICOS, para continuar con el procedimiento administrativo de la comisión que se me ha asignado. Quedo pendiente de sus comentarios, muchas gracias.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-16 16:28:00', 'Se dio de alta al usuario en módulo de Viáticos.', 'Modificación en BD', '2026-07-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001739');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001740', 'VIATICOS', '2026-07-15 17:54:00', 'Buenas tardes:


Solicito su apoyo para que le sean asignados privilegios en el sistema de viáticos al Ing.  Rodolfo Moreno Contreras, Coordinador de Proyectos adscrito a la Gerencia de Ingenieria.


Usuario:cproyectosing4      


Agradezco la atencion.',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-16 15:54:00', 'Se dio de alta al usuario en módulo de Viáticos.', 'Modificación en BD', '2026-07-15 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001740');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001720', 'SUSTITUIR FACTURAS EN BÓVEDA', '2026-07-13 18:45:00', 'Buenas tardes 

Me podrían apoyar a sustituir en bóveda la factura del folio 87573 del proveedor 109879 OMNIBUS DE ALBA

Ya que la que se subió, no es posible validar el QR. 

Adjunto PDF
Gracias por el apoyo

Saludos!!',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas'),
  (select id from solicitantes_mesa where nombre = 'Gutierrez Uscanga, Juan Pedro'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-16 16:00:00', 'Se reemplazaron los archivos en bóveda.', 'Modificación en BD', '2026-07-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001720');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001742', 'RETIRO DE RUBRO EN COMPRACION DE VIATICOS', '2026-07-16 09:16:00', 'Buen día Equipo.

El motivo del presente es para solicitar la eliminación de la factura de rubro 4 por la cantidad de $ 31.00 pesos, la cual se encuentra ubicada con el folio 5154, con número de solicitud de viáticos 4789. Lo anterior, instruido por la GAF.

*Adjunto evidencia para su referencia.

Sin mas por el momento, reciban un saludo',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Pérez Hernández, Joel Adrian'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-16 16:16:00', 'Se eliminaron los registros de INVENTARIO.FOLIO_FACTURA, VIATICOS.VTCOSDETCOMPROBACION y de la bóveda.', 'Modificación en BD', '2026-07-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001742');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001745', 'FIRMA DE RESIDENTE EN CONTRATOS', '2026-07-16 11:26:00', 'AL INTENTAR INGRESAR UNA ESTIMACIÓN, EN EL APARTADO DE FIRMAS NO APARECE MI NOMBRE COMO RESIDENTE EN EL SISTEMA INTEGRAL',
  (select id from ventanas_mesa where nombre = 'PERSONAS AUTORIZADAS PARA FIRMAR CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Trujillo Melchor, Omar'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-17 10:26:00', 'Se actualizo el registro del usuario en OBRAS.USUARIOS', 'Modificación en BD', '2026-07-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001745');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001751', 'NO TIMBRADO DE NOTA DE EGRESO', '2026-07-16 16:11:00', 'Buena tarde
Agradezco el apoyo con el timbrado de la nota de egreso 18752  , folio 15849.
Saludos',
  (select id from ventanas_mesa where nombre = 'NOTAS DE CREDITO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Notas de Crédito'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-17 15:11:00', 'En FACTURACION.VTNOTASCREDITO se modifico el campo MONTO asi como en FACTURACION.FACTURAS_TIMBRADOR se regreso el campo TIMBRADO a 0', 'Modificación en BD', '2026-07-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001751');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001750', 'SOLICITUD DE APOYO PARA CORRECIÓN DE VIÁTICOS', '2026-07-16 16:05:00', 'Buena tarde,
Por este medio solicito su amable apoyo con la corrección de mi solicitud de viáticos con número de folio 4799 toda vez que, por error se capturó como fecha de salida el día 23 de julio de 2026 y llegada 24 de julio de 2026, siendo lo correcto, salida en fecha 22 de julio de 2026 y llegada en fecha 23 de julio de 2026.
Quedo pendiente de sus comentarios.
Saludos',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'Isidoro Cervantes, Pamela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-17 15:05:00', 'Se cambió la INFTECHAINI e INTFECHAFIN en VIATICOS.VTCOSSOLICITUD.', 'Modificación en BD', '2026-07-16 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001750');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001753', 'DESBLOQUEO DE SIIP -FACTURACION- VENTANA DE COBROS', '2026-07-16 17:52:00', 'Buenas tardes estimados a quien corresponda.
Agradecería su amable apoyo, desbloqueando la ventana de cobros, ya que envía mensajes de error, como a continuación se muestra:Quedo atenta.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'COBROS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación/Cobros'),
  (select id from solicitantes_mesa where nombre = 'Carballido Brenis, Barbara'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-17 16:52:00', 'Seguimiento de proceso, se realizo el desbloqueo de usuarios en facturacion', 'Seguimiento de proceso', '2026-07-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001753');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001757', 'Actualización Integral - Proyectos de Inversión', '2026-07-17 12:30:00', 'Buenos días estimados
Por este medio se solicita amablemente la inclusión del proyecto de inversión 2313J3E0007 Construcción de la UNAPROP en el Integral:
Agradeciendo de antemano sus finas atenciones, reciban un cordial saludo.',
  (select id from ventanas_mesa where nombre = 'SOLICITUD DE CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/Integral'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-17 17:30:00', 'Seguimiento de proceso, se indico al el usuario que debia solicitar la activacion del proyecto de inversion en finanzas', 'Seguimiento de proceso', '2026-07-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001757');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001755', 'hacer solicitud de vacaciones', '2026-07-17 11:48:00', 'poder  realizar solicitud de vacaciones a partir del dia 22 pero el sistema no me permite',
  (select id from ventanas_mesa where nombre = 'VACACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Vacaciones'),
  (select id from solicitantes_mesa where nombre = 'Velazquez Rodriguez, Sandra Luz'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-20 09:48:00', 'Se comentó mediante llamada telefónica que debía comunicarse con RH para que ellos generen su solicitud.', 'Seguimiento de proceso', '2026-07-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001755');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001736', 'RECLASIFICACION ASIENTO CONTABLE - POLIZA DIARIO', '2026-07-15 13:33:00', 'Buena tarde
En alcance a la incidencia/Solicitud REQ 2026-001716, solicitamos el apoyo de reclasificación en la póliza de diario 778 de fecha 14/07/26, la cual se visualiza en el módulo de CANCELACION DE FACTURAS ( se adjunta pantalla ).
DICE                                    ABONO
2151-10111-00-0058        $ 55,699.91
DEBE DECIR
 2151-10111-00-0058        $48,017.16
2117-32011-00-0000            7,682.75    
Cualquier duda ó comentario, quedamos a sus órdenes.
Saludos
DICE
DEBE DECIR',
  (select id from ventanas_mesa where nombre = 'POLIZAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Mendoza Castillo, Marisa Trinidad'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-16 10:37:00', 'En FACTURACION.MOVIMIENTOS se agregaron los movimientos 6,7 y 8 a la poliza 778-7-D-2026, asi como tambien se agregaron los registros 5086 y 5085 para la misma poliza', 'Modificación en BD', '2026-07-17 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001736');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001738', 'APOYO PARA VALIDACIÓN DE CFDI FOLIO 87621 EN MEDIPORT', '2026-07-15 16:00:00', 'Buenas tardes, 
Por medio del presente solicito de su colaboración para la validación en el portal mediport de la factura con folio 87621, debido a que en el portal se visualiza en $0, tal como se muestra a continuación:
Sin embargo, en el modulo de licitaciones y en el portal de facturas, si se ve el importe correcto tal como se muestra a continuación. 
Quedo atenta a sus valiosos comentarios. 
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Priego López, Valeria Guadalupe'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-20 12:24:00', 'Se corrigió el PROVEEDOR, RFC, CORREO, NO_CONTRATO, ESTIMACION, MONTO, IMPUESTO, MONTOFACTURA, FORMA_PAGO y METODO_PAGO en INVENTARIO.FOLIO_FACTURA.', 'Seguimiento de proceso', '2026-07-20 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001738');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001771', 'Error Mediport', '2026-07-20 15:32:00', 'Buenas tardes

Por este medio  se solicita amablemente la carga en Mediport de los CFDI´s del contratista  JESUS HITLER DE LOS SANTOS PERALTA, contrato  ASPN-GI-CS-62601-012-25. Rubro: Programas y Proyectos de Inversión 2026 en el ejercicio 2025.

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-21 13:32:00', 'Se cargó manualmente usando el candado.', 'Seguimiento de proceso', '2026-07-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001771');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001768', 'CAMBIO DE FECHA', '2026-07-20 13:54:00', 'Por este medio solicito de su apoyo para el cambio de fecha del pedido: 37653.

Debe decir: 17/06/2026.

El pedido se encuentra en estado TRAMITE para que se realicen los cambios solicitados.

Quedo atentan a sus indicaciones.',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Sardiña Aguirre, Eira Danae'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-21 15:27:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-07-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001768');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001747', 'ACTIVAR BOTON GRABAR EN EL DETALLE DE INVESTIGACION DEL MERCADO', '2026-07-16 13:11:00', 'ACTIVAR BOTON GRABAR EN EL DETALLE DE INVESTIGACION DEL MERCADO',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Investigación de Mercado'),
  (select id from solicitantes_mesa where nombre = 'Chavez Trujillo, Magda Isabel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-22 09:54:00', 'Se dio de alta al usuario tportuario4 en módulo de compras y se asignaron los privilegios requeridos.', 'Modificación en BD', '2026-07-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001747');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001737', 'Acceso para hacer Requisiciones', '2026-07-15 13:49:00', 'Muy buenas tardes, agradecería de antemano se me habiliten las funciones para poder elaborar Requisiciones, mas que nada la función de "tramitar" para poder completar el proceso.

Sin mas por el momento quedo en espera de los solicitado.
Saludos Cordiales',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Acceso al modulo de Compras'),
  (select id from solicitantes_mesa where nombre = 'Chavez Trujillo, Magda Isabel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-21 16:26:00', 'Se dio de alta al usuario tportuario4 en módulo de compras y se asignaron los privilegios requeridos.', 'Modificación en BD', '2026-07-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001737');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001781', 'HABILITAR MÓDULOS DEL SIIPV2', '2026-07-20 17:56:00', 'Buen tardes

Por medio del presente solicito se abran los atributos del SIIPV 2 

COMPRAS, para poder elaborar requisiciones e investigaciones de mercado respectivamente 


Agradeciendo su pronta respuesta quedo atento a sus comentarios',
  (select id from ventanas_mesa where nombre = 'COMPRAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Acceso al modulo de Compras'),
  (select id from solicitantes_mesa where nombre = 'Calva Hernández, Juan Manuel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-21 16:34:00', 'Se dio de alta al nuevo usuario auxcontrol5 y se dio de baja al anterior. Se dio de alta en módulo de compras y se asignaron privilegios requeridos.', 'Seguimiento de proceso', '2026-07-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001781');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001787', 'REASIGNACION DE REQUISICIONES A COMPRADOR ESPECÍFICO', '2026-07-21 11:36:00', 'Estimados ingenieros, por medio del presente solicito su apoyo para reasignar la siguientes requisiciones conforme a lo siguiente:

Requisición: 133709
dice:  48 Rosa Isela Fierro Escobedo

Debe decir: 44 Michelle Domínguez Vera

Requisición: 133708
dice:  47 Karla Victoria Cano

Debe decir: 44 Michelle Domínguez Vera


 Requisición: 133713
dice:  47 Karla Victoria Cano

Debe decir: 44 Michelle Domínguez Vera


Muchas gracias por la atención',
  (select id from ventanas_mesa where nombre = 'REQUISICIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Requisiciones'),
  (select id from solicitantes_mesa where nombre = 'Mora Utrera, Luis Alberto'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-21 16:36:00', 'Se cambió el COMPRADOR por el 44 en INVENTARIO.REQUISICIONES.', 'Modificación en BD', '2026-07-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001787');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001772', 'SOLICITUD DE APOYO CON CARGA DE COMPLEMENTOS', '2026-07-20 15:33:00', 'BUEN DÍA. SE SOLICITA APOYO CON LA CARGA DE TRES COMPLEMENTOS DEL PROVEEDOR GRUPO METROPOLITANO DE AGUA Y SANEAMIENTOS, TODA VEZ QUE TIENEN DIFERENCIA EN LA FECHA DE PAGO Y DE EMISIÓN:',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Complemento de pago'),
  (select id from solicitantes_mesa where nombre = 'Fierro Escobedo, Rosa Isela'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-22 11:33:00', 'Se cargó manualmente usando el candado.', 'Seguimiento de proceso', '2026-07-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001772');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001791', 'Sustitución de archivo Mediport', '2026-07-21 15:02:00', 'Buenas tardes

Por este medio se solicita amablemente la sustitución de la nota de crédito con folio Mediport 87510 del contratista Jesús Hitler de los Santos Peralta contrato ASPN-GI-CS-62601-012-25',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas Obras'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-22 13:02:00', 'Se eliminaron los registros de CFDCONNECT.CFD_RECEPCION, CFD_CUSTOM_DATA y los archivos de la bóveda. Se cambió el ESTADO en INVENTARIO.FOLIO_FACTURA a 0 y se quitó el valor en la columna UUID.', 'Modificación en BD', '2026-07-21 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001791');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001789', 'Error Mediport', '2026-07-21 14:03:00', 'Buenas tardes

Por este medio  se solicita su valioso apoyo para realizar la carga de la factura de ingreso de la estimación 10-N  del contrato ASPN-GI-CS-62601-010-25 RUBRO: SERVICIOS DE LABORATORIO PARA LA TOMA DE MUESTRAS, ANALISIS DE MATERIALES Y CONTROL DE CALIDAD DE LAS OBRAS EFECTUADAS EN EL INTERIOR Y EXTERIOR DEL PUERTO DE VERACRUZ DURANTE LOS EJERCICIOS 2025-2026:



Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)/Portal de Facturación/Facturas Obras'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-22 13:00:00', 'Se colocó el valor G03 en USO_CFDI de INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001789');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001794', 'Error Mediport', '2026-07-21 16:54:00', 'Buenas tardes estimado, 

Por este medio se anexan el archivo PDF y el XML correspondientes al contrato ASPN-GI-CS-62601-010-25 del contratista  KIH SOLUCIONES INDUSTRIALES SA DE CV, para agregar a la estimación 10-N.

Saludos cordiales',
  (select id from ventanas_mesa where nombre = 'RECEPCION DE CFDI'),
  (select id from categorias_mesa where nombre = '/Mediport (Tramites Electronicos)'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-22 11:54:00', 'Se colocó el valor G03 en USO_CFDI de INVENTARIO.FOLIO_FACTURA.', 'Modificación en BD', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001794');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001802', 'MODIFICACIÓN DE INCIDENCIAS', '2026-07-22 10:19:00', 'Buen día estimados,
Esperando contar con su valioso apoyo para realizar una modificación en la justificación de incidencias, ya que vencen en día de hoy. Realizarlas de nuevo para tratar de justificarlas.
Saludos.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Vázquez Ruiz, Ileana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-23 09:19:00', 'Se eliminaron los registros de EDIV2.JUSTIFICA_INCIDENCIAS, JUSTIFICA_INCIDENCIAS_DETALLE, DOCUMENTO, FLUJODOCUMENTO e INCIDENCIAS.', 'Modificación en BD', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001802');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001800', 'DAR DE BAJA SOLICITUD EN SIRE', '2026-07-22 09:52:00', 'BUEN DÍA, 
SOLICITO SU AMABLE APOYO PARA DAR DE BAJA DEL SIRE LA SOLICITUD A NOMBRE DE GRUPO ETTORE, S.A. DE C.V.
MUCHAS GRACIAS.',
  (select id from ventanas_mesa where nombre = 'SIRE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIRE'),
  (select id from solicitantes_mesa where nombre = 'Saavedra Lara, Silvia Dariana'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-22 16:52:00', 'Se cambió el ESTADO en EDIV2.CONTRATOS_SOLICITUD a 4.', 'Modificación en BD', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001800');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001809', 'SOLICITUD DE ACTUALIZACIÓN DE VACACIONES', '2026-07-22 11:14:00', 'Buen día, 
Por medio del presente solicito de su amable apoyo para gestionar el cambio de las personas que autorizan mis vacaciones, por favor a las siguientes, si es tan amable:
- Silvia Dariana Saavedra Lara jdmercado
- Isis Gonzáles Vidrio sgdmercado
Mencionando que el único dato correcto sería la de la Gerente Comercial, muchas gracias, quedo atenta y anexo imagen para mayor referencia:',
  (select id from ventanas_mesa where nombre = 'VACACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Vacaciones'),
  (select id from solicitantes_mesa where nombre = 'Bautista Bello, Abigail'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-22 16:14:00', 'En NOMINA.EMPLEADOS1 se modifico el campo SUPERVISOR de 3754 a 69583', 'Modificación en BD', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001809');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001776', 'JUSTIFICACION DE INCIDENCIAS', '2026-07-20 17:26:00', 'Buenas tardes:
Solicito su apoyo para que en el sistema SIIPV2 "JUSTIFICACION DE INCIDENCIAS" se permita o se habilite la opción de GUARDAR, ya que no esta permitiendo guardar los cambios realizados por lo que no se puede continuar con el procedimiento.
Agradezco la atención.
Saludos cordiales.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Carrion Lechuga, Olivia'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-21 15:26:00', 'Seguimiento de proceso, el proceso se rehabilito de manera correcta', 'Seguimiento de proceso', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001776');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001778', 'PROBLEMA AL GUARDAR INCIDENCIAS EN MODULO JUSTIFICACION DE INCIDENCIAS', '2026-07-20 17:43:00', 'Buenas tardes
Por medio del presente se solicita el apoyo para guardar incidencias ya que al generarlas en el Modulo Justificación de Incidencias, no me permite guardarlas, ya que el boton de guardar, no aparece activo.
Se anexa evidencia.
De antemano Gracias.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Molina Montiel, Miriam del Carmen'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-21 15:43:00', 'Seguimiento de proceso, el proceso se rehabilito de manera correcta', 'Seguimiento de proceso', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001778');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001780', 'Falla en el sistema integral', '2026-07-20 17:52:00', 'Buenas tardes solicito su valioso apoyo con el apartado de justificación de incidencias en el sistema SIIPV2 ya que al momento de querer guardar una solicitud de justificación de incidencias no me permite hacerlo. 
se adjunta captura de pantalla.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Carmona Nájera, Joselin'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-21 12:52:00', 'Seguimiento de proceso, el proceso se rehabilito de manera correcta', 'Seguimiento de proceso', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001780');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001782', 'Apoyo con seccion justificacion incidencias en sistema SIIPV2', '2026-07-20 18:01:00', 'Buenas tardes solicito su valioso apoyo con el apartado de justificación de incidencias en el sistema SIIPV2 ya que al momento de querer guardar una solicitud de justificación de incidencias no me permite hacerlo. 
se adjunta captura de pantalla.',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Ronces Rodríguez, Elias Armando'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-21 17:00:00', 'Seguimiento de proceso, el proceso se rehabilito de manera correcta', 'Seguimiento de proceso', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001782');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001783', 'Error en SIIPV12', '2026-07-20 17:49:00', 'Buenas tardes estimados
Por este medio se informa que el sistema SIIPV12 no me permite guardar mis incidencias:
Aprovecho la ocasión para enviarle un cordial saludo',
  (select id from ventanas_mesa where nombre = 'JUSTIFICACION DE INCIDENCIAS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Justificación de Incidencias'),
  (select id from solicitantes_mesa where nombre = 'Reyes Cicero, Sergio'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-21 17:00:00', 'Seguimiento de proceso, el proceso se rehabilito de manera correcta', 'Seguimiento de proceso', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001783');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001798', 'USUARIO FONDO REVOLVENTE', '2026-07-21 17:48:00', 'Buenas tardes,
De la manera más atenta, solicito su apoyo para habilitar el apartado de "COMPROBACIÓN DE FONDO REVOLVENTE" en el MÓDULO DE TRÁMITES Y SOLICITUDES para la Mtra. Andrea Molina Blancas, Gerente de Comercialización.',
  (select id from ventanas_mesa where nombre = 'COMPROBACION DE FONDO REVOLVENTE'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes'),
  (select id from solicitantes_mesa where nombre = 'Campos Garcia, Reyna Alejandra'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-23 12:36:00', 'Se asignaron privilegios de Comprobación de fondo revolvente al usuario gcomercializacion.', 'Modificación en BD', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001798');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001801', 'Solicitud de apoyo para cambio de fecha', '2026-07-22 09:55:00', 'Buenas tardes, por la presente me permito solicitar su amable apoyo para cambios de fecha dentro de pedidos, serían los siguientes:
-37666 FECHA SOLICITADA: 20/07/2026
-37665  FECHA SOLICITADA: 16/07/2026
Le agradezco, quedó atenta a sus comentarios.
Saludos',
  (select id from ventanas_mesa where nombre = 'CAMBIOS DE FECHA'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos/Cambio de Fecha'),
  (select id from solicitantes_mesa where nombre = 'Cano Velázquez, Karla Victoria'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-23 15:25:00', 'Se realizó el cambio de fechas en INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-07-22 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001801');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001815', 'DESCRIPCIÓN EN EL APARTADO OBSERVACIONES DEL PEDIDO 37518', '2026-07-22 17:44:00', 'Buenas tardes, por medio del presente se solicita de su amable apoyo para agregar en el pedido 37518 en el apartado de OBSERVACIONES, se agregue la descripción "SERVICIO DE INSUMOS PARA LAS BOLSITAS DE LOS HIJOS DE LOS COLABORADORES" 
Agregar hasta los caracteres que permita el sistema, muchas gracias por su apoyo, espero sus comentarios.',
  (select id from ventanas_mesa where nombre = 'PEDIDOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Compras/Pedidos'),
  (select id from solicitantes_mesa where nombre = 'Vargas Díaz, Leonardo'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-23 12:44:00', 'Se colocó el texto en OBSERVACIONES de INVENTARIO.PEDIDOS.', 'Modificación en BD', '2026-07-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001815');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001805', 'SOLICITUD DE USUARIO, CONTRASEÑA Y PRIVILEGIOS PARA SISTEMA SIIPV', '2026-07-22 10:59:00', 'Buenos dias
Solicito de su apoyo para crear usuario y contraseña a sistema siipv para Danna Michelle Flores Colorado quien será nuestra auxiliar en el Departamento de Supervision y Control Operativo, asi como otorgarle los privilegios con los que cuenta la Lic. Yahaira Alin Acosta Ramos
Gracias',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Operaciones'),
  (select id from solicitantes_mesa where nombre = 'Salgado Navarro, Agustin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-22 15:59:00', 'Se dio de alta al usuario en SIIP.', 'Modificación en BD', '2026-07-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001805');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001812', 'SOLICITUD DE USUARIO, CONTRASEÑA PARA SISTEMA SIIV', '2026-07-22 14:30:00', 'Buenos días
Solicito de su apoyo para crear usuario y contraseña a sistema SIIPV para Jesús Manuel Pérez Solórzano quien será nuestra auxiliar en el Departamento de Supervisión y Control Operativo, así como otorgarle los privilegios con los que cuenta el personal de tecnicos portuarios',
  (select id from ventanas_mesa where nombre = 'SIIP'),
  (select id from categorias_mesa where nombre = '/Sistemas/Nuevos Ingresos/SIIP- nuevo ingreso'),
  (select id from solicitantes_mesa where nombre = 'Salgado Navarro, Agustin'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-23 10:00:00', 'Se dio de alta al usuario en SIIP.', 'Modificación en BD', '2026-07-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001812');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001818', 'Error en SIIP entrar al modulo de viaticos', '2026-07-23 09:38:00', 'Se solicita de su amable para poder acceder al modulo de viáticos en la plataforma SIIP de la cuenta de la Lic. Gabriela Bautista de la Gerencia de Comercialización. Marca el siguiente error:
"No se tiene privilegios de acceder al modulo"',
  (select id from ventanas_mesa where nombre = 'VIATICOS'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Viáticos'),
  (select id from solicitantes_mesa where nombre = 'González Dominguez, Daniel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-23 13:38:00', 'Se dio de alta en módulo de Viáticos.', 'Modificación en BD', '2026-07-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001818');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001826', 'habiloitar contrato cargar convenio tiempo y monto.', '2026-07-23 14:55:00', 'Solicito el apoyo para poder habilitar la opción de dar tramite a un convenio de tiempo y monto del contrato ASPN-GI-CO-62601-015-25, ya que venció la fecha de contrato y no me permite cargarlo.
Ademas requiero el apoyo para no mover los precios que autorizare a CONVENIO, que se queden en NORMAL. son 8 conceptos
adjunto captura del convenio que no se puede ingresar',
  (select id from ventanas_mesa where nombre = 'MODIFICACIONES AL CONTRATO'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Obras'),
  (select id from solicitantes_mesa where nombre = 'Martínez Pardo, Missael Abraham'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-24 13:52:00', 'Se realizo el cambio de fecha en OBRAS.CNTOVIGENTES y en OBRAS.VERSIONESCONTRATOS', 'Modificación en BD', '2026-07-23 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001826');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001832', 'FORMATO DE VACACIONES', '2026-07-24 10:18:00', 'El formato de vacaciones en el SIIP, aparece como jefe JORGE ISRAEL, sin embargo yo estoy en seguridad, debe de aparecer JUAN DE DIOS.
Así mismo, aparece ROBERTO SALAZAR, sin embargo es GERARDO CRUZ.
En una solicitud de vacaciones anterior, los datos venian de forma correcta.
saludos',
  (select id from ventanas_mesa where nombre = 'VACACIONES'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Trámites y Solicitudes/Vacaciones'),
  (select id from solicitantes_mesa where nombre = 'Suarez Herrera, Jose Gabriel'),
  (select id from resolutores_mesa where nombre = 'Sandria Pérez, Ángel Manuel'),
  '2026-07-24 17:18:00', 'Se corrigió el SUPERVISOR en NOMINA.EMPLEADOS1.', 'Modificación en BD', '2026-07-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001832');

insert into mesas (codigo, titulo, fecha_carga, descripcion, ventana_id, categoria_id, solicitante_id, resolutor_id, fecha_estimada_resolucion, solucion, tipo_solucion, fecha_cierre_real)
select 'REQ 2026-001820', 'APOYO PARA CORRECCION DE IMPORTE EN POLIZA', '2026-07-23 10:08:00', 'Buen día
El presente es para solicitar su apoyo para corregir el importe en póliza de ingresos por facturación del 21/07/2026
Dice:   112910711000000 IVA RETENIDO 16% (CLIENTES) 366,009.00
Debe decir:  112910711000000 IVA RETENIDO 16% (CLIENTES)  50,484.00
Adjunto Word con detalle
Cualquier duda, quedo atento.
Saludos.',
  (select id from ventanas_mesa where nombre = 'EXPORTACION DE POLIZAS A CONTABILIDAD'),
  (select id from categorias_mesa where nombre = '/Sistemas/SIIP Facturación'),
  (select id from solicitantes_mesa where nombre = 'Serrano Berriozabal, Jose Luis'),
  (select id from resolutores_mesa where nombre = 'Andrade Malpica, Hector Ulises'),
  '2026-07-24 10:58:00', 'Seguimiento de proceso, se modifico la forma VTESP030 par agregar una evaluacion en la unidad de programa EXPORTACONCENTRALL con la condicion: <> ''112910711000000''', 'Seguimiento de proceso', '2026-07-24 00:00:00'
where not exists (select 1 from mesas where codigo = 'REQ 2026-001820');

