export type OpcionCatalogo = { id: number; nombre: string };

export function coincidenciaExacta(opciones: OpcionCatalogo[], texto: string): OpcionCatalogo | null {
	const buscado = texto.trim().toLowerCase();
	if (!buscado) return null;
	return opciones.find((o) => o.nombre.toLowerCase() === buscado) ?? null;
}
