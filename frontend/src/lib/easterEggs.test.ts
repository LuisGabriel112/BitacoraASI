import { describe, expect, it } from 'vitest';
import { RUTA_SONIDO_EE_ATZIMBA, esPrimerSoporteDelDiaDeAtzimba } from './easterEggs';

describe('esPrimerSoporteDelDiaDeAtzimba', () => {
	it('aplica cuando el agente es Atzimba Torres y el logro de primer soporte del día está presente', () => {
		expect(esPrimerSoporteDelDiaDeAtzimba('Atzimba Torres', ['primer_soporte_dia_agente'])).toBe(true);
	});

	it('no aplica cuando el logro de primer soporte del día no está', () => {
		expect(esPrimerSoporteDelDiaDeAtzimba('Atzimba Torres', ['primer_soporte_semana'])).toBe(false);
	});

	it('no aplica cuando no hay logros', () => {
		expect(esPrimerSoporteDelDiaDeAtzimba('Atzimba Torres', [])).toBe(false);
	});

	it('no aplica cuando el agente no es Atzimba Torres', () => {
		expect(esPrimerSoporteDelDiaDeAtzimba('Juan Pérez', ['primer_soporte_dia_agente'])).toBe(false);
	});

	it('ignora mayúsculas y espacios extra en el nombre', () => {
		expect(esPrimerSoporteDelDiaDeAtzimba('  atzimba   torres ', ['primer_soporte_dia_agente'])).toBe(true);
	});

	it('define una ruta de sonido para el easter egg', () => {
		expect(RUTA_SONIDO_EE_ATZIMBA).toBe('/sonidos/ee-atzimba.ogg');
	});
});
