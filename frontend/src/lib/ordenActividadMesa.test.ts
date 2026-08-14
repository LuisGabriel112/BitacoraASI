import { describe, expect, it } from 'vitest';
import { ordenarPorActividadReciente } from './ordenActividadMesa';

function mesa(id: number, fecha_carga: string, fecha_cierre_real: string | null = null) {
	return { id, fecha_carga, fecha_cierre_real };
}

describe('ordenarPorActividadReciente', () => {
	it('una mesa recien cerrada sube por encima de una abierta mas nueva', () => {
		const abierta = mesa(1, '2026-08-13T08:00:00');
		const cerrada = mesa(2, '2026-08-10T09:00:00', '2026-08-13T09:00:00');

		expect(ordenarPorActividadReciente([abierta, cerrada])).toEqual([cerrada, abierta]);
	});

	it('entre dos cerradas, la que cerro mas tarde va primero', () => {
		const cerradaAntes = mesa(1, '2026-08-01T09:00:00', '2026-08-10T09:00:00');
		const cerradaDespues = mesa(2, '2026-08-01T09:00:00', '2026-08-12T09:00:00');

		expect(ordenarPorActividadReciente([cerradaAntes, cerradaDespues])).toEqual([cerradaDespues, cerradaAntes]);
	});

	it('una mesa sin cerrar usa su fecha de carga', () => {
		const vieja = mesa(1, '2026-08-01T09:00:00');
		const nueva = mesa(2, '2026-08-13T09:00:00');

		expect(ordenarPorActividadReciente([vieja, nueva])).toEqual([nueva, vieja]);
	});

	it('no modifica el arreglo original', () => {
		const original = [mesa(1, '2026-08-01T09:00:00'), mesa(2, '2026-08-13T09:00:00')];
		const copia = [...original];

		ordenarPorActividadReciente(original);

		expect(original).toEqual(copia);
	});
});
