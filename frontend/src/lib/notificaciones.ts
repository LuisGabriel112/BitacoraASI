export type TipoAviso = 'exito' | 'error';

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

export function elegirSonidoAleatorio(opciones: readonly string[], aleatorio: () => number = Math.random): string {
	const indice = Math.floor(aleatorio() * opciones.length);
	return opciones[indice];
}

export function rutaSonidoParaAviso(tipo: TipoAviso, aleatorio: () => number = Math.random): string {
	return elegirSonidoAleatorio(tipo === 'exito' ? SONIDOS_EXITO : SONIDOS_ERROR, aleatorio);
}
