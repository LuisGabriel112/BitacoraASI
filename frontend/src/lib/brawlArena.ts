export interface Punto {
	x: number;
	y: number;
}

export interface Direccion {
	dx: number;
	dy: number;
}

export interface Muro {
	x: number;
	y: number;
	ancho: number;
	alto: number;
}

export const ANCHO_ARENA = 360;
export const ALTO_ARENA = 260;
export const RADIO_PERSONAJE = 11;
export const VELOCIDAD_JUGADOR = 3.2;
export const VELOCIDAD_BOT = 1.15;

export const POSICION_INICIAL_JUGADOR: Punto = { x: ANCHO_ARENA / 2, y: ALTO_ARENA / 2 };

/** Coberturas fijas: dan al jugador dónde esconderse de los disparos enemigos,
 *  que es lo que vuelve la arena un duelo y no una persecución en campo abierto. */
export const MUROS: Muro[] = [
	{ x: 60, y: 170, ancho: 40, alto: 44 },
	{ x: 160, y: 40, ancho: 40, alto: 40 },
	{ x: 260, y: 160, ancho: 40, alto: 44 }
];

export function distancia(a: Punto, b: Punto): number {
	return Math.hypot(a.x - b.x, a.y - b.y);
}

export function direccionHacia(desde: Punto, hacia: Punto): Direccion {
	const dist = distancia(desde, hacia) || 1;
	return { dx: (hacia.x - desde.x) / dist, dy: (hacia.y - desde.y) / dist };
}

export function limitarAArena(p: Punto, radio: number): Punto {
	return {
		x: Math.min(ANCHO_ARENA - radio, Math.max(radio, p.x)),
		y: Math.min(ALTO_ARENA - radio, Math.max(radio, p.y))
	};
}

export function dentroDeArena(p: Punto): boolean {
	return p.x >= 0 && p.x <= ANCHO_ARENA && p.y >= 0 && p.y <= ALTO_ARENA;
}

function invadeMuro(p: Punto, muro: Muro, radio: number): boolean {
	return (
		p.x > muro.x - radio &&
		p.x < muro.x + muro.ancho + radio &&
		p.y > muro.y - radio &&
		p.y < muro.y + muro.alto + radio
	);
}

export function tocaMuro(p: Punto, radio: number): boolean {
	return MUROS.some((muro) => invadeMuro(p, muro, radio));
}

/** Intenta el movimiento completo y, si un muro lo bloquea, prueba cada eje por
 *  separado — así el personaje se desliza pegado al muro en vez de trabarse. */
export function moverConColision(
	desde: Punto,
	dx: number,
	dy: number,
	velocidad: number,
	radio: number
): Punto {
	const candidatos = [
		{ x: desde.x + dx * velocidad, y: desde.y + dy * velocidad },
		{ x: desde.x + dx * velocidad, y: desde.y },
		{ x: desde.x, y: desde.y + dy * velocidad }
	];
	for (const candidato of candidatos) {
		const destino = limitarAArena(candidato, radio);
		if (!tocaMuro(destino, radio)) return destino;
	}
	return desde;
}
