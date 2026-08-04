<script lang="ts">
	import BarChartHorizontal from '$lib/components/BarChartHorizontal.svelte';
	import { api, type GrupoSoporte, type ReporteMesasSemanal } from '$lib/api/client';

	function formatearFechaHora(iso: string) {
		const [fecha, hora] = iso.split('T');
		const [anio, mes, dia] = fecha.split('-');
		return `${dia}/${mes}/${anio} ${hora?.slice(0, 5) ?? ''}`;
	}

	function semanaISOActual() {
		const hoy = new Date();
		const d = new Date(Date.UTC(hoy.getFullYear(), hoy.getMonth(), hoy.getDate()));
		const day = d.getUTCDay() || 7;
		d.setUTCDate(d.getUTCDate() + 4 - day);
		const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
		const week = Math.ceil(((d.getTime() - yearStart.getTime()) / 86400000 + 1) / 7);
		return `${d.getUTCFullYear()}-W${String(week).padStart(2, '0')}`;
	}

	function semanaInputAEtiqueta(valor: string) {
		const [anio, semana] = valor.split('-W');
		return `SEM ${semana} - ${anio}`;
	}

	function sumarSemanas(valor: string, delta: number) {
		const [anioStr, semanaStr] = valor.split('-W');
		const anio = Number(anioStr);
		const semana = Number(semanaStr);
		const base = new Date(Date.UTC(anio, 0, 1 + (semana - 1) * 7));
		base.setUTCDate(base.getUTCDate() + delta * 7);
		const day = base.getUTCDay() || 7;
		base.setUTCDate(base.getUTCDate() + 4 - day);
		const yearStart = new Date(Date.UTC(base.getUTCFullYear(), 0, 1));
		const w = Math.ceil(((base.getTime() - yearStart.getTime()) / 86400000 + 1) / 7);
		return `${base.getUTCFullYear()}-W${String(w).padStart(2, '0')}`;
	}

	let semanaInput = $state(semanaISOActual());
	let reporte = $state<ReporteMesasSemanal | null>(null);
	let cargando = $state(true);
	let grupos = $state<GrupoSoporte[] | null>(null);
	let gruposCargando = $state(false);
	let gruposError = $state<string | null>(null);

	const semanaEtiqueta = $derived(semanaInputAEtiqueta(semanaInput));

	async function cargar() {
		cargando = true;
		try {
			reporte = await api.reporteMesas(semanaEtiqueta);
		} finally {
			cargando = false;
		}
	}

	async function cargarGrupos() {
		gruposCargando = true;
		gruposError = null;
		try {
			grupos = await api.temasFrecuentesMesas(semanaEtiqueta);
		} catch (e) {
			gruposError = e instanceof Error ? e.message : 'No se pudo analizar la similitud de descripciones.';
			grupos = null;
		} finally {
			gruposCargando = false;
		}
	}

	$effect(() => {
		semanaEtiqueta;
		cargar();
		cargarGrupos();
	});

	const solicitanteItems = $derived(
		reporte ? Object.entries(reporte.por_solicitante).map(([label, value]) => ({ label, value })) : []
	);
	const resolutorItems = $derived(
		reporte ? Object.entries(reporte.por_resolutor).map(([label, value]) => ({ label, value })) : []
	);
</script>

<h1 class="font-display">Reporte semanal de mesas</h1>

<div class="selector-semana">
	<button onclick={() => (semanaInput = sumarSemanas(semanaInput, -1))} aria-label="Semana anterior">←</button>
	<input type="week" bind:value={semanaInput} />
	<button onclick={() => (semanaInput = sumarSemanas(semanaInput, 1))} aria-label="Semana siguiente">→</button>
	<a href={api.exportMesasUrl('xlsx', { semana: semanaEtiqueta })} class="boton-excel">Exportar Excel</a>
</div>

