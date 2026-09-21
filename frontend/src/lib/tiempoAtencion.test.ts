import { describe, expect, it } from 'vitest';
import { formatearMinutosAtencion, parsearMinutosAtencion } from './tiempoAtencion';

describe('parsearMinutosAtencion', () => {
	it('convierte un tiempo válido a número de minutos', () => {
		expect(parsearMinutosAtencion('45')).toEqual({ minutos: 45, error: null });
	});

	it('acepta el campo vacío como sin tiempo capturado', () => {
		expect(parsearMinutosAtencion('   ')).toEqual({ minutos: null, error: null });
	});

	it.each(['media hora', '12.5', '4m'])('rechaza el texto no entero %s', (texto) => {
		expect(parsearMinutosAtencion(texto).error).toBe('El tiempo debe ser un número entero de minutos');
	});

	it.each(['0', '-5', '1441'])('rechaza el tiempo fuera de rango %s', (texto) => {
		expect(parsearMinutosAtencion(texto).error).toBe('El tiempo debe estar entre 1 y 1440 minutos');
	});
});

describe('formatearMinutosAtencion', () => {
	it('muestra horas y minutos cuando pasa de una hora', () => {
		expect(formatearMinutosAtencion(95)).toBe('1 h 35 min');
	});

	it('muestra horas exactas sin minutos sobrantes', () => {
		expect(formatearMinutosAtencion(120)).toBe('2 h');
	});

	it('muestra solo minutos abajo de una hora', () => {
		expect(formatearMinutosAtencion(45)).toBe('45 min');
	});

	it('muestra un guion cuando no hay tiempo capturado', () => {
		expect(formatearMinutosAtencion(null)).toBe('—');
	});
});
