import { describe, expect, it } from 'vitest';
import { PALETA_GATITO, colorGatito } from './colorGatito';

describe('colorGatito', () => {
	it('es determinista para la misma semilla', () => {
		expect(colorGatito('SEM 32 - 2026-El SLA Vencido')).toBe(colorGatito('SEM 32 - 2026-El SLA Vencido'));
	});

	it('siempre devuelve un color de la paleta', () => {
		for (const semilla of ['SEM 01 - 2026-x', 'SEM 15 - 2026-y', 'SEM 52 - 2026-z']) {
			expect(PALETA_GATITO).toContain(colorGatito(semilla));
		}
	});

	it('semillas distintas no estan forzadas al mismo color', () => {
		const colores = new Set(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].map(colorGatito));
		expect(colores.size).toBeGreaterThan(1);
	});
});
