import { describe, expect, it } from 'vitest';
import {
	ALTO_ARENA,
	ANCHO_ARENA,
	MUROS,
	POSICION_INICIAL_JUGADOR,
	RADIO_PERSONAJE,
	direccionHacia,
	distancia,
	limitarAArena,
	moverConColision,
	tocaMuro
} from './brawlArena';

const centroDe = (muro: (typeof MUROS)[number]) => ({
	x: muro.x + muro.ancho / 2,
	y: muro.y + muro.alto / 2
});

describe('limitarAArena', () => {
	it('mantiene un punto fuera de los límites dentro de la arena', () => {
		const p = limitarAArena({ x: -50, y: ALTO_ARENA + 999 }, RADIO_PERSONAJE);
		expect(p.x).toBeGreaterThanOrEqual(RADIO_PERSONAJE);
		expect(p.x).toBeLessThanOrEqual(ANCHO_ARENA - RADIO_PERSONAJE);
		expect(p.y).toBeGreaterThanOrEqual(RADIO_PERSONAJE);
		expect(p.y).toBeLessThanOrEqual(ALTO_ARENA - RADIO_PERSONAJE);
	});
});

describe('tocaMuro', () => {
	it('detecta un punto encima de un muro', () => {
		expect(tocaMuro(centroDe(MUROS[0]), RADIO_PERSONAJE)).toBe(true);
	});

	it('el punto de salida del jugador está libre', () => {
		expect(tocaMuro(POSICION_INICIAL_JUGADOR, RADIO_PERSONAJE)).toBe(false);
	});
});

describe('moverConColision', () => {
	it('avanza normalmente en zona libre', () => {
		const desde = POSICION_INICIAL_JUGADOR;
		const destino = moverConColision(desde, 0, -1, 5, RADIO_PERSONAJE);
		expect(destino.y).toBeLessThan(desde.y);
	});

	it('no atraviesa un muro pero se desliza por el eje libre', () => {
		const muro = MUROS[0];
		const pegado = {
			x: muro.x - RADIO_PERSONAJE - 1,
			y: muro.y + muro.alto / 2
		};
		const destino = moverConColision(pegado, 1, -1, 4, RADIO_PERSONAJE);

		expect(tocaMuro(destino, RADIO_PERSONAJE)).toBe(false);
		expect(destino.x).toBeLessThanOrEqual(pegado.x);
		expect(destino.y).toBeLessThan(pegado.y);
	});
});

describe('direccionHacia', () => {
	it('devuelve un vector normalizado', () => {
		const d = direccionHacia({ x: 0, y: 0 }, { x: 30, y: 40 });
		expect(Math.hypot(d.dx, d.dy)).toBeCloseTo(1);
		expect(d.dx).toBeCloseTo(0.6);
		expect(d.dy).toBeCloseTo(0.8);
	});

	it('no divide entre cero cuando origen y objetivo coinciden', () => {
		const d = direccionHacia({ x: 5, y: 5 }, { x: 5, y: 5 });
		expect(Number.isFinite(d.dx)).toBe(true);
		expect(Number.isFinite(d.dy)).toBe(true);
	});
});

describe('distancia', () => {
	it('calcula la distancia euclidiana', () => {
		expect(distancia({ x: 0, y: 0 }, { x: 3, y: 4 })).toBe(5);
	});
});