{#if cargando}
	<p class="cargando">Cargando reporte de {semanaEtiqueta}…</p>
{:else if !reporte || reporte.total === 0}
	<div class="tarjeta vacio">
		<p>No hubo mesas en {semanaEtiqueta}. Elige otra semana o abre la primera mesa.</p>
	</div>
{:else}
	<section class="tarjeta">
		<h2 class="font-display">Resumen ejecutivo</h2>
		<p>
			Durante <strong>{semanaEtiqueta}</strong> se abrieron <strong>{reporte.total}</strong> mesas,
			distribuidas entre {Object.keys(reporte.por_categoria).length} categorías y
			{Object.keys(reporte.por_solicitante).length} solicitantes.
		</p>
		<div class="chips-categoria">
			{#each Object.entries(reporte.por_categoria) as [nombre, total]}
				<div class="chip-total">
					<span class="chip">{nombre}</span>
					<span>{total}</span>
				</div>
			{/each}
		</div>
	</section>

	<div class="graficas">
		<section class="tarjeta">
			<h2 class="font-display">Por solicitante</h2>
			<BarChartHorizontal items={solicitanteItems} />
		</section>
		<section class="tarjeta">
			<h2 class="font-display">Por resolutor</h2>
			<BarChartHorizontal items={resolutorItems} />
		</section>
	</div>

	<section class="tarjeta">
		<h2 class="font-display">Temas más frecuentes</h2>
		{#if gruposCargando}
			<p class="cargando">Analizando similitud de descripciones…</p>
		{:else if gruposError}
			<p class="grupos-error">{gruposError}</p>
		{:else if !grupos || grupos.length === 0}
			<p class="cargando">No se detectaron mesas que se repitan esta semana.</p>
		{:else}
			<ul class="lista-grupos">
				{#each grupos as g}
					<li class="grupo">
						<span class="grupo-cantidad">{g.cantidad}×</span>
						<span class="grupo-descripcion">{g.tema}</span>
					</li>
				{/each}
			</ul>
		{/if}
	</section>

	<section class="tarjeta">
		<h2 class="font-display">Detalle completo — {semanaEtiqueta}</h2>
		<div class="tabla-wrap">
			<table>
				<thead>
					<tr>
						<th>Código</th><th>Título</th><th>Fecha carga</th><th>Ventana</th><th>Solicitante</th><th>Resolutor</th><th>Estado</th><th>Descripción</th>
					</tr>
				</thead>
				<tbody>
					{#each reporte.mesas as m}
						<tr>
							<td class="codigo">
							{#if m.enlace}
								<a href={m.enlace} target="_blank" rel="noopener noreferrer" class="link-codigo" title="Abrir en Proactivanet">
									{m.codigo} ↗
								</a>
							{:else}
								{m.codigo}
							{/if}
						</td>
							<td>{m.titulo}</td>
							<td>{formatearFechaHora(m.fecha_carga)}</td>
							<td>{m.ventana.nombre}</td>
							<td>{m.solicitante.nombre}</td>
							<td>{m.resolutor.nombre}</td>
							<td>
								<span class="chip-estado" class:cerrada={!!m.fecha_cierre_real}>
									{m.fecha_cierre_real ? 'Cerrada' : 'Abierta'}
								</span>
							</td>
							<td class="descripcion">{m.descripcion}</td>
						</tr>
					{/each}
				</tbody>
			</table>
		</div>
	</section>
{/if}

<style>
	.selector-semana {
		display: flex;
		align-items: center;
		gap: 10px;
		margin-bottom: 20px;
	}

	.selector-semana button {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		width: 40px;
		height: 40px;
		color: var(--text);
		cursor: pointer;
	}

	.selector-semana button:hover {
		border-color: var(--accent);
	}

	.selector-semana input[type='week'] {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 7px 10px;
		color: var(--text);
	}

	.boton-excel {
		margin-left: auto;
		background: var(--accent);
		color: var(--bg);
		border-radius: var(--radius);
		padding: 8px 16px;
		text-decoration: none;
		font-weight: 600;
		font-family: var(--font-display);
	}

	.boton-excel:hover {
		background: var(--accent-strong);
	}

	.cargando {
		color: var(--text-muted);
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
		margin: 0 0 12px;
		color: var(--text-muted);
	}

	.tarjeta.vacio {
		color: var(--text-muted);
	}

	.chips-categoria {
		display: flex;
		gap: 16px;
		margin-top: 14px;
		flex-wrap: wrap;
	}

	.chip-total {
		display: flex;
		align-items: center;
		gap: 8px;
		font-size: 13px;
	}

	.chip {
		background: color-mix(in srgb, var(--accent) 16%, transparent);
		color: var(--accent-strong);
		border-radius: var(--radius);
		padding: 3px 8px;
		font-size: 11px;
		font-weight: 600;
	}

	.graficas {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 16px;
	}

	.grupos-error {
		color: var(--text-muted);
	}

	.lista-grupos {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.grupo {
		display: flex;
		align-items: baseline;
		gap: 10px;
		padding: 8px 0;
		border-bottom: 1px solid var(--border);
		font-size: 13px;
	}

	.grupo:last-child {
		border-bottom: none;
	}

	.grupo-cantidad {
		font-weight: 700;
		font-family: var(--font-display);
		color: var(--accent);
		min-width: 32px;
	}

	.grupo-descripcion {
		flex: 1;
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
		padding: 8px 10px;
		border-bottom: 1px solid var(--border);
	}

	tbody tr:hover {
		background: var(--surface-raised);
	}

	.codigo {
		font-family: var(--font-mono);
	}

	.link-codigo {
		color: var(--text);
		text-decoration: none;
	}

	.link-codigo:hover {
		color: var(--accent-strong);
		text-decoration: underline;
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

	.descripcion {
		max-width: 320px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
</style>
