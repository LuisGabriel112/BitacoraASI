import { describe, expect, it } from 'vitest';
import * as THREE from 'three';
import { MODELOS_ENEMIGO } from './modelosEnemigo';
import { CANTIDAD_VARIANTES_ENEMIGO, varianteEnemigo } from './varianteEnemigo';

const NOMBRES = [
	'Backlog Infinito',
	'El Ticket Zombie',
	'Cuello de Botella',
	'El Bug Legendario',
	'Sobrecarga de Turno',
	'El SLA Vencido'
];

function construirGrupo(indice: number): THREE.Group {
	const grupo = new THREE.Group();
	const material = new THREE.MeshStandardMaterial({ color: MODELOS_ENEMIGO[indice].color });
	MODELOS_ENEMIGO[indice].construir(grupo, material, 0xff3b30, 1.2);
	return grupo;
}

describe('MODELOS_ENEMIGO', () => {
	it('tiene al menos 14 modelos', () => {
		expect(MODELOS_ENEMIGO.length).toBeGreaterThanOrEqual(14);
	});

	it('coincide con la cantidad de variantes usada por el hash', () => {
		expect(MODELOS_ENEMIGO.length).toBe(CANTIDAD_VARIANTES_ENEMIGO);
	});

	it('cada modelo declara constructor y color', () => {
		for (const modelo of MODELOS_ENEMIGO) {
			expect(typeof modelo.construir).toBe('function');
			expect(typeof modelo.color).toBe('number');
		}
	});

	it('cada modelo arma al menos una malla', () => {
		for (let i = 0; i < MODELOS_ENEMIGO.length; i++) {
			expect(construirGrupo(i).children.length).toBeGreaterThan(0);
		}
	});

	it('la variante de cualquier nombre apunta a un modelo existente', () => {
		for (const nombre of NOMBRES) {
			expect(MODELOS_ENEMIGO[varianteEnemigo(nombre)]).toBeDefined();
		}
	});
});
