import { describe, expect, it } from 'vitest';
import { hashTexto } from './hashDeterminista';

describe('hashTexto', () => {
	it('es determinista', () => {
		expect(hashTexto('El SLA Vencido')).toBe(hashTexto('El SLA Vencido'));
	});

	it('siempre da un entero no negativo, incluso para texto vacio', () => {
		for (const texto of ['', 'a', 'El Ticket Zombie', 'Caos de Prioridades']) {
			const h = hashTexto(texto);
			expect(Number.isInteger(h)).toBe(true);
			expect(h).toBeGreaterThanOrEqual(0);
		}
	});
});
