export type Catalogo = { id: number; nombre: string };

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

export type RegistroCreado = { registro: Registro; trello_ok: boolean; trello_error: string | null };
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
	created_at: string;
	ventana: Catalogo;
	categoria: Catalogo;
	solicitante: Catalogo;
	resolutor: Catalogo;
};
export type ExtraccionMesa = {
	codigo: string | null;
	titulo: string | null;
	fecha_carga: string | null;
	descripcion: string | null;
	solicitante: Catalogo | null;
};
export type PaginaMesas = { total: number; items: Mesa[] };
export type PanelMesasKPIs = {
	semana: string;
	total_semana: number;
	por_categoria: Record<string, number>;
	volumen_diario: { fecha: string; total: number }[];
	distribucion_resolutor: { resolutor: string; total: number }[];
	recientes: Mesa[];
};
export type ReporteMesasSemanal = {
	semana: string;
	total: number;
	por_categoria: Record<string, number>;
	por_solicitante: Record<string, number>;
	por_resolutor: Record<string, number>;
	mesas: Mesa[];
};

const BASE = '/api';

async function json<T>(path: string, init?: RequestInit): Promise<T> {
	const resp = await fetch(`${BASE}${path}`, {
		...init,
		headers: { 'Content-Type': 'application/json', ...(init?.headers ?? {}) }
	});
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
	catalogo: (nombre: NombreCatalogo, q = '') =>
		json<Catalogo[]>(`/${nombre}${q ? `?q=${encodeURIComponent(q)}` : ''}`),

	crearCatalogo: (
		nombre: 'empresas' | 'modulos' | 'categorias-mesa' | 'solicitantes-mesa' | 'resolutores-mesa' | 'ventanas-mesa',
		valor: string
	) => json<Catalogo>(`/${nombre}`, { method: 'POST', body: JSON.stringify({ nombre: valor }) }),

	crearRegistro: (payload: {
		fecha: string;
		empresa_id: number;
		sistema_id: number;
		medio_id: number;
		modulo_id: number;
		atendio_id: number;
		descripcion: string;
	}) => json<RegistroCreado>('/registros', { method: 'POST', body: JSON.stringify(payload) }),

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
		ventana_id: number;
		categoria_id: number;
		solicitante_id: number;
		resolutor_id: number;
		fecha_estimada_resolucion: string;
	}) => json<Mesa>('/mesas', { method: 'POST', body: JSON.stringify(payload) }),

	extraerImagenMesa: async (archivo: File) => {
		const form = new FormData();
		form.append('imagen', archivo);
		const resp = await fetch(`${BASE}/mesas/extraer-imagen`, { method: 'POST', body: form });
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
		return resp.json() as Promise<ExtraccionMesa>;
	},

	mesaPorId: (id: number) => json<Mesa>(`/mesas/${id}`),

	cerrarMesa: (id: number, payload: { solucion: string; tipo_solucion: string; fecha_cierre_real: string }) =>
		json<Mesa>(`/mesas/${id}/cerrar`, { method: 'POST', body: JSON.stringify(payload) }),

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

	listadoMesas: (params: Record<string, string | number | undefined>) => {
		const qs = new URLSearchParams();
		for (const [k, v] of Object.entries(params)) if (v !== undefined && v !== '') qs.set(k, String(v));
		return json<PaginaMesas>(`/mesas?${qs.toString()}`);
	},

	panelMesas: () => json<PanelMesasKPIs>('/mesas/panel'),

	reporteMesas: (semana: string) => json<ReporteMesasSemanal>(`/mesas/reporte?semana=${encodeURIComponent(semana)}`),

	temasFrecuentesMesas: (semana: string, top = 10) =>
		json<GrupoSoporte[]>(`/mesas/temas-frecuentes?semana=${encodeURIComponent(semana)}&top=${top}`),

	exportMesasUrl: (formato: 'csv' | 'xlsx', params: Record<string, string | number | undefined> = {}) => {
		const qs = new URLSearchParams({ formato });
		for (const [k, v] of Object.entries(params)) if (v !== undefined && v !== '') qs.set(k, String(v));
		return `${BASE}/mesas/export?${qs.toString()}`;
	}
};
