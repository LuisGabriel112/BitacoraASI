import { describe, it, expect } from 'vitest';
import { CLAVE_NAV_COLAPSADO, leerNavColapsado, guardarNavColapsado } from './navColapsado';

function almacenFalso(inicial: Record<string, string> = {}) {
	const datos = { ...inicial };
	return {
		datos,
		getItem: (clave: string) => datos[clave] ?? null,
		setItem: (clave: string, valor: string) => {
			datos[clave] = valor;
		}
	};
}

describe('leerNavColapsado', () => {
	it('arranca visible cuando no hay preferencia guardada', () => {
		expect(leerNavColapsado(almacenFalso())).toBe(false);
	});

	it('recuerda que la barra quedó colapsada', () => {
		expect(leerNavColapsado(almacenFalso({ [CLAVE_NAV_COLAPSADO]: '1' }))).toBe(true);
	});

	it('trata un almacenamiento ausente como barra visible', () => {
		expect(leerNavColapsado(null)).toBe(false);
	});

	it('trata un valor corrupto como barra visible', () => {
		expect(leerNavColapsado(almacenFalso({ [CLAVE_NAV_COLAPSADO]: 'quizás' }))).toBe(false);
	});
});

describe('guardarNavColapsado', () => {
	it('conserva la preferencia cuando la barra se colapsa', () => {
		const almacen = almacenFalso();

		guardarNavColapsado(almacen, true);

		expect(almacen.datos[CLAVE_NAV_COLAPSADO]).toBe('1');
	});

	it('conserva la preferencia cuando la barra vuelve a mostrarse', () => {
		const almacen = almacenFalso({ [CLAVE_NAV_COLAPSADO]: '1' });

		guardarNavColapsado(almacen, false);

		expect(almacen.datos[CLAVE_NAV_COLAPSADO]).toBe('0');
	});

	it('no falla cuando no hay almacenamiento', () => {
		expect(() => guardarNavColapsado(null, true)).not.toThrow();
	});
});
