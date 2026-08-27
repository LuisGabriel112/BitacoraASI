import random
from dataclasses import dataclass
from datetime import date, datetime, timedelta

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models import IntentoTrivia
from app.services import cooldown as cooldown_service
from app.services import tienda
from app.services.jefes import danar_jefe
from app.services.semanas import semana_de

DANIO_TRIVIA = 2
COOLDOWN_TRIVIA = timedelta(minutes=5)


@dataclass(frozen=True)
class PreguntaTrivia:
    id: int
    texto: str
    opciones: tuple[str, str, str, str]
    respuesta_correcta: int


PREGUNTAS: tuple[PreguntaTrivia, ...] = (
    PreguntaTrivia(
        0, '¿Qué significa "SLA" en soporte técnico?',
        ("Acuerdo de Nivel de Servicio", "Sistema de Log de Accesos", "Solicitud de Levantamiento", "Servicio Local de Ayuda"),
        0,
    ),
    PreguntaTrivia(
        1, "¿Qué código HTTP indica que un recurso no existe?",
        ("401", "403", "404", "500"),
        2,
    ),
    PreguntaTrivia(
        2, "¿Qué código HTTP indica que no tienes permiso para hacer algo?",
        ("400", "403", "404", "409"),
        1,
    ),
    PreguntaTrivia(
        3, "¿Qué significa CFDI en facturación electrónica mexicana?",
        ("Comprobante Fiscal Digital por Internet", "Clave Federal de Documentos e Inventario", "Certificado de Firma Digital Integrada", "Código de Folio de Documento Interno"),
        0,
    ),
    PreguntaTrivia(
        4, "¿Qué significa 'BD' en la categoría de solución 'Modificación en BD'?",
        ("Bitácora Digital", "Base de Datos", "Backup Diario", "Boletín de Datos"),
        1,
    ),
    PreguntaTrivia(
        5, "¿Qué protocolo cifra el tráfico web (el candado del navegador)?",
        ("FTP", "SMTP", "HTTPS", "SSH"),
        2,
    ),
    PreguntaTrivia(
        6, 'En la Bitácora, ¿cuántos minutos de espera hay entre intentos de "Encuentra la pelota"?',
        ("1 minuto", "5 minutos", "15 minutos", "1 hora"),
        1,
    ),
    PreguntaTrivia(
        7, "En piedra, papel o tijera, ¿qué le gana a la piedra?",
        ("Tijera", "Papel", "Nada", "Otra piedra"),
        1,
    ),
    PreguntaTrivia(
        8, "¿Cuántas casillas tiene el tablero del gato (tic-tac-toe)?",
        ("6", "8", "9", "12"),
        2,
    ),
    PreguntaTrivia(
        9, "¿Qué significa 'RFC' en un comprobante fiscal mexicano?",
        ("Registro Federal de Contribuyentes", "Reporte Financiero de Cierre", "Registro de Folios Consecutivos", "Recibo Fiscal de Compra"),
        0,
    ),
    PreguntaTrivia(
        10, "¿Qué comando de Git crea una nueva rama y se cambia a ella?",
        ("git branch -m", "git checkout -b", "git merge -b", "git switch --new"),
        1,
    ),
    PreguntaTrivia(
        11, "¿Qué estructura de datos sigue el orden 'último en entrar, primero en salir'?",
        ("Cola (queue)", "Pila (stack)", "Árbol binario", "Lista enlazada"),
        1,
    ),
    PreguntaTrivia(
        12, "¿Qué significa 'ORM' al trabajar con bases de datos?",
        ("Object-Relational Mapping", "Online Resource Manager", "Ordered Record Model", "Output Rendering Method"),
        0,
    ),
    PreguntaTrivia(
        13, "¿Cuál es la complejidad en tiempo de una búsqueda binaria sobre un arreglo ordenado?",
        ("O(n)", "O(n²)", "O(log n)", "O(1)"),
        2,
    ),
    PreguntaTrivia(
        14, "¿Qué método HTTP se usa normalmente para actualizar parcialmente un recurso?",
        ("GET", "PATCH", "TRACE", "OPTIONS"),
        1,
    ),
    PreguntaTrivia(
        15, "En SQL, ¿qué cláusula filtra filas después de aplicar un GROUP BY?",
        ("WHERE", "ORDER BY", "HAVING", "LIMIT"),
        2,
    ),
    PreguntaTrivia(
        16, "¿Qué tipo de dato representa 'verdadero' o 'falso' en la mayoría de lenguajes de programación?",
        ("String", "Boolean", "Float", "Enum"),
        1,
    ),
    PreguntaTrivia(
        17, "¿Cómo se le llama a una función que se llama a sí misma?",
        ("Función anónima", "Función pura", "Función recursiva", "Función lambda"),
        2,
    ),
)


def pregunta_por_id(pregunta_id: int) -> PreguntaTrivia:
    return PREGUNTAS[pregunta_id]


def pregunta_aleatoria() -> PreguntaTrivia:
    return random.choice(PREGUNTAS)


class TriviaError(Exception):
    pass


async def _ultimo_intento(session: AsyncSession, usuario_id: int) -> IntentoTrivia | None:
    stmt = (
        select(IntentoTrivia)
        .where(IntentoTrivia.usuario_id == usuario_id)
        .order_by(IntentoTrivia.created_at.desc())
        .limit(1)
    )
    return (await session.execute(stmt)).scalar_one_or_none()


async def iniciar_intento(session: AsyncSession, usuario_id: int, ahora: datetime) -> tuple[IntentoTrivia, PreguntaTrivia]:
    ultimo = await _ultimo_intento(session, usuario_id)
    if ultimo is not None:
        bono = await tienda.bono_de_usuario(session, usuario_id, semana_de(date.today()))
        cooldown = cooldown_service.cooldown_efectivo(COOLDOWN_TRIVIA, bono.cooldown_pct)
        if not cooldown_service.puede_jugar(ultimo.created_at, ahora, cooldown):
            raise TriviaError("Todavía en cooldown")

    pregunta = pregunta_aleatoria()
    intento = IntentoTrivia(usuario_id=usuario_id, pregunta_id=pregunta.id)
    session.add(intento)
    await session.commit()
    await session.refresh(intento)
    return intento, pregunta


async def resolver_intento(
    session: AsyncSession, intento_id: int, usuario_id: int, opcion: int, nombre: str
) -> IntentoTrivia:
    intento = await session.get(IntentoTrivia, intento_id)
    if intento is None or intento.usuario_id != usuario_id:
        raise TriviaError("Intento no encontrado")
    if intento.resuelto:
        raise TriviaError("Ese intento ya se resolvió")

    pregunta = pregunta_por_id(intento.pregunta_id)
    intento.resuelto = True
    intento.acierto = opcion == pregunta.respuesta_correcta
    if intento.acierto:
        await danar_jefe(session, semana_de(date.today()), DANIO_TRIVIA, nombre, "minijuego_trivia")

    await session.commit()
    await session.refresh(intento)
    return intento
