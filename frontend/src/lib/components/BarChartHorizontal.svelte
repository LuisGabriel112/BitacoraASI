<script lang="ts">
	type Item = { label: string; value: number; color?: string; sistema?: boolean };

	let {
		items,
		loading = false,
		vacio = 'Sin datos para mostrar.'
	}: { items: Item[]; loading?: boolean; vacio?: string } = $props();

	const max = $derived(Math.max(1, ...items.map((i) => i.value)));
	let hoverIdx = $state<number | null>(null);
</script>

<div class="chart" role="img" aria-label="Gráfica de barras horizontales">
	{#if loading}
		{#each Array(5) as _, i}
			<div class="fila">
				<span class="skeleton skeleton-label" aria-hidden="true"></span>
				<span class="skeleton skeleton-barra" style="width: {90 - i * 12}%" aria-hidden="true"></span>
			</div>
		{/each}
	{:else if items.length === 0}
		<p class="vacio">{vacio}</p>
	{:else}
		{#each items as item, i}
			<div
				class="fila"
				onmouseenter={() => (hoverIdx = i)}
				onmouseleave={() => (hoverIdx = null)}
				role="listitem"
			>
				<span class="etiqueta">{item.label}</span>
				<div class="pista">
					<div
						class="barra"
						class:activa={hoverIdx === i}
						style="width: {(item.value / max) * 100}%; background: {item.color ?? 'var(--accent)'}"
					></div>
					<span class="valor">{item.value}</span>
				</div>
			</div>
		{/each}
	{/if}
</div>

<style>
	.chart {
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.fila {
		display: grid;
		grid-template-columns: 120px 1fr;
		align-items: center;
		gap: 10px;
	}

	.etiqueta {
		font-size: 12px;
		color: var(--text-muted);
		text-align: right;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.pista {
		display: flex;
		align-items: center;
		gap: 8px;
		height: 20px;
	}

	.barra {
		height: 16px;
		border-radius: 0 4px 4px 0;
		transition: filter 0.15s ease;
		min-width: 3px;
	}

	.barra.activa {
		filter: brightness(1.2);
	}

	.valor {
		font-size: 12px;
		color: var(--text-muted);
		min-width: 24px;
	}

	.vacio {
		color: var(--text-muted);
		font-size: 13px;
		padding: 12px 0;
	}

	.skeleton-label {
		width: 100px;
		height: 12px;
		border-radius: 3px;
	}

	.skeleton-barra {
		height: 16px;
		border-radius: 0 4px 4px 0;
	}
</style>
