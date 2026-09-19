type JugadorGato = { nombre: string };
type PartidaConJugadores = { jugador_x: JugadorGato; jugador_o: JugadorGato | null };

export function miSimbolo(partida: PartidaConJugadores, miNombre: string): 'X' | 'O' | null {
	if (partida.jugador_x.nombre === miNombre) return 'X';
	if (partida.jugador_o?.nombre === miNombre) return 'O';
	return null;
}

/** Qué sonido de cierre me toca: true = victoria, false = derrota, null = nada
 *  (empate, o no soy parte de la partida). */
export function sonidoDelFinal(ganador: 'X' | 'O' | 'empate' | null, miSimbolo: 'X' | 'O' | null): boolean | null {
	if (ganador === null || ganador === 'empate' || miSimbolo === null) return null;
	return ganador === miSimbolo;
}
