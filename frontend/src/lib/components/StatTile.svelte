<script lang="ts">
	let { label, value, loading = false }: { label: string; value: number | string; loading?: boolean } = $props();
</script>

<div class="tile">
	<span class="label">{label}</span>
	{#if loading}
		<span class="skeleton skeleton-valor" aria-hidden="true"></span>
	{:else}
		<span class="valor font-display">{value}</span>
	{/if}
</div>

<style>
	.tile {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 14px 16px;
		display: flex;
		flex-direction: column;
		gap: 6px;
		min-width: 140px;
	}

	.label {
		font-size: 12px;
		color: var(--text-muted);
	}

	.valor {
		font-size: 28px;
		font-weight: 700;
	}

	.skeleton-valor {
		height: 28px;
		width: 60px;
		border-radius: 4px;
	}
</style>
