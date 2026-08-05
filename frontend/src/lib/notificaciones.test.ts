import { describe, expect, it } from 'vitest';
import { rutaSonidoParaAviso } from './notificaciones';

describe('rutaSonidoParaAviso', () => {
	it('devuelve el sonido de éxito para un aviso de tipo exito', () => {
		expect(rutaSonidoParaAviso('exito')).toBe('/sonidos/pop-succes.ogg');
	});

	it('devuelve el sonido de error para un aviso de tipo error', () => {
		expect(rutaSonidoParaAviso('error')).toBe('/sonidos/denied-ehh.ogg');
	});
});
