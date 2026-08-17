import { describe, expect, it } from 'vitest';
import { generarMazo } from './memorama';

describe('generarMazo', () => {
	it('cada simbolo aparece exactamente 2 veces', () => {
		const simbolos = ['🐱', '🐶', '🐭', '🐹'];
		const mazo = generarMazo(simbolos);

		for (const s of simbolos) {
			expect(mazo.filter((c) => c === s)).toHaveLength(2);
		}
	});

	it('el mazo tiene el doble de cartas que simbolos', () => {
		const simbolos = ['🐱', '🐶', '🐭'];
		expect(generarMazo(simbolos)).toHaveLength(6);
	});

	it('el mismo generador aleatorio produce siempre el mismo mazo', () => {
		const simbolos = ['🐱', '🐶', '🐭'];
		expect(generarMazo(simbolos, () => 0.3)).toEqual(generarMazo(simbolos, () => 0.3));
	});
});
