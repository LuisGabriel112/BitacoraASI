<script lang="ts">
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import { api, type Mesa } from '$lib/api/client';

	function formatearFechaHora(iso: string) {
		const [fecha, hora] = iso.split('T');
		const [anio, mes, dia] = fecha.split('-');
		return `${dia}/${mes}/${anio} ${hora?.slice(0, 5) ?? ''}`;
	}

	let buscar = $state('');
	let categoriaId = $state<number | null>(null);
	let solicitanteId = $state<number | null>(null);
	let resolutorId = $state<number | null>(null);
	let ventanaId = $state<number | null>(null);
	let estado = $state<'' | 'abierta' | 'cerrada'>('');
	let page = $state(1);
	const pageSize = 25;

	let items = $state<Mesa[]>([]);
	let total = $state(0);
	let cargando = $state(true);
	let timer: ReturnType<typeof setTimeout>;

	let confirmandoId = $state<number | null>(null);
	let eliminandoId = $state<number | null>(null);
	let errorEliminar = $state<string | null>(null);

	let cerrandoId = $state<number | null>(null);
	let solucionTexto = $state('');
	let tipoSolucion = $state<'Modificación en BD' | 'Seguimiento de proceso'>('Modificación en BD');
	let fechaCierreReal = $state(new Date().toISOString().slice(0, 10));
	let guardandoCierre = $state(false);
	let errorCierre = $state<string | null>(null);

	async function confirmarEliminar(id: number) {
		eliminandoId = id;
		errorEliminar = null;
		try {
			await api.eliminarMesa(id);
			items = items.filter((m) => m.id !== id);
			total -= 1;
			confirmandoId = null;
		} catch (e) {
			errorEliminar = e instanceof Error ? e.message : 'No se pudo eliminar la mesa';
		} finally {
			eliminandoId = null;
		}
	}

	function abrirCierre(id: number) {
		cerrandoId = id;
		errorCierre = null;
		solucionTexto = '';
		tipoSolucion = 'Modificación en BD';
		fechaCierreReal = new Date().toISOString().slice(0, 10);
	}

	async function confirmarCierre(id: number) {
		if (!solucionTexto.trim()) return (errorCierre = 'Falta describir la solución');
		guardandoCierre = true;
		errorCierre = null;
		try {
			const actualizada = await api.cerrarMesa(id, {
				solucion: solucionTexto.trim(),
				tipo_solucion: tipoSolucion,
				fecha_cierre_real: fechaCierreReal
			});
			items = items.map((m) => (m.id === id ? actualizada : m));
			cerrandoId = null;
		} catch (e) {
			errorCierre = e instanceof Error ? e.message : 'No se pudo cerrar la mesa';
		} finally {
			guardandoCierre = false;
		}
	}

	async function cargar() {
		cargando = true;
		try {
			const pagina = await api.listadoMesas({
				page,
				page_size: pageSize,
				buscar: buscar || undefined,
				categoria_id: categoriaId ?? undefined,
				solicitante_id: solicitanteId ?? undefined,
				resolutor_id: resolutorId ?? undefined,
				ventana_id: ventanaId ?? undefined,
				estado: estado || undefined
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
		page; categoriaId; solicitanteId; resolutorId; ventanaId; estado;
		cargar();
	});

	const totalPaginas = $derived(Math.max(1, Math.ceil(total / pageSize)));

	function paramsFiltros() {
		return {
			buscar: buscar || undefined,
			categoria_id: categoriaId ?? undefined,
			solicitante_id: solicitanteId ?? undefined,
			resolutor_id: resolutorId ?? undefined,
			ventana_id: ventanaId ?? undefined,
			estado: estado || undefined
		};
	}
</script>

<h1 class="font-display">Listado de mesas</h1>

<div class="barra-superior">
	<input
		type="search"
		placeholder="Buscar por código, título o descripción…"
		value={buscar}
		oninput={alBuscar}
		class="buscador"
	/>
	<div class="filtros">
		<ComboboxCreatable id="m-categoria" catalogo="categorias-mesa" label="Categoría" bind:selectedId={categoriaId} />
		<ComboboxCreatable id="m-solicitante" catalogo="solicitantes-mesa" label="Solicitante" bind:selectedId={solicitanteId} />
		<ComboboxCreatable id="m-resolutor" catalogo="resolutores-mesa" label="Resolutor" bind:selectedId={resolutorId} />
		<ComboboxCreatable id="m-ventana" catalogo="ventanas-mesa" label="Ventana" bind:selectedId={ventanaId} />
		<div class="campo">
			<label for="m-estado">Estado</label>
			<select id="m-estado" bind:value={estado}>
				<option value="">Todos</option>
				<option value="abierta">Abierta</option>
				<option value="cerrada">Cerrada</option>
			</select>
		</div>
	</div>
	<div class="exportar">
		<a href={api.exportMesasUrl('csv', paramsFiltros())} class="boton-secundario">Exportar CSV</a>
		<a href={api.exportMesasUrl('xlsx', paramsFiltros())} class="boton-secundario">Exportar Excel</a>
	</div>
</div>

<div class="tabla-wrap">
	<table>
		<thead>
			<tr>
				<th>Código</th>
				<th>Título</th>
				<th>Fecha carga</th>
				<th>Categoría</th>
				<th>Solicitante</th>
				<th>Resolutor</th>
				<th>Estado</th>
				<th class="col-acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			{#if cargando}
				{#each Array(8) as _}
					<tr>
						{#each Array(8) as _}
							<td><span class="skeleton skeleton-celda" aria-hidden="true"></span></td>
						{/each}
					</tr>
				{/each}
			{:else if items.length === 0}
				<tr><td colspan="8" class="vacio">Ninguna mesa con estos filtros.</td></tr>
			{:else}
				{#each items as m}
					<tr>
						<td class="codigo">{m.codigo}</td>
						<td class="titulo-col">{m.titulo}</td>
						<td>{formatearFechaHora(m.fecha_carga)}</td>
						<td>{m.categoria.nombre}</td>
						<td>{m.solicitante.nombre}</td>
						<td>{m.resolutor.nombre}</td>
						<td>
							<span class="chip-estado" class:cerrada={!!m.fecha_cierre_real}>
								{m.fecha_cierre_real ? 'Cerrada' : 'Abierta'}
							</span>
						</td>
						<td class="col-acciones">
							{#if confirmandoId === m.id}
								<div class="confirmar-eliminar">
									<span>¿Eliminar?</span>
									<button class="btn-confirmar" disabled={eliminandoId === m.id} onclick={() => confirmarEliminar(m.id)}>
										{eliminandoId === m.id ? 'Eliminando…' : 'Sí'}
									</button>
									<button class="btn-cancelar" onclick={() => (confirmandoId = null)}>No</button>
								</div>
							{:else}
								<div class="acciones-fila">
									{#if !m.fecha_cierre_real}
										<button class="btn-cerrar" onclick={() => abrirCierre(m.id)}>Cerrar</button>
									{/if}
									<button class="btn-eliminar" title="Eliminar mesa" aria-label="Eliminar mesa" onclick={() => (confirmandoId = m.id)}>
										🗑
									</button>
								</div>
							{/if}
						</td>
					</tr>
					{#if cerrandoId === m.id}
						<tr class="fila-cierre">
							<td colspan="8">
								<div class="form-cierre">
									<div class="campo">
										<label for="solucion-{m.id}">Solución</label>
										<textarea id="solucion-{m.id}" rows="2" bind:value={solucionTexto}></textarea>
									</div>
									<div class="campo">
										<label for="tipo-{m.id}">Tipo de solución</label>
										<select id="tipo-{m.id}" bind:value={tipoSolucion}>
											<option value="Modificación en BD">Modificación en BD</option>
											<option value="Seguimiento de proceso">Seguimiento de proceso</option>
										</select>
									</div>
									<div class="campo">
										<label for="fecha-cierre-{m.id}">Fecha real de cierre</label>
										<input id="fecha-cierre-{m.id}" type="date" bind:value={fechaCierreReal} />
									</div>
									<div class="acciones-cierre">
										<button class="btn-guardar-cierre" disabled={guardandoCierre} onclick={() => confirmarCierre(m.id)}>
											{guardandoCierre ? 'Guardando…' : 'Guardar cierre'}
										</button>
										<button class="btn-cancelar" onclick={() => (cerrandoId = null)}>Cancelar</button>
									</div>
									{#if errorCierre}<p class="error-cierre">{errorCierre}</p>{/if}
								</div>
							</td>
						</tr>
					{/if}
				{/each}
			{/if}
		</tbody>
	</table>
</div>

{#if errorEliminar}
	<p class="error-eliminar">No se pudo eliminar: {errorEliminar}</p>
{/if}

<div class="paginacion">
	<span>{total} mesas</span>
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

	.campo {
		display: flex;
		flex-direction: column;
		gap: 6px;
	}

	label {
		font-size: 12px;
		color: var(--text-muted);
		font-family: var(--font-display);
	}

	select,
	input,
	textarea {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
		resize: vertical;
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

	.btn-cerrar {
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 4px 10px;
		color: var(--text);
		cursor: pointer;
		font-size: 12px;
	}

	.btn-cerrar:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.btn-eliminar {
		background: none;
		border: 1px solid transparent;
		border-radius: var(--radius);
		padding: 4px 8px;
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
		justify-content: flex-end;
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

	.fila-cierre td {
		background: var(--surface-raised);
	}

	.form-cierre {
		display: grid;
		grid-template-columns: 2fr 1fr 1fr auto;
		gap: 12px;
		align-items: start;
		padding: 8px 4px;
	}

	.acciones-cierre {
		display: flex;
		gap: 8px;
		align-items: center;
		padding-top: 20px;
	}

	.btn-guardar-cierre {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 8px 14px;
		font-weight: 600;
		cursor: pointer;
		white-space: nowrap;
	}

	.btn-guardar-cierre:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.error-cierre {
		grid-column: 1 / -1;
		color: var(--danger);
		font-size: 12px;
		margin: 0;
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
