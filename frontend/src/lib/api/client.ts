export type Catalogo = { id: number; nombre: string; usuario_id?: number | null };

export type Accesorio = 'ninguno' | 'gorra' | 'casco' | 'antenas';

export type Personaje = {
	id: number;
	nombre: string;
	avatar: string;
	color_piel: string;
	color_cuerpo: string;
	accesorio: Accesorio;
	xp: number;
	nivel: number;
	xp_en_nivel_actual: number;
	xp_para_siguiente_nivel: number;
	titulo: string;
};

export type EventoXp = { cantidad: number; motivo: string; created_at: string };
export type RankingItem = { nombre: string; avatar: string; nivel: number; xp: number };
export type Jefe = { semana: string; nombre: string; vida_max: number; vida_actual: number; derrotado: boolean };
export type Mascota = { semana: string; nombre: string; vida_max: number };
export type DanioJefeEvento = {
	id: number;
	nombre_capturado: string;
	cantidad: number;
	motivo: string;
	created_at: string;
};

export type AutorChat = { nombre: string; avatar: string };
export type MensajeChat = {
	id: number;
	autor: AutorChat;
	texto: string | null;
	archivo_url: string | null;
	archivo_nombre: string | null;
	archivo_tipo: string | null;
	created_at: string;
};

export type Registro = {
	id: number;
	fecha: string;
	semana: string;
	descripcion: string;
	trello_card_id: string | null;
	created_at: string;
	empresa: Catalogo;
	sistema: Catalogo;
	medio: Catalogo;
	modulo: Catalogo;
	atendio: Catalogo;
};

export type RegistroCreado = {
	registro: Registro;
	trello_ok: boolean;
	trello_error: string | null;
	logros: string[];
};
export type ExtraccionRegistro = {
	fecha: string | null;
	descripcion: string | null;
	empresa: Catalogo | null;
	sistema: Catalogo | null;
	medio: Catalogo | null;
	modulo: Catalogo | null;
	atendio: Catalogo | null;
};
export type PaginaRegistros = { total: number; items: Registro[] };
export type PanelKPIs = {
	semana: string;
	total_semana: number;
	por_sistema: Record<string, number>;
	volumen_diario: { fecha: string; total: number }[];
	distribucion_modulo: { modulo: string; total: number }[];
	recientes: Registro[];
};
export type ReporteSemanal = {
	semana: string;
	total: number;
	por_sistema: Record<string, number>;
	por_empresa: Record<string, number>;
	por_medio: Record<string, number>;
	registros: Registro[];
};
export type GrupoSoporte = { tema: string; cantidad: number };

export type Mesa = {
	id: number;
	enlace: string | null;
	codigo: string;
	titulo: string;
	fecha_carga: string;
	semana: string;
	descripcion: string;
	fecha_estimada_resolucion: string;
	solucion: string | null;
	tipo_solucion: string | null;
	fecha_cierre_real: string | null;
	medidas_impacto: boolean;
	prioridad: boolean;
	destacada: boolean;
	created_at: string;
	ventana: Catalogo | null;
	categoria: Catalogo;
	solicitante: Catalogo;
	resolutor: Catalogo;
	logros: string[];
};
export type PaginaMesas = { total: number; items: Mesa[] };
export type JugadorGato = { nombre: string; avatar: string };
export type PartidaGato = {
	id: number;
	tablero: string;
	turno: 'X' | 'O';
	estado: 'esperando' | 'jugando' | 'terminada';
	ganador: 'X' | 'O' | 'empate' | null;
	jugador_x: JugadorGato;
	jugador_o: JugadorGato | null;
};
export type IntentoPelota = { id: number; resuelto: boolean; acierto: boolean | null };
export type ResultadoPelota = { acierto: boolean; posicion_correcta: number };
export type PreguntaTrivia = { intento_id: number; pregunta_id: number; texto: string; opciones: string[] };
export type ResultadoTrivia = { acierto: boolean; respuesta_correcta: number };
export type IntentoMemorama = { id: number; resuelto: boolean; acierto: boolean | null };
export type ResultadoMemorama = { acierto: boolean };
export type IntentoReaccion = { id: number; resuelto: boolean; acierto: boolean | null };
export type ResultadoReaccion = { acierto: boolean };
export type ResultadoRuleta = { gano: boolean };
export type JugadaRPS = 'piedra' | 'papel' | 'tijera';
export type PartidaRPS = {
	id: number;
	estado: 'esperando' | 'jugando' | 'terminada';
	resultado: 'X' | 'O' | 'empate' | null;
	jugada_x: JugadaRPS | null;
	jugada_o: JugadaRPS | null;
	jugador_x: JugadorGato;
	jugador_o: JugadorGato | null;
};
export type SintesisSolucion = {
	id: number;
	categoria: Catalogo;
	tipo_solucion: string | null;
	titulo: string;
	texto: string;
	cantidad_mesas: number;
	generado_en: string;
};
export type ResumenGeneracionSintesis = { grupos_generados: number; mesas_cubiertas: number };
export type PanelMesasKPIs = {
	semana: string;
	total_semana: number;
	volumen_diario: { fecha: string; total: number }[];
	distribucion_ventana: { ventana: string; total: number }[];
	distribucion_categoria_solucion: { categoria_solucion: string; total: number }[];
	recientes: Mesa[];
};
const BASE = '/api';

