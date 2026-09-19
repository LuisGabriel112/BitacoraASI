import { describe, expect, it } from 'vitest';
import { RESPALDO_POR_ACCION, SONIDOS_ERROR, SONIDOS_EXITO, elegirSonidoAleatorio } from './notificaciones';

describe('elegirSonidoAleatorio', () => {
	it('elige el primer elemento cuando el azar da 0', () => {
		expect(elegirSonidoAleatorio(['a', 'b', 'c'], () => 0)).toBe('a');
	});

	it('elige el último elemento cuando el azar da justo antes de 1', () => {
		expect(elegirSonidoAleatorio(['a', 'b', 'c'], () => 0.999999)).toBe('c');
	});

	it('elige el elemento del medio con un azar intermedio', () => {
		expect(elegirSonidoAleatorio(['a', 'b', 'c'], () => 0.5)).toBe('b');
	});
});

describe('pool de respaldo', () => {
	it('hay más de un sonido de éxito y de error registrados', () => {
		expect(SONIDOS_EXITO.length).toBeGreaterThan(1);
		expect(SONIDOS_ERROR.length).toBeGreaterThan(1);
	});

	it('todos apuntan a la carpeta estática de sonidos', () => {
		for (const ruta of [...SONIDOS_EXITO, ...SONIDOS_ERROR]) expect(ruta).toMatch(/^\/sonidos\//);
	});

	it('cada acción del catálogo tiene al menos un sonido de respaldo', () => {
		for (const accion of ['error', 'exito', 'compra', 'victoria', 'derrota'] as const) {
			expect(RESPALDO_POR_ACCION[accion].length).toBeGreaterThan(0);
		}
	});

	it('el respaldo de compra, victoria y derrota es sintetizado (no depende de archivos)', () => {
		for (const accion of ['compra', 'victoria', 'derrota'] as const) {
			for (const url of RESPALDO_POR_ACCION[accion]) expect(url).toMatch(/^sintetizado:/);
		}
	});
});
