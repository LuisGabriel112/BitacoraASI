import type { CategoriaSonido, EventoSonido, PreferenciaSonido, Sonido } from './api/client';
import { SONIDOS_ERROR, SONIDOS_EXITO, elegirSonidoAleatorio } from './notificaciones';

/** Qué suena junto a un aviso: ruta de archivo, función (sonido sintetizado),
 *  la preferencia del usuario para una acción, o null para no sonar. */
export type FuenteSonido = string | (() => void) | { evento: EventoSonido } | null;

/** Los sonidos sin archivo (Web Audio) viven en el catálogo con este esquema
 *  en vez de una URL; el reproductor los resuelve a una función. */
export const PREFIJO_SINTETIZADO = 'sintetizado:';

export const EVENTOS_SONIDO: {
	evento: EventoSonido;
	etiqueta: string;
	descripcion: string;
	categoria: CategoriaSonido;
}[] = [
	{
		evento: 'guardar_mesa',
		etiqueta: 'Guardar mesa',
		descripcion: 'Al registrar o editar una mesa en la bitácora administrativa.',
		categoria: 'exito'
	},
	{
		evento: 'cerrar_mesa',
		etiqueta: 'Cerrar mesa',
		descripcion: 'Al cerrar una mesa con su solución.',
		categoria: 'exito'
	},
	{
		evento: 'error',
		etiqueta: 'Mensaje de error',
		descripcion: 'Cuando falta un campo o el servidor rechaza el guardado.',
		categoria: 'error'
	}
];

export const ETIQUETA_CATEGORIA: Record<CategoriaSonido, string> = { exito: 'Éxito', error: 'Error' };

export function categoriaDeEvento(evento: EventoSonido): CategoriaSonido {
	return EVENTOS_SONIDO.find((e) => e.evento === evento)!.categoria;
}

export function esSintetizado(url: string): boolean {
	return url.startsWith(PREFIJO_SINTETIZADO);
}

/** Sonidos que una acción puede reproducir: los activos de su categoría. */
export function sonidosParaEvento(evento: EventoSonido, sonidos: readonly Sonido[]): Sonido[] {
	const categoria = categoriaDeEvento(evento);
	return sonidos.filter((s) => s.activo && s.categoria === categoria);
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
 * - Sonido elegido y todavía activo → ese.
 * - Sin preferencia, o el elegido fue deshabilitado en general → aleatorio
 *   entre los activos de la categoría; si no queda ninguno activo → null.
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
	const aSonido = (url: string, categoria: CategoriaSonido, indice: number): Sonido => ({
		id: -(indice + 1) * (categoria === 'exito' ? 1 : 100),
		categoria,
		nombre: url.split('/').pop() ?? url,
		url,
		activo: true,
		created_at: ''
	});
	return [
		...SONIDOS_EXITO.map((url, i) => aSonido(url, 'exito', i)),
		...SONIDOS_ERROR.map((url, i) => aSonido(url, 'error', i))
	];
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
