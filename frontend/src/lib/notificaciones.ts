export type TipoAviso = 'exito' | 'error';

const SONIDO_POR_TIPO: Record<TipoAviso, string> = {
	exito: '/sonidos/pop-succes.ogg',
	error: '/sonidos/denied-ehh.ogg'
};

export function rutaSonidoParaAviso(tipo: TipoAviso): string {
	return SONIDO_POR_TIPO[tipo];
}
