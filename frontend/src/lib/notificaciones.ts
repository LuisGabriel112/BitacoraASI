import type { AccionSonido } from './api/client';

export type TipoAviso = 'exito' | 'error';

// Pool fijo de respaldo: es lo que la app reproducía antes del catálogo en
// base de datos (/sonidos), más los sintetizados de fábrica de las acciones
// nuevas. Hoy solo se usa si el catálogo no pudo cargarse (ver
// sonidosDeRespaldo en sonidos.ts); la fuente de verdad es la tabla.
export const SONIDOS_EXITO = [
	'/sonidos/pop-succes.ogg',
	'/sonidos/success-2.ogg',
	'/sonidos/success-3.ogg',
	'/sonidos/success-4.ogg',
	'/sonidos/success-5.mp4'
] as const;

export const SONIDOS_ERROR = [
	'/sonidos/denied-ehh.ogg',
	'/sonidos/denied-2.ogg',
	'/sonidos/denied-3.ogg',
	'/sonidos/denied-4.ogg',
	'/sonidos/denied-5.mp4'
] as const;

export const SONIDOS_COMPRA = ['sintetizado:caja-registradora', 'sintetizado:monedas'] as const;
export const SONIDOS_VICTORIA = ['sintetizado:victoria'] as const;
export const SONIDOS_DERROTA = ['sintetizado:derrota'] as const;

export const RESPALDO_POR_ACCION: Record<AccionSonido, readonly string[]> = {
	error: SONIDOS_ERROR,
	exito: SONIDOS_EXITO,
	compra: SONIDOS_COMPRA,
	victoria: SONIDOS_VICTORIA,
	derrota: SONIDOS_DERROTA
};

export function elegirSonidoAleatorio(opciones: readonly string[], aleatorio: () => number = Math.random): string {
	const indice = Math.floor(aleatorio() * opciones.length);
	return opciones[indice];
}
