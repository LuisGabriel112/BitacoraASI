import type { RequestHandler } from './$types';

const BACKEND_URL = process.env.BACKEND_URL ?? 'http://localhost:8000';

async function reenviar(evento: Parameters<RequestHandler>[0]) {
	const { params, url, request } = evento;
	const destino = `${BACKEND_URL}/${params.path}${url.search}`;

	const headers: Record<string, string> = {
		'Content-Type': request.headers.get('content-type') ?? 'application/json'
	};
	const cookie = request.headers.get('cookie');
	if (cookie) headers['cookie'] = cookie;

	const init: RequestInit = { method: request.method, headers };
	if (request.method !== 'GET' && request.method !== 'HEAD') {
		init.body = await request.arrayBuffer();
	}

	const respuesta = await fetch(destino, init);

	const encabezadosSalida = new Headers({
		'Content-Type': respuesta.headers.get('content-type') ?? 'application/octet-stream',
		'Content-Disposition': respuesta.headers.get('content-disposition') ?? ''
	});
	for (const valorCookie of respuesta.headers.getSetCookie()) {
		encabezadosSalida.append('set-cookie', valorCookie);
	}

	if (respuesta.status === 204) {
		return new Response(null, { status: 204, headers: encabezadosSalida });
	}
	const cuerpo = await respuesta.arrayBuffer();
	return new Response(cuerpo, { status: respuesta.status, headers: encabezadosSalida });
}

// Un metodo que falte aqui no llega al backend: SvelteKit responde 405 antes
// de entrar a `reenviar`. En desarrollo no se nota porque ahi el proxy lo hace
// Vite (vite.config.ts), que reenvia todo -- asi se escapo el PUT de
// /sonidos/{id}/acciones/{accion}, que solo fallaba en produccion.
export const GET: RequestHandler = reenviar;
export const POST: RequestHandler = reenviar;
export const PUT: RequestHandler = reenviar;
export const PATCH: RequestHandler = reenviar;
export const DELETE: RequestHandler = reenviar;
