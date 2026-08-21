import { describe, expect, it } from 'vitest';
import { sugerenciasParaCategoria, sugerenciasPorTexto, type SintesisConCategoria } from './sugerenciasSolucion';

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

function sintesisConTitulo(id: number, titulo: string, texto = `x${id}`): SintesisConCategoria {
	return { id, categoria: { id: 1, nombre: 'cat-1' }, titulo, texto };
}

describe('sugerenciasPorTexto', () => {
	const lista = [sintesisConTitulo(1, 'Reinicio de servicio'), sintesisConTitulo(2, 'Cambio de contraseña')];

	it('filtra por coincidencia en el título, sin distinguir mayúsculas', () => {
		expect(sugerenciasPorTexto(lista, 'reinicio')).toEqual([lista[0]]);
	});

	it('filtra por coincidencia en el cuerpo del texto', () => {
		const conTexto = [sintesisConTitulo(1, 'Solución previa', 'Se reinició el servicio de impresión')];
		expect(sugerenciasPorTexto(conTexto, 'impresión')).toEqual(conTexto);
	});

	it('devuelve vacio si el texto escrito no coincide con nada', () => {
		expect(sugerenciasPorTexto(lista, 'xyz')).toEqual([]);
	});

	it('devuelve todas las sugerencias si aun no se ha escrito nada', () => {
		expect(sugerenciasPorTexto(lista, '   ')).toEqual(lista);
	});
});
