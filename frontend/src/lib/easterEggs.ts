export const RUTA_SONIDO_EE_ATZIMBA = '/sonidos/ee-atzimba.ogg';

function normalizar(nombre: string): string {
	return nombre.trim().toLowerCase().split(/\s+/).join(' ');
}

export function esPrimerSoporteDelDiaDeAtzimba(nombreAgente: string, logros: string[]): boolean {
	return normalizar(nombreAgente) === normalizar('Atzimba Torres') && logros.includes('primer_soporte_dia_agente');
}
