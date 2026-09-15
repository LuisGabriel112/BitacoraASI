import { describe, expect, it } from 'vitest';
import type { PreferenciaSonido, Sonido } from './api/client';
import { SONIDOS_ERROR, SONIDOS_EXITO } from './notificaciones';
import {
	EVENTOS_SONIDO,
	categoriaDeEvento,
	esSintetizado,
	nombreSugerido,
	resolverSonido,
	sonidosDeRespaldo,
	sonidosParaEvento,
	validarArchivoSonido
} from './sonidos';

function sonido(id: number, categoria: 'exito' | 'error', activo = true): Sonido {
	return { id, categoria, nombre: `s${id}`, url: `/sonidos/s${id}.ogg`, activo, created_at: '' };
}

const CATALOGO: Sonido[] = [
	sonido(1, 'exito'),
	sonido(2, 'exito'),
	sonido(3, 'exito', false),
	sonido(4, 'error'),
	sonido(5, 'error', false)
];

function preferencia(evento: PreferenciaSonido['evento'], sonido_id: number | null, silenciado = false): PreferenciaSonido {
	return { evento, sonido_id, silenciado };
}

describe('categoriaDeEvento', () => {
	it('las dos acciones de mesa son de éxito y la de error es de error', () => {
		expect(categoriaDeEvento('guardar_mesa')).toBe('exito');
		expect(categoriaDeEvento('cerrar_mesa')).toBe('exito');
		expect(categoriaDeEvento('error')).toBe('error');
	});

	it('el listado de acciones cubre exactamente las tres', () => {
		expect(EVENTOS_SONIDO.map((e) => e.evento)).toEqual(['guardar_mesa', 'cerrar_mesa', 'error']);
	});
});

describe('sonidosParaEvento', () => {
	it('solo devuelve los activos de la categoría', () => {
		expect(sonidosParaEvento('guardar_mesa', CATALOGO).map((s) => s.id)).toEqual([1, 2]);
		expect(sonidosParaEvento('error', CATALOGO).map((s) => s.id)).toEqual([4]);
	});
});

describe('resolverSonido', () => {
	it('sin preferencia elige al azar entre los activos de la categoría', () => {
		expect(resolverSonido('guardar_mesa', CATALOGO, [], () => 0)).toBe('/sonidos/s1.ogg');
		expect(resolverSonido('guardar_mesa', CATALOGO, [], () => 0.99)).toBe('/sonidos/s2.ogg');
	});

	it('nunca elige un inactivo ni uno de otra categoría', () => {
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

	it('un sonido elegido que fue deshabilitado en general cae al aleatorio', () => {
		const prefs = [preferencia('guardar_mesa', 3)];
		expect(resolverSonido('guardar_mesa', CATALOGO, prefs, () => 0)).toBe('/sonidos/s1.ogg');
	});

	it('un sonido elegido de otra categoría se ignora y cae al aleatorio', () => {
		const prefs = [preferencia('error', 1)];
		expect(resolverSonido('error', CATALOGO, prefs)).toBe('/sonidos/s4.ogg');
	});

	it('silenciar una acción no reproduce nada aunque haya sonido elegido', () => {
		expect(resolverSonido('error', CATALOGO, [preferencia('error', 4, true)])).toBeNull();
	});

	it('sin ningún sonido activo de la categoría no suena nada', () => {
		const soloInactivos = [sonido(4, 'error', false), sonido(1, 'exito')];
		expect(resolverSonido('error', soloInactivos, [])).toBeNull();
	});
});

describe('esSintetizado', () => {
	it('reconoce el esquema sintetizado: y rechaza rutas de archivo', () => {
		expect(esSintetizado('sintetizado:fanfarria-mexicana')).toBe(true);
		expect(esSintetizado('/sonidos/pop-succes.ogg')).toBe(false);
		expect(esSintetizado('https://x.supabase.co/storage/v1/object/public/b/sonidos/a.ogg')).toBe(false);
	});
});

describe('sonidosDeRespaldo', () => {
	it('trae el pool fijo de éxito y error, todo activo', () => {
		const respaldo = sonidosDeRespaldo();
		expect(respaldo.filter((s) => s.categoria === 'exito').map((s) => s.url)).toEqual([...SONIDOS_EXITO]);
		expect(respaldo.filter((s) => s.categoria === 'error').map((s) => s.url)).toEqual([...SONIDOS_ERROR]);
		expect(respaldo.every((s) => s.activo)).toBe(true);
	});

	it('los ids del respaldo no chocan entre sí ni con ids reales (positivos)', () => {
		const ids = sonidosDeRespaldo().map((s) => s.id);
		expect(new Set(ids).size).toBe(ids.length);
		expect(ids.every((id) => id < 0)).toBe(true);
	});

	it('el respaldo resuelve un sonido para cada acción', () => {
		const respaldo = sonidosDeRespaldo();
		expect(SONIDOS_EXITO).toContain(resolverSonido('guardar_mesa', respaldo, []));
		expect(SONIDOS_ERROR).toContain(resolverSonido('error', respaldo, []));
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
