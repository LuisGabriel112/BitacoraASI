import * as THREE from 'three';
import type { Accesorio, Cara, Espalda, FormaCuerpo } from './api/client';

type Proporciones = { torso: [number, number, number]; extremidad: number; cabeza: number };

const PROPORCIONES: Record<FormaCuerpo, Proporciones> = {
	normal: { torso: [1, 1.2, 0.6], extremidad: 0.35, cabeza: 0.9 },
	robusto: { torso: [1.35, 1.15, 0.8], extremidad: 0.45, cabeza: 1 },
	delgado: { torso: [0.75, 1.3, 0.5], extremidad: 0.26, cabeza: 0.8 }
};

const ALTURA_CABEZA = 1.55;

function malla(geometria: THREE.BufferGeometry, material: THREE.Material, posicion: [number, number, number]) {
	const pieza = new THREE.Mesh(geometria, material);
	pieza.position.set(...posicion);
	return pieza;
}

function espejar(grupo: THREE.Group, pieza: THREE.Mesh) {
	grupo.add(pieza);
	const copia = pieza.clone();
	copia.position.x = -pieza.position.x;
	grupo.add(copia);
}

export function construirCuerpo(
	grupo: THREE.Group,
	forma: FormaCuerpo,
	colorPiel: number,
	colorCuerpo: number
) {
	const { torso, extremidad, cabeza } = PROPORCIONES[forma];
	const matPiel = new THREE.MeshStandardMaterial({ color: colorPiel });
	const matCuerpo = new THREE.MeshStandardMaterial({ color: colorCuerpo });

	grupo.add(malla(new THREE.BoxGeometry(cabeza, cabeza, cabeza), matPiel, [0, ALTURA_CABEZA, 0]));
	grupo.add(malla(new THREE.BoxGeometry(...torso), matCuerpo, [0, 0.6, 0]));
	espejar(
		grupo,
		malla(new THREE.BoxGeometry(extremidad, 1.1, extremidad), matPiel, [torso[0] / 2 + extremidad / 2, 0.6, 0])
	);
	espejar(
		grupo,
		malla(new THREE.BoxGeometry(extremidad + 0.05, 1.1, extremidad + 0.05), matCuerpo, [torso[0] / 3, -0.55, 0])
	);
}

function ojos(grupo: THREE.Group, material: THREE.Material, radio: number, separacion: number) {
	espejar(grupo, malla(new THREE.SphereGeometry(radio, 10, 10), material, [separacion, ALTURA_CABEZA + 0.08, 0.46]));
}

function boca(grupo: THREE.Group, material: THREE.Material, ancho: number, alto: number, y: number) {
	grupo.add(malla(new THREE.BoxGeometry(ancho, alto, 0.05), material, [0, y, 0.46]));
}

function caraFeliz(grupo: THREE.Group, material: THREE.Material) {
	ojos(grupo, material, 0.07, 0.18);
	boca(grupo, material, 0.3, 0.06, ALTURA_CABEZA - 0.22);
}

function caraSeria(grupo: THREE.Group, material: THREE.Material) {
	ojos(grupo, material, 0.06, 0.18);
	boca(grupo, material, 0.22, 0.04, ALTURA_CABEZA - 0.2);
}

function caraEnojada(grupo: THREE.Group, material: THREE.Material) {
	ojos(grupo, material, 0.06, 0.18);
	const ceja = malla(new THREE.BoxGeometry(0.2, 0.05, 0.05), material, [0.18, ALTURA_CABEZA + 0.22, 0.46]);
	ceja.rotation.z = -0.4;
	espejar(grupo, ceja);
	boca(grupo, material, 0.26, 0.05, ALTURA_CABEZA - 0.24);
}

function caraKawaii(grupo: THREE.Group, material: THREE.Material) {
	ojos(grupo, material, 0.11, 0.2);
	boca(grupo, material, 0.12, 0.08, ALTURA_CABEZA - 0.2);
	const rubor = new THREE.MeshStandardMaterial({ color: 0xff8fa3 });
	espejar(grupo, malla(new THREE.SphereGeometry(0.08, 8, 8), rubor, [0.33, ALTURA_CABEZA - 0.12, 0.38]));
}

function caraRobot(grupo: THREE.Group, material: THREE.Material) {
	const visorCara = new THREE.MeshStandardMaterial({
		color: 0x35e0d0,
		emissive: 0x35e0d0,
		emissiveIntensity: 0.8
	});
	grupo.add(malla(new THREE.BoxGeometry(0.62, 0.18, 0.06), visorCara, [0, ALTURA_CABEZA + 0.1, 0.46]));
	boca(grupo, material, 0.34, 0.08, ALTURA_CABEZA - 0.24);
}

const CARAS_3D: Record<Cara, (grupo: THREE.Group, material: THREE.Material) => void> = {
	feliz: caraFeliz,
	serio: caraSeria,
	enojado: caraEnojada,
	kawaii: caraKawaii,
	robot: caraRobot
};

export function agregarCara(grupo: THREE.Group, cara: Cara, colorDetalle: number) {
	CARAS_3D[cara](grupo, new THREE.MeshStandardMaterial({ color: colorDetalle }));
}

function gorra(grupo: THREE.Group, material: THREE.Material) {
	grupo.add(malla(new THREE.CylinderGeometry(0.5, 0.55, 0.3, 16), material, [0, 2.05, 0]));
	grupo.add(malla(new THREE.BoxGeometry(0.6, 0.06, 0.4), material, [0, 1.95, 0.4]));
}

