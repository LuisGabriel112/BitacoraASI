/** Matemática de la capa visual 3D, aparte de three.js para poder probarla.
 *  La arena del servidor es un plano 2D de 360x260 con el origen arriba a la
 *  izquierda; el mundo 3D la centra en el origen y usa la profundidad (z) como
 *  el eje vertical de la arena. */

const ANCHO_ARENA = 360;
const ALTO_ARENA = 260;
/** Deja la arena en 4.5 x 3.25 unidades de mundo. Tiene que ir a la par del
 *  tamaño de los personajes (radio 0.11) y de la altura de la cámara: con una
 *  escala de 0.1 la arena medía 36 x 26 y quedaba entera fuera de cuadro. */
export const ESCALA_MUNDO = 0.0125;

export const ANCHO_MUNDO = ANCHO_ARENA * ESCALA_MUNDO;
export const ALTO_MUNDO = ALTO_ARENA * ESCALA_MUNDO;

export const DURACION_SACUDIDA_MS = 300;
export const DURACION_PARTICULA_MS = 700;

const GRAVEDAD_PARTICULA = 9;
const ALTURA_REBOTE = 0.06;
const PERIODO_REBOTE_MS = 190;

const VERDE = 0x3b9b6f;
const AMBAR = 0xd97706;
const ROJO = 0xc1443c;

export interface PuntoMundo {
	x: number;
	z: number;
}

export interface Particula {
	x: number;
	y: number;
	z: number;
	vx: number;
	vy: number;
	vz: number;
	nacida: number;
	color: number;
}

export function aMundo(x: number, y: number): PuntoMundo {
	return {
		x: (x - ANCHO_ARENA / 2) * ESCALA_MUNDO,
		z: (y - ALTO_ARENA / 2) * ESCALA_MUNDO
	};
}

/** Decae linealmente: una sacudida que no se apaga sola deja la cámara temblando
 *  para siempre en cuanto se encadenan dos impactos. */
export function intensidadSacudida(
	inicial: number,
	inicio: number,
	ahora: number,
	duracion = DURACION_SACUDIDA_MS
): number {
	const restante = 1 - (ahora - inicio) / duracion;
	return Math.max(0, inicial * restante);
}

export function colorVida(fraccion: number): number {
	if (fraccion > 0.6) return VERDE;
	if (fraccion > 0.25) return AMBAR;
	return ROJO;
}

export function crearParticulas(cantidad: number, x: number, y: number, z: number, color = ROJO): Particula[] {
	return Array.from({ length: cantidad }, (_, i) => {
		const angulo = (i / cantidad) * Math.PI * 2;
		return {
			x,
			y,
			z,
			vx: Math.cos(angulo) * 1.6,
			vy: 2.4 + (i % 3) * 0.5,
			vz: Math.sin(angulo) * 1.6,
			nacida: 0,
			color
		};
	});
}

export function posicionParticula(
	p: Particula,
	transcurridoMs: number
): { x: number; y: number; z: number; opacidad: number } {
	const t = transcurridoMs / 1000;
	return {
		x: p.x + p.vx * t,
		y: p.y + p.vy * t - GRAVEDAD_PARTICULA * t * t,
		z: p.z + p.vz * t,
		opacidad: Math.max(0, 1 - transcurridoMs / DURACION_PARTICULA_MS)
	};
}

export function particulaViva(p: Particula, transcurridoMs: number): boolean {
	return transcurridoMs < DURACION_PARTICULA_MS;
}

/** Rebote de caminata: solo cuando el personaje se mueve, para que quieto se vea
 *  quieto y en movimiento se sienta que pisa. */
export function alturaRebote(tiempoMs: number, velocidad: number): number {
	if (velocidad <= 0) return 0;
	return Math.abs(Math.sin((tiempoMs / PERIODO_REBOTE_MS) * Math.PI)) * ALTURA_REBOTE;
}
