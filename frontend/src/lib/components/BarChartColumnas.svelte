<script lang="ts">
	type Punto = { fecha: string; total: number };

	let { datos, loading = false }: { datos: Punto[]; loading?: boolean } = $props();

	const max = $derived(Math.max(1, ...datos.map((d) => d.total)));
	let hoverIdx = $state<number | null>(null);

	function diaCorto(iso: string) {
		const [, m, d] = iso.split('-');
		return `${d}/${m}`;
	}
</script>

<div class="chart">
	{#if loading}
		<div class="columnas">
			{#each Array(7) as _, i}
				<div class="col">
					<span class="skeleton skeleton-barra" style="height: {30 + ((i * 13) % 60)}px" aria-hidden="true"></span>
					<span class="skeleton skeleton-eje" aria-hidden="true"></span>
				</div>
			{/each}
		</div>
	{:else if datos.length === 0}
		<p class="vacio">Sin registros esta semana. Nada que graficar todavía.</p>
	{:else}
		<div class="columnas">
			{#each datos as punto, i}
				<div
					class="col"
					onmouseenter={() => (hoverIdx = i)}
					onmouseleave={() => (hoverIdx = null)}
					role="group"
				>
					{#if hoverIdx === i}
						<div class="tooltip">{punto.total} · {diaCorto(punto.fecha)}</div>
					{/if}
					<div class="pista-vertical">
						<div
							class="barra"
							class:activa={hoverIdx === i}
							style="height: {(punto.total / max) * 100}%"
						></div>
					</div>
					<span class="eje">{diaCorto(punto.fecha)}</span>
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
	}

	.pista-vertical {
		flex: 1;
		width: 100%;
		max-width: 28px;
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
		background: var(--accent-strong);
	}

	.eje {
		font-size: 11px;
		color: var(--text-faint);
	}

	.tooltip {
		position: absolute;
		top: -26px;
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: 4px;
		padding: 2px 8px;
		font-size: 11px;
		white-space: nowrap;
		z-index: 5;
	}

	.vacio {
		color: var(--text-muted);
		font-size: 13px;
	}

	.skeleton-barra {
		width: 100%;
		max-width: 28px;
		border-radius: 4px 4px 0 0;
		align-self: flex-end;
	}

	.skeleton-eje {
		width: 22px;
		height: 11px;
		border-radius: 3px;
	}
</style>
