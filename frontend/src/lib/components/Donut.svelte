<script lang="ts">
	type Segmento = { label: string; value: number; color: string };

	let { items }: { items: Segmento[] } = $props();

	const total = $derived(items.reduce((s, i) => s + i.value, 0));

	const gradiente = $derived.by(() => {
		if (total === 0) return 'var(--border-strong)';
		let acumulado = 0;
		const segmentos = items.map((i) => {
			const inicio = (acumulado / total) * 360;
			acumulado += i.value;
			const fin = (acumulado / total) * 360;
			return `${i.color} ${inicio}deg ${fin}deg`;
		});
		return `conic-gradient(${segmentos.join(', ')})`;
	});
</script>

<div class="donut-wrap">
	<div class="donut" style="background: {gradiente}" role="img" aria-label="Distribución por módulo"></div>
	<ul class="leyenda">
		{#each items as i}
			<li>
				<span class="punto" style="background: {i.color}"></span>
				<span class="etiqueta">{i.label}</span>
				<strong>{total ? Math.round((i.value / total) * 100) : 0}%</strong>
			</li>
		{/each}
	</ul>
</div>

<style>
	.donut-wrap {
		display: flex;
		align-items: center;
		gap: 22px;
		flex-wrap: wrap;
	}

	.donut {
		width: 120px;
		height: 120px;
		border-radius: 50%;
		flex-shrink: 0;
		mask: radial-gradient(farthest-side, transparent calc(100% - 22px), #000 calc(100% - 22px));
		-webkit-mask: radial-gradient(farthest-side, transparent calc(100% - 22px), #000 calc(100% - 22px));
	}

	.leyenda {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 9px;
		font-size: 13px;
		flex: 1;
		min-width: 140px;
	}

	.leyenda li {
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.punto {
		width: 10px;
		height: 10px;
		border-radius: 50%;
		flex-shrink: 0;
	}

	.etiqueta {
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		color: var(--text-muted);
	}

	.leyenda strong {
		margin-left: auto;
		font-family: var(--font-mono);
		color: var(--text);
		flex-shrink: 0;
	}
</style>
