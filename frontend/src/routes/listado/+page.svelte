<script lang="ts">
	import ChipSistema from '$lib/components/ChipSistema.svelte';
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import SelectCatalogo from '$lib/components/SelectCatalogo.svelte';
	import Header from '$lib/components/Header.svelte';
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

	let confirmandoId = $state<number | null>(null);
	let eliminandoId = $state<number | null>(null);
	let errorEliminar = $state<string | null>(null);

	async function confirmarEliminar(id: number) {
		eliminandoId = id;
		errorEliminar = null;
		try {
			await api.eliminarRegistro(id);
			items = items.filter((r) => r.id !== id);
			total -= 1;
			confirmandoId = null;
		} catch (e) {
			errorEliminar = e instanceof Error ? e.message : 'No se pudo eliminar el registro';
		} finally {
			eliminandoId = null;
		}
	}

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

<Header titulo="Listado completo" />

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
		<a href={api.exportUrl('xlsx', paramsFiltros())} class="boton-primario">Exportar Excel</a>
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
				<th class="col-acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			{#if cargando}
				{#each Array(10) as _}
					<tr>
						{#each Array(10) as _}
							<td><span class="skeleton skeleton-celda" aria-hidden="true"></span></td>
						{/each}
					</tr>
				{/each}
			{:else if items.length === 0}
				<tr><td colspan="10" class="vacio">Ningún registro con estos filtros. Ajusta empresa o rango de fecha.</td></tr>
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
						<td>
						{#if r.trello_card_id}
							<a
								href="https://trello.com/c/{r.trello_card_id}"
								target="_blank"
								rel="noopener noreferrer"
								class="link-trello"
							>
								Ver tarjeta ↗
							</a>
						{:else}
							—
						{/if}
					</td>
						<td class="col-acciones">
							{#if confirmandoId === r.id}
								<div class="confirmar-eliminar">
									<span>¿Eliminar?</span>
									<button
										class="btn-confirmar"
										disabled={eliminandoId === r.id}
										onclick={() => confirmarEliminar(r.id)}
									>
										{eliminandoId === r.id ? 'Eliminando…' : 'Sí'}
									</button>
									<button class="btn-cancelar" onclick={() => (confirmandoId = null)}>No</button>
								</div>
							{:else}
								<div class="acciones-fila">
									<a class="btn-editar" href="/{r.id}/editar">Editar</a>
									<button
										class="btn-eliminar"
										title="Eliminar registro"
										aria-label="Eliminar registro"
										onclick={() => (confirmandoId = r.id)}
									>
										🗑
									</button>
								</div>
							{/if}
						</td>
					</tr>
				{/each}
			{/if}
		</tbody>
	</table>
</div>

{#if errorEliminar}
	<p class="error-eliminar">No se pudo eliminar: {errorEliminar}</p>
{/if}

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
		gap: 8px;
		flex-wrap: wrap;
	}

	/* filtros como chips: el .campo de ComboboxCreatable/SelectCatalogo pasa
	   de columna (label arriba, control abajo) a una píldora horizontal con
	   flecha ▾, sin tocar los componentes (afecta solo dentro de .filtros). */
	.filtros :global(.campo) {
		position: relative;
		flex-direction: row;
		align-items: center;
		gap: 6px;
		min-width: 0;
		border: 1px solid var(--glass-border);
		border-radius: 999px;
		padding: 6px 26px 6px 14px;
		background: var(--glass-bg);
	}

	.filtros :global(.campo)::after {
		content: '▾';
		position: absolute;
		right: 12px;
		top: 50%;
		transform: translateY(-50%);
		font-size: 10px;
		color: var(--text-faint);
		pointer-events: none;
	}

	.filtros :global(label) {
		font-size: 11px;
		white-space: nowrap;
	}

	.filtros :global(input),
	.filtros :global(select) {
		background: transparent !important;
		border: none !important;
		padding: 2px 0 !important;
		min-width: 84px;
		appearance: none;
		-webkit-appearance: none;
	}

	.exportar {
		display: flex;
		gap: 8px;
		margin-left: auto;
	}

	.boton-secundario,
	.boton-primario {
		display: inline-flex;
		align-items: center;
		border-radius: var(--radius);
		padding: 8px 14px;
		text-decoration: none;
		font-size: 13px;
	}

	.boton-secundario {
		border: 1px solid var(--border-strong);
		color: var(--text);
	}

	.boton-secundario:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.boton-primario {
		border: none;
		background: var(--accent);
		color: var(--bg);
		font-weight: 600;
	}

	.boton-primario:hover {
		background: var(--accent-strong);
	}

	.link-trello {
		color: var(--accent);
		text-decoration: none;
		font-size: 12px;
		white-space: nowrap;
	}

	.link-trello:hover {
		color: var(--accent-strong);
		text-decoration: underline;
	}

	.tabla-wrap {
		overflow: auto;
		max-height: 560px;
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
		background: var(--bg);
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

	.col-acciones {
		width: 1%;
		white-space: nowrap;
		text-align: right;
	}

	.acciones-fila {
		display: flex;
		gap: 6px;
		justify-content: flex-end;
	}

	.btn-editar {
		display: inline-flex;
		align-items: center;
		min-height: 40px;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 4px 10px;
		color: var(--text);
		text-decoration: none;
		font-size: 12px;
	}

	.btn-editar:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.btn-eliminar {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		min-width: 40px;
		min-height: 40px;
		background: none;
		border: 1px solid transparent;
		border-radius: var(--radius);
		color: var(--text-faint);
		cursor: pointer;
		font-size: 14px;
		line-height: 1;
	}

	.btn-eliminar:hover {
		border-color: var(--danger);
		color: var(--danger);
		background: color-mix(in srgb, var(--danger) 12%, transparent);
	}

	.confirmar-eliminar {
		display: flex;
		align-items: center;
		gap: 6px;
		font-size: 12px;
		color: var(--text-muted);
		white-space: nowrap;
	}

	.btn-confirmar {
		background: var(--danger);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 4px 10px;
		font-weight: 600;
		cursor: pointer;
	}

	.btn-confirmar:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.btn-cancelar {
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 4px 10px;
		color: var(--text);
		cursor: pointer;
	}

	.btn-cancelar:hover {
		border-color: var(--accent);
	}

	.error-eliminar {
		margin-top: 10px;
		color: var(--danger);
		font-size: 13px;
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
		border-radius: 999px;
		min-height: 40px;
		padding: 7px 16px;
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
