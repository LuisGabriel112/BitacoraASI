import { api, type Personaje } from './api/client';

export const estadoPersonaje = $state<{ actual: Personaje | null }>({ actual: null });

let promesaCarga: Promise<void> | null = null;

export function cargarPersonaje(): Promise<void> {
	if (!promesaCarga) {
		promesaCarga = api
			.miPersonaje()
			.then((p) => {
				estadoPersonaje.actual = p;
			})
			.catch(() => {
				estadoPersonaje.actual = null;
			});
	}
	return promesaCarga;
}

export function actualizarPersonaje(p: Personaje) {
	estadoPersonaje.actual = p;
}

export function limpiarPersonaje() {
	estadoPersonaje.actual = null;
	promesaCarga = null;
}
