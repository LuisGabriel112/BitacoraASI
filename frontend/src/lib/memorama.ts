export function generarMazo(simbolos: string[], aleatorio: () => number = Math.random): string[] {
	const mazo = [...simbolos, ...simbolos];
	for (let i = mazo.length - 1; i > 0; i--) {
		const j = Math.floor(aleatorio() * (i + 1));
		[mazo[i], mazo[j]] = [mazo[j], mazo[i]];
	}
	return mazo;
}
