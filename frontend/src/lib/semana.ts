function isoWeekInfo(d: Date) {
	const date = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
	const day = date.getUTCDay() || 7;
	date.setUTCDate(date.getUTCDate() + 4 - day);
	const yearStart = new Date(Date.UTC(date.getUTCFullYear(), 0, 1));
	const week = Math.ceil(((date.getTime() - yearStart.getTime()) / 86400000 + 1) / 7);
	return { year: date.getUTCFullYear(), week, isoWeekday: day };
}

export function semanaActual(): { etiqueta: string; diaIso: number; progreso: number } {
	const hoy = new Date();
	const { year, week, isoWeekday } = isoWeekInfo(hoy);
	return {
		etiqueta: `SEM ${String(week).padStart(2, '0')} - ${year}`,
		diaIso: isoWeekday,
		progreso: isoWeekday / 7
	};
}
