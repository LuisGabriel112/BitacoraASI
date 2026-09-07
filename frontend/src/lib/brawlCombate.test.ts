import { describe, expect, it } from 'vitest';
import { ANCHO_ARENA, MUROS } from './brawlArena';
import {
	CADENCIA_BOT_CUADROS,
	CANTIDAD_BOTS,
	DISTANCIA_PREFERIDA_BOT,
	VIDA_BOT,
	avanzarProyectiles,
	botDebeDisparar,
	crearBots,
	crearProyectil,
	direccionDeBot,
	eliminados,
	impactarBots,
	impactarJugador,
	todosEliminados,
	type Bot,
	type Proyectil
} from './brawlCombate';

const proyectil = (extra: Partial<Proyectil> = {}): Proyectil => ({
	id: 1,
	pos: { x: 100, y: 100 },
	dx: 1,
	dy: 0,
	aliado: true,
	...extra
});

const bot = (extra: Partial<Bot> = {}): Bot => ({
	id: 1,
	pos: { x: 100, y: 100 },
	vida: VIDA_BOT,
	...extra
});

describe('crearBots', () => {
	it('crea la cantidad pedida, con vida completa y posiciones distintas', () => {
		const bots = crearBots(3);
		expect(bots).toHaveLength(3);
		expect(bots.every((b) => b.vida === VIDA_BOT)).toBe(true);
		expect(new Set(bots.map((b) => `${b.pos.x},${b.pos.y}`)).size).toBe(3);
	});
});

describe('crearProyectil', () => {
	it('apunta al objetivo con dirección normalizada', () => {
		const p = crearProyectil(7, { x: 0, y: 0 }, { x: 50, y: 0 }, true);
		expect(p.dx).toBeCloseTo(1);
		expect(p.dy).toBeCloseTo(0);
		expect(p.id).toBe(7);
		expect(p.aliado).toBe(true);
	});
});

describe('avanzarProyectiles', () => {
	it('mueve el proyectil en su dirección', () => {
		const [movido] = avanzarProyectiles([proyectil()]);
		expect(movido.pos.x).toBeGreaterThan(100);
	});

	it('descarta el proyectil que sale de la arena', () => {
		const borde = proyectil({ pos: { x: ANCHO_ARENA - 1, y: 100 }, dx: 1, dy: 0 });
		expect(avanzarProyectiles([borde])).toHaveLength(0);
	});

	it('descarta el proyectil que pega en un muro', () => {
		const muro = MUROS[0];
		const centro = { x: muro.x + muro.ancho / 2, y: muro.y + muro.alto / 2 };
		expect(avanzarProyectiles([proyectil({ pos: centro })])).toHaveLength(0);
	});
});

describe('impactarBots', () => {
	it('un disparo aliado baja vida al bot y se consume', () => {
		const resultado = impactarBots([proyectil()], [bot()]);
		expect(resultado.bots[0].vida).toBe(VIDA_BOT - 1);
		expect(resultado.proyectiles).toHaveLength(0);
	});

	it('el bot con un punto de vida queda eliminado', () => {
		const resultado = impactarBots([proyectil()], [bot({ vida: 1 })]);
		expect(resultado.bots[0].vida).toBe(0);
		expect(eliminados(resultado.bots)).toBe(1);
	});

	it('un disparo enemigo no daña a los bots', () => {
		const resultado = impactarBots([proyectil({ aliado: false })], [bot()]);
		expect(resultado.bots[0].vida).toBe(VIDA_BOT);
		expect(resultado.proyectiles).toHaveLength(1);
	});

	it('un disparo lejos no daña a nadie', () => {
		const lejos = proyectil({ pos: { x: 10, y: 10 } });
		const resultado = impactarBots([lejos], [bot({ pos: { x: 300, y: 200 } })]);
		expect(resultado.bots[0].vida).toBe(VIDA_BOT);
		expect(resultado.proyectiles).toHaveLength(1);
	});
});

describe('impactarJugador', () => {
	it('un disparo enemigo encima golpea y se consume', () => {
		const resultado = impactarJugador([proyectil({ aliado: false })], { x: 100, y: 100 });
		expect(resultado.golpes).toBe(1);
		expect(resultado.proyectiles).toHaveLength(0);
	});

	it('un disparo aliado no golpea al jugador', () => {
		const resultado = impactarJugador([proyectil({ aliado: true })], { x: 100, y: 100 });
		expect(resultado.golpes).toBe(0);
		expect(resultado.proyectiles).toHaveLength(1);
	});

	it('un disparo enemigo lejos no golpea', () => {
		const resultado = impactarJugador([proyectil({ aliado: false })], { x: 300, y: 200 });
		expect(resultado.golpes).toBe(0);
		expect(resultado.proyectiles).toHaveLength(1);
	});
});

describe('eliminados y todosEliminados', () => {
	it('cuenta los bots sin vida', () => {
		const bots = [bot({ id: 1, vida: 0 }), bot({ id: 2, vida: 0 }), bot({ id: 3, vida: 2 })];
		expect(eliminados(bots)).toBe(2);
		expect(todosEliminados(bots)).toBe(false);
	});

	it('detecta la ronda ganada', () => {
		expect(todosEliminados([bot({ vida: 0 })])).toBe(true);
	});
});

describe('botDebeDisparar', () => {
	it('dispara solo en los cuadros múltiplos de su cadencia', () => {
		expect(botDebeDisparar(CADENCIA_BOT_CUADROS, 0)).toBe(true);
		expect(botDebeDisparar(CADENCIA_BOT_CUADROS + 1, 0)).toBe(false);
	});

	it('nunca deja que todos los bots disparen en el mismo cuadro', () => {
		const indices = [...Array(CANTIDAD_BOTS).keys()];
		for (let cuadro = 1; cuadro <= CADENCIA_BOT_CUADROS * 3; cuadro++) {
			const disparos = indices.filter((i) => botDebeDisparar(cuadro, i)).length;
			expect(disparos).toBeLessThan(CANTIDAD_BOTS);
		}
	});

	it('cada bot alcanza a disparar dentro de una vuelta de cadencia', () => {
		const indices = [...Array(CANTIDAD_BOTS).keys()];
		for (const i of indices) {
			const cuadros = [...Array(CADENCIA_BOT_CUADROS * 2).keys()];
			expect(cuadros.some((c) => botDebeDisparar(c, i))).toBe(true);
		}
	});
});

describe('direccionDeBot', () => {
	it('se acerca cuando está más lejos que su distancia preferida', () => {
		const jugador = { x: 0, y: 0 };
		const lejos = { x: DISTANCIA_PREFERIDA_BOT + 50, y: 0 };
		expect(direccionDeBot(lejos, jugador).dx).toBeCloseTo(-1);
	});

	it('mantiene su distancia cuando ya está a tiro', () => {
		const jugador = { x: 0, y: 0 };
		const cerca = { x: DISTANCIA_PREFERIDA_BOT - 10, y: 0 };
		expect(direccionDeBot(cerca, jugador)).toEqual({ dx: 0, dy: 0 });
	});
});
