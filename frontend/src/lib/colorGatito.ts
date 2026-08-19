export const PALETA_GATITO = ['#d97a3d', '#8a8f98', '#33363b', '#e8e4da', '#6b4a35', '#d8c39a'] as const;

function hash(texto: string): number {
	let h = 0;
	for (let i = 0; i < texto.length; i++) h = (h * 31 + texto.charCodeAt(i)) | 0;
	return Math.abs(h);
}

export function colorGatito(semilla: string): (typeof PALETA_GATITO)[number] {
	return PALETA_GATITO[hash(semilla) % PALETA_GATITO.length];
}
