export const COOLDOWN_MS = 5 * 60_000;

export function segundosRestantesCooldown(ultimoIntentoMs: number | null, ahoraMs: number): number {
	if (ultimoIntentoMs === null) return 0;
	const restanteMs = COOLDOWN_MS - (ahoraMs - ultimoIntentoMs);
	return Math.max(0, Math.ceil(restanteMs / 1000));
}
