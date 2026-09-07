export interface Punto {
	x: number;
	y: number;
}

export interface Bot {
	id: number;
	pos: Punto;
	vivo: boolean;
}

export const ANCHO_ARENA = 320;
export const ALTO_ARENA = 220;
export const RADIO_CONTACTO = 20;
export const VELOCIDAD_JUGADOR = 4;
export const VELOCIDAD_BOT = 1.6;
export const ALCANCE_DISPARO = 90;

const ESQUINAS_BOT: Punto[] = [
	{ x: 20, y: 20 },
	{ x: ANCHO_ARENA - 20, y: 20 },
	{ x: ANCHO_ARENA - 20, y: ALTO_ARENA - 20 }
];

export function limitarAArena(p: Punto): Punto {
	return {
		x: Math.min(ANCHO_ARENA, Math.max(0, p.x)),
		y: Math.min(ALTO_ARENA, Math.max(0, p.y))
	};
}

export function moverPunto(p: Punto, dx: number, dy: number, velocidad: number): Punto {
	return limitarAArena({ x: p.x + dx * velocidad, y: p.y + dy * velocidad });
}

export function distancia(a: Punto, b: Punto): number {
	return Math.hypot(a.x - b.x, a.y - b.y);
}

export function moverBotHaciaJugador(bot: Punto, jugador: Punto, velocidad: number): Punto {
	const dist = distancia(bot, jugador) || 1;
	const dx = (jugador.x - bot.x) / dist;
	const dy = (jugador.y - bot.y) / dist;
	return moverPunto(bot, dx, dy, velocidad);
}

export function crearBotsIniciales(cantidad: number): Bot[] {
	return Array.from({ length: cantidad }, (_, i) => ({
		id: i,
		pos: ESQUINAS_BOT[i % ESQUINAS_BOT.length],
		vivo: true
	}));
}

export function botMasCercano(jugador: Punto, bots: Bot[]): Bot | null {
	const vivos = bots.filter((b) => b.vivo);
	if (vivos.length === 0) return null;
	return vivos.reduce((cercano, b) => (distancia(jugador, b.pos) < distancia(jugador, cercano.pos) ? b : cercano));
}

export function disparar(jugador: Punto, bots: Bot[], alcance: number): Bot[] {
	const objetivo = botMasCercano(jugador, bots);
	if (!objetivo || distancia(jugador, objetivo.pos) > alcance) return bots;
	return bots.map((b) => (b.id === objetivo.id ? { ...b, vivo: false } : b));
}

export function jugadorFueGolpeado(jugador: Punto, bots: Bot[], radio: number): boolean {
	return bots.some((b) => b.vivo && distancia(jugador, b.pos) < radio);
}

export function enemigosEliminados(bots: Bot[]): number {
	return bots.filter((b) => !b.vivo).length;
}

export function partidaGanada(bots: Bot[]): boolean {
	return bots.every((b) => !b.vivo);
}
