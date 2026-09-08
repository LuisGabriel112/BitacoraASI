import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
		port: 5173,
		proxy: {
			'/api': {
				target: process.env.BACKEND_URL ?? 'http://localhost:8000',
				changeOrigin: true,
				// El WebSocket del brawl pasa por aquí en desarrollo. En producción
				// no puede: el proxy /api es una función serverless y no sostiene
				// conexiones WS, así que ahí el cliente va directo al backend.
				ws: true,
				rewrite: (path) => path.replace(/^\/api/, '')
			}
		}
	}
});
