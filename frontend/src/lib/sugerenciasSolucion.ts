export type SintesisConCategoria = {
	id: number;
	categoria: { id: number; nombre: string };
	titulo: string;
	texto: string;
};

export function sugerenciasParaCategoria<T extends SintesisConCategoria>(
	sintesis: T[],
	categoriaId: number | null
): T[] {
	if (categoriaId === null) return [];
	return sintesis.filter((s) => s.categoria.id === categoriaId);
}
