import { describe, expect, it } from 'vitest';
import { parsearFechaHoraPegada } from './fechaHora';

describe('parsearFechaHoraPegada', () => {
	it('convierte una fecha DD/MM/AAAA HH:mm a formato datetime-local', () => {
		expect(parsearFechaHoraPegada('05/08/2026 10:36')).toBe('2026-08-05T10:36');
	});

	it('acepta espacio no separable (nbsp) entre fecha y hora', () => {
		expect(parsearFechaHoraPegada('05/08/2026 10:36')).toBe('2026-08-05T10:36');
	});

	it('extrae la fecha aunque venga con texto alrededor', () => {
		expect(parsearFechaHoraPegada('Fecha: 05/08/2026 10:36 hrs')).toBe('2026-08-05T10:36');
	});

	it('rellena con cero día, mes y hora de un solo dígito', () => {
		expect(parsearFechaHoraPegada('5/8/2026 9:05')).toBe('2026-08-05T09:05');
	});

	it('devuelve null cuando el texto no contiene una fecha reconocible', () => {
		expect(parsearFechaHoraPegada('TCK-001')).toBeNull();
	});
});
