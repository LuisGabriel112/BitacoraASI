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

export const api = {
	catalogo: (nombre: 'empresas' | 'modulos' | 'sistemas' | 'medios' | 'agentes', q = '') =>
		json<Catalogo[]>(`/${nombre}${q ? `?q=${encodeURIComponent(q)}` : ''}`),

	crearCatalogo: (nombre: 'empresas' | 'modulos', valor: string) =>
		json<Catalogo>(`/${nombre}`, { method: 'POST', body: JSON.stringify({ nombre: valor }) }),

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
	}
};
