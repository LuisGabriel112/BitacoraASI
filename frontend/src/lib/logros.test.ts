import { describe, expect, it } from 'vitest';
import { MENSAJES_LOGRO } from './logros';

describe('MENSAJES_LOGRO', () => {
	it('define un mensaje para el logro de soporte guardado', () => {
		expect(MENSAJES_LOGRO.soporte_guardado).toBe('Soporte registrado en la bitácora');
	});
});
