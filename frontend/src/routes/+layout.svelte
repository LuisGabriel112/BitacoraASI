<script lang="ts">
	import '../lib/tokens.css';
	import Nav from '$lib/components/Nav.svelte';

	let { children } = $props();
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
