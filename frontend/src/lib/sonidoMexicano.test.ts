import { describe, expect, it } from 'vitest';
import { notasFanfarriaMexicana } from './sonidoMexicano';

describe('notasFanfarriaMexicana', () => {
	it('genera 4 notas', () => {
		expect(notasFanfarriaMexicana()).toHaveLength(4);
	});

	it('las frecuencias son ascendentes', () => {
		const frecuencias = notasFanfarriaMexicana().map((n) => n.frecuenciaHz);
		for (let i = 1; i < frecuencias.length; i++) {
			expect(frecuencias[i]).toBeGreaterThan(frecuencias[i - 1]);
		}
	});

	it('cada nota empieza justo cuando termina la anterior', () => {
		const notas = notasFanfarriaMexicana();
		for (let i = 1; i < notas.length; i++) {
			expect(notas[i].inicioMs).toBe(notas[i - 1].inicioMs + notas[i - 1].duracionMs);
		}
	});

	it('la última nota se sostiene más que las demás', () => {
		const notas = notasFanfarriaMexicana();
		const ultima = notas[notas.length - 1];
		for (let i = 0; i < notas.length - 1; i++) {
			expect(ultima.duracionMs).toBeGreaterThan(notas[i].duracionMs);
		}
	});
});
