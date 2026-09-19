import { describe, expect, it } from 'vitest';
import {
	DURACION_RULETA_MS,
	PARTES_CAJA_REGISTRADORA,
	deslizamientosVasos,
	golpesRuleta,
	notasDerrota,
	notasVictoria,
	tintineosMonedas
} from './sonidosSintetizados';

/** Azar determinista para las partituras con variación. */
function azarFijo(...valores: number[]): () => number {
	let i = 0;
	return () => valores[i++ % valores.length];
}

describe('notasVictoria', () => {
	it('empieza con una escalera ascendente', () => {
		const notas = notasVictoria();
		const escalera = notas.filter((n) => n.duracionMs !== notas[notas.length - 1].duracionMs);
		expect(escalera.length).toBeGreaterThanOrEqual(4);
		for (let i = 1; i < escalera.length; i++) {
			expect(escalera[i].frecuenciaHz).toBeGreaterThan(escalera[i - 1].frecuenciaHz);
			expect(escalera[i].inicioMs).toBeGreaterThan(escalera[i - 1].inicioMs);
		}
	});

	it('remata con un acorde: varias notas que empiezan juntas y duran más que la escalera', () => {
		const notas = notasVictoria();
		const inicioAcorde = Math.max(...notas.map((n) => n.inicioMs));
		const acorde = notas.filter((n) => n.inicioMs === inicioAcorde);
		const escalera = notas.filter((n) => n.inicioMs < inicioAcorde);
		expect(acorde.length).toBeGreaterThanOrEqual(3);
		for (const nota of acorde) {
			for (const paso of escalera) expect(nota.duracionMs).toBeGreaterThan(paso.duracionMs);
		}
	});

	it('el acorde empieza cuando termina de sonar la escalera', () => {
		const notas = notasVictoria();
		const inicioAcorde = Math.max(...notas.map((n) => n.inicioMs));
		const ultimoPaso = notas.filter((n) => n.inicioMs < inicioAcorde).pop()!;
		expect(inicioAcorde).toBeGreaterThan(ultimoPaso.inicioMs);
		expect(inicioAcorde).toBeLessThanOrEqual(ultimoPaso.inicioMs + ultimoPaso.duracionMs);
	});
});

describe('notasDerrota', () => {
	it('son cuatro notas cada vez más graves', () => {
		const notas = notasDerrota();
		expect(notas).toHaveLength(4);
		for (let i = 1; i < notas.length; i++) {
			expect(notas[i].frecuenciaHz).toBeLessThan(notas[i - 1].frecuenciaHz);
			expect(notas[i].inicioMs).toBeGreaterThan(notas[i - 1].inicioMs);
		}
	});

	it('cada nota resbala hacia abajo mientras suena', () => {
		for (const nota of notasDerrota()) expect(nota.frecuenciaFinalHz).toBeLessThan(nota.frecuenciaHz);
	});

	it('la última se arrastra más y cae más lejos que las demás', () => {
		const notas = notasDerrota();
		const ultima = notas[notas.length - 1];
		for (const nota of notas.slice(0, -1)) {
			expect(ultima.duracionMs).toBeGreaterThan(nota.duracionMs);
			expect(ultima.frecuenciaHz - ultima.frecuenciaFinalHz).toBeGreaterThan(nota.frecuenciaHz - nota.frecuenciaFinalHz);
		}
	});

	it('las notas no se encima una con otra', () => {
		const notas = notasDerrota();
		for (let i = 1; i < notas.length; i++) {
			expect(notas[i].inicioMs).toBeGreaterThanOrEqual(notas[i - 1].inicioMs + notas[i - 1].duracionMs);
		}
	});
});

describe('caja registradora', () => {
	it('sus partes pasan en orden: tecla, campana, cajón y tope', () => {
		const { tecla, campana, cajon, tope } = PARTES_CAJA_REGISTRADORA;
		expect(tecla).toBeLessThan(campana);
		expect(campana).toBeLessThan(cajon);
		expect(cajon).toBeLessThan(tope);
	});
});

