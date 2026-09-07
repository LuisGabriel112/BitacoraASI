import { describe, expect, it } from 'vitest';
import { generarBanderines } from './papelPicado';

describe('generarBanderines', () => {
	it('genera la cantidad pedida', () => {
		expect(generarBanderines(9)).toHaveLength(9);
	});

	it('rota los colores verde, blanco, rojo en orden', () => {
		const colores = generarBanderines(6).map((b) => b.color);
		expect(colores).toEqual(['verde', 'blanco', 'rojo', 'verde', 'blanco', 'rojo']);
	});

	it('aumenta el retraso de animación en cada banderín', () => {
		const retrasos = generarBanderines(4).map((b) => b.retrasoMs);
		for (let i = 1; i < retrasos.length; i++) {
			expect(retrasos[i]).toBeGreaterThan(retrasos[i - 1]);
		}
	});

	it('devuelve una lista vacía si se piden cero banderines', () => {
		expect(generarBanderines(0)).toEqual([]);
	});
});
