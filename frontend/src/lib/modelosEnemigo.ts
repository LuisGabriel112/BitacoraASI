import * as THREE from 'three';

export type ConstructorEnemigo = (
	grupo: THREE.Group,
	matCuerpo: THREE.Material,
	colorOjos: number,
	intensidadOjos: number
) => void;

export type ModeloEnemigo = {
	nombre: string;
	color: number;
	construir: ConstructorEnemigo;
};

type Punto = [number, number, number];

const OFFSETS_PINCHOS: Punto[] = [
	[0.6, 0.6, 0.3],
	[-0.6, 0.6, 0.3],
	[0, 0.9, -0.5],
	[0.55, -0.5, 0.45],
	[-0.55, -0.5, 0.45],
	[0, -0.3, -0.85]
];

export function agregarPinchos(grupo: THREE.Group, offsets: Punto[], color: number) {
	const material = new THREE.MeshStandardMaterial({ color, flatShading: true });
	for (const [x, y, z] of offsets) {
		const pincho = new THREE.Mesh(new THREE.ConeGeometry(0.18, 0.55, 6), material);
		const direccion = new THREE.Vector3(x, y, z).normalize();
		pincho.quaternion.setFromUnitVectors(new THREE.Vector3(0, 1, 0), direccion);
		pincho.position.set(x, y, z);
		grupo.add(pincho);
	}
}

export function agregarOjosEn(
	grupo: THREE.Group,
	posiciones: Punto[],
	color: number,
	intensidad: number,
	radio = 0.14
) {
	const material = new THREE.MeshStandardMaterial({ color, emissive: color, emissiveIntensity: intensidad });
	for (const [x, y, z] of posiciones) {
		const ojo = new THREE.Mesh(new THREE.SphereGeometry(radio, 12, 12), material);
		ojo.position.set(x, y, z);
		grupo.add(ojo);
	}
}

function colorDe(material: THREE.Material): number {
	return (material as THREE.MeshStandardMaterial).color.getHex();
}

function construirErizo(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	grupo.add(new THREE.Mesh(new THREE.IcosahedronGeometry(0.9, 0), matCuerpo));
	agregarPinchos(grupo, OFFSETS_PINCHOS, 0x1a1a1a);
	agregarOjosEn(grupo, [[-0.3, 0.15, 0.75], [0.3, 0.15, 0.75]], colorOjos, intensidad);
}

function construirCuernos(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	grupo.add(new THREE.Mesh(new THREE.BoxGeometry(1.3, 1.3, 1.3), matCuerpo));
	const cuerno = new THREE.Mesh(new THREE.ConeGeometry(0.14, 0.6, 5), matCuerpo);
	cuerno.position.set(-0.35, 0.95, 0);
	cuerno.rotation.z = -0.3;
	grupo.add(cuerno);
	const cuernoDer = cuerno.clone();
	cuernoDer.position.x = 0.35;
	cuernoDer.rotation.z = 0.3;
	grupo.add(cuernoDer);
	agregarOjosEn(grupo, [[-0.28, 0.1, 0.68], [0.28, 0.1, 0.68]], colorOjos, intensidad);
}

function construirCiclope(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	grupo.add(new THREE.Mesh(new THREE.SphereGeometry(1.0, 10, 8), matCuerpo));
	const tentaculos: Punto[] = [
		[-0.5, -0.9, 0.2],
		[-0.15, -1.0, -0.2],
		[0.15, -1.0, 0.2],
		[0.5, -0.9, -0.2]
	];
	agregarPinchos(grupo, tentaculos, colorDe(matCuerpo));
	agregarOjosEn(grupo, [[0, 0.15, 0.9]], colorOjos, intensidad, 0.3);
}

function construirSlime(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const cuerpo = new THREE.Mesh(new THREE.SphereGeometry(0.95, 10, 8), matCuerpo);
	cuerpo.scale.set(1.1, 0.65, 1.1);
	grupo.add(cuerpo);
	const goteos: Punto[] = [
		[-0.4, -0.55, 0.3],
		[0.1, -0.65, -0.3],
		[0.45, -0.5, 0.2]
	];
	for (const [x, y, z] of goteos) {
		const gota = new THREE.Mesh(new THREE.ConeGeometry(0.12, 0.3, 6), matCuerpo);
		gota.position.set(x, y, z);
		gota.rotation.x = Math.PI;
		grupo.add(gota);
	}
	agregarOjosEn(grupo, [[-0.28, 0.05, 0.7], [0.28, 0.05, 0.7]], colorOjos, intensidad);
}

