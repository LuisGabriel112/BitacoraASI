import {
	dentroDeArena,
	direccionHacia,
	distancia,
	tocaMuro,
	type Direccion,
	type Punto
} from './brawlArena';

export interface Bot {
	id: number;
	pos: Punto;
	vida: number;
}

export interface Proyectil {
	id: number;
	pos: Punto;
	dx: number;
	dy: number;
	aliado: boolean;
}

export interface ResultadoBots {
	proyectiles: Proyectil[];
	bots: Bot[];
}

export interface ResultadoJugador {
	proyectiles: Proyectil[];
	golpes: number;
}

export const VIDA_JUGADOR = 5;
export const VIDA_BOT = 4;
export const CANTIDAD_BOTS = 3;
export const VELOCIDAD_PROYECTIL = 5;
export const RADIO_PROYECTIL = 4;
export const RADIO_IMPACTO = 13;
export const CADENCIA_BOT_CUADROS = 90;
/** Los bots se detienen a esta distancia en vez de correr al cuerpo a cuerpo:
 *  sin esto la ronda se resolvía en ~3s cuando los tres llegaban al jugador a la
 *  vez, en lugar de ser un duelo a distancia donde los muros sirven de cobertura. */
export const DISTANCIA_PREFERIDA_BOT = 110;

const ESQUINAS: Punto[] = [
	{ x: 30, y: 30 },
	{ x: 330, y: 30 },
	{ x: 330, y: 230 }
];

export function crearBots(cantidad: number): Bot[] {
	return Array.from({ length: cantidad }, (_, i) => ({
		id: i,
		pos: ESQUINAS[i % ESQUINAS.length],
		vida: VIDA_BOT
	}));
}

export function botsVivos(bots: Bot[]): Bot[] {
	return bots.filter((b) => b.vida > 0);
}

export function eliminados(bots: Bot[]): number {
	return bots.filter((b) => b.vida <= 0).length;
}

export function todosEliminados(bots: Bot[]): boolean {
	return bots.every((b) => b.vida <= 0);
}

/** Cada bot dispara en su propio turno dentro de la cadencia. Si todos tiraran
 *  en el mismo cuadro, la salva de 3 proyectiles apuntados a la posición exacta
 *  del jugador le vaciaba la vida entera de golpe y era inesquivable. */
export function botDebeDisparar(cuadro: number, indiceBot: number = 0): boolean {
	const desfase = indiceBot * Math.floor(CADENCIA_BOT_CUADROS / CANTIDAD_BOTS);
	return cuadro > desfase && (cuadro - desfase) % CADENCIA_BOT_CUADROS === 0;
}

export function direccionDeBot(bot: Punto, jugador: Punto): Direccion {
	if (distancia(bot, jugador) <= DISTANCIA_PREFERIDA_BOT) return { dx: 0, dy: 0 };
	return direccionHacia(bot, jugador);
}

export function crearProyectil(id: number, origen: Punto, hacia: Punto, aliado: boolean): Proyectil {
	const { dx, dy } = direccionHacia(origen, hacia);
	return { id, pos: { ...origen }, dx, dy, aliado };
}

function avanzarUno(p: Proyectil): Proyectil {
	return {
		...p,
		pos: { x: p.pos.x + p.dx * VELOCIDAD_PROYECTIL, y: p.pos.y + p.dy * VELOCIDAD_PROYECTIL }
	};
}

function sigueEnVuelo(p: Proyectil): boolean {
	return dentroDeArena(p.pos) && !tocaMuro(p.pos, RADIO_PROYECTIL);
}

export function avanzarProyectiles(proyectiles: Proyectil[]): Proyectil[] {
	return proyectiles.map(avanzarUno).filter(sigueEnVuelo);
}

function botAlcanzado(p: Proyectil, bots: Bot[]): Bot | undefined {
	return botsVivos(bots).find((b) => distancia(p.pos, b.pos) <= RADIO_IMPACTO);
}

function danarBot(bots: Bot[], id: number): Bot[] {
	return bots.map((b) => (b.id === id ? { ...b, vida: Math.max(0, b.vida - 1) } : b));
}

export function impactarBots(proyectiles: Proyectil[], bots: Bot[]): ResultadoBots {
	let restantes = bots;
	const enVuelo = proyectiles.filter((p) => {
		const objetivo = p.aliado ? botAlcanzado(p, restantes) : undefined;
		if (!objetivo) return true;
		restantes = danarBot(restantes, objetivo.id);
		return false;
	});
	return { proyectiles: enVuelo, bots: restantes };
}

function golpeaAlJugador(p: Proyectil, jugador: Punto): boolean {
	return !p.aliado && distancia(p.pos, jugador) <= RADIO_IMPACTO;
}

export function impactarJugador(proyectiles: Proyectil[], jugador: Punto): ResultadoJugador {
	const enVuelo = proyectiles.filter((p) => !golpeaAlJugador(p, jugador));
	return { proyectiles: enVuelo, golpes: proyectiles.length - enVuelo.length };
}
