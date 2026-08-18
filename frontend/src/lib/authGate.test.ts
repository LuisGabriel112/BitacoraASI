import { describe, expect, it } from 'vitest';
import { debeRedirigirALogin } from './authGate';

describe('debeRedirigirALogin', () => {
	it('no redirige cuando la sesion es valida', () => {
		expect(debeRedirigirALogin(true)).toBe(false);
	});

	it('redirige cuando la sesion no es valida', () => {
		expect(debeRedirigirALogin(false)).toBe(true);
	});
});
