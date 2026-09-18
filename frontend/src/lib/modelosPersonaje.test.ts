import { describe, expect, it } from 'vitest';
import * as THREE from 'three';
import { ACCESORIOS, CARAS, ESPALDAS, FORMAS_CUERPO } from './apariencia';
import { agregarAccesorio, agregarCara, agregarEspalda, construirCuerpo } from './modelosPersonaje';

const PIEL = 0xf2c9a1;
const CUERPO = 0x3b82f6;
const DETALLE = 0x222222;

function grupoNuevo(): THREE.Group {
	return new THREE.Group();
}

function colores(grupo: THREE.Group): number[] {
	const encontrados: number[] = [];
	grupo.traverse((objeto) => {
		if (objeto instanceof THREE.Mesh) {
			encontrados.push((objeto.material as THREE.MeshStandardMaterial).color.getHex());
		}
	});
	return encontrados;
}

function ancho(grupo: THREE.Group): number {
	return new THREE.Box3().setFromObject(grupo).getSize(new THREE.Vector3()).x;
}

describe('construirCuerpo', () => {
	it.each(FORMAS_CUERPO.map((f) => f.valor))('la complexion %s arma mallas', (forma) => {
		const grupo = grupoNuevo();
		construirCuerpo(grupo, forma, PIEL, CUERPO);
		expect(grupo.children.length).toBeGreaterThan(0);
	});

	it('la complexion robusta es mas ancha que la delgada', () => {
		const robusto = grupoNuevo();
		const delgado = grupoNuevo();
		construirCuerpo(robusto, 'robusto', PIEL, CUERPO);
		construirCuerpo(delgado, 'delgado', PIEL, CUERPO);
		expect(ancho(robusto)).toBeGreaterThan(ancho(delgado));
	});
});

describe('agregarCara', () => {
	it.each(CARAS.map((c) => c.valor))('la cara %s dibuja rasgos', (cara) => {
		const grupo = grupoNuevo();
		agregarCara(grupo, cara, DETALLE);
		expect(grupo.children.length).toBeGreaterThan(0);
	});
});

describe('agregarAccesorio', () => {
	it('el accesorio ninguno no agrega piezas', () => {
		const grupo = grupoNuevo();
		agregarAccesorio(grupo, 'ninguno', DETALLE);
		expect(grupo.children.length).toBe(0);
	});

	it.each(ACCESORIOS.filter((a) => a.valor !== 'ninguno').map((a) => a.valor))(
		'el accesorio %s agrega piezas',
		(accesorio) => {
			const grupo = grupoNuevo();
			agregarAccesorio(grupo, accesorio, DETALLE);
			expect(grupo.children.length).toBeGreaterThan(0);
		}
	);

	it('usa el color de detalle elegido', () => {
		const grupo = grupoNuevo();
		agregarAccesorio(grupo, 'gorra', 0xff0000);
		expect(colores(grupo)).toContain(0xff0000);
	});
});

describe('agregarEspalda', () => {
	it('la espalda ninguna no agrega piezas', () => {
		const grupo = grupoNuevo();
		agregarEspalda(grupo, 'ninguna', DETALLE);
		expect(grupo.children.length).toBe(0);
	});

	it.each(ESPALDAS.filter((e) => e.valor !== 'ninguna').map((e) => e.valor))(
		'la espalda %s agrega piezas',
		(espalda) => {
			const grupo = grupoNuevo();
			agregarEspalda(grupo, espalda, DETALLE);
			expect(grupo.children.length).toBeGreaterThan(0);
		}
	);
});
