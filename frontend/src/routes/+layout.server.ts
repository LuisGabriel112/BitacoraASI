import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';

const BACKEND_URL = process.env.BACKEND_URL ?? 'http://localhost:8000';

export const load: LayoutServerLoad = async ({ request, url, fetch }) => {
	if (url.pathname.startsWith('/login')) return {};

	const cookie = request.headers.get('cookie');
	const respuesta = await fetch(`${BACKEND_URL}/auth/me`, {
		headers: cookie ? { cookie } : {}
	});

	if (!respuesta.ok) throw redirect(303, '/login');
	return {};
};
