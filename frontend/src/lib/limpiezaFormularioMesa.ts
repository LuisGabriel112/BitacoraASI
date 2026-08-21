type ConResolutor = { resolutorId: number | null; resolutorNombre: string };

export function limpiarExceptoResolutor<T extends ConResolutor>(actual: T, vacio: T): T {
	return { ...vacio, resolutorId: actual.resolutorId, resolutorNombre: actual.resolutorNombre };
}
