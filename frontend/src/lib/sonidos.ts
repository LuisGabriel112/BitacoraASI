import type { AccionSonido, EventoSonido, Sonido } from './api/client';
import { RESPALDO_POR_ACCION } from './notificaciones';

/** Qué suena junto a un aviso: ruta de archivo, función (sonido sintetizado),
 *  una acción del usuario que resuelve el catálogo, o null para no sonar. */
export type FuenteSonido = string | (() => void) | { evento: EventoSonido } | null;

/** Los sonidos sin archivo (Web Audio) viven en el catálogo con este esquema
 *  en vez de una URL; el reproductor los resuelve a una función. */
export const PREFIJO_SINTETIZADO = 'sintetizado:';

/** Interruptores de cada sonido en el catálogo, en el orden en que se muestran
 *  (mismo orden que ACCIONES en el backend, services/sonidos.py). */
export const ACCIONES_SONIDO: { accion: AccionSonido; etiqueta: string; descripcion: string }[] = [
	{ accion: 'error', etiqueta: 'Error', descripcion: 'Mensajes de error' },
	{ accion: 'exito', etiqueta: 'Éxito', descripcion: 'Guardar mesa o registro' },
	{ accion: 'compra', etiqueta: 'Compra', descripcion: 'Comprar en la tienda' },
	{ accion: 'victoria', etiqueta: 'Victoria', descripcion: 'Ganar un minijuego' },
	{ accion: 'derrota', etiqueta: 'Derrota', descripcion: 'Perder un minijuego' }
];

export const ETIQUETA_ACCION: Record<AccionSonido, string> = Object.fromEntries(
	ACCIONES_SONIDO.map((a) => [a.accion, a.etiqueta])
) as Record<AccionSonido, string>;

/** Acciones concretas del usuario y la acción del catálogo con la que suenan
 *  (mismo mapa que ACCION_POR_EVENTO en el backend). */
export const EVENTOS_SONIDO: {
	evento: EventoSonido;
	etiqueta: string;
	descripcion: string;
	accion: AccionSonido;
}[] = [
	{
		evento: 'guardar_mesa',
		etiqueta: 'Guardar mesa',
		descripcion: 'Al registrar o editar una mesa en la bitácora administrativa.',
		accion: 'exito'
	},
	{
		evento: 'cerrar_mesa',
		etiqueta: 'Cerrar mesa',
		descripcion: 'Al cerrar una mesa con su solución.',
		accion: 'exito'
	},
	{
		evento: 'guardar_registro',
		etiqueta: 'Guardar registro',
		descripcion: 'Al registrar o editar un soporte en la bitácora operativa.',
		accion: 'exito'
	},
	{
		evento: 'error',
		etiqueta: 'Mensaje de error',
		descripcion: 'Cuando falta un campo o el servidor rechaza el guardado.',
		accion: 'error'
	},
	{
		evento: 'compra',
		etiqueta: 'Compra en la tienda',
		descripcion: 'Al comprar un objeto con tus créditos.',
		accion: 'compra'
	},
	{
		evento: 'victoria',
		etiqueta: 'Victoria en minijuego',
		descripcion: 'Al ganar cualquier minijuego del jefe de la semana.',
		accion: 'victoria'
	},
	{
		evento: 'derrota',
		etiqueta: 'Derrota en minijuego',
		descripcion: 'Al perder un minijuego (los empates no suenan).',
		accion: 'derrota'
	}
];

export function accionDeEvento(evento: EventoSonido): AccionSonido {
	return EVENTOS_SONIDO.find((e) => e.evento === evento)!.accion;
}

export function esSintetizado(url: string): boolean {
	return url.startsWith(PREFIJO_SINTETIZADO);
}

/** Sonidos que una acción puede reproducir: los marcados para su acción del catálogo. */
export function sonidosParaEvento(evento: EventoSonido, sonidos: readonly Sonido[]): Sonido[] {
	const accion = accionDeEvento(evento);
	return sonidos.filter((s) => s.acciones.includes(accion));
}

