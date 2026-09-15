import { redirect } from '@sveltejs/kit';

// "En línea" ya vive dentro del chat; los enlaces viejos a /hub siguen sirviendo.
export function load() {
	throw redirect(301, '/chat');
}
