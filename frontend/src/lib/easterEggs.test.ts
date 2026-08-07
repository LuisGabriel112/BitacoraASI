import { describe, expect, it } from 'vitest';
import { RUTA_SONIDO_EE_ATZIMBA, esPrimerSoporteDeAtzimba } from './easterEggs';

describe('esPrimerSoporteDeAtzimba', () => {
	it('aplica cuando el agente es Atzimba Torres y es su primer soporte', () => {
		expect(esPrimerSoporteDeAtzimba('Atzimba Torres', 1)).toBe(true);
	});

	it('no aplica cuando ya tiene más de un soporte', () => {
		expect(esPrimerSoporteDeAtzimba('Atzimba Torres', 2)).toBe(false);
	});

	it('no aplica cuando el agente no es Atzimba Torres', () => {
		expect(esPrimerSoporteDeAtzimba('Juan Pérez', 1)).toBe(false);
	});

	it('ignora mayúsculas y espacios extra en el nombre', () => {
		expect(esPrimerSoporteDeAtzimba('  atzimba   torres ', 1)).toBe(true);
	});

	it('define una ruta de sonido para el easter egg', () => {
		expect(RUTA_SONIDO_EE_ATZIMBA).toBe('/sonidos/ee-atzimba.ogg');
	});
});
