import { describe, expect, it } from 'vitest';
import { SONIDOS_ERROR, SONIDOS_EXITO, elegirSonidoAleatorio } from './notificaciones';

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
});
