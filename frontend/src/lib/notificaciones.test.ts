import { describe, expect, it } from 'vitest';
import { SONIDOS_ERROR, SONIDOS_EXITO, elegirSonidoAleatorio, rutaSonidoParaAviso } from './notificaciones';

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

describe('rutaSonidoParaAviso', () => {
	it('hay más de un sonido de éxito y de error registrados', () => {
		expect(SONIDOS_EXITO.length).toBeGreaterThan(1);
		expect(SONIDOS_ERROR.length).toBeGreaterThan(1);
	});

	it('devuelve siempre uno de los sonidos de éxito registrados', () => {
		for (let i = 0; i < 20; i++) {
			expect(SONIDOS_EXITO).toContain(rutaSonidoParaAviso('exito'));
		}
	});

	it('devuelve siempre uno de los sonidos de error registrados', () => {
		for (let i = 0; i < 20; i++) {
			expect(SONIDOS_ERROR).toContain(rutaSonidoParaAviso('error'));
		}
	});
});