function construirGusano(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const segmentos: [number, number][] = [
		[0.55, -0.6],
		[0.4, 0.15],
		[0.28, 0.75]
	];
	for (const [radio, y] of segmentos) {
		const segmento = new THREE.Mesh(new THREE.SphereGeometry(radio, 10, 8), matCuerpo);
		segmento.position.y = y;
		grupo.add(segmento);
	}
	agregarOjosEn(grupo, [[-0.16, 0.78, 0.24], [0.16, 0.78, 0.24]], colorOjos, intensidad, 0.09);
}

function construirCristal(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const nucleo = new THREE.Mesh(new THREE.OctahedronGeometry(1.05, 0), matCuerpo);
	nucleo.rotation.y = Math.PI / 6;
	grupo.add(nucleo);
	agregarOjosEn(grupo, [[-0.25, 0.05, 0.55], [0.25, 0.05, 0.55]], colorOjos, intensidad, 0.11);
}

function construirArana(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const abdomen = new THREE.Mesh(new THREE.SphereGeometry(0.75, 10, 8), matCuerpo);
	abdomen.position.z = -0.35;
	grupo.add(abdomen);
	const cabeza = new THREE.Mesh(new THREE.SphereGeometry(0.45, 10, 8), matCuerpo);
	cabeza.position.set(0, 0.05, 0.55);
	grupo.add(cabeza);
	const patas: Punto[] = [
		[-0.85, -0.35, 0.3],
		[-0.9, -0.2, -0.2],
		[0.85, -0.35, 0.3],
		[0.9, -0.2, -0.2]
	];
	agregarPinchos(grupo, patas, colorDe(matCuerpo));
	agregarOjosEn(grupo, [[-0.18, 0.2, 0.9], [0.18, 0.2, 0.9], [0, 0.35, 0.85]], colorOjos, intensidad, 0.08);
}

function construirTorre(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const bloques: [number, number][] = [
		[1.1, -0.7],
		[0.9, 0],
		[0.7, 0.7]
	];
	bloques.forEach(([ancho, y], indice) => {
		const bloque = new THREE.Mesh(new THREE.BoxGeometry(ancho, 0.6, ancho), matCuerpo);
		bloque.position.y = y;
		bloque.rotation.y = indice * 0.3;
		grupo.add(bloque);
	});
	agregarOjosEn(grupo, [[-0.18, 0.75, 0.38], [0.18, 0.75, 0.38]], colorOjos, intensidad, 0.1);
}

function construirFantasma(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const cuerpo = new THREE.Mesh(new THREE.CapsuleGeometry(0.62, 0.7, 6, 12), matCuerpo);
	cuerpo.position.y = 0.15;
	grupo.add(cuerpo);
	const flecos: Punto[] = [
		[-0.4, -0.75, 0.15],
		[0, -0.85, -0.15],
		[0.4, -0.75, 0.15]
	];
	for (const [x, y, z] of flecos) {
		const fleco = new THREE.Mesh(new THREE.ConeGeometry(0.2, 0.4, 6), matCuerpo);
		fleco.position.set(x, y, z);
		fleco.rotation.x = Math.PI;
		grupo.add(fleco);
	}
	agregarOjosEn(grupo, [[-0.24, 0.3, 0.55], [0.24, 0.3, 0.55]], colorOjos, intensidad, 0.12);
}

function construirGolem(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	grupo.add(new THREE.Mesh(new THREE.DodecahedronGeometry(0.85, 0), matCuerpo));
	const brazos: Punto[] = [
		[-0.95, 0.1, 0],
		[0.95, 0.1, 0]
	];
	for (const [x, y, z] of brazos) {
		const brazo = new THREE.Mesh(new THREE.BoxGeometry(0.45, 0.45, 0.45), matCuerpo);
		brazo.position.set(x, y, z);
		grupo.add(brazo);
	}
	agregarOjosEn(grupo, [[-0.22, 0.3, 0.7], [0.22, 0.3, 0.7]], colorOjos, intensidad, 0.1);
}

function construirMedusa(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const campana = new THREE.Mesh(new THREE.SphereGeometry(0.8, 12, 8, 0, Math.PI * 2, 0, Math.PI / 2), matCuerpo);
	campana.position.y = 0.2;
	grupo.add(campana);
	for (let i = 0; i < 6; i++) {
		const angulo = (i / 6) * Math.PI * 2;
		const tentaculo = new THREE.Mesh(new THREE.CylinderGeometry(0.06, 0.02, 1.0, 6), matCuerpo);
		tentaculo.position.set(Math.cos(angulo) * 0.45, -0.35, Math.sin(angulo) * 0.45);
		grupo.add(tentaculo);
	}
	agregarOjosEn(grupo, [[-0.25, 0.25, 0.6], [0.25, 0.25, 0.6]], colorOjos, intensidad, 0.1);
}

