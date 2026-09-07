import { describe, expect, it } from 'vitest';
import {
	ALTO_ARENA,
	ANCHO_ARENA,
	botMasCercano,
	crearBotsIniciales,
	disparar,
	distancia,
	enemigosEliminados,
	jugadorFueGolpeado,
	limitarAArena,
	moverBotHaciaJugador,
	moverPunto
} from './brawlArena';

describe('limitarAArena', () => {
	it('mantiene un punto fuera de los límites dentro de la arena', () => {
		const p = limitarAArena({ x: -50, y: ALTO_ARENA + 999 });
		expect(p.x).toBeGreaterThanOrEqual(0);
		expect(p.x).toBeLessThanOrEqual(ANCHO_ARENA);
		expect(p.y).toBeGreaterThanOrEqual(0);
		expect(p.y).toBeLessThanOrEqual(ALTO_ARENA);
	});
});

describe('moverPunto', () => {
	it('desplaza el punto en la dirección dada', () => {
		const p = moverPunto({ x: 0, y: 0 }, 1, 0, 4);
		expect(p.x).toBe(4);
		expect(p.y).toBe(0);
	});
});

describe('moverBotHaciaJugador', () => {
	it('acerca al bot hacia el jugador', () => {
		const bot = { x: 0, y: 0 };
		const jugador = { x: 100, y: 0 };
		const nuevo = moverBotHaciaJugador(bot, jugador, 5);
		expect(distancia(nuevo, jugador)).toBeLessThan(distancia(bot, jugador));
	});
});

describe('crearBotsIniciales', () => {
	it('crea la cantidad pedida, todos vivos, en posiciones distintas', () => {
		const bots = crearBotsIniciales(3);
		expect(bots).toHaveLength(3);
		expect(bots.every((b) => b.vivo)).toBe(true);
		const posiciones = new Set(bots.map((b) => `${b.pos.x},${b.pos.y}`));
		expect(posiciones.size).toBe(3);
	});
});

describe('disparar', () => {
	it('elimina solo al bot vivo más cercano dentro de alcance', () => {
		const jugador = { x: 0, y: 0 };
		const bots = [
			{ id: 0, pos: { x: 10, y: 0 }, vivo: true },
			{ id: 1, pos: { x: 50, y: 0 }, vivo: true }
		];
		const resultado = disparar(jugador, bots, 100);
		expect(resultado.find((b) => b.id === 0)?.vivo).toBe(false);
		expect(resultado.find((b) => b.id === 1)?.vivo).toBe(true);
	});

	it('no elimina a nadie si está fuera de alcance', () => {
		const jugador = { x: 0, y: 0 };
		const bots = [{ id: 0, pos: { x: 500, y: 0 }, vivo: true }];
		const resultado = disparar(jugador, bots, 50);
		expect(resultado.find((b) => b.id === 0)?.vivo).toBe(true);
	});
});

describe('botMasCercano', () => {
	it('devuelve null si no hay bots vivos', () => {
		expect(botMasCercano({ x: 0, y: 0 }, [{ id: 0, pos: { x: 1, y: 1 }, vivo: false }])).toBeNull();
	});
});

describe('jugadorFueGolpeado', () => {
	it('detecta contacto con un bot vivo cercano', () => {
		const jugador = { x: 0, y: 0 };
		const bots = [{ id: 0, pos: { x: 5, y: 0 }, vivo: true }];
		expect(jugadorFueGolpeado(jugador, bots, 20)).toBe(true);
	});

	it('ignora bots eliminados', () => {
		const jugador = { x: 0, y: 0 };
		const bots = [{ id: 0, pos: { x: 5, y: 0 }, vivo: false }];
		expect(jugadorFueGolpeado(jugador, bots, 20)).toBe(false);
	});
});

describe('enemigosEliminados', () => {
	it('cuenta los bots no vivos', () => {
		const bots = [
			{ id: 0, pos: { x: 0, y: 0 }, vivo: false },
			{ id: 1, pos: { x: 0, y: 0 }, vivo: false },
			{ id: 2, pos: { x: 0, y: 0 }, vivo: true }
		];
		expect(enemigosEliminados(bots)).toBe(2);
	});
});
