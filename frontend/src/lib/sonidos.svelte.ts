import { api, type EventoSonido, type Sonido } from './api/client';
import { reproducirFanfarriaMexicana } from './sonidoMexicano';
import { PREFIJO_SINTETIZADO, resolverSonido, sonidosDeRespaldo } from './sonidos';
import {
	reproducirCajaRegistradora,
	reproducirDerrota,
	reproducirMonedas,
	reproducirVictoria
} from './sonidosSintetizados';

// Catálogo cargado una vez por sesión (igual que personaje.svelte.ts) y
// refrescado si pasan más de 5 min, para que un cambio de acciones o de pesos
// hecho por otra persona llegue sin recargar la pestaña.
const TTL_MS = 5 * 60_000;

export const estadoSonidos = $state<{
	sonidos: Sonido[];
	cargado: boolean;
}>({ sonidos: [], cargado: false });

let promesaCarga: Promise<void> | null = null;
let enVuelo = false;
let cargadoEn = 0;

export function cargarSonidos(forzar = false): Promise<void> {
	const fresco = Date.now() - cargadoEn < TTL_MS;
	if (promesaCarga && (enVuelo || (fresco && !forzar))) return promesaCarga;

	enVuelo = true;
	promesaCarga = api
		.sonidos()
		.then((sonidos) => {
			estadoSonidos.sonidos = sonidos;
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

/** Lo saca del catálogo en memoria, sin recargar la página. */
export function quitarSonidoDelCache(id: number) {
	estadoSonidos.sonidos = estadoSonidos.sonidos.filter((s) => s.id !== id);
}

// Sonidos sin archivo: el catálogo los referencia por esquema y aquí se
// mapean a su generador Web Audio.
const SINTETIZADOS: Record<string, () => void> = {
	[`${PREFIJO_SINTETIZADO}fanfarria-mexicana`]: () => reproducirFanfarriaMexicana(),
	[`${PREFIJO_SINTETIZADO}victoria`]: () => reproducirVictoria(),
	[`${PREFIJO_SINTETIZADO}derrota`]: () => reproducirDerrota(),
	[`${PREFIJO_SINTETIZADO}caja-registradora`]: () => reproducirCajaRegistradora(),
	[`${PREFIJO_SINTETIZADO}monedas`]: () => reproducirMonedas()
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
	const url = resolverSonido(evento, catalogo);
	if (url) reproducirFuente(url);
}

/** Cierre de un minijuego: victoria o derrota según cómo le fue al usuario. */
export function reproducirResultado(gano: boolean): Promise<void> {
	return reproducirEvento(gano ? 'victoria' : 'derrota');
}
