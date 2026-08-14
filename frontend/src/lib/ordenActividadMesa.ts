export type MesaConActividad = { fecha_carga: string; fecha_cierre_real: string | null };

function fechaDeActividad(mesa: MesaConActividad): string {
	return mesa.fecha_cierre_real ?? mesa.fecha_carga;
}

export function ordenarPorActividadReciente<T extends MesaConActividad>(mesas: T[]): T[] {
	return [...mesas].sort((a, b) => fechaDeActividad(b).localeCompare(fechaDeActividad(a)));
}
