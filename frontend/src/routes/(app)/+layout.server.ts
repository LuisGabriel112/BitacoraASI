import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';
import { debeRedirigirALogin } from '$lib/authGate';

const BACKEND_URL = process.env.BACKEND_URL ?? 'http://localhost:8000';

export const load: LayoutServerLoad = async ({ request, fetch }) => {
	const cookie = request.headers.get('cookie');
	const respuesta = await fetch(`${BACKEND_URL}/auth/me`, {
		headers: cookie ? { cookie } : {}
	});

	if (debeRedirigirALogin(respuesta.ok)) throw redirect(303, '/login');
	return {};
};
