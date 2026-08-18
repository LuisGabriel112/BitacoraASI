<script lang="ts">
	import Nav from '$lib/components/Nav.svelte';
	import { api } from '$lib/api/client';
	import { cargarPersonaje } from '$lib/personaje.svelte';

	const INTERVALO_HEARTBEAT_MS = 25_000;

	let { children } = $props();

	$effect(() => {
		cargarPersonaje();
		api.heartbeat();
		const id = setInterval(() => api.heartbeat(), INTERVALO_HEARTBEAT_MS);
		return () => clearInterval(id);
	});
</script>

<div class="app">
	<Nav />
	<main>
		{@render children()}
	</main>
</div>

<style>
	.app {
		display: flex;
		min-height: 100vh;
	}

	main {
		flex: 1;
		min-width: 0;
		padding: 24px 28px;
	}
</style>
