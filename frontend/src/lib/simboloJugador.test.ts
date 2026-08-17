import { describe, expect, it } from 'vitest';
import { miSimbolo } from './simboloJugador';

const jugador = (nombre: string) => ({ nombre, avatar: '🙂' });

describe('miSimbolo', () => {
	it('devuelve X si mi nombre es el del jugador X', () => {
		const partida = { jugador_x: jugador('Ana'), jugador_o: jugador('Beto') };
		expect(miSimbolo(partida, 'Ana')).toBe('X');
	});

	it('devuelve O si mi nombre es el del jugador O', () => {
		const partida = { jugador_x: jugador('Ana'), jugador_o: jugador('Beto') };
		expect(miSimbolo(partida, 'Beto')).toBe('O');
	});

	it('devuelve null si no soy ninguno de los dos', () => {
		const partida = { jugador_x: jugador('Ana'), jugador_o: jugador('Beto') };
		expect(miSimbolo(partida, 'Carla')).toBeNull();
	});

	it('devuelve X aunque todavia no haya jugador O', () => {
		const partida = { jugador_x: jugador('Ana'), jugador_o: null };
		expect(miSimbolo(partida, 'Ana')).toBe('X');
	});
});
