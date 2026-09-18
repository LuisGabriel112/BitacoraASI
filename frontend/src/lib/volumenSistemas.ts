export type FilaSistema = { nombre: string; total: number; fraccion: number };

/**
 * La fracción se mide contra el sistema más alto, no contra la suma: el panel
 * compara sistemas entre sí, y con el total la barra del líder nunca llenaría
 * la fila y la lectura de un vistazo se pierde.
 */
export function calcularVolumenSistemas(porSistema: Record<string, number>): FilaSistema[] {
	const conRegistros = Object.entries(porSistema).filter(([, total]) => total > 0);
	if (conRegistros.length === 0) return [];

	const mayor = Math.max(...conRegistros.map(([, total]) => total));
	return conRegistros
		.sort(([, a], [, b]) => b - a)
		.map(([nombre, total]) => ({ nombre, total, fraccion: total / mayor }));
}
