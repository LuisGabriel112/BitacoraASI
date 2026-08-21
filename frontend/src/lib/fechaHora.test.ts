import { describe, expect, it } from 'vitest';
import { fechaHoraActualLocal, formatearFechaHora, parsearFechaHoraPegada } from './fechaHora';

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

describe('formatearFechaHora', () => {
	it('convierte el formato datetime-local a DD/MM/AAAA HH:mm', () => {
		expect(formatearFechaHora('2026-08-06T15:49')).toBe('06/08/2026 15:49');
	});

	it('devuelve cadena vacía si no hay valor guardado', () => {
		expect(formatearFechaHora('')).toBe('');
	});

	it('es el inverso de parsearFechaHoraPegada para un valor ya normalizado', () => {
		const iso = parsearFechaHoraPegada('05/08/2026 10:36')!;
		expect(formatearFechaHora(iso)).toBe('05/08/2026 10:36');
	});
});

describe('fechaHoraActualLocal', () => {
	it('rellena con ceros mes, día, hora y minuto de un solo dígito', () => {
		expect(fechaHoraActualLocal(new Date(2026, 0, 5, 3, 7))).toBe('2026-01-05T03:07');
	});

	it('usa la fecha y hora del sistema si no se le pasa una', () => {
		const antes = new Date();
		const resultado = fechaHoraActualLocal();
		expect(resultado.slice(0, 4)).toBe(String(antes.getFullYear()));
	});
});
