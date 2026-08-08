import { describe, expect, it } from 'vitest';
import { easeOutBack } from './animacion';

describe('easeOutBack', () => {
	it('empieza en 0', () => {
		expect(easeOutBack(0)).toBeCloseTo(0);
	});

	it('termina exactamente en 1', () => {
		expect(easeOutBack(1)).toBeCloseTo(1);
	});

	it('sobrepasa 1 en algún punto intermedio (efecto rebote)', () => {
		const valores = Array.from({ length: 20 }, (_, i) => easeOutBack(i / 19));
		expect(Math.max(...valores)).toBeGreaterThan(1);
	});
});
