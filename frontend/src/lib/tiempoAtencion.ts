// Una jornada de 24 h acota el dato: arriba de eso es captura errónea, no un soporte real.
const MINUTOS_MINIMOS = 1;
const MINUTOS_MAXIMOS = 1440;
const MINUTOS_POR_HORA = 60;

const ERROR_NO_ENTERO = 'El tiempo debe ser un número entero de minutos';
const ERROR_FUERA_DE_RANGO = `El tiempo debe estar entre ${MINUTOS_MINIMOS} y ${MINUTOS_MAXIMOS} minutos`;

export type TiempoParseado = { minutos: number | null; error: string | null };

export function parsearMinutosAtencion(texto: string): TiempoParseado {
	const limpio = texto.trim();
	if (limpio === '') return { minutos: null, error: null };
	if (!/^-?\d+$/.test(limpio)) return { minutos: null, error: ERROR_NO_ENTERO };

	const minutos = Number(limpio);
	if (minutos < MINUTOS_MINIMOS || minutos > MINUTOS_MAXIMOS) {
		return { minutos: null, error: ERROR_FUERA_DE_RANGO };
	}
	return { minutos, error: null };
}

export function formatearMinutosAtencion(minutos: number | null): string {
	if (minutos === null) return '—';

	const horas = Math.floor(minutos / MINUTOS_POR_HORA);
	const restantes = minutos % MINUTOS_POR_HORA;
	if (horas === 0) return `${restantes} min`;
	return restantes === 0 ? `${horas} h` : `${horas} h ${restantes} min`;
}
