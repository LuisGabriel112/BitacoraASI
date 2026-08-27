from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    database_url: str
    secret_key: str
    trello_api_key: str = ""
    trello_token: str = ""
    trello_list_id: str = ""
    gemini_api_key: str = ""
    gemini_model: str = "gemini-flash-latest"
    gemini_embed_model: str = "models/gemini-embedding-001"
    cloudflare_account_id: str = ""
    cloudflare_api_token: str = ""
    cloudflare_vision_model: str = "@cf/meta/llama-3.2-11b-vision-instruct"
    cors_origins: str = "http://localhost:5173"
    supabase_url: str = ""
    supabase_service_key: str = ""
    chat_bucket: str = "chat-adjuntos"
    exponer_docs: bool = False

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    @property
    def cors_origin_list(self) -> list[str]:
        return [o.strip() for o in self.cors_origins.split(",") if o.strip()]


settings = Settings()