/** Cuánto pesa un sonido en el sorteo de una acción. Lo que no está ajustado
 *  pesa lo normal, así que todos compiten parejo hasta que alguien lo cambia. */
export const PESO_NORMAL = 1;
export const PESO_MINIMO = 1;
export const PESO_MAXIMO = 100;

export function pesoDe(sonido: Sonido, accion: AccionSonido): number {
	return sonido.pesos?.[accion] ?? PESO_NORMAL;
}

/** Qué tanto le toca a este sonido dentro de su acción, de 0 a 1: su peso
 *  entre la suma de los pesos de todos los que comparten esa acción. */
export function probabilidadDe(sonido: Sonido, accion: AccionSonido, sonidos: readonly Sonido[]): number {
	const comparten = sonidos.filter((s) => s.acciones.includes(accion));
	const total = comparten.reduce((suma, s) => suma + pesoDe(s, accion), 0);
	if (total === 0 || !sonido.acciones.includes(accion)) return 0;
	return pesoDe(sonido, accion) / total;
}

/** Sorteo proporcional al peso: con pesos 3 y 1, el primero sale 3 de cada 4
 *  veces. Con todos los pesos iguales equivale a elegir al azar. */
export function elegirPonderado(
	candidatos: readonly Sonido[],
	accion: AccionSonido,
	aleatorio: () => number = Math.random
): Sonido | null {
	if (candidatos.length === 0) return null;
	const total = candidatos.reduce((suma, s) => suma + pesoDe(s, accion), 0);
	let tirada = aleatorio() * total;
	for (const candidato of candidatos) {
		tirada -= pesoDe(candidato, accion);
		if (tirada < 0) return candidato;
	}
	// por redondeo del flotante la tirada puede quedarse justo en el tope
	return candidatos[candidatos.length - 1];
}

/**
 * Decide qué URL suena para una acción del usuario. `null` significa silencio.
 * Sortea entre los sonidos marcados para esa acción, dándole a cada uno la
 * probabilidad que marca su peso; sin ninguno marcado, no suena nada.
 */
export function resolverSonido(
	evento: EventoSonido,
	sonidos: readonly Sonido[],
	aleatorio: () => number = Math.random
): string | null {
	const elegido = elegirPonderado(sonidosParaEvento(evento, sonidos), accionDeEvento(evento), aleatorio);
	return elegido?.url ?? null;
}

/** Catálogo de respaldo cuando el backend no respondió: el pool fijo que la
 *  app traía antes, así el aviso sigue sonando aunque falle la carga. */
export function sonidosDeRespaldo(): Sonido[] {
	const respaldo: Sonido[] = [];
	for (const { accion } of ACCIONES_SONIDO) {
		for (const url of RESPALDO_POR_ACCION[accion]) {
			respaldo.push({
				id: -(respaldo.length + 1),
				nombre: url.split(/[/:]/).pop() ?? url,
				url,
				acciones: [accion],
				pesos: {},
				created_at: ''
			});
		}
	}
	return respaldo;
}

/** Nombre sugerido para un archivo recién elegido: sin extensión ni guiones bajos. */
export function nombreSugerido(nombreArchivo: string): string {
	return nombreArchivo
		.replace(/\.[^.]+$/, '')
		.replace(/[_]+/g, ' ')
		.trim();
}

export const TAMANO_MAXIMO_SONIDO_BYTES = 2 * 1024 * 1024;

/** Validación previa a subir: audio (o mp4 corto, como los que ya trae la app)
 *  y de tamaño razonable para un aviso. */
export function validarArchivoSonido(archivo: { name: string; type: string; size: number }): string | null {
	const esAudio = archivo.type.startsWith('audio/') || /\.(ogg|mp3|wav|m4a|mp4|webm|aac|flac)$/i.test(archivo.name);
	if (!esAudio) return 'Elige un archivo de audio (ogg, mp3, wav, m4a, mp4…)';
	if (archivo.size > TAMANO_MAXIMO_SONIDO_BYTES) return 'El sonido pesa más de 2 MB; recórtalo o comprímelo';
	return null;
}
