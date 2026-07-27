import type { RequestHandler } from './$types';

const BACKEND_URL = process.env.BACKEND_URL ?? 'http://localhost:8000';

async function reenviar(evento: Parameters<RequestHandler>[0]) {
	const { params, url, request } = evento;
	const destino = `${BACKEND_URL}/${params.path}${url.search}`;

	const init: RequestInit = {
		method: request.method,
		headers: { 'Content-Type': request.headers.get('content-type') ?? 'application/json' }
	};
	if (request.method !== 'GET' && request.method !== 'HEAD') {
		init.body = await request.arrayBuffer();
	}

	const respuesta = await fetch(destino, init);
	if (respuesta.status === 204) {
		return new Response(null, { status: 204 });
	}
	const cuerpo = await respuesta.arrayBuffer();

	return new Response(cuerpo, {
		status: respuesta.status,
		headers: {
			'Content-Type': respuesta.headers.get('content-type') ?? 'application/octet-stream',
			'Content-Disposition': respuesta.headers.get('content-disposition') ?? ''
		}
	});
}

export const GET: RequestHandler = reenviar;
export const POST: RequestHandler = reenviar;
export const DELETE: RequestHandler = reenviar;
