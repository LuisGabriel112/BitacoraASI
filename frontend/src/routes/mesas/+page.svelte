<script lang="ts">
	import StatTile from '$lib/components/StatTile.svelte';
	import BarChartHorizontal from '$lib/components/BarChartHorizontal.svelte';
	import BarChartColumnas from '$lib/components/BarChartColumnas.svelte';
	import { api, type PanelMesasKPIs } from '$lib/api/client';

	let kpis = $state<PanelMesasKPIs | null>(null);
	let cargandoKpis = $state(true);

	async function cargarPanel() {
		cargandoKpis = true;
		try {
			kpis = await api.panelMesas();
		} finally {
			cargandoKpis = false;
		}
	}

	$effect(() => {
		cargarPanel();
	});

	const resolutorChartItems = $derived(
		kpis ? kpis.distribucion_resolutor.map((d) => ({ label: d.resolutor, value: d.total })) : []
	);
</script>

<h1 class="font-display">Panel de mesas</h1>
<p class="subtitulo">{kpis ? kpis.semana : 'Cargando semana en curso…'}</p>

<div class="kpis">
	<StatTile label="Mesas esta semana" value={kpis?.total_semana ?? 0} loading={cargandoKpis} />
	{#each Object.entries(kpis?.por_categoria ?? {}) as [nombre, total]}
		<StatTile label={nombre} value={total} loading={cargandoKpis} />
	{/each}
</div>

<div class="graficas">
	<section class="tarjeta">
		<h2 class="font-display">Volumen diario</h2>
		<BarChartColumnas datos={kpis?.volumen_diario ?? []} loading={cargandoKpis} />
	</section>
	<section class="tarjeta">
		<h2 class="font-display">Carga por resolutor</h2>
		<BarChartHorizontal items={resolutorChartItems} loading={cargandoKpis} />
	</section>
</div>

<section class="tarjeta">
	<h2 class="font-display">Mesas recientes</h2>
	<div class="tabla-wrap">
		<table>
			<thead>
				<tr>
					<th>Código</th>
					<th>Título</th>
					<th>Categoría</th>
					<th>Solicitante</th>
					<th>Resolutor</th>
					<th>Estado</th>
				</tr>
			</thead>
			<tbody>
				{#if cargandoKpis}
					{#each Array(5) as _}
						<tr>
							{#each Array(6) as _}
								<td><span class="skeleton skeleton-celda" aria-hidden="true"></span></td>
							{/each}
						</tr>
					{/each}
				{:else if (kpis?.recientes.length ?? 0) === 0}
					<tr><td colspan="6" class="vacio">Ninguna mesa esta semana.</td></tr>
				{:else}
					{#each kpis?.recientes ?? [] as m}
						<tr>
							<td class="codigo">{m.codigo}</td>
							<td class="titulo-col">{m.titulo}</td>
							<td>{m.categoria.nombre}</td>
							<td>{m.solicitante.nombre}</td>
							<td>{m.resolutor.nombre}</td>
							<td>
								<span class="chip-estado" class:cerrada={!!m.fecha_cierre_real}>
									{m.fecha_cierre_real ? 'Cerrada' : 'Abierta'}
								</span>
							</td>
						</tr>
					{/each}
				{/if}
			</tbody>
		</table>
	</div>
</section>

<style>
	.subtitulo {
		color: var(--text-muted);
		margin-top: -8px;
		margin-bottom: 20px;
		font-size: 13px;
		font-family: var(--font-mono);
	}

	.kpis {
		display: flex;
		gap: 12px;
		flex-wrap: wrap;
		margin-bottom: 20px;
	}

	.kpis :global(.tile) {
		flex: 1 1 140px;
	}

	.graficas {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 16px;
		margin-bottom: 20px;
	}

	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px;
		margin-bottom: 16px;
	}

	.tarjeta h2 {
		font-size: 14px;
		margin: 0 0 14px;
		color: var(--text-muted);
	}

	.tabla-wrap {
		overflow-x: auto;
	}

	table {
		width: 100%;
		border-collapse: collapse;
		font-size: 13px;
	}

	th {
		text-align: left;
		color: var(--text-muted);
		font-weight: 500;
		font-size: 11px;
		text-transform: uppercase;
		letter-spacing: 0.04em;
		padding: 8px 10px;
		border-bottom: 1px solid var(--border-strong);
	}

	td {
		padding: 9px 10px;
		border-bottom: 1px solid var(--border);
	}

	tbody tr:hover {
		background: var(--surface-raised);
	}

	.codigo {
		font-family: var(--font-mono);
	}

	.titulo-col {
		max-width: 260px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.chip-estado {
		display: inline-block;
		padding: 3px 8px;
		border-radius: var(--radius);
		font-size: 11px;
		font-weight: 600;
		background: color-mix(in srgb, var(--accent) 16%, transparent);
		color: var(--accent-strong);
	}

	.chip-estado.cerrada {
		background: color-mix(in srgb, var(--success) 16%, transparent);
		color: var(--success);
	}

	.vacio {
		color: var(--text-muted);
		text-align: center;
		padding: 20px;
	}

	.skeleton-celda {
		display: block;
		height: 12px;
		width: 80%;
		border-radius: 3px;
	}
</style>
