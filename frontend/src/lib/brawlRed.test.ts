import { describe, expect, it } from 'vitest';
import {
	interpolar,
	otrosJugadores,
	urlWebSocketBrawl,
	type EstadoSala,
	type JugadorRemoto
} from './brawlRed';

const jugador = (id: string, x = 0, y = 0): JugadorRemoto => ({
	id,
	nombre: `Jugador ${id}`,
	avatar: '🙂',
	x,
	y,
	vida: 5,
	bajas: 0
});

const estado = (jugadores: JugadorRemoto[]): EstadoSala => ({
	estado: 'jugando',
	tick: 1,
	segundos_restantes: 30,
	muros: [],
	jugadores,
	bots: [],
	proyectiles: []
});

describe('urlWebSocketBrawl', () => {
	it('usa el proxy del mismo origen cuando no hay backend configurado', () => {
		const url = urlWebSocketBrawl('http://localhost:5173', '', 'abc');
		expect(url).toBe('ws://localhost:5173/api/juegos/brawl/ws?ticket=abc');
	});

	it('va directo al backend cuando está configurado', () => {
		const url = urlWebSocketBrawl('https://bitacora.vercel.app', 'https://api.onrender.com', 'abc');
		expect(url).toBe('wss://api.onrender.com/juegos/brawl/ws?ticket=abc');
	});

	it('usa wss en un origen seguro', () => {
		expect(urlWebSocketBrawl('https://bitacora.app', '', 't')).toMatch(/^wss:/);
	});

	it('usa ws en un origen sin cifrar', () => {
		expect(urlWebSocketBrawl('http://localhost:5173', '', 't')).toMatch(/^ws:/);
	});

	it('escapa el ticket en la query string', () => {
		expect(urlWebSocketBrawl('http://x.dev', '', 'a b+c')).toContain('ticket=a%20b%2Bc');
	});

	it('ignora una diagonal final del backend configurado', () => {
		const url = urlWebSocketBrawl('https://f.app', 'https://api.onrender.com/', 'abc');
		expect(url).toBe('wss://api.onrender.com/juegos/brawl/ws?ticket=abc');
	});
});

describe('interpolar', () => {
	it('da el punto intermedio a la mitad del tramo', () => {
		expect(interpolar({ x: 0, y: 0 }, { x: 10, y: 20 }, 0.5)).toEqual({ x: 5, y: 10 });
	});

	it('devuelve la posición nueva si no hay previa', () => {
		expect(interpolar(undefined, { x: 10, y: 20 }, 0.5)).toEqual({ x: 10, y: 20 });
	});

	it('no se pasa de la posición nueva aunque el avance exceda uno', () => {
		expect(interpolar({ x: 0, y: 0 }, { x: 10, y: 20 }, 5)).toEqual({ x: 10, y: 20 });
	});

	it('no se regresa antes de la posición previa', () => {
		expect(interpolar({ x: 0, y: 0 }, { x: 10, y: 20 }, -3)).toEqual({ x: 0, y: 0 });
	});
});

describe('otrosJugadores', () => {
	it('deja fuera a mi propio jugador', () => {
		const otros = otrosJugadores(estado([jugador('a'), jugador('b')]), 'a');
		expect(otros.map((j) => j.id)).toEqual(['b']);
	});

	it('devuelve lista vacía si estoy solo', () => {
		expect(otrosJugadores(estado([jugador('a')]), 'a')).toEqual([]);
	});
});
