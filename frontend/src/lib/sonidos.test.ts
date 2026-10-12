import { describe, expect, it } from 'vitest';
import type { AccionSonido, Sonido } from './api/client';
import { RESPALDO_POR_ACCION, SONIDOS_ERROR, SONIDOS_EXITO } from './notificaciones';
import {
	ACCIONES_SONIDO,
	EVENTOS_SONIDO,
	PESO_NORMAL,
	accionDeEvento,
	elegirPonderado,
	esSintetizado,
	nombreSugerido,
	PESO_MAXIMO,
	pesoDe,
	probabilidadCon,
	probabilidadDe,
	resolverSonido,
	sonidosDeRespaldo,
	sonidosParaEvento,
	validarArchivoSonido
} from './sonidos';

function sonido(id: number, acciones: AccionSonido[], pesos: Sonido['pesos'] = {}): Sonido {
	return { id, acciones, pesos, nombre: `s${id}`, url: `/sonidos/s${id}.ogg`, created_at: '' };
}

const CATALOGO: Sonido[] = [
	sonido(1, ['exito']),
	sonido(2, ['exito', 'victoria']),
	sonido(3, []),
	sonido(4, ['error']),
	sonido(5, ['derrota']),
	sonido(6, ['compra'])
];

describe('accionDeEvento', () => {
	it('las dos acciones de mesa suenan a éxito y la de error a error', () => {
		expect(accionDeEvento('guardar_mesa')).toBe('exito');
		expect(accionDeEvento('cerrar_mesa')).toBe('exito');
		expect(accionDeEvento('error')).toBe('error');
	});

	it('guardar registro suena a éxito, igual que las mesas', () => {
		expect(accionDeEvento('guardar_registro')).toBe('exito');
	});

	it('compra, victoria y derrota suenan con su propia acción', () => {
		expect(accionDeEvento('compra')).toBe('compra');
		expect(accionDeEvento('victoria')).toBe('victoria');
		expect(accionDeEvento('derrota')).toBe('derrota');
	});

	it('el listado de eventos cubre exactamente los siete', () => {
		expect(EVENTOS_SONIDO.map((e) => e.evento)).toEqual([
			'guardar_mesa',
			'cerrar_mesa',
			'guardar_registro',
			'error',
			'compra',
			'victoria',
			'derrota'
		]);
	});

	it('los interruptores del catálogo son cinco, en el orden en que se muestran', () => {
		expect(ACCIONES_SONIDO.map((a) => a.accion)).toEqual(['error', 'exito', 'compra', 'victoria', 'derrota']);
	});

	it('toda acción del catálogo la dispara al menos un evento', () => {
		const disparadas = new Set(EVENTOS_SONIDO.map((e) => e.accion));
		for (const { accion } of ACCIONES_SONIDO) expect(disparadas.has(accion)).toBe(true);
	});
});

describe('sonidosParaEvento', () => {
	it('solo devuelve los marcados para la acción del evento', () => {
		expect(sonidosParaEvento('guardar_mesa', CATALOGO).map((s) => s.id)).toEqual([1, 2]);
		expect(sonidosParaEvento('error', CATALOGO).map((s) => s.id)).toEqual([4]);
	});

	it('un sonido marcado para varias acciones sirve para todas ellas', () => {
		expect(sonidosParaEvento('victoria', CATALOGO).map((s) => s.id)).toEqual([2]);
		expect(sonidosParaEvento('cerrar_mesa', CATALOGO).map((s) => s.id)).toContain(2);
	});

	it('un sonido sin acciones no sirve para nada', () => {
		for (const e of EVENTOS_SONIDO) {
			expect(sonidosParaEvento(e.evento, CATALOGO).map((s) => s.id)).not.toContain(3);
		}
	});
});

describe('pesoDe', () => {
	it('lo que nadie ajustó pesa lo normal', () => {
		expect(pesoDe(sonido(1, ['exito']), 'exito')).toBe(PESO_NORMAL);
	});

	it('comparte el peso ajustado entre todas las acciones', () => {
		const s = sonido(1, ['exito', 'victoria'], { exito: 4 });
		expect(pesoDe(s, 'exito')).toBe(4);
		expect(pesoDe(s, 'victoria')).toBe(4);
	});
});

describe('peso compartido existente', () => {
	it('usa el mayor peso anterior incluso con todas las acciones apagadas', () => {
		const s = sonido(1, [], { exito: 3, victoria: 7 });
		expect(pesoDe(s, 'error')).toBe(7);
		expect(pesoDe(s, 'victoria')).toBe(7);
	});
});

