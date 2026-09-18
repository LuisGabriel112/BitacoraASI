import { describe, it, expect } from 'vitest';
import { calcularVolumenSistemas } from './volumenSistemas';

describe('calcularVolumenSistemas', () => {
	it('ordena los sistemas de mayor a menor volumen', () => {
		const filas = calcularVolumenSistemas({ Mediport: 4, Pis: 9, Proactivanet: 2 });

		expect(filas.map((f) => f.nombre)).toEqual(['Pis', 'Mediport', 'Proactivanet']);
		expect(filas[0].total).toBe(9);
		expect(filas[2].total).toBe(2);
	});

	it('mide la fracción contra el sistema más alto', () => {
		const filas = calcularVolumenSistemas({ Mediport: 5, Pis: 10 });

		expect(filas[0].fraccion).toBe(1);
		expect(filas[1].fraccion).toBe(0.5);
	});

	it('devuelve una lista vacía cuando no hay registros', () => {
		expect(calcularVolumenSistemas({})).toEqual([]);
	});

	it('descarta los sistemas sin registros', () => {
		const filas = calcularVolumenSistemas({ Mediport: 3, Pis: 0 });

		expect(filas).toHaveLength(1);
		expect(filas[0].nombre).toBe('Mediport');
	});

	it('da fracción 1 a los sistemas empatados en el máximo', () => {
		const filas = calcularVolumenSistemas({ Mediport: 4, Pis: 4 });

		expect(filas.map((f) => f.fraccion)).toEqual([1, 1]);
	});
});
