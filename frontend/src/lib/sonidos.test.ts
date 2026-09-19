import { describe, expect, it } from 'vitest';
import type { AccionSonido, PreferenciaSonido, Sonido } from './api/client';
import { RESPALDO_POR_ACCION, SONIDOS_ERROR, SONIDOS_EXITO } from './notificaciones';
import {
	ACCIONES_SONIDO,
	EVENTOS_SONIDO,
	accionDeEvento,
	esSintetizado,
	nombreSugerido,
	resolverSonido,
	sonidosDeRespaldo,
	sonidosParaEvento,
	validarArchivoSonido
} from './sonidos';

function sonido(id: number, acciones: AccionSonido[]): Sonido {
	return { id, acciones, nombre: `s${id}`, url: `/sonidos/s${id}.ogg`, created_at: '' };
}

const CATALOGO: Sonido[] = [
	sonido(1, ['exito']),
	sonido(2, ['exito', 'victoria']),
	sonido(3, []),
	sonido(4, ['error']),
	sonido(5, ['derrota']),
	sonido(6, ['compra'])
];

function preferencia(evento: PreferenciaSonido['evento'], sonido_id: number | null, silenciado = false): PreferenciaSonido {
	return { evento, sonido_id, silenciado };
}

describe('accionDeEvento', () => {
	it('las dos acciones de mesa suenan a éxito y la de error a error', () => {
		expect(accionDeEvento('guardar_mesa')).toBe('exito');
		expect(accionDeEvento('cerrar_mesa')).toBe('exito');
		expect(accionDeEvento('error')).toBe('error');
	});

	it('compra, victoria y derrota suenan con su propia acción', () => {
		expect(accionDeEvento('compra')).toBe('compra');
		expect(accionDeEvento('victoria')).toBe('victoria');
		expect(accionDeEvento('derrota')).toBe('derrota');
	});

	it('el listado de eventos cubre exactamente los seis', () => {
		expect(EVENTOS_SONIDO.map((e) => e.evento)).toEqual([
			'guardar_mesa',
			'cerrar_mesa',
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

describe('resolverSonido', () => {
	it('sin preferencia elige al azar entre los marcados para la acción', () => {
		expect(resolverSonido('guardar_mesa', CATALOGO, [], () => 0)).toBe('/sonidos/s1.ogg');
		expect(resolverSonido('guardar_mesa', CATALOGO, [], () => 0.99)).toBe('/sonidos/s2.ogg');
	});

	it('nunca elige uno sin la acción marcada', () => {
		for (let i = 0; i < 30; i++) {
			const url = resolverSonido('cerrar_mesa', CATALOGO, []);
			expect(['/sonidos/s1.ogg', '/sonidos/s2.ogg']).toContain(url);
		}
	});

	it('el sonido elegido por el usuario suena siempre, sin importar el azar', () => {
		const prefs = [preferencia('cerrar_mesa', 2)];
		expect(resolverSonido('cerrar_mesa', CATALOGO, prefs, () => 0)).toBe('/sonidos/s2.ogg');
		expect(resolverSonido('cerrar_mesa', CATALOGO, prefs, () => 0.99)).toBe('/sonidos/s2.ogg');
	});

	it('la preferencia de una acción no afecta a las otras', () => {
		const prefs = [preferencia('cerrar_mesa', 2)];
		expect(resolverSonido('guardar_mesa', CATALOGO, prefs, () => 0)).toBe('/sonidos/s1.ogg');
	});

	it('un sonido elegido al que le quitaron la acción cae al aleatorio', () => {
		const prefs = [preferencia('guardar_mesa', 3)];
		expect(resolverSonido('guardar_mesa', CATALOGO, prefs, () => 0)).toBe('/sonidos/s1.ogg');
	});

	it('un sonido elegido marcado para otra acción se ignora y cae al aleatorio', () => {
		const prefs = [preferencia('error', 1)];
		expect(resolverSonido('error', CATALOGO, prefs)).toBe('/sonidos/s4.ogg');
	});

	it('silenciar una acción no reproduce nada aunque haya sonido elegido', () => {
		expect(resolverSonido('error', CATALOGO, [preferencia('error', 4, true)])).toBeNull();
	});

	it('sin ningún sonido marcado para la acción no suena nada', () => {
		const sinError = [sonido(4, []), sonido(1, ['exito'])];
		expect(resolverSonido('error', sinError, [])).toBeNull();
	});

	it('victoria, derrota y compra resuelven con sus propios sonidos', () => {
		expect(resolverSonido('victoria', CATALOGO, [])).toBe('/sonidos/s2.ogg');
		expect(resolverSonido('derrota', CATALOGO, [])).toBe('/sonidos/s5.ogg');
		expect(resolverSonido('compra', CATALOGO, [])).toBe('/sonidos/s6.ogg');
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
	});

	it('los ids del respaldo no chocan entre sí ni con ids reales (positivos)', () => {
		const ids = sonidosDeRespaldo().map((s) => s.id);
		expect(new Set(ids).size).toBe(ids.length);
		expect(ids.every((id) => id < 0)).toBe(true);
	});

	it('el respaldo resuelve un sonido para cada evento', () => {
		const respaldo = sonidosDeRespaldo();
		for (const e of EVENTOS_SONIDO) {
			expect(RESPALDO_POR_ACCION[e.accion]).toContain(resolverSonido(e.evento, respaldo, []));
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
