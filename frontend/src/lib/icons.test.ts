import { describe, expect, it } from 'vitest';
import { ICONOS } from './icons';

describe('ICONOS', () => {
	it('ninguna entrada esta vacia', () => {
		for (const marcado of Object.values(ICONOS)) {
			expect(marcado.length).toBeGreaterThan(0);
		}
	});

	it('toda entrada empieza con una etiqueta SVG valida', () => {
		for (const marcado of Object.values(ICONOS)) {
			expect(marcado).toMatch(/^<(path|circle|rect|line|polyline)\b/);
		}
	});

	it('un nombre conocido devuelve su marcado', () => {
		expect(ICONOS.trophy).toBeDefined();
		expect(ICONOS.trophy.length).toBeGreaterThan(0);
	});
});
