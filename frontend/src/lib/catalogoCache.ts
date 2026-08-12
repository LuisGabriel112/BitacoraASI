import { api, type Catalogo, type NombreCatalogo } from './api/client';

const LIMITE_CATALOGO_COMPLETO = 500;
const cache = new Map<NombreCatalogo, Promise<Catalogo[]>>();

export function catalogoCompleto(nombre: NombreCatalogo): Promise<Catalogo[]> {
	let promesa = cache.get(nombre);
	if (!promesa) {
		promesa = api.catalogo(nombre, '', LIMITE_CATALOGO_COMPLETO);
		cache.set(nombre, promesa);
	}
	return promesa;
}

export async function agregarAlCache(nombre: NombreCatalogo, item: Catalogo): Promise<void> {
	const promesa = cache.get(nombre);
	if (!promesa) return;
	const lista = await promesa;
	if (lista.some((i) => i.id === item.id)) return;
	const actualizada = [...lista, item].sort((a, b) => a.nombre.localeCompare(b.nombre));
	cache.set(nombre, Promise.resolve(actualizada));
}

export function invalidarCache(nombre: NombreCatalogo): void {
	cache.delete(nombre);
}
