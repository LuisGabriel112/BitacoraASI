<script lang="ts">
	import ChipSistema from '$lib/components/ChipSistema.svelte';
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import SelectCatalogo from '$lib/components/SelectCatalogo.svelte';
	import { api, type Registro } from '$lib/api/client';

	let buscar = $state('');
	let empresaId = $state<number | null>(null);
	let sistemaId = $state<number | null>(null);
	let medioId = $state<number | null>(null);
	let moduloId = $state<number | null>(null);
	let atendioId = $state<number | null>(null);
	let page = $state(1);
	const pageSize = 25;

	let items = $state<Registro[]>([]);
	let total = $state(0);
	let cargando = $state(true);
	let timer: ReturnType<typeof setTimeout>;

	async function cargar() {
		cargando = true;
		try {
			const pagina = await api.listado({
				page,
				page_size: pageSize,
				buscar: buscar || undefined,
				empresa_id: empresaId ?? undefined,
				sistema_id: sistemaId ?? undefined,
				medio_id: medioId ?? undefined,
				modulo_id: moduloId ?? undefined,
				atendio_id: atendioId ?? undefined
			});
			items = pagina.items;
			total = pagina.total;
		} finally {
			cargando = false;
		}
	}

	function alBuscar(e: Event) {
		buscar = (e.target as HTMLInputElement).value;
		page = 1;
		clearTimeout(timer);
		timer = setTimeout(cargar, 250);
	}

	$effect(() => {
		page; empresaId; sistemaId; medioId; moduloId; atendioId;
		cargar();
	});

	const totalPaginas = $derived(Math.max(1, Math.ceil(total / pageSize)));

	function paramsFiltros() {
		return {
			buscar: buscar || undefined,
			empresa_id: empresaId ?? undefined,
			sistema_id: sistemaId ?? undefined,
			medio_id: medioId ?? undefined,
			modulo_id: moduloId ?? undefined,
			atendio_id: atendioId ?? undefined
		};
	}
</script>

<h1 class="font-display">Listado completo</h1>

<div class="barra-superior">
	<input
		type="search"
		placeholder="Buscar en todos los campos…"
		value={buscar}
		oninput={alBuscar}
		class="buscador"
	/>
	<div class="filtros">
		<ComboboxCreatable id="l-empresa" catalogo="empresas" label="Empresa" bind:selectedId={empresaId} />
		<SelectCatalogo id="l-sistema" catalogo="sistemas" label="Sistema" bind:selectedId={sistemaId} />
		<SelectCatalogo id="l-medio" catalogo="medios" label="Medio" bind:selectedId={medioId} />
		<ComboboxCreatable id="l-modulo" catalogo="modulos" label="Módulo" bind:selectedId={moduloId} />
		<SelectCatalogo id="l-atendio" catalogo="agentes" label="Atendió" bind:selectedId={atendioId} />
	</div>
	<div class="exportar">
		<a href={api.exportUrl('csv', paramsFiltros())} class="boton-secundario">Exportar CSV</a>
		<a href={api.exportUrl('xlsx', paramsFiltros())} class="boton-secundario">Exportar Excel</a>
	</div>
</div>

<div class="tabla-wrap">
	<table>
		<thead>
			<tr>
				<th>Fecha</th>
				<th>Semana</th>
				<th>Empresa</th>
				<th>Sistema</th>
				<th>Medio</th>
				<th>Módulo</th>
				<th>Atendió</th>
				<th>Descripción</th>
				<th>Trello</th>
			</tr>
		</thead>
		<tbody>
			{#if cargando}
				{#each Array(10) as _}
					<tr>
						{#each Array(9) as _}
							<td><span class="skeleton skeleton-celda" aria-hidden="true"></span></td>
						{/each}
					</tr>
				{/each}
			{:else if items.length === 0}
				<tr><td colspan="9" class="vacio">Ningún registro con estos filtros. Ajusta empresa o rango de fecha.</td></tr>
			{:else}
				{#each items as r}
					<tr tabindex="0">
						<td>{r.fecha}</td>
						<td>{r.semana}</td>
						<td>{r.empresa.nombre}</td>
						<td><ChipSistema nombre={r.sistema.nombre} /></td>
						<td>{r.medio.nombre}</td>
						<td>{r.modulo.nombre}</td>
						<td>{r.atendio.nombre}</td>
						<td class="descripcion">{r.descripcion}</td>
						<td>{r.trello_card_id ? '✓' : '—'}</td>
					</tr>
				{/each}
			{/if}
		</tbody>
	</table>
</div>

<div class="paginacion">
	<span>{total} registros</span>
	<div class="botones">
		<button disabled={page <= 1} onclick={() => (page -= 1)}>← Anterior</button>
		<span>Página {page} de {totalPaginas}</span>
		<button disabled={page >= totalPaginas} onclick={() => (page += 1)}>Siguiente →</button>
	</div>
</div>

<style>
	.barra-superior {
		display: flex;
		flex-wrap: wrap;
		gap: 14px;
		align-items: flex-end;
		margin-bottom: 18px;
	}

	.buscador {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 12px;
		min-width: 220px;
		color: var(--text);
	}

	.buscador:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}

	.filtros {
		display: flex;
		gap: 10px;
		flex-wrap: wrap;
	}

	.filtros :global(.campo) {
		min-width: 130px;
	}

	.exportar {
		display: flex;
		gap: 8px;
		margin-left: auto;
	}

	.boton-secundario {
		display: inline-flex;
		align-items: center;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 8px 14px;
		text-decoration: none;
		color: var(--text);
		font-size: 13px;
	}

	.boton-secundario:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.tabla-wrap {
		overflow-x: auto;
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
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
		padding: 10px;
		border-bottom: 1px solid var(--border-strong);
		position: sticky;
		top: 0;
		background: var(--surface);
	}

	td {
		padding: 9px 10px;
		border-bottom: 1px solid var(--border);
	}

	tbody tr:hover {
		background: var(--surface-raised);
	}

	tbody tr:focus-visible,
	tbody tr:focus {
		outline: 2px solid var(--accent);
		outline-offset: -2px;
		background: var(--surface-raised);
	}

	.descripcion {
		max-width: 280px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.vacio {
		color: var(--text-muted);
		text-align: center;
		padding: 24px;
	}

	.skeleton-celda {
		display: block;
		height: 12px;
		width: 80%;
		border-radius: 3px;
	}

	.paginacion {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-top: 14px;
		font-size: 13px;
		color: var(--text-muted);
	}

	.botones {
		display: flex;
		align-items: center;
		gap: 12px;
	}

	.botones button {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 6px 12px;
		color: var(--text);
		cursor: pointer;
	}

	.botones button:disabled {
		opacity: 0.4;
		cursor: default;
	}

	.botones button:not(:disabled):hover {
		border-color: var(--accent);
	}
</style>
