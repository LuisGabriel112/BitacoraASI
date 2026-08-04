<script lang="ts">
	let { datos }: { datos: { fecha: string; total: number }[] } = $props();

	const max = $derived(Math.max(1, ...datos.map((d) => d.total)));
</script>

<div class="sparkline" role="img" aria-label="Tendencia de registros por día esta semana">
	{#each datos as d}
		<div class="barra" style="height: {(d.total / max) * 100}%" title="{d.fecha}: {d.total}"></div>
	{/each}
</div>

<style>
	.sparkline {
		display: flex;
		align-items: flex-end;
		gap: 4px;
		height: 40px;
		margin-top: 14px;
	}

	.barra {
		flex: 1;
		background: var(--accent);
		border-radius: 2px;
		min-height: 2px;
	}
</style>
