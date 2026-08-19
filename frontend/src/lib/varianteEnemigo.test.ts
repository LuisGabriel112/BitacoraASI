import { describe, expect, it } from 'vitest';
import { CANTIDAD_VARIANTES_ENEMIGO, varianteEnemigo } from './varianteEnemigo';

describe('varianteEnemigo', () => {
	it('es determinista para el mismo nombre', () => {
		expect(varianteEnemigo('El SLA Vencido')).toBe(varianteEnemigo('El SLA Vencido'));
	});

	it('siempre devuelve un indice dentro de rango', () => {
		const nombres = ['Backlog Infinito', 'El Ticket Zombie', 'Cuello de Botella', 'El Bug Legendario'];
		for (const nombre of nombres) {
			const v = varianteEnemigo(nombre);
			expect(v).toBeGreaterThanOrEqual(0);
			expect(v).toBeLessThan(CANTIDAD_VARIANTES_ENEMIGO);
		}
	});

	it('nombres distintos no estan forzados a la misma variante', () => {
		const nombres = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'];
		const variantes = new Set(nombres.map(varianteEnemigo));
		expect(variantes.size).toBeGreaterThan(1);
	});
});
