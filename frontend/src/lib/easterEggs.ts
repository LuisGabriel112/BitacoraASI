export const RUTA_SONIDO_EE_ATZIMBA = '/sonidos/ee-atzimba.ogg';

function normalizar(nombre: string): string {
	return nombre.trim().toLowerCase().split(/\s+/).join(' ');
}

export function esPrimerSoporteDeAtzimba(nombreAgente: string, totalSoportesDelAgente: number): boolean {
	return normalizar(nombreAgente) === normalizar('Atzimba Torres') && totalSoportesDelAgente === 1;
}