describe('tintineosMonedas', () => {
	it('son seis monedas que caen una tras otra', () => {
		const tintineos = tintineosMonedas(azarFijo(0.1, 0.5, 0.9));
		expect(tintineos).toHaveLength(6);
		for (let i = 1; i < tintineos.length; i++) {
			expect(tintineos[i].inicioMs).toBeGreaterThan(tintineos[i - 1].inicioMs);
		}
	});

	it('todas suenan agudas, como metal, y cortas', () => {
		for (const azar of [azarFijo(0), azarFijo(0.999), azarFijo(0.3, 0.7)]) {
			for (const t of tintineosMonedas(azar)) {
				expect(t.frecuenciaHz).toBeGreaterThan(1900);
				expect(t.frecuenciaHz).toBeLessThan(3800);
				expect(t.duracionMs).toBeGreaterThanOrEqual(180);
				expect(t.duracionMs).toBeLessThanOrEqual(260);
			}
		}
	});

	it('el azar varía el tono y la separación entre monedas', () => {
		const a = tintineosMonedas(azarFijo(0.1));
		const b = tintineosMonedas(azarFijo(0.8));
		expect(a.map((t) => t.frecuenciaHz)).not.toEqual(b.map((t) => t.frecuenciaHz));
		expect(a[1].inicioMs).not.toBe(b[1].inicioMs);
	});

	it('todo el sonido cabe en menos de un segundo', () => {
		const tintineos = tintineosMonedas(azarFijo(0.999));
		const ultimo = tintineos[tintineos.length - 1];
		expect(ultimo.inicioMs + ultimo.duracionMs).toBeLessThan(1000);
	});
});

describe('golpesRuleta', () => {
	it('la bola pega cada vez más espaciado, como una rueda que frena', () => {
		const golpes = golpesRuleta();
		expect(golpes.length).toBeGreaterThan(10);
		expect(golpes[0]).toBe(0);
		const intervalos = golpes.slice(1).map((t, i) => t - golpes[i]);
		for (let i = 1; i < intervalos.length; i++) expect(intervalos[i]).toBeGreaterThan(intervalos[i - 1]);
	});

	it('el giro completo dura entre 2 y 3 segundos y termina después del último golpe', () => {
		const golpes = golpesRuleta();
		expect(DURACION_RULETA_MS).toBeGreaterThan(golpes[golpes.length - 1]);
		expect(DURACION_RULETA_MS).toBeGreaterThanOrEqual(2000);
		expect(DURACION_RULETA_MS).toBeLessThanOrEqual(3000);
	});

	it('es determinista: el minijuego puede confiar en la duración', () => {
		expect(golpesRuleta()).toEqual(golpesRuleta());
	});
});

describe('deslizamientosVasos', () => {
	it('son cuatro vasos que se arrastran uno tras otro', () => {
		const vasos = deslizamientosVasos(azarFijo(0.5));
		expect(vasos).toHaveLength(4);
		for (let i = 1; i < vasos.length; i++) {
			expect(vasos[i].inicioMs).toBeGreaterThanOrEqual(vasos[i - 1].inicioMs + vasos[i - 1].duracionMs);
		}
	});

	it('alternan el sentido del roce para que no suenen iguales', () => {
		const vasos = deslizamientosVasos(azarFijo(0.5));
		expect(vasos[0].frecuenciaFinalHz).toBeGreaterThan(vasos[0].frecuenciaInicialHz);
		expect(vasos[1].frecuenciaFinalHz).toBeLessThan(vasos[1].frecuenciaInicialHz);
		expect(vasos[2].frecuenciaFinalHz).toBeGreaterThan(vasos[2].frecuenciaInicialHz);
	});

	it('el azar solo mueve un poco el inicio de cada vaso, nunca lo vuelve negativo salvo el primero', () => {
		const temprano = deslizamientosVasos(azarFijo(0));
		const tarde = deslizamientosVasos(azarFijo(0.999));
		for (let i = 0; i < 4; i++) {
			expect(Math.abs(temprano[i].inicioMs - tarde[i].inicioMs)).toBeLessThanOrEqual(40);
		}
		for (const v of temprano.slice(1)) expect(v.inicioMs).toBeGreaterThan(0);
	});

	it('todo el barajeo dura alrededor de un segundo', () => {
		const vasos = deslizamientosVasos(azarFijo(0.5));
		const ultimo = vasos[vasos.length - 1];
		expect(ultimo.inicioMs + ultimo.duracionMs).toBeGreaterThan(800);
		expect(ultimo.inicioMs + ultimo.duracionMs).toBeLessThan(1200);
	});
});
