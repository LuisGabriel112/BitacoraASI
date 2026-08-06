import { describe, expect, it } from 'vitest';
import { coincidenciaExacta } from './catalogoMatch';

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
