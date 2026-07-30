<script lang="ts">
	import BarChartHorizontal from '$lib/components/BarChartHorizontal.svelte';
	import ChipSistema from '$lib/components/ChipSistema.svelte';
	import { api, type GrupoSoporte, type ReporteSemanal } from '$lib/api/client';

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
	let reporte = $state<ReporteSemanal | null>(null);
	let cargando = $state(true);
	let grupos = $state<GrupoSoporte[] | null>(null);
	let gruposCargando = $state(false);
	let gruposError = $state<string | null>(null);

	const semanaEtiqueta = $derived(semanaInputAEtiqueta(semanaInput));

	async function cargar() {
		cargando = true;
		try {
			reporte = await api.reporte(semanaEtiqueta);
		} finally {
			cargando = false;
		}
	}

	async function cargarGrupos() {
		gruposCargando = true;
		gruposError = null;
		try {
			grupos = await api.soportesFrecuentes(semanaEtiqueta);
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

	const empresaItems = $derived(
		reporte ? Object.entries(reporte.por_empresa).map(([label, value]) => ({ label, value })) : []
	);
	const medioItems = $derived(
		reporte ? Object.entries(reporte.por_medio).map(([label, value]) => ({ label, value })) : []
	);
</script>

<h1 class="font-display">Reporte semanal</h1>

<div class="selector-semana">
	<button onclick={() => (semanaInput = sumarSemanas(semanaInput, -1))} aria-label="Semana anterior">←</button>
	<input type="week" bind:value={semanaInput} />
	<button onclick={() => (semanaInput = sumarSemanas(semanaInput, 1))} aria-label="Semana siguiente">→</button>
	<a href={api.exportUrl('xlsx', { semana: semanaEtiqueta })} class="boton-excel">Exportar Excel</a>
</div>

{#if cargando}
	<p class="cargando">Cargando reporte de {semanaEtiqueta}…</p>
{:else if !reporte || reporte.total === 0}
	<div class="tarjeta vacio">
		<p>No hubo registros en {semanaEtiqueta}. Elige otra semana o captura el primer registro.</p>
	</div>
{:else}
	<section class="tarjeta">
		<h2 class="font-display">Resumen ejecutivo</h2>
		<p>
			Durante <strong>{semanaEtiqueta}</strong> se atendieron <strong>{reporte.total}</strong> solicitudes de soporte,
			distribuidas entre {Object.keys(reporte.por_sistema).length} sistemas y
			{Object.keys(reporte.por_empresa).length} empresas.
		</p>
		<div class="chips-sistema">
			{#each Object.entries(reporte.por_sistema) as [nombre, total]}
				<div class="chip-total">
					<ChipSistema {nombre} />
					<span>{total}</span>
				</div>
			{/each}
		</div>
	</section>

	<div class="graficas">
		<section class="tarjeta">
			<h2 class="font-display">Por empresa</h2>
			<BarChartHorizontal items={empresaItems} />
		</section>
		<section class="tarjeta">
			<h2 class="font-display">Por medio</h2>
			<BarChartHorizontal items={medioItems} />
		</section>
	</div>

	<section class="tarjeta">
		<h2 class="font-display">Soportes más frecuentes</h2>
		{#if gruposCargando}
			<p class="cargando">Analizando similitud de descripciones…</p>
		{:else if gruposError}
			<p class="grupos-error">{gruposError}</p>
		{:else if !grupos || grupos.length === 0}
			<p class="cargando">No se detectaron soportes que se repitan esta semana.</p>
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
						<th>Fecha</th><th>Empresa</th><th>Sistema</th><th>Medio</th><th>Módulo</th><th>Atendió</th><th>Descripción</th>
					</tr>
				</thead>
				<tbody>
					{#each reporte.registros as r}
						<tr>
							<td>{r.fecha}</td>
							<td>{r.empresa.nombre}</td>
							<td><ChipSistema nombre={r.sistema.nombre} /></td>
							<td>{r.medio.nombre}</td>
							<td>{r.modulo.nombre}</td>
							<td>{r.atendio.nombre}</td>
							<td class="descripcion">{r.descripcion}</td>
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
		width: 32px;
		height: 32px;
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

	.chips-sistema {
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

	.graficas {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 16px;
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

	.descripcion {
		max-width: 320px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
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
</style>
