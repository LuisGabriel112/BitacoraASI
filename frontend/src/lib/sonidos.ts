import type { AccionSonido, EventoSonido, PreferenciaSonido, Sonido } from './api/client';
import { RESPALDO_POR_ACCION, elegirSonidoAleatorio } from './notificaciones';

/** Qué suena junto a un aviso: ruta de archivo, función (sonido sintetizado),
 *  la preferencia del usuario para una acción, o null para no sonar. */
export type FuenteSonido = string | (() => void) | { evento: EventoSonido } | null;

/** Los sonidos sin archivo (Web Audio) viven en el catálogo con este esquema
 *  en vez de una URL; el reproductor los resuelve a una función. */
export const PREFIJO_SINTETIZADO = 'sintetizado:';

/** Interruptores de cada sonido en el catálogo, en el orden en que se muestran
 *  (mismo orden que ACCIONES en el backend, services/sonidos.py). */
export const ACCIONES_SONIDO: { accion: AccionSonido; etiqueta: string; descripcion: string }[] = [
	{ accion: 'error', etiqueta: 'Error', descripcion: 'Mensajes de error' },
	{ accion: 'exito', etiqueta: 'Éxito', descripcion: 'Guardar y cerrar mesa' },
	{ accion: 'compra', etiqueta: 'Compra', descripcion: 'Comprar en la tienda' },
	{ accion: 'victoria', etiqueta: 'Victoria', descripcion: 'Ganar un minijuego' },
	{ accion: 'derrota', etiqueta: 'Derrota', descripcion: 'Perder un minijuego' }
];

export const ETIQUETA_ACCION: Record<AccionSonido, string> = Object.fromEntries(
	ACCIONES_SONIDO.map((a) => [a.accion, a.etiqueta])
) as Record<AccionSonido, string>;

/** Acciones concretas del usuario con preferencia propia y la acción del
 *  catálogo con la que suenan (mismo mapa que ACCION_POR_EVENTO en el backend). */
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

export function preferenciaDe(
	evento: EventoSonido,
	preferencias: readonly PreferenciaSonido[]
): PreferenciaSonido | undefined {
	return preferencias.find((p) => p.evento === evento);
}

/**
 * Decide qué URL suena para una acción. `null` significa silencio.
 * - Silenciado por el usuario → null.
 * - Sonido elegido y todavía marcado para la acción → ese.
 * - Sin preferencia, o al elegido le quitaron la acción en el catálogo →
 *   aleatorio entre los marcados; si no queda ninguno → null.
 */
export function resolverSonido(
	evento: EventoSonido,
	sonidos: readonly Sonido[],
	preferencias: readonly PreferenciaSonido[],
	aleatorio: () => number = Math.random
): string | null {
	const preferencia = preferenciaDe(evento, preferencias);
	if (preferencia?.silenciado) return null;

	const disponibles = sonidosParaEvento(evento, sonidos);
	const elegido = preferencia?.sonido_id != null ? disponibles.find((s) => s.id === preferencia.sonido_id) : undefined;
	if (elegido) return elegido.url;
	if (disponibles.length === 0) return null;
	return elegirSonidoAleatorio(
		disponibles.map((s) => s.url),
		aleatorio
	);
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
