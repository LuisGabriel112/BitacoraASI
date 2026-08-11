<script lang="ts">
	import { page } from '$app/stores';
	import '../lib/tokens.css';
	import Nav from '$lib/components/Nav.svelte';
	import { api } from '$lib/api/client';
	import { cargarPersonaje } from '$lib/personaje.svelte';

	const INTERVALO_HEARTBEAT_MS = 25_000;

	let { children } = $props();
	const enLogin = $derived($page.url.pathname.startsWith('/login'));

	$effect(() => {
		if (enLogin) return;
		cargarPersonaje();
		api.heartbeat();
		const id = setInterval(() => api.heartbeat(), INTERVALO_HEARTBEAT_MS);
		return () => clearInterval(id);
	});
</script>

<div class="fondo-decorativo" aria-hidden="true">
	<span class="blob blob-1"></span>
	<span class="blob blob-2"></span>
	<span class="blob blob-3"></span>
</div>

<div class="app">
	{#if !enLogin}
		<Nav />
	{/if}
	<main class:sin-nav={enLogin}>
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

	main.sin-nav {
		padding: 0;
	}
</style>
