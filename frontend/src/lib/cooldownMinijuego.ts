export const COOLDOWN_MS = 5 * 60_000;

export function segundosRestantesCooldown(
	ultimoIntentoMs: number | null,
	ahoraMs: number,
	cooldownMs: number = COOLDOWN_MS
): number {
	if (ultimoIntentoMs === null) return 0;
	const restanteMs = cooldownMs - (ahoraMs - ultimoIntentoMs);
	return Math.max(0, Math.ceil(restanteMs / 1000));
}