function construirDron(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	grupo.add(new THREE.Mesh(new THREE.BoxGeometry(0.8, 0.4, 0.8), matCuerpo));
	const aro = new THREE.Mesh(new THREE.TorusGeometry(0.95, 0.07, 8, 24), matCuerpo);
	aro.rotation.x = Math.PI / 2;
	grupo.add(aro);
	agregarOjosEn(grupo, [[0, 0.05, 0.45]], colorOjos, intensidad, 0.18);
}

function construirHidra(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const base = new THREE.Mesh(new THREE.SphereGeometry(0.7, 10, 8), matCuerpo);
	base.position.y = -0.45;
	grupo.add(base);
	const cuellos: Punto[] = [
		[-0.45, 0.55, 0],
		[0, 0.75, 0.1],
		[0.45, 0.55, 0]
	];
	for (const [x, y, z] of cuellos) {
		const cuello = new THREE.Mesh(new THREE.CapsuleGeometry(0.18, 0.5, 4, 8), matCuerpo);
		cuello.position.set(x, y, z);
		cuello.rotation.z = -x * 0.6;
		grupo.add(cuello);
	}
	agregarOjosEn(grupo, [[-0.45, 0.9, 0.18], [0, 1.1, 0.28], [0.45, 0.9, 0.18]], colorOjos, intensidad, 0.08);
}

function construirReloj(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const caja = new THREE.Mesh(new THREE.CylinderGeometry(0.85, 0.85, 0.35, 16), matCuerpo);
	caja.rotation.x = Math.PI / 2;
	grupo.add(caja);
	const manecillas: [number, number][] = [
		[0.6, 0.6],
		[0.45, -0.9]
	];
	for (const [largo, angulo] of manecillas) {
		const manecilla = new THREE.Mesh(new THREE.BoxGeometry(0.07, largo, 0.07), matCuerpo);
		manecilla.position.set(Math.sin(angulo) * largo * 0.4, Math.cos(angulo) * largo * 0.4, 0.22);
		manecilla.rotation.z = -angulo;
		grupo.add(manecilla);
	}
	agregarOjosEn(grupo, [[-0.3, 0.3, 0.25], [0.3, 0.3, 0.25]], colorOjos, intensidad, 0.1);
}

function construirPiramide(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidad: number) {
	const cuerpo = new THREE.Mesh(new THREE.TetrahedronGeometry(1.15, 0), matCuerpo);
	cuerpo.rotation.y = Math.PI / 4;
	grupo.add(cuerpo);
	const satelites: Punto[] = [
		[-0.9, 0.7, 0],
		[0.9, 0.7, 0]
	];
	for (const [x, y, z] of satelites) {
		const satelite = new THREE.Mesh(new THREE.OctahedronGeometry(0.22, 0), matCuerpo);
		satelite.position.set(x, y, z);
		grupo.add(satelite);
	}
	agregarOjosEn(grupo, [[0, 0.1, 0.62]], colorOjos, intensidad, 0.22);
}

export const MODELOS_ENEMIGO: ModeloEnemigo[] = [
	{ nombre: 'erizo', color: 0x5b1a2b, construir: construirErizo },
	{ nombre: 'cuernos', color: 0x1a4a5b, construir: construirCuernos },
	{ nombre: 'ciclope', color: 0x4a2f1a, construir: construirCiclope },
	{ nombre: 'slime', color: 0x2f5b1a, construir: construirSlime },
	{ nombre: 'gusano', color: 0x3a1a5b, construir: construirGusano },
	{ nombre: 'cristal', color: 0x1a2f5b, construir: construirCristal },
	{ nombre: 'arana', color: 0x3d1f1f, construir: construirArana },
	{ nombre: 'torre', color: 0x4a4420, construir: construirTorre },
	{ nombre: 'fantasma', color: 0x2a2a45, construir: construirFantasma },
	{ nombre: 'golem', color: 0x3c3c3c, construir: construirGolem },
	{ nombre: 'medusa', color: 0x1f4a44, construir: construirMedusa },
	{ nombre: 'dron', color: 0x24485c, construir: construirDron },
	{ nombre: 'hidra', color: 0x53321a, construir: construirHidra },
	{ nombre: 'reloj', color: 0x5b4a1a, construir: construirReloj },
	{ nombre: 'piramide', color: 0x40205b, construir: construirPiramide }
];
