import { describe, expect, it } from 'vitest';
import {
	ALTO_MUNDO,
	ANCHO_MUNDO,
	DURACION_PARTICULA_MS,
	aMundo,
	alturaRebote,
	colorVida,
	crearParticulas,
	intensidadSacudida,
	particulaViva,
	posicionParticula
} from './brawlVisual';

describe('aMundo', () => {
	it('lleva el centro de la arena al origen', () => {
		expect(aMundo(180, 130)).toEqual({ x: 0, z: 0 });
	});

	it('convierte el eje vertical de la arena en profundidad', () => {
		expect(aMundo(180, 200).z).toBeGreaterThan(aMundo(180, 100).z);
	});

	it('mantiene la arena dentro del ancho y alto del mundo', () => {
		const esquina = aMundo(360, 260);
		expect(Math.abs(esquina.x)).toBeCloseTo(ANCHO_MUNDO / 2);
		expect(Math.abs(esquina.z)).toBeCloseTo(ALTO_MUNDO / 2);
	});
});

describe('intensidadSacudida', () => {
	it('se apaga al cumplirse su duración', () => {
		expect(intensidadSacudida(1, 0, 300, 300)).toBe(0);
	});

	it('sacude más al arranque que a la mitad', () => {
		const arranque = intensidadSacudida(1, 0, 10, 300);
		const mitad = intensidadSacudida(1, 0, 150, 300);
		expect(arranque).toBeGreaterThan(mitad);
	});

	it('nunca devuelve un valor negativo', () => {
		expect(intensidadSacudida(1, 0, 99999, 300)).toBe(0);
	});
});

describe('colorVida', () => {
	it('es verde con vida completa', () => {
		expect(colorVida(1)).toBe(0x3b9b6f);
	});

	it('es rojo con poca vida', () => {
		expect(colorVida(0.15)).toBe(0xc1443c);
	});

	it('avisa en ámbar a media vida', () => {
		expect(colorVida(0.5)).toBe(0xd97706);
	});
});

describe('partículas', () => {
	it('crea el puñado pedido con direcciones distintas', () => {
		const particulas = crearParticulas(8, 0, 0, 0);
		expect(particulas).toHaveLength(8);
		const direcciones = new Set(particulas.map((p) => `${p.vx.toFixed(3)},${p.vz.toFixed(3)}`));
		expect(direcciones.size).toBeGreaterThan(1);
	});

	it('caen y se desvanecen con el tiempo', () => {
		const [particula] = crearParticulas(1, 0, 0, 0);
		const temprano = posicionParticula(particula, 50);
		const tarde = posicionParticula(particula, DURACION_PARTICULA_MS - 50);
		expect(tarde.y).toBeLessThan(temprano.y);
		expect(tarde.opacidad).toBeLessThan(temprano.opacidad);
	});

	it('descarta la partícula que agotó su vida', () => {
		const [particula] = crearParticulas(1, 0, 0, 0);
		expect(particulaViva(particula, DURACION_PARTICULA_MS - 1)).toBe(true);
		expect(particulaViva(particula, DURACION_PARTICULA_MS + 1)).toBe(false);
	});
});

describe('alturaRebote', () => {
	it('oscila alrededor de la altura de reposo', () => {
		const alturas = [0, 100, 200, 300, 400].map((t) => alturaRebote(t, 1));
		expect(Math.max(...alturas)).toBeGreaterThan(0);
		expect(Math.min(...alturas)).toBeLessThan(Math.max(...alturas));
	});

	it('no rebota cuando el personaje está quieto', () => {
		expect(alturaRebote(123, 0)).toBe(0);
	});
});
