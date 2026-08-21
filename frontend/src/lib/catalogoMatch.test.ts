import { describe, expect, it } from 'vitest';
import { coincidenciaExacta, filtrarPorFragmento } from './catalogoMatch';

const opciones = [
	{ id: 1, nombre: 'Redes' },
	{ id: 2, nombre: 'Soporte' },
	{ id: 3, nombre: 'Infraestructura' }
];

describe('coincidenciaExacta', () => {
	it('encuentra la opción sin distinguir mayúsculas/minúsculas', () => {
		expect(coincidenciaExacta(opciones, 'soporte')).toEqual({ id: 2, nombre: 'Soporte' });
	});

	it('devuelve null si ninguna opción coincide exactamente', () => {
		expect(coincidenciaExacta(opciones, 'Redes y telecomunicaciones')).toBeNull();
	});

	it('ignora espacios sobrantes alrededor del texto buscado', () => {
		expect(coincidenciaExacta(opciones, '  Redes  ')).toEqual({ id: 1, nombre: 'Redes' });
	});

	it('devuelve null para texto vacío', () => {
		expect(coincidenciaExacta(opciones, '   ')).toBeNull();
	});
});

describe('filtrarPorFragmento', () => {
	const nombresPropios = [
		{ id: 1, nombre: 'Reyes Cicero, Sergio' },
		{ id: 2, nombre: 'Loperena Domínguez, Sergio Adolfo' }
	];

	it('encuentra el fragmento aunque esté a mitad del nombre', () => {
		expect(filtrarPorFragmento(nombresPropios, 'Sergio')).toEqual(nombresPropios);
	});

	it('no distingue mayúsculas ni minúsculas', () => {
		expect(filtrarPorFragmento(opciones, 'SOPOR')).toEqual([{ id: 2, nombre: 'Soporte' }]);
	});

	it('devuelve vacío si el fragmento no coincide con nada', () => {
		expect(filtrarPorFragmento(opciones, 'xyz')).toEqual([]);
	});

	it('devuelve todas las opciones si el texto está vacío', () => {
		expect(filtrarPorFragmento(opciones, '   ')).toEqual(opciones);
	});
});
