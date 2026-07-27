<script lang="ts">
	import StatTile from '$lib/components/StatTile.svelte';
	import BarChartHorizontal from '$lib/components/BarChartHorizontal.svelte';
	import BarChartColumnas from '$lib/components/BarChartColumnas.svelte';
	import ChipSistema from '$lib/components/ChipSistema.svelte';
	import SelectCatalogo from '$lib/components/SelectCatalogo.svelte';
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import { api, type PanelKPIs, type Registro } from '$lib/api/client';

	let kpis = $state<PanelKPIs | null>(null);
	let cargandoKpis = $state(true);

	let empresaId = $state<number | null>(null);
	let sistemaId = $state<number | null>(null);
	let medioId = $state<number | null>(null);
	let moduloId = $state<number | null>(null);

	let recientes = $state<Registro[]>([]);
	let cargandoTabla = $state(true);

	async function cargarPanel() {
		cargandoKpis = true;
		kpis = await api.panel();
		cargandoKpis = false;
	}

	async function cargarTabla() {
		cargandoTabla = true;
		try {
			const pagina = await api.listado({
				page: 1,
				page_size: 10,
				empresa_id: empresaId ?? undefined,
				sistema_id: sistemaId ?? undefined,
				medio_id: medioId ?? undefined,
				modulo_id: moduloId ?? undefined
			});
			recientes = pagina.items;
		} finally {
			cargandoTabla = false;
		}
	}

	$effect(() => {
		cargarPanel();
	});

	$effect(() => {
		// re-fetch al cambiar cualquier filtro
		empresaId; sistemaId; medioId; moduloId;
		cargarTabla();
	});

	const sistemaChartItems = $derived(
		kpis
			? Object.entries(kpis.por_sistema).map(([label, value]) => ({
					label,
					value,
					color: `var(--sistema-${label.toLowerCase()}, var(--accent))`
				}))
			: []
	);

	const moduloChartItems = $derived(
		kpis ? kpis.distribucion_modulo.map((d) => ({ label: d.modulo, value: d.total })) : []
	);
</script>

<h1 class="font-display">Panel principal</h1>
<p class="subtitulo">{kpis ? kpis.semana : 'Cargando semana en curso…'}</p>

<div class="kpis">
	<StatTile label="Registros esta semana" value={kpis?.total_semana ?? 0} loading={cargandoKpis} />
	{#each Object.entries(kpis?.por_sistema ?? {}) as [nombre, total]}
		<StatTile label={nombre} value={total} loading={cargandoKpis} />
	{/each}
</div>

<div class="graficas">
	<section class="tarjeta">
		<h2 class="font-display">Volumen diario</h2>
		<BarChartColumnas datos={kpis?.volumen_diario ?? []} loading={cargandoKpis} />
	</section>
	<section class="tarjeta">
		<h2 class="font-display">Distribución por módulo</h2>
		<BarChartHorizontal items={moduloChartItems} loading={cargandoKpis} />
	</section>
</div>

<section class="tarjeta">
	<div class="tarjeta-cabecera">
		<h2 class="font-display">Registros recientes</h2>
		<div class="filtros">
			<ComboboxCreatable id="f-empresa" catalogo="empresas" label="Empresa" bind:selectedId={empresaId} />
			<SelectCatalogo id="f-sistema" catalogo="sistemas" label="Sistema" bind:selectedId={sistemaId} />
			<SelectCatalogo id="f-medio" catalogo="medios" label="Medio" bind:selectedId={medioId} />
			<ComboboxCreatable id="f-modulo" catalogo="modulos" label="Módulo" bind:selectedId={moduloId} />
		</div>
	</div>

	<div class="tabla-wrap">
		<table>
			<thead>
				<tr>
					<th>Fecha</th>
					<th>Empresa</th>
					<th>Sistema</th>
					<th>Módulo</th>
					<th>Atendió</th>
					<th>Descripción</th>
				</tr>
			</thead>
			<tbody>
				{#if cargandoTabla}
					{#each Array(5) as _}
						<tr>
							{#each Array(6) as _}
								<td><span class="skeleton skeleton-celda" aria-hidden="true"></span></td>
							{/each}
						</tr>
					{/each}
				{:else if recientes.length === 0}
					<tr><td colspan="6" class="vacio">Ningún registro con estos filtros. Ajusta empresa, sistema o módulo.</td></tr>
				{:else}
					{#each recientes as r}
						<tr>
							<td>{r.fecha}</td>
							<td>{r.empresa.nombre}</td>
							<td><ChipSistema nombre={r.sistema.nombre} /></td>
							<td>{r.modulo.nombre}</td>
							<td>{r.atendio.nombre}</td>
							<td class="descripcion">{r.descripcion}</td>
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
	}

	.tarjeta h2 {
		font-size: 14px;
		margin: 0 0 14px;
		color: var(--text-muted);
	}

	.tarjeta-cabecera {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
		gap: 16px;
		margin-bottom: 14px;
		flex-wrap: wrap;
	}

	.filtros {
		display: flex;
		gap: 10px;
		flex-wrap: wrap;
		min-width: 280px;
	}

	.filtros :global(.campo) {
		min-width: 130px;
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

	tbody tr:focus-within {
		outline: 2px solid var(--accent);
		outline-offset: -2px;
	}

	.descripcion {
		max-width: 320px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
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
