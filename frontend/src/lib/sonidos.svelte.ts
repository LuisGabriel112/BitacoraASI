import { api, type EventoSonido, type PreferenciaSonido, type Sonido } from './api/client';
import { reproducirFanfarriaMexicana } from './sonidoMexicano';
import { PREFIJO_SINTETIZADO, resolverSonido, sonidosDeRespaldo } from './sonidos';

// Catálogo + preferencias del usuario, cargados una vez por sesión (igual que
// personaje.svelte.ts) y refrescados si pasan más de 5 min, para que un toggle
// general hecho por otra persona llegue sin recargar la pestaña.
const TTL_MS = 5 * 60_000;

export const estadoSonidos = $state<{
	sonidos: Sonido[];
	preferencias: PreferenciaSonido[];
	cargado: boolean;
}>({ sonidos: [], preferencias: [], cargado: false });

let promesaCarga: Promise<void> | null = null;
let enVuelo = false;
let cargadoEn = 0;

export function cargarSonidos(forzar = false): Promise<void> {
	const fresco = Date.now() - cargadoEn < TTL_MS;
	if (promesaCarga && (enVuelo || (fresco && !forzar))) return promesaCarga;

	enVuelo = true;
	promesaCarga = Promise.all([api.sonidos(), api.preferenciasSonido()])
		.then(([sonidos, preferencias]) => {
			estadoSonidos.sonidos = sonidos;
			estadoSonidos.preferencias = preferencias;
			estadoSonidos.cargado = true;
			cargadoEn = Date.now();
		})
		.catch(() => {
			// sin catálogo se reproduce el pool de respaldo; no rompe ningún flujo
		})
		.finally(() => {
			enVuelo = false;
		});
	return promesaCarga;
}

export function limpiarSonidos() {
	estadoSonidos.sonidos = [];
	estadoSonidos.preferencias = [];
	estadoSonidos.cargado = false;
	promesaCarga = null;
	cargadoEn = 0;
}

export function actualizarSonidoEnCache(sonido: Sonido) {
	const existe = estadoSonidos.sonidos.some((s) => s.id === sonido.id);
	estadoSonidos.sonidos = existe
		? estadoSonidos.sonidos.map((s) => (s.id === sonido.id ? sonido : s))
		: [...estadoSonidos.sonidos, sonido];
}

export function actualizarPreferenciaEnCache(preferencia: PreferenciaSonido) {
	const resto = estadoSonidos.preferencias.filter((p) => p.evento !== preferencia.evento);
	estadoSonidos.preferencias = [...resto, preferencia];
}

// Sonidos sin archivo: el catálogo los referencia por esquema y aquí se
// mapean a su generador Web Audio.
const SINTETIZADOS: Record<string, () => void> = {
	[`${PREFIJO_SINTETIZADO}fanfarria-mexicana`]: () => reproducirFanfarriaMexicana()
};

/** Reproduce una URL del catálogo (archivo o sintetizado). Devuelve el
 *  elemento de audio cuando lo hay, para que quien previsualiza pueda pararlo. */
export function reproducirFuente(url: string): HTMLAudioElement | null {
	if (url.startsWith(PREFIJO_SINTETIZADO)) {
		SINTETIZADOS[url]?.();
		return null;
	}
	const audio = new Audio(url);
	audio.play().catch(() => {});
	return audio;
}

/** Suena lo que el usuario eligió para esa acción (o el aleatorio / nada). */
export async function reproducirEvento(evento: EventoSonido): Promise<void> {
	await cargarSonidos();
	const catalogo = estadoSonidos.cargado ? estadoSonidos.sonidos : sonidosDeRespaldo();
	const url = resolverSonido(evento, catalogo, estadoSonidos.preferencias);
	if (url) reproducirFuente(url);
}
