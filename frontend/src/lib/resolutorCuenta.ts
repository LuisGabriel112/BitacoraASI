import type { Catalogo } from './api/client';

export function resolutorVinculadoA(catalogo: Catalogo[], usuarioId: number | null): Catalogo | null {
	if (usuarioId === null) return null;
	return catalogo.find((r) => r.usuario_id === usuarioId) ?? null;
}
