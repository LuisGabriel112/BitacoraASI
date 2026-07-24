import httpx

from app.config import settings


class TrelloError(Exception):
    pass


def trello_configurado() -> bool:
    return bool(settings.trello_api_key and settings.trello_token and settings.trello_list_id)


async def crear_tarjeta(titulo: str, descripcion: str) -> str:
    if not trello_configurado():
        raise TrelloError("Trello no está configurado (faltan credenciales)")

    params = {
        "key": settings.trello_api_key,
        "token": settings.trello_token,
        "idList": settings.trello_list_id,
        "name": titulo,
        "desc": descripcion,
    }
    async with httpx.AsyncClient(timeout=10) as client:
        try:
            resp = await client.post("https://api.trello.com/1/cards", params=params)
        except httpx.RequestError as exc:
            raise TrelloError(f"No se pudo conectar con Trello: {exc}") from exc

    if resp.status_code >= 400:
        raise TrelloError(f"Trello respondió {resp.status_code}: {resp.text[:200]}")

    return resp.json()["id"]
