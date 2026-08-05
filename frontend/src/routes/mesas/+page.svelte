<script lang="ts">
	import Sparkline from '$lib/components/Sparkline.svelte';
	import BarChartVertical from '$lib/components/BarChartVertical.svelte';
	import BarChartColumnas from '$lib/components/BarChartColumnas.svelte';
	import Header from '$lib/components/Header.svelte';
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

	const ventanaChartItems = $derived(
		kpis ? kpis.distribucion_ventana.map((d) => ({ label: d.ventana, value: d.total })) : []
	);
	const categoriaSolucionChartItems = $derived(
		kpis ? kpis.distribucion_categoria_solucion.map((d) => ({ label: d.categoria_solucion, value: d.total })) : []
	);

	let expandidaId = $state<number | null>(null);

	function alternarSolucion(m: { id: number; solucion: string | null }) {
		if (!m.solucion) return;
		expandidaId = expandidaId === m.id ? null : m.id;
	}

	function noPropagar(e: Event) {
		e.stopPropagation();
	}
</script>

<Header titulo="Panel de mesas" subtitulo={kpis ? kpis.semana : 'Cargando semana en curso…'} />

<div class="bento">
	<section class="tarjeta tile-hero">
		<span class="label">Mesas esta semana</span>
		{#if cargandoKpis}
			<span class="skeleton skeleton-hero" aria-hidden="true"></span>
		{:else}
			<span class="valor-hero font-display">{kpis?.total_semana ?? 0}</span>
			<Sparkline datos={volumenSemanaCompleta} />
		{/if}
	</section>

	<section class="tarjeta tile-resolutor">
		<h2 class="font-display">Por ventana</h2>
		<BarChartVertical items={ventanaChartItems} loading={cargandoKpis} />
	</section>

	<section class="tarjeta tile-barras">
		<h2 class="font-display">Por categoría de solución</h2>
		<BarChartVertical items={categoriaSolucionChartItems} loading={cargandoKpis} vacio="Aún no hay mesas cerradas con categoría de solución esta semana." />
	</section>

	<section class="tarjeta tile-barras">
		<h2 class="font-display">Volumen diario</h2>
		<BarChartColumnas datos={volumenSemanaCompleta} loading={cargandoKpis} etiquetas="diaSemana" />
	</section>

	<section class="tarjeta tile-tabla">
		<h2 class="font-display">Mesas recientes</h2>
		<div class="tabla-wrap">
			<table>
				<thead>
					<tr>
						<th>Código</th>
						<th>Título</th>
						<th>Ventana</th>
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
							<tr class:clicable={!!m.solucion} title={m.solucion ? 'Ver solución' : undefined} onclick={() => alternarSolucion(m)}>
								<td class="codigo" onclick={noPropagar}>
									{#if m.enlace}
										<a href={m.enlace} target="_blank" rel="noopener noreferrer" class="link-codigo" title="Abrir en Proactivanet">
											{m.codigo} ↗
										</a>
									{:else}
										<span class="sin-enlace">{m.codigo}</span>
									{/if}
								</td>
								<td class="titulo-col">{m.titulo}</td>
								<td>{m.ventana?.nombre ?? '—'}</td>
								<td>{m.solicitante.nombre}</td>
								<td>{m.resolutor.nombre}</td>
								<td>
									<span class="chip-estado" class:cerrada={!!m.fecha_cierre_real}>
										{m.fecha_cierre_real ? 'Cerrada' : 'Abierta'}
									</span>
								</td>
							</tr>
							{#if expandidaId === m.id}
								<tr class="fila-solucion">
									<td colspan="6">
										<div class="detalle-solucion">
											<span class="detalle-etiqueta">Solución</span>
											<p class="detalle-texto">{m.solucion}</p>
											{#if m.tipo_solucion}
												<span class="detalle-tipo">{m.tipo_solucion}</span>
											{/if}
										</div>
									</td>
								</tr>
							{/if}
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

	.tile-resolutor {
		grid-column: span 2;
		grid-row: span 2;
		display: flex;
		flex-direction: column;
	}

	.tile-barras,
	.tile-tabla {
		grid-column: span 4;
	}

	.tile-barras {
		display: flex;
		flex-direction: column;
	}

	.tabla-wrap {
		overflow-x: auto;
	}

	@media (max-width: 960px) {
		.bento {
			grid-template-columns: repeat(2, 1fr);
		}

		.tile-hero,
		.tile-resolutor,
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
		.tile-resolutor,
		.tile-barras,
		.tile-tabla {
			grid-column: span 1;
		}
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

	tbody tr.clicable {
		cursor: pointer;
	}

	.fila-solucion td {
		background: var(--surface-raised);
		border-bottom: 1px solid var(--border);
	}

	.detalle-solucion {
		display: flex;
		flex-direction: column;
		gap: 6px;
		padding: 10px 4px;
	}

	.detalle-etiqueta {
		font-size: 11px;
		text-transform: uppercase;
		letter-spacing: 0.04em;
		color: var(--text-muted);
		font-weight: 600;
	}

	.detalle-texto {
		margin: 0;
		font-size: 13px;
		color: var(--text);
		white-space: pre-wrap;
	}

	.detalle-tipo {
		align-self: flex-start;
		font-size: 11px;
		color: var(--text-muted);
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: 999px;
		padding: 3px 10px;
	}

	/* misma distinción que en Listado de mesas: la celda de código abre el
	   enlace, el resto de la fila despliega la solución. */
	.codigo {
		font-family: var(--font-mono);
		padding: 0;
		background: color-mix(in srgb, var(--accent) 7%, transparent);
		border-left: 2px solid color-mix(in srgb, var(--accent) 35%, transparent);
	}

	.codigo .link-codigo,
	.codigo .sin-enlace {
		display: flex;
		align-items: center;
		height: 100%;
		padding: 9px 10px;
	}

	.codigo .link-codigo:hover {
		background: color-mix(in srgb, var(--accent) 16%, transparent);
	}

	.link-codigo {
		color: var(--text);
		text-decoration: none;
	}

	.link-codigo:hover {
		color: var(--accent-strong);
		text-decoration: underline;
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