function casco(grupo: THREE.Group, material: THREE.Material) {
	const metal = new THREE.MeshStandardMaterial({ color: 0xcccccc, metalness: 0.6, roughness: 0.3 });
	grupo.add(malla(new THREE.SphereGeometry(0.55, 16, 16), metal, [0, 1.6, 0]));
	grupo.add(malla(new THREE.BoxGeometry(0.12, 0.3, 0.12), material, [0, 2.25, 0]));
}

function antenas(grupo: THREE.Group, material: THREE.Material) {
	espejar(grupo, malla(new THREE.CylinderGeometry(0.03, 0.03, 0.5), material, [0.25, 2.25, 0]));
	espejar(grupo, malla(new THREE.SphereGeometry(0.08, 8, 8), material, [0.25, 2.5, 0]));
}

function sombrero(grupo: THREE.Group, material: THREE.Material) {
	grupo.add(malla(new THREE.CylinderGeometry(0.85, 0.85, 0.06, 20), material, [0, 2.0, 0]));
	grupo.add(malla(new THREE.CylinderGeometry(0.42, 0.45, 0.45, 16), material, [0, 2.22, 0]));
}

function diadema(grupo: THREE.Group, material: THREE.Material) {
	const aro = malla(new THREE.TorusGeometry(0.46, 0.05, 8, 20), material, [0, 2.0, 0]);
	aro.rotation.x = Math.PI / 2;
	grupo.add(aro);
	espejar(grupo, malla(new THREE.SphereGeometry(0.1, 8, 8), material, [0.3, 2.18, 0]));
}

function aureola(grupo: THREE.Group) {
	const dorado = new THREE.MeshStandardMaterial({ color: 0xffd34d, emissive: 0xffd34d, emissiveIntensity: 0.6 });
	const anillo = malla(new THREE.TorusGeometry(0.42, 0.06, 10, 24), dorado, [0, 2.35, 0]);
	anillo.rotation.x = Math.PI / 2;
	grupo.add(anillo);
}

function cuernos(grupo: THREE.Group, material: THREE.Material) {
	const cuerno = malla(new THREE.ConeGeometry(0.14, 0.55, 8), material, [0.3, 2.2, 0]);
	cuerno.rotation.z = -0.35;
	espejar(grupo, cuerno);
}

function visor(grupo: THREE.Group, material: THREE.Material) {
	const cristal = new THREE.MeshStandardMaterial({ color: 0x35e0d0, metalness: 0.4, roughness: 0.2 });
	grupo.add(malla(new THREE.BoxGeometry(0.95, 0.24, 0.12), cristal, [0, 1.72, 0.4]));
	espejar(grupo, malla(new THREE.BoxGeometry(0.1, 0.08, 0.5), material, [0.45, 1.72, 0.1]));
}

function corona(grupo: THREE.Group, material: THREE.Material) {
	grupo.add(malla(new THREE.CylinderGeometry(0.46, 0.46, 0.22, 12, 1, true), material, [0, 2.1, 0]));
	for (let i = 0; i < 5; i++) {
		const angulo = (i / 5) * Math.PI * 2;
		const punta: [number, number, number] = [Math.cos(angulo) * 0.42, 2.32, Math.sin(angulo) * 0.42];
		grupo.add(malla(new THREE.ConeGeometry(0.09, 0.26, 6), material, punta));
	}
}

const ACCESORIOS_3D: Record<Accesorio, ((grupo: THREE.Group, material: THREE.Material) => void) | null> = {
	ninguno: null,
	gorra,
	casco,
	antenas,
	sombrero,
	diadema,
	aureola,
	cuernos,
	visor,
	corona
};

export function agregarAccesorio(grupo: THREE.Group, accesorio: Accesorio, colorDetalle: number) {
	const construir = ACCESORIOS_3D[accesorio];
	if (!construir) return;
	construir(grupo, new THREE.MeshStandardMaterial({ color: colorDetalle }));
}

function capa(grupo: THREE.Group, material: THREE.Material) {
	const tela = malla(new THREE.BoxGeometry(1.1, 1.6, 0.08), material, [0, 0.5, -0.42]);
	tela.rotation.x = 0.12;
	grupo.add(tela);
	grupo.add(malla(new THREE.BoxGeometry(0.9, 0.1, 0.12), material, [0, 1.15, -0.36]));
}

function mochila(grupo: THREE.Group, material: THREE.Material) {
	grupo.add(malla(new THREE.BoxGeometry(0.75, 0.85, 0.35), material, [0, 0.7, -0.5]));
	espejar(grupo, malla(new THREE.BoxGeometry(0.1, 0.9, 0.08), material, [0.25, 0.75, -0.28]));
}

function alas(grupo: THREE.Group, material: THREE.Material) {
	const ala = malla(new THREE.BoxGeometry(0.9, 0.9, 0.06), material, [0.75, 0.85, -0.4]);
	ala.rotation.z = 0.35;
	ala.rotation.y = -0.3;
	espejar(grupo, ala);
}

const ESPALDAS_3D: Record<Espalda, ((grupo: THREE.Group, material: THREE.Material) => void) | null> = {
	ninguna: null,
	capa,
	mochila,
	alas
};

export function agregarEspalda(grupo: THREE.Group, espalda: Espalda, colorDetalle: number) {
	const construir = ESPALDAS_3D[espalda];
	if (!construir) return;
	construir(grupo, new THREE.MeshStandardMaterial({ color: colorDetalle }));
}
