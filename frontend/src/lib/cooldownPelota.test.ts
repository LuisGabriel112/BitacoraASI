import { describe, expect, it } from 'vitest';
import { COOLDOWN_MS, segundosRestantesCooldown } from './cooldownPelota';

describe('segundosRestantesCooldown', () => {
	it('es 0 si nunca ha jugado', () => {
		expect(segundosRestantesCooldown(null, Date.now())).toBe(0);
	});

	it('calcula el restante si jugo hace 2 minutos', () => {
		const ahora = Date.now();
		const ultimo = ahora - 2 * 60_000;
		expect(segundosRestantesCooldown(ultimo, ahora)).toBe(3 * 60);
	});

	it('es 0 si ya paso el cooldown completo', () => {
		const ahora = Date.now();
		const ultimo = ahora - 10 * 60_000;
		expect(segundosRestantesCooldown(ultimo, ahora)).toBe(0);
	});

	it('el cooldown configurado es de 5 minutos', () => {
		expect(COOLDOWN_MS).toBe(5 * 60_000);
	});
});
