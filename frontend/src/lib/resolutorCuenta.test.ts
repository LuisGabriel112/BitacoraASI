import { describe, expect, it } from 'vitest';
import { resolutorVinculadoA } from './resolutorCuenta';

const catalogo = [
	{ id: 7, nombre: 'Reyes Cicero, Sergio', usuario_id: 42 },
	{ id: 8, nombre: 'Loperena Domínguez, Sergio Adolfo', usuario_id: null }
];

describe('resolutorVinculadoA', () => {
	it('devuelve el resolutor cuyo usuario_id coincide con el usuario dado', () => {
		expect(resolutorVinculadoA(catalogo, 42)).toEqual(catalogo[0]);
	});

	it('devuelve null si ningún resolutor está vinculado a ese usuario', () => {
		expect(resolutorVinculadoA(catalogo, 99)).toBeNull();
	});

	it('devuelve null si no hay usuario identificado', () => {
		expect(resolutorVinculadoA(catalogo, null)).toBeNull();
	});
});
