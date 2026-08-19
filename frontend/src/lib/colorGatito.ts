import { hashTexto } from './hashDeterminista';

export const PALETA_GATITO = ['#d97a3d', '#8a8f98', '#33363b', '#e8e4da', '#6b4a35', '#d8c39a'] as const;

export function colorGatito(semilla: string): (typeof PALETA_GATITO)[number] {
	return PALETA_GATITO[hashTexto(semilla) % PALETA_GATITO.length];
}
