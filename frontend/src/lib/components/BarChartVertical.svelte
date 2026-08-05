<script lang="ts">
	type Item = { label: string; value: number; color?: string };

	let {
		items,
		loading = false,
		vacio = 'Sin datos para mostrar.'
	}: { items: Item[]; loading?: boolean; vacio?: string } = $props();

	const max = $derived(Math.max(1, ...items.map((i) => i.value)));
	let hoverIdx = $state<number | null>(null);
</script>

<div class="chart">
	{#if loading}
		<div class="columnas">
			{#each Array(5) as _, i}
				<div class="col">
					<span class="skeleton skeleton-barra" style="height: {30 + ((i * 13) % 60)}px" aria-hidden="true"></span>
					<span class="skeleton skeleton-eje" aria-hidden="true"></span>
				</div>
			{/each}
		</div>
	{:else if items.length === 0}
		<p class="vacio">{vacio}</p>
	{:else}
		<div class="columnas">
			{#each items as item, i}
				<div
					class="col"
					onmouseenter={() => (hoverIdx = i)}
					onmouseleave={() => (hoverIdx = null)}
					role="group"
				>
					{#if hoverIdx === i}
						<div class="tooltip">{item.value} · {item.label}</div>
					{/if}
					<div class="pista-vertical">
						<div
							class="barra"
							class:activa={hoverIdx === i}
							style="height: {(item.value / max) * 100}%; background: {item.color ?? 'var(--accent)'}"
						></div>
					</div>
					<span class="eje" title={item.label}>{item.label}</span>
				</div>
			{/each}
		</div>
	{/if}
</div>

<style>
	.chart {
		min-height: 160px;
	}

	.columnas {
		display: flex;
		align-items: flex-end;
		gap: 10px;
		height: 140px;
		border-bottom: 1px solid var(--border);
	}

	.col {
		flex: 1;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 6px;
		height: 100%;
		position: relative;
		min-width: 0;
	}

	.pista-vertical {
		flex: 1;
		width: 100%;
		max-width: 32px;
		display: flex;
		align-items: flex-end;
	}

	.barra {
		width: 100%;
		background: var(--accent);
		border-radius: 4px 4px 0 0;
		min-height: 3px;
		transition: filter 0.15s ease;
	}

	.barra.activa {
		filter: brightness(1.25);
	}

	.eje {
		font-size: 11px;
		color: var(--text-faint);
		max-width: 100%;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.tooltip {
		position: absolute;
		top: -26px;
		left: 50%;
		transform: translateX(-50%);
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: 4px;
		padding: 2px 8px;
		font-size: 11px;
		white-space: nowrap;
		z-index: 5;
		max-width: 220px;
		overflow: hidden;
		text-overflow: ellipsis;
	}

	.vacio {
		color: var(--text-muted);
		font-size: 13px;
	}

	.skeleton-barra {
		width: 100%;
		max-width: 32px;
		border-radius: 4px 4px 0 0;
		align-self: flex-end;
	}

	.skeleton-eje {
		width: 70%;
		height: 11px;
		border-radius: 3px;
	}
</style>
