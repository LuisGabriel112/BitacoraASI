import { describe, expect, it } from 'vitest';
import { MENSAJES_LOGRO } from './logros';

describe('MENSAJES_LOGRO', () => {
	it('define un mensaje para el logro de soporte guardado', () => {
		expect(MENSAJES_LOGRO.soporte_guardado).toBe('Soporte registrado en la bitácora');
	});

	it('define mensajes para los logros de horario de soporte, distintos a los de mesas', () => {
		expect(MENSAJES_LOGRO.antes_de_jornada_soporte).toContain('Soporte');
		expect(MENSAJES_LOGRO.antes_de_jornada_soporte).not.toBe(MENSAJES_LOGRO.antes_de_jornada);
	});

	it('define mensajes para los logros de conteo de soporte', () => {
		expect(MENSAJES_LOGRO.primer_soporte_dia_agente).toBeDefined();
		expect(MENSAJES_LOGRO.decimo_soporte_dia).toBeDefined();
		expect(MENSAJES_LOGRO.primer_soporte_semana).toBeDefined();
	});
});
