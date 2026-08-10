import type { Handle } from '@sveltejs/kit';
import { ipPermitida } from '$lib/accesoRed';

export const handle: Handle = async ({ event, resolve }) => {
	const ip = event.getClientAddress();
	if (!ipPermitida(ip, process.env.IPS_PERMITIDAS)) {
		return new Response('Acceso restringido a la red autorizada.', { status: 403 });
	}
	return resolve(event);
};
