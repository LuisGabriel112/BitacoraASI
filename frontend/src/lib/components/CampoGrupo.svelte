<script lang="ts">
	let { grupo, children }: { grupo: 'a' | 'b'; children: import('svelte').Snippet } = $props();
</script>

<div class="campo-grupo grupo-{grupo}">
	{@render children()}
</div>

<style>
	.campo-grupo {
		border-left: 3px solid var(--grupo-color);
		padding-left: 10px;
	}

	.grupo-a {
		--grupo-color: var(--accent);
	}

	.grupo-b {
		--grupo-color: var(--accent-2);
	}
</style>