describe('probabilidadDe', () => {
	it('con pesos iguales se reparte parejo', () => {
		const catalogo = [sonido(1, ['exito']), sonido(2, ['exito'])];
		expect(probabilidadDe(catalogo[0], 'exito', catalogo)).toBeCloseTo(0.5);
	});

	it('el peso manda: 3 contra 1 da 75% y 25%', () => {
		const catalogo = [sonido(1, ['exito'], { exito: 3 }), sonido(2, ['exito'])];
		expect(probabilidadDe(catalogo[0], 'exito', catalogo)).toBeCloseTo(0.75);
		expect(probabilidadDe(catalogo[1], 'exito', catalogo)).toBeCloseTo(0.25);
	});

	it('las probabilidades de una acción suman 1', () => {
		const catalogo = [
			sonido(1, ['exito'], { exito: 5 }),
			sonido(2, ['exito'], { exito: 2 }),
			sonido(3, ['exito'])
		];
		const suma = catalogo.reduce((t, s) => t + probabilidadDe(s, 'exito', catalogo), 0);
		expect(suma).toBeCloseTo(1);
	});

	it('el mismo sonido puede tener probabilidad distinta en cada acción', () => {
		const catalogo = [sonido(1, ['exito', 'victoria'], { exito: 9, victoria: 9 }), sonido(2, ['exito'], { exito: 9 }), sonido(3, ['victoria'])];
		expect(probabilidadDe(catalogo[0], 'exito', catalogo)).toBeCloseTo(0.5);
		expect(probabilidadDe(catalogo[0], 'victoria', catalogo)).toBeCloseTo(0.9);
	});

	it('un sonido sin esa acción marcada tiene probabilidad 0', () => {
		const catalogo = [sonido(1, ['exito']), sonido(2, ['error'])];
		expect(probabilidadDe(catalogo[1], 'exito', catalogo)).toBe(0);
	});
});

describe('probabilidadCon', () => {
	it('calcula con el peso que se le pase, no con el guardado', () => {
		const catalogo = [sonido(1, ['exito']), sonido(2, ['exito'])];
		// lo que se ve mientras se arrastra la barra del primero hasta 3
		const enVivo = (s: Sonido) => (s.id === 1 ? 3 : pesoDe(s, 'exito'));
		expect(probabilidadCon(catalogo[0], 'exito', catalogo, enVivo)).toBeCloseTo(0.75);
		expect(probabilidadCon(catalogo[1], 'exito', catalogo, enVivo)).toBeCloseTo(0.25);
		// el guardado sigue siendo el de antes hasta que se suelte
		expect(probabilidadDe(catalogo[0], 'exito', catalogo)).toBeCloseTo(0.5);
	});

	it('un sonido sin esa acción sigue en 0 aunque le pasen peso', () => {
		const catalogo = [sonido(1, ['error'])];
		expect(probabilidadCon(catalogo[0], 'exito', catalogo, () => 5)).toBe(0);
	});
});

describe('elegirPonderado', () => {
	it('sin candidatos no elige nada', () => {
		expect(elegirPonderado([], 'exito', () => 0)).toBeNull();
	});

	it('reparte el rango del azar en proporción al peso', () => {
		const candidatos = [sonido(1, ['exito'], { exito: 3 }), sonido(2, ['exito'])];
		// total 4: [0, 3) le toca al primero y [3, 4) al segundo
		expect(elegirPonderado(candidatos, 'exito', () => 0)!.id).toBe(1);
		expect(elegirPonderado(candidatos, 'exito', () => 0.74)!.id).toBe(1);
		expect(elegirPonderado(candidatos, 'exito', () => 0.76)!.id).toBe(2);
	});

	it('nunca devuelve null por redondeo cuando el azar roza el tope', () => {
		const candidatos = [sonido(1, ['exito']), sonido(2, ['exito'])];
		expect(elegirPonderado(candidatos, 'exito', () => 0.999999999)).not.toBeNull();
	});

	it('un peso alto no excluye al resto', () => {
		const candidatos = [sonido(1, ['exito'], { exito: PESO_MAXIMO }), sonido(2, ['exito'])];
		expect(elegirPonderado(candidatos, 'exito', () => 0.999)!.id).toBe(2);
	});
});

