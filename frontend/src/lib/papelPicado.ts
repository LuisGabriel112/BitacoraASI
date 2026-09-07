export type ColorBanderin = 'verde' | 'blanco' | 'rojo';

export interface Banderin {
	color: ColorBanderin;
	retrasoMs: number;
}

const ORDEN_COLORES: ColorBanderin[] = ['verde', 'blanco', 'rojo'];
const RETRASO_ENTRE_BANDERINES_MS = 120;

export function generarBanderines(cantidad: number): Banderin[] {
	return Array.from({ length: cantidad }, (_, indice) => ({
		color: ORDEN_COLORES[indice % ORDEN_COLORES.length],
		retrasoMs: indice * RETRASO_ENTRE_BANDERINES_MS
	}));
}
