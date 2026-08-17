type JugadorGato = { nombre: string };
type PartidaConJugadores = { jugador_x: JugadorGato; jugador_o: JugadorGato | null };

export function miSimbolo(partida: PartidaConJugadores, miNombre: string): 'X' | 'O' | null {
	if (partida.jugador_x.nombre === miNombre) return 'X';
	if (partida.jugador_o?.nombre === miNombre) return 'O';
	return null;
}
