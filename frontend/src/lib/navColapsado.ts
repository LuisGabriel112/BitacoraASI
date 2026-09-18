export const CLAVE_NAV_COLAPSADO = 'bitacora-nav-colapsado';

export type AlmacenPreferencia = Pick<Storage, 'getItem' | 'setItem'>;

/**
 * El almacén entra por parámetro en vez de leerse de `localStorage`: durante el
 * render en servidor no existe, y así la lógica se prueba sin navegador.
 */
export function leerNavColapsado(almacen: AlmacenPreferencia | null): boolean {
	return almacen?.getItem(CLAVE_NAV_COLAPSADO) === '1';
}

export function guardarNavColapsado(almacen: AlmacenPreferencia | null, colapsado: boolean): void {
	almacen?.setItem(CLAVE_NAV_COLAPSADO, colapsado ? '1' : '0');
}
