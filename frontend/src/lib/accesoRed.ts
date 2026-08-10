const IPS_LOCALES = ['127.0.0.1', '::1'];
const IPS_POR_DEFECTO = '189.240.215.209';

export function ipsPermitidas(configuradas: string | undefined): string[] {
	const lista = (configuradas ?? IPS_POR_DEFECTO)
		.split(',')
		.map((ip) => ip.trim())
		.filter(Boolean);
	return [...lista, ...IPS_LOCALES];
}

export function ipPermitida(ip: string, configuradas?: string): boolean {
	return ipsPermitidas(configuradas).includes(ip);
}