describe('resolverSonido', () => {
	it('elige entre los marcados para la acción del evento', () => {
		expect(resolverSonido('guardar_mesa', CATALOGO, () => 0)).toBe('/sonidos/s1.ogg');
		expect(resolverSonido('guardar_mesa', CATALOGO, () => 0.99)).toBe('/sonidos/s2.ogg');
	});

	it('nunca elige uno sin la acción marcada', () => {
		for (let i = 0; i < 30; i++) {
			expect(['/sonidos/s1.ogg', '/sonidos/s2.ogg']).toContain(resolverSonido('cerrar_mesa', CATALOGO));
		}
	});

	it('guardar registro suena con los mismos sonidos que guardar mesa', () => {
		expect(resolverSonido('guardar_registro', CATALOGO, () => 0)).toBe(
			resolverSonido('guardar_mesa', CATALOGO, () => 0)
		);
	});

	it('respeta el peso al sortear', () => {
		const catalogo = [sonido(1, ['error'], { error: 9 }), sonido(2, ['error'])];
		expect(resolverSonido('error', catalogo, () => 0.5)).toBe('/sonidos/s1.ogg');
		expect(resolverSonido('error', catalogo, () => 0.95)).toBe('/sonidos/s2.ogg');
	});

	it('sin ningún sonido marcado para la acción no suena nada', () => {
		expect(resolverSonido('error', [sonido(4, []), sonido(1, ['exito'])])).toBeNull();
	});

	it('victoria, derrota y compra resuelven con sus propios sonidos', () => {
		expect(resolverSonido('victoria', CATALOGO)).toBe('/sonidos/s2.ogg');
		expect(resolverSonido('derrota', CATALOGO)).toBe('/sonidos/s5.ogg');
		expect(resolverSonido('compra', CATALOGO)).toBe('/sonidos/s6.ogg');
	});
});

describe('esSintetizado', () => {
	it('reconoce el esquema sintetizado: y rechaza rutas de archivo', () => {
		expect(esSintetizado('sintetizado:fanfarria-mexicana')).toBe(true);
		expect(esSintetizado('sintetizado:victoria')).toBe(true);
		expect(esSintetizado('/sonidos/pop-succes.ogg')).toBe(false);
		expect(esSintetizado('https://x.supabase.co/storage/v1/object/public/b/sonidos/a.ogg')).toBe(false);
	});
});

describe('sonidosDeRespaldo', () => {
	it('trae el pool fijo de cada acción, cada sonido marcado para la suya', () => {
		const respaldo = sonidosDeRespaldo();
		const urlsDe = (accion: AccionSonido) =>
			respaldo.filter((s) => s.acciones.includes(accion)).map((s) => s.url);
		expect(urlsDe('exito')).toEqual([...SONIDOS_EXITO]);
		expect(urlsDe('error')).toEqual([...SONIDOS_ERROR]);
		expect(urlsDe('compra')).toEqual([...RESPALDO_POR_ACCION.compra]);
		expect(urlsDe('victoria')).toEqual([...RESPALDO_POR_ACCION.victoria]);
		expect(urlsDe('derrota')).toEqual([...RESPALDO_POR_ACCION.derrota]);
		expect(respaldo.every((s) => s.acciones.length === 1)).toBe(true);
		expect(respaldo.every((s) => Object.keys(s.pesos).length === 0)).toBe(true);
	});

	it('los ids del respaldo no chocan entre sí ni con ids reales (positivos)', () => {
		const ids = sonidosDeRespaldo().map((s) => s.id);
		expect(new Set(ids).size).toBe(ids.length);
		expect(ids.every((id) => id < 0)).toBe(true);
	});

	it('el respaldo resuelve un sonido para cada evento', () => {
		const respaldo = sonidosDeRespaldo();
		for (const e of EVENTOS_SONIDO) {
			expect(RESPALDO_POR_ACCION[e.accion]).toContain(resolverSonido(e.evento, respaldo));
		}
	});

	it('los sintetizados del respaldo llevan nombre legible', () => {
		const nombres = sonidosDeRespaldo().map((s) => s.nombre);
		expect(nombres).toContain('caja-registradora');
		expect(nombres).toContain('victoria');
		expect(nombres).toContain('pop-succes.ogg');
	});
});

describe('validarArchivoSonido', () => {
	it('un ogg pequeño pasa', () => {
		expect(validarArchivoSonido({ name: 'tada.ogg', type: 'audio/ogg', size: 5_000 })).toBeNull();
	});

	it('acepta por extensión aunque el navegador no reporte MIME', () => {
		expect(validarArchivoSonido({ name: 'tada.mp4', type: '', size: 5_000 })).toBeNull();
	});

	it('rechaza lo que no es audio', () => {
		expect(validarArchivoSonido({ name: 'foto.png', type: 'image/png', size: 5_000 })).toMatch(/audio/);
	});

	it('rechaza archivos de más de 2 MB', () => {
		expect(validarArchivoSonido({ name: 'largo.mp3', type: 'audio/mpeg', size: 3 * 1024 * 1024 })).toMatch(/2 MB/);
	});
});

describe('nombreSugerido', () => {
	it('quita la extensión y los guiones bajos', () => {
		expect(nombreSugerido('tada_final.ogg')).toBe('tada final');
		expect(nombreSugerido('buzzer.mp3')).toBe('buzzer');
	});
});
