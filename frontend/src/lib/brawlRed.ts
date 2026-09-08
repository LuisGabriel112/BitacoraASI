export interface Punto2D {
	x: number;
	y: number;
}

export interface MuroRemoto extends Punto2D {
	ancho: number;
	alto: number;
}

export interface JugadorRemoto extends Punto2D {
	id: string;
	nombre: string;
	avatar: string;
	vida: number;
	bajas: number;
}

export interface BotRemoto extends Punto2D {
	id: number;
	vida: number;
}

export interface ProyectilRemoto extends Punto2D {
	id: number;
	aliado: boolean;
}

export interface EstadoSala {
	estado: 'esperando' | 'jugando' | 'terminada';
	tick: number;
	segundos_restantes: number;
	muros: MuroRemoto[];
	jugadores: JugadorRemoto[];
	bots: BotRemoto[];
	proyectiles: ProyectilRemoto[];
}

const RUTA_WS = '/juegos/brawl/ws';

/** En desarrollo el WebSocket cruza el proxy de Vite (mismo origen, prefijo
 *  /api). En producción no puede: ese proxy es una función serverless y no
 *  sostiene conexiones WebSocket, así que el navegador va directo al backend
 *  público. De ahí que la URL del backend sea un parámetro y no una constante. */
export function urlWebSocketBrawl(origen: string, urlBackend: string, ticket: string): string {
	const base = urlBackend ? urlBackend.replace(/\/+$/, '') : `${origen}/api`;
	const conEsquemaWs = base.replace(/^http/, 'ws');
	return `${conEsquemaWs}${RUTA_WS}?ticket=${encodeURIComponent(ticket)}`;
}

/** El servidor manda 20 estados por segundo y la pantalla dibuja 60 cuadros:
 *  sin interpolar, las entidades remotas avanzarían a saltos. */
export function interpolar(previa: Punto2D | undefined, nueva: Punto2D, avance: number): Punto2D {
	if (!previa) return { x: nueva.x, y: nueva.y };
	const t = Math.min(1, Math.max(0, avance));
	return {
		x: previa.x + (nueva.x - previa.x) * t,
		y: previa.y + (nueva.y - previa.y) * t
	};
}

export function otrosJugadores(estado: EstadoSala, miId: string): JugadorRemoto[] {
	return estado.jugadores.filter((j) => j.id !== miId);
}

export function miJugador(estado: EstadoSala, miId: string): JugadorRemoto | undefined {
	return estado.jugadores.find((j) => j.id === miId);
}
