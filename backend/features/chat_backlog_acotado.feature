# language: es
Característica: El backlog de chat tras reconectar tiene un límite
  Como responsable de rendimiento de la bitácora
  Quiero que /chat/mensajes limite también los mensajes nuevos que llegan
  después de un id (despues_de), no solo el listado inicial
  Para que un cliente que reconecta tras estar inactivo mucho tiempo no
  traiga un backlog sin cota

  Escenario: Pedir mensajes después de un id respeta el límite pedido
    Dado que pido mensajes con despues_de y un límite específico
    Cuando se construye la consulta
    Entonces la consulta trae como máximo esa cantidad de mensajes
