<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import StatTile from '$lib/components/StatTile.svelte';
	import Sparkline from '$lib/components/Sparkline.svelte';
	import Donut from '$lib/components/Donut.svelte';
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
		try {
			kpis = await api.panel();
		} finally {
			cargandoKpis = false;
		}
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

	function lunesDeEstaSemana(): Date {
		const hoy = new Date();
		const d = new Date(Date.UTC(hoy.getFullYear(), hoy.getMonth(), hoy.getDate()));
		const diaIso = d.getUTCDay() || 7;
		d.setUTCDate(d.getUTCDate() - (diaIso - 1));
		return d;
	}

	const volumenSemanaCompleta = $derived.by(() => {
		if (!kpis) return [];
		const lunes = lunesDeEstaSemana();
		const mapa = new Map(kpis.volumen_diario.map((v) => [v.fecha, v.total]));
		return Array.from({ length: 7 }, (_, i) => {
			const d = new Date(lunes);
			d.setUTCDate(d.getUTCDate() + i);
			const iso = d.toISOString().slice(0, 10);
			return { fecha: iso, total: mapa.get(iso) ?? 0 };
		});
	});

	const promedioDiario = $derived(
		kpis && kpis.volumen_diario.length > 0
			? Math.round((kpis.total_semana / kpis.volumen_diario.length) * 10) / 10
			: 0
	);

	const moduloTop = $derived(kpis?.distribucion_modulo[0]?.modulo ?? '—');

	const COLORES_DONUT = ['var(--accent)', 'var(--accent-2)', 'var(--sistema-mediport)', 'var(--border-strong)'];

	const donutItems = $derived.by(() => {
		if (!kpis) return [];
		const mods = kpis.distribucion_modulo;
		const top = mods.slice(0, 3);
		const restoTotal = mods.slice(3).reduce((s, m) => s + m.total, 0);
		const items = top.map((m, i) => ({ label: m.modulo, value: m.total, color: COLORES_DONUT[i] }));
		if (restoTotal > 0) items.push({ label: 'Otros', value: restoTotal, color: COLORES_DONUT[3] });
		return items;
	});

	function diasHabilesRestantes(): number {
		const hoy = new Date();
		const diaIso = new Date(Date.UTC(hoy.getFullYear(), hoy.getMonth(), hoy.getDate())).getUTCDay() || 7;
		return diaIso <= 5 ? 5 - diaIso : 0;
	}

	function horaCorta(iso: string) {
		return new Date(iso).toLocaleTimeString('es-MX', { hour: '2-digit', minute: '2-digit' });
	}

	const ultimaActualizacion = $derived(
		kpis && kpis.recientes.length > 0 ? horaCorta(kpis.recientes[0].created_at) : '—'
	);
</script>

<Header titulo="Panel principal" subtitulo={kpis ? kpis.semana : 'Cargando semana en curso…'} />

<div class="bento">
	<section class="tarjeta tile-hero">
		<span class="label">Registros esta semana</span>
		{#if cargandoKpis}
			<span class="skeleton skeleton-hero" aria-hidden="true"></span>
		{:else}
			<span class="valor-hero font-display">{kpis?.total_semana ?? 0}</span>
			<Sparkline datos={volumenSemanaCompleta} />
		{/if}
	</section>

	<div class="tile-1x1">
		<StatTile label="Promedio diario" value={promedioDiario} loading={cargandoKpis} />
	</div>

	<div class="tile-1x1">
		<StatTile label="Módulo más frecuente" value={moduloTop} loading={cargandoKpis} />
	</div>

	<section class="tarjeta tile-donut">
		<h2 class="font-display">Distribución por módulo</h2>
		{#if cargandoKpis}
			<p class="cargando">Cargando…</p>
		{:else}
			<Donut items={donutItems} />
		{/if}
	</section>

	<section class="tarjeta tile-barras">
		<h2 class="font-display">Volumen diario</h2>
		<BarChartColumnas datos={volumenSemanaCompleta} loading={cargandoKpis} etiquetas="diaSemana" />
	</section>

	<div class="tile-1x1">
		<StatTile label="Días hábiles restantes" value={diasHabilesRestantes()} />
	</div>

	<div class="tile-1x1">
		<StatTile label="Última actualización" value={ultimaActualizacion} />
	</div>

	<section class="tarjeta tile-tabla">
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
</div>

<style>
	.bento {
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		grid-auto-rows: minmax(96px, auto);
		grid-auto-flow: dense;
		gap: 18px;
	}

	.tarjeta {
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px;
		box-shadow: 0 8px 30px -12px oklch(0 0 0 / 0.35);
	}

	.tarjeta h2 {
		font-size: 14px;
		margin: 0 0 14px;
		color: var(--text-muted);
	}

	.tile-hero {
		grid-column: span 2;
		grid-row: span 2;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}

	.tile-hero .label {
		font-size: 13px;
		color: var(--text-muted);
	}

	.valor-hero {
		font-size: 44px;
		font-weight: 700;
		line-height: 1.1;
		margin-top: 6px;
	}

	.skeleton-hero {
		display: block;
		height: 44px;
		width: 100px;
		border-radius: 6px;
		margin-top: 6px;
	}

	.tile-1x1 {
		grid-column: span 1;
		grid-row: span 1;
	}

	.tile-1x1 :global(.tile) {
		height: 100%;
		justify-content: center;
	}

	.tile-donut {
		grid-column: span 2;
		grid-row: span 2;
		display: flex;
		flex-direction: column;
	}

	.tile-barras {
		grid-column: span 2;
		grid-row: span 2;
		display: flex;
		flex-direction: column;
	}

	.tile-tabla {
		grid-column: span 4;
	}

	.cargando {
		color: var(--text-muted);
		font-size: 13px;
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

	@media (max-width: 960px) {
		.bento {
			grid-template-columns: repeat(2, 1fr);
		}

		.tile-hero,
		.tile-donut,
		.tile-barras,
		.tile-tabla {
			grid-column: span 2;
		}
	}

	@media (max-width: 640px) {
		.bento {
			grid-template-columns: 1fr;
		}

		.tile-hero,
		.tile-1x1,
		.tile-donut,
		.tile-barras,
		.tile-tabla {
			grid-column: span 1;
		}
	}
</style>
