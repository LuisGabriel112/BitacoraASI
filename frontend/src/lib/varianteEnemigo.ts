import { hashTexto } from './hashDeterminista';

export const CANTIDAD_VARIANTES_ENEMIGO = 15;

export function varianteEnemigo(nombre: string): number {
	return hashTexto(nombre) % CANTIDAD_VARIANTES_ENEMIGO;
}