async function lanzarSiError(resp: Response): Promise<void> {
	if (resp.ok) return;
	let detail = resp.statusText;
	try {
		const body = await resp.json();
		detail = body.detail ?? detail;
	} catch {
		/* respuesta sin cuerpo JSON */
	}
	throw new Error(detail);
}

async function json<T>(path: string, init?: RequestInit): Promise<T> {
	const resp = await fetch(`${BASE}${path}`, {
		...init,
		headers: { 'Content-Type': 'application/json', ...(init?.headers ?? {}) }
	});
	await lanzarSiError(resp);
	return resp.json() as Promise<T>;
}

export type NombreCatalogo =
	| 'empresas'
	| 'modulos'
	| 'sistemas'
	| 'medios'
	| 'agentes'
	| 'categorias-mesa'
	| 'solicitantes-mesa'
	| 'resolutores-mesa'
	| 'ventanas-mesa';

export const api = {
	registrarse: (
		nombre: string,
		pin: string,
		avatar: string,
		apariencia: { color_piel: string; color_cuerpo: string; accesorio: Accesorio }
	) =>
		json<Personaje>('/auth/registro', {
			method: 'POST',
			body: JSON.stringify({ nombre, pin, avatar, ...apariencia })
		}),

	actualizarApariencia: (apariencia: { color_piel: string; color_cuerpo: string; accesorio: Accesorio }) =>
		json<Personaje>('/auth/apariencia', { method: 'POST', body: JSON.stringify(apariencia) }),

	iniciarSesion: (nombre: string, pin: string) =>
		json<Personaje>('/auth/login', { method: 'POST', body: JSON.stringify({ nombre, pin }) }),

	cerrarSesion: async () => {
		await fetch(`${BASE}/auth/logout`, { method: 'POST' });
	},

	miPersonaje: () => json<Personaje>('/auth/me'),

	miHistorial: () => json<EventoXp[]>('/auth/historial'),

	ranking: () => json<RankingItem[]>('/auth/ranking'),

	heartbeat: async () => {
		await fetch(`${BASE}/auth/heartbeat`, { method: 'POST' });
	},

	enLinea: () => json<RankingItem[]>('/auth/en-linea'),

	jefeActual: () => json<Jefe>('/jefes/actual'),

	danosAlJefeActual: () => json<DanioJefeEvento[]>('/jefes/actual/danos'),

	mascotas: () => json<Mascota[]>('/jefes/mascotas'),

	buscarPartidaGato: () => json<PartidaGato>('/juegos/gato/buscar', { method: 'POST' }),

	obtenerPartidaGato: (id: number) => json<PartidaGato>(`/juegos/gato/${id}`),

	jugarGato: (id: number, posicion: number) =>
		json<PartidaGato>(`/juegos/gato/${id}/jugar`, { method: 'POST', body: JSON.stringify({ posicion }) }),

	salirGato: async (id: number) => {
		await fetch(`${BASE}/juegos/gato/${id}/salir`, { method: 'POST' });
	},

	iniciarPelota: () => json<IntentoPelota>('/juegos/pelota/iniciar', { method: 'POST' }),

	elegirPelota: (id: number, posicion: number) =>
		json<ResultadoPelota>(`/juegos/pelota/${id}/elegir`, { method: 'POST', body: JSON.stringify({ posicion }) }),

	buscarPartidaRPS: () => json<PartidaRPS>('/juegos/rps/buscar', { method: 'POST' }),

	obtenerPartidaRPS: (id: number) => json<PartidaRPS>(`/juegos/rps/${id}`),

	jugarRPS: (id: number, jugada: JugadaRPS) =>
		json<PartidaRPS>(`/juegos/rps/${id}/jugar`, { method: 'POST', body: JSON.stringify({ jugada }) }),

	salirRPS: async (id: number) => {
		await fetch(`${BASE}/juegos/rps/${id}/salir`, { method: 'POST' });
	},

	iniciarTrivia: () => json<PreguntaTrivia>('/juegos/trivia/iniciar', { method: 'POST' }),

	responderTrivia: (id: number, opcion: number) =>
		json<ResultadoTrivia>(`/juegos/trivia/${id}/responder`, { method: 'POST', body: JSON.stringify({ opcion }) }),

	iniciarMemorama: () => json<IntentoMemorama>('/juegos/memorama/iniciar', { method: 'POST' }),

	completarMemorama: (id: number) =>
		json<ResultadoMemorama>(`/juegos/memorama/${id}/completar`, { method: 'POST' }),

	iniciarReaccion: () => json<IntentoReaccion>('/juegos/reaccion/iniciar', { method: 'POST' }),

	reportarReaccion: (id: number, tiempoMs: number) =>
		json<ResultadoReaccion>(`/juegos/reaccion/${id}/reportar`, {
			method: 'POST',
			body: JSON.stringify({ tiempo_ms: Math.round(tiempoMs) })
		}),

	jugarRuleta: () => json<ResultadoRuleta>('/juegos/ruleta/jugar', { method: 'POST' }),

	crearUrlSubidaChat: (nombreArchivo: string, contentType: string) =>
		json<{ url_subida: string; url_publica: string }>('/chat/subir-url', {
			method: 'POST',
			body: JSON.stringify({ nombre_archivo: nombreArchivo, content_type: contentType })
		}),

	subirArchivoDirecto: async (urlSubida: string, archivo: File) => {
		const resp = await fetch(urlSubida, { method: 'PUT', headers: { 'Content-Type': archivo.type }, body: archivo });
		if (!resp.ok) throw new Error('No se pudo subir el archivo');
	},

	enviarMensajeChat: (payload: {
		texto?: string;
		archivo_url?: string;
		archivo_nombre?: string;
		archivo_tipo?: string;
	}) => json<MensajeChat>('/chat/mensajes', { method: 'POST', body: JSON.stringify(payload) }),

	mensajesChat: (despuesDe?: number) =>
		json<MensajeChat[]>(`/chat/mensajes${despuesDe !== undefined ? `?despues_de=${despuesDe}` : ''}`),

	catalogo: (nombre: NombreCatalogo, q = '', limit?: number) => {
		const qs = new URLSearchParams();
		if (q) qs.set('q', q);
		if (limit) qs.set('limit', String(limit));
		const query = qs.toString();
		return json<Catalogo[]>(`/${nombre}${query ? `?${query}` : ''}`);
	},

	vincularCatalogo: (nombre: 'agentes' | 'resolutores-mesa', id: number) =>
		json<Catalogo>(`/${nombre}/${id}/vincular`, { method: 'POST' }),

	desvincularCatalogo: (nombre: 'agentes' | 'resolutores-mesa', id: number) =>
		json<Catalogo>(`/${nombre}/${id}/desvincular`, { method: 'POST' }),

	crearCatalogo: (
		nombre: 'empresas' | 'modulos' | 'categorias-mesa' | 'solicitantes-mesa' | 'resolutores-mesa' | 'ventanas-mesa',
		valor: string
	) => json<Catalogo>(`/${nombre}`, { method: 'POST', body: JSON.stringify({ nombre: valor }) }),

	eliminarCatalogo: async (
		nombre: 'categorias-mesa' | 'solicitantes-mesa' | 'resolutores-mesa' | 'ventanas-mesa',
		id: number
	) => {
		const resp = await fetch(`${BASE}/${nombre}/${id}`, { method: 'DELETE' });
		await lanzarSiError(resp);
	},

	crearRegistro: (payload: {
		fecha: string;
		empresa_id: number;
		sistema_id: number;
		medio_id: number;
		modulo_id: number;
		atendio_id: number;
		descripcion: string;
	}) => json<RegistroCreado>('/registros', { method: 'POST', body: JSON.stringify(payload) }),

	registroPorId: (id: number) => json<Registro>(`/registros/${id}`),

	editarRegistro: (
		id: number,
		payload: Partial<{
			fecha: string;
			empresa_id: number;
			sistema_id: number;
			medio_id: number;
			modulo_id: number;
			atendio_id: number;
			descripcion: string;
		}>
	) => json<Registro>(`/registros/${id}/editar`, { method: 'POST', body: JSON.stringify(payload) }),

	reintentarTrello: (id: number) => json<RegistroCreado>(`/registros/${id}/reintentar-trello`, { method: 'POST' }),

	extraerImagen: async (archivo: File) => {
		const form = new FormData();
		form.append('imagen', archivo);
		const resp = await fetch(`${BASE}/registros/extraer-imagen`, { method: 'POST', body: form });
		if (!resp.ok) {
			let detail = resp.statusText;
			try {
				const body = await resp.json();
				detail = body.detail ?? detail;
			} catch {
				/* respuesta sin cuerpo JSON */
			}
			throw new Error(detail);
		}
		return resp.json() as Promise<ExtraccionRegistro>;
	},

	eliminarRegistro: async (id: number) => {
		const resp = await fetch(`${BASE}/registros/${id}`, { method: 'DELETE' });
		if (!resp.ok) {
			let detail = resp.statusText;
			try {
				const body = await resp.json();
				detail = body.detail ?? detail;
			} catch {
				/* respuesta sin cuerpo JSON */
			}
			throw new Error(detail);
		}
	},

	panel: () => json<PanelKPIs>('/registros/panel'),

	listado: (params: Record<string, string | number | undefined>) => {
		const qs = new URLSearchParams();
		for (const [k, v] of Object.entries(params)) if (v !== undefined && v !== '') qs.set(k, String(v));
		return json<PaginaRegistros>(`/registros?${qs.toString()}`);
	},

	reporte: (semana: string) => json<ReporteSemanal>(`/registros/reporte?semana=${encodeURIComponent(semana)}`),

	soportesFrecuentes: (semana: string, top = 10) =>
		json<GrupoSoporte[]>(`/registros/soportes-frecuentes?semana=${encodeURIComponent(semana)}&top=${top}`),

	exportUrl: (formato: 'csv' | 'xlsx', params: Record<string, string | number | undefined> = {}) => {
		const qs = new URLSearchParams({ formato });
		for (const [k, v] of Object.entries(params)) if (v !== undefined && v !== '') qs.set(k, String(v));
		return `${BASE}/registros/export?${qs.toString()}`;
	},

	crearMesa: (payload: {
		enlace?: string | null;
		codigo: string;
		titulo: string;
		fecha_carga: string;
		descripcion: string;
		categoria_id: number;
		solicitante_id: number;
		resolutor_id: number;
		fecha_estimada_resolucion: string;
		ventana_id?: number | null;
		solucion?: string | null;
		tipo_solucion?: string | null;
		fecha_cierre_real?: string | null;
		medidas_impacto?: boolean;
	}) => json<Mesa>('/mesas', { method: 'POST', body: JSON.stringify(payload) }),

	mesaPorId: (id: number) => json<Mesa>(`/mesas/${id}`),

	editarMesa: (
		id: number,
		payload: Partial<{
			enlace: string | null;
			codigo: string;
			titulo: string;
			fecha_carga: string;
			descripcion: string;
			ventana_id: number | null;
			categoria_id: number;
			solicitante_id: number;
			resolutor_id: number;
			fecha_estimada_resolucion: string;
			solucion: string | null;
			tipo_solucion: string | null;
			fecha_cierre_real: string | null;
			medidas_impacto: boolean;
			prioridad: boolean;
			destacada: boolean;
		}>
	) => json<Mesa>(`/mesas/${id}/editar`, { method: 'POST', body: JSON.stringify(payload) }),

	cerrarMesa: (
		id: number,
		payload: {
			ventana_id: number;
			solucion: string;
			tipo_solucion: string;
			fecha_cierre_real: string;
			medidas_impacto?: boolean;
		}
	) => json<Mesa>(`/mesas/${id}/cerrar`, { method: 'POST', body: JSON.stringify(payload) }),

	eliminarMesa: async (id: number) => {
		const resp = await fetch(`${BASE}/mesas/${id}`, { method: 'DELETE' });
		if (!resp.ok) {
			let detail = resp.statusText;
			try {
				const body = await resp.json();
				detail = body.detail ?? detail;
			} catch {
				/* respuesta sin cuerpo JSON */
			}
			throw new Error(detail);
		}
	},

	listadoMesas: (params: Record<string, string | number | boolean | undefined>) => {
		const qs = new URLSearchParams();
		for (const [k, v] of Object.entries(params)) if (v !== undefined && v !== '') qs.set(k, String(v));
		return json<PaginaMesas>(`/mesas?${qs.toString()}`);
	},

	sintesisSoluciones: () => json<SintesisSolucion[]>('/mesas/sintesis'),

	generarSintesisSoluciones: () =>
		json<ResumenGeneracionSintesis>('/mesas/sintesis/generar', { method: 'POST' }),

	panelMesas: (fecha?: string) =>
		json<PanelMesasKPIs>(fecha ? `/mesas/panel?fecha=${encodeURIComponent(fecha)}` : '/mesas/panel'),

	exportMesasUrl: (formato: 'csv' | 'xlsx', params: Record<string, string | number | boolean | undefined> = {}) => {
		const qs = new URLSearchParams({ formato });
		for (const [k, v] of Object.entries(params)) if (v !== undefined && v !== '') qs.set(k, String(v));
		return `${BASE}/mesas/export?${qs.toString()}`;
	},

	exportReporteMesasUrl: (semana: string, formato: 'xlsx' | 'pptx' | 'pdf') =>
		`${BASE}/mesas/reporte/exportar?semana=${encodeURIComponent(semana)}&formato=${formato}`
};
