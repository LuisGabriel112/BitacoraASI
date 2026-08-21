export type OpcionCatalogo = { id: number; nombre: string };

export function coincidenciaExacta(opciones: OpcionCatalogo[], texto: string): OpcionCatalogo | null {
	const buscado = texto.trim().toLowerCase();
	if (!buscado) return null;
	return opciones.find((o) => o.nombre.toLowerCase() === buscado) ?? null;
}

export function filtrarPorFragmento<T extends OpcionCatalogo>(opciones: T[], texto: string): T[] {
	const fragmento = texto.trim().toLowerCase();
	if (!fragmento) return opciones;
	return opciones.filter((o) => o.nombre.toLowerCase().includes(fragmento));
}
