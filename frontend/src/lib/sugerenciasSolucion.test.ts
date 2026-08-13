import { describe, expect, it } from 'vitest';
import { sugerenciasParaCategoria, type SintesisConCategoria } from './sugerenciasSolucion';

function sintesis(id: number, categoriaId: number): SintesisConCategoria {
	return { id, categoria: { id: categoriaId, nombre: `cat-${categoriaId}` }, titulo: `t${id}`, texto: `x${id}` };
}

describe('sugerenciasParaCategoria', () => {
	it('devuelve solo las sintesis de la categoria pedida, en orden', () => {
		const lista = [sintesis(1, 5), sintesis(2, 8), sintesis(3, 5)];
		expect(sugerenciasParaCategoria(lista, 5)).toEqual([sintesis(1, 5), sintesis(3, 5)]);
	});

	it('devuelve vacio si ninguna sintesis coincide con la categoria', () => {
		const lista = [sintesis(1, 5), sintesis(2, 8)];
		expect(sugerenciasParaCategoria(lista, 99)).toEqual([]);
	});

	it('devuelve vacio si no hay categoria seleccionada', () => {
		const lista = [sintesis(1, 5), sintesis(2, 8)];
		expect(sugerenciasParaCategoria(lista, null)).toEqual([]);
	});

	it('devuelve vacio si la lista de sintesis esta vacia', () => {
		expect(sugerenciasParaCategoria([], 5)).toEqual([]);
	});
});
