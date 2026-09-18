<script lang="ts">
	import { fade } from 'svelte/transition';
	import Header from '$lib/components/Header.svelte';
	import StatTile from '$lib/components/StatTile.svelte';
	import Sparkline from '$lib/components/Sparkline.svelte';
	import Donut from '$lib/components/Donut.svelte';
	import BarChartColumnas from '$lib/components/BarChartColumnas.svelte';
	import ChipSistema from '$lib/components/ChipSistema.svelte';
	import ListaSistemas from '$lib/components/ListaSistemas.svelte';
	import { calcularVolumenSistemas } from '$lib/volumenSistemas';
	import SelectCatalogo from '$lib/components/SelectCatalogo.svelte';
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import { api, type PanelKPIs, type Registro } from '$lib/api/client';

	let kpis = $state<PanelKPIs | null>(null);
	let cargandoKpis = $state(true);
	let errorPanel = $state(false);

	let empresaId = $state<number | null>(null);
	let sistemaId = $state<number | null>(null);
	let medioId = $state<number | null>(null);
	let moduloId = $state<number | null>(null);

	let recientes = $state<Registro[]>([]);
	let cargandoTabla = $state(true);
	let errorTabla = $state(false);
	let datosDesactualizados = $state(false);
	const INTERVALO_REFRESCO_MS = 30_000;

	async function cargarPanel() {
		cargandoKpis = true;
		errorPanel = false;
		try {
			kpis = await api.panel();
		} catch {
			errorPanel = true;
		} finally {
			cargandoKpis = false;
		}
	}

	function paramsTabla() {
		return {
			page: 1,
			page_size: 10,
			empresa_id: empresaId ?? undefined,
			sistema_id: sistemaId ?? undefined,
			medio_id: medioId ?? undefined,
			modulo_id: moduloId ?? undefined
		};
	}

	async function cargarTabla() {
		cargandoTabla = true;
		errorTabla = false;
		try {
			const pagina = await api.listado(paramsTabla());
			recientes = pagina.items;
		} catch {
			errorTabla = true;
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

	async function refrescarSilencioso() {
		try {
			kpis = await api.panel();
			recientes = (await api.listado(paramsTabla())).items;
			datosDesactualizados = false;
		} catch {
			// un fallo de refresco en segundo plano no debe interrumpir al usuario con un
			// error bloqueante, pero sí debe quedar visible que los datos ya no son frescos.
			datosDesactualizados = true;
		}
	}

	$effect(() => {
		const id = setInterval(refrescarSilencioso, INTERVALO_REFRESCO_MS);
		return () => clearInterval(id);
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

	const volumenPorSistema = $derived(calcularVolumenSistemas(kpis?.por_sistema ?? {}));

	const sistemaTop = $derived(volumenPorSistema[0]?.nombre ?? '—');

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

	const ultimaActualizacion = $derived.by(() => {
		if (!kpis || kpis.recientes.length === 0) return '—';
		const hora = horaCorta(kpis.recientes[0].created_at);
		return datosDesactualizados ? `${hora} (desactualizado)` : hora;
	});
</script>

<Header titulo="Panel principal" subtitulo={kpis ? kpis.semana : 'Cargando semana en curso…'} />

{#if errorPanel || errorTabla}
	<div class="banner-error" role="alert">
		<span>No se pudo cargar el panel. Verifica tu conexión.</span>
		<button type="button" onclick={() => { cargarPanel(); cargarTabla(); }}>Reintentar</button>
	</div>
{/if}

<div class="pantalla">
	<div class="fila-tiles">
		<StatTile
			label="Registros esta semana"
			value={kpis?.total_semana ?? 0}
			loading={cargandoKpis}
			icono="clipboard-list"
			nota="Actualizado {ultimaActualizacion}"
			destacada
		>
			{#if !cargandoKpis}
				<div in:fade={{ duration: 200 }}><Sparkline datos={volumenSemanaCompleta} /></div>
			{/if}
		</StatTile>

		<StatTile label="Promedio diario" value={promedioDiario} loading={cargandoKpis} icono="bar-chart-2" nota="Registros por día" />
		<StatTile label="Módulo más frecuente" value={moduloTop} loading={cargandoKpis} icono="grid-3x3" nota="Semana en curso" />
		<StatTile label="Sistema más atendido" value={sistemaTop} loading={cargandoKpis} icono="target" nota="Semana en curso" />
	</div>

	<div class="fila-ancha">
		<section class="tarjeta">
			<h2 class="font-display">Volumen diario</h2>
			<BarChartColumnas datos={volumenSemanaCompleta} loading={cargandoKpis} etiquetas="diaSemana" />
		</section>

		<div class="columna-lateral">
			<section class="tarjeta">
				<h2 class="font-display">Distribución por módulo</h2>
				{#if cargandoKpis}
					<p class="cargando">Cargando…</p>
				{:else}
					<div in:fade={{ duration: 200 }}><Donut items={donutItems} /></div>
				{/if}
			</section>

			<div class="par-tiles">
				<StatTile label="Días hábiles" value={diasHabilesRestantes()} nota="Restantes" />
				<StatTile label="Actualizado" value={ultimaActualizacion} nota="Hora local" />
			</div>
		</div>
	</div>

	<div class="fila-ancha">
		<section class="tarjeta">
		<div class="tarjeta-cabecera">
			<div class="titulo-con-link">
				<h2 class="font-display">Registros recientes</h2>
				<a href="/listado" class="ver-todos">Ver todos en Listado →</a>
			</div>
			<div class="filtros">
				<ComboboxCreatable id="f-empresa" catalogo="empresas" label="Empresa" bind:selectedId={empresaId} permiteCrear={false} />
				<SelectCatalogo id="f-sistema" catalogo="sistemas" label="Sistema" bind:selectedId={sistemaId} />
				<SelectCatalogo id="f-medio" catalogo="medios" label="Medio" bind:selectedId={medioId} />
				<ComboboxCreatable id="f-modulo" catalogo="modulos" label="Módulo" bind:selectedId={moduloId} permiteCrear={false} />
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
						{#each recientes as r, i}
							<tr in:fade={{ duration: 200, delay: i * 25 }}>
								<td>{r.fecha}</td>
								<td>{r.empresa.nombre}</td>
								<td><ChipSistema nombre={r.sistema.nombre} /></td>
								<td>{r.modulo.nombre}</td>
								<td>{r.atendio.nombre}</td>
								<td class="descripcion" title={r.descripcion}>{r.descripcion}</td>
							</tr>
						{/each}
					{/if}
				</tbody>
			</table>
		</div>
	</section>

		<section class="tarjeta">
			<h2 class="font-display">Volumen por sistema</h2>
			<ListaSistemas filas={volumenPorSistema} loading={cargandoKpis} />
		</section>
	</div>
</div>

<style>
	.banner-error {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 12px;
		background: color-mix(in oklch, var(--danger) 14%, var(--surface));
		border: 1px solid var(--danger);
		border-radius: var(--radius-lg);
		padding: 12px 16px;
		margin-bottom: 18px;
		font-size: 13px;
		color: var(--text);
	}

	.banner-error button {
		background: var(--danger);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 7px 14px;
		font-weight: 600;
		cursor: pointer;
		flex-shrink: 0;
	}

	/* la primera tarjeta es la destacada: la sparkline va sobre el gradiente,
	   donde el acento no se distingue */
	.fila-tiles :global(.tile.destacada) {
		--color-sparkline: oklch(1 0 0 / 0.55);
	}

	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px;
		box-shadow: var(--shadow-sm);
	}

	.tarjeta h2 {
		font-size: 14px;
		margin: 0 0 14px;
		color: var(--text-muted);
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

	.titulo-con-link {
		display: flex;
		align-items: baseline;
		gap: 14px;
	}

	.titulo-con-link h2 {
		margin: 0;
	}

	.ver-todos {
		font-size: 12px;
		color: var(--accent);
		text-decoration: none;
		white-space: nowrap;
	}

	.ver-todos:hover {
		text-decoration: underline;
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
		padding: 10px 12px;
		border-bottom: 1px solid var(--border);
	}

	td {
		padding: 13px 12px;
		border-bottom: 1px solid var(--border);
	}

	tbody tr:last-child td {
		border-bottom: none;
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
		border-radius: var(--radius-sm);
	}

</style>
