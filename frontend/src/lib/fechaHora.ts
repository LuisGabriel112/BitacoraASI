const PATRON_FECHA_HORA = /(\d{1,2})\/(\d{1,2})\/(\d{4})\s+(\d{1,2}):(\d{2})/;

export function parsearFechaHoraPegada(texto: string): string | null {
	const m = texto.match(PATRON_FECHA_HORA);
	if (!m) return null;
	const [, dia, mes, anio, hora, min] = m;
	return `${anio}-${mes.padStart(2, '0')}-${dia.padStart(2, '0')}T${hora.padStart(2, '0')}:${min}`;
}

export function formatearFechaHora(valorGuardado: string): string {
	if (!valorGuardado) return '';
	const [fecha, hora] = valorGuardado.split('T');
	const [anio, mes, dia] = fecha.split('-');
	return `${dia}/${mes}/${anio} ${hora ?? ''}`.trim();
}
