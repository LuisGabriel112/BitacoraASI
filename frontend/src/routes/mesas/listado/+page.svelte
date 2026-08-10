<script lang="ts">
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import FechaHoraInput from '$lib/components/FechaHoraInput.svelte';
	import Header from '$lib/components/Header.svelte';
	import Celebracion from '$lib/components/Celebracion.svelte';
	import BotonGenerarReporte from '$lib/components/BotonGenerarReporte.svelte';
	import { semanaActual } from '$lib/semana';
	import { api, type Mesa } from '$lib/api/client';

	let celebracion: Celebracion;
	const semanaEtiqueta = semanaActual().etiqueta;

	function formatearFechaHora(iso: string) {
		const [fecha, hora] = iso.split('T');
		const [anio, mes, dia] = fecha.split('-');
		return `${dia}/${mes}/${anio} ${hora?.slice(0, 5) ?? ''}`;
	}

	function ahora() {
		const d = new Date();
		const pad = (n: number) => String(n).padStart(2, '0');
		return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
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
	let ventanaCierreId = $state<number | null>(null);
	let solucionTexto = $state('');
	let tipoSolucion = $state<'Modificación en BD' | 'Seguimiento de proceso'>('Modificación en BD');
	let fechaCierreReal = $state(ahora());
	let guardandoCierre = $state(false);
	let errorCierre = $state<string | null>(null);

	let expandidaId = $state<number | null>(null);

	function alternarSolucion(m: Mesa) {
		if (!m.solucion) return;
		expandidaId = expandidaId === m.id ? null : m.id;
	}

	function noPropagar(e: Event) {
		e.stopPropagation();
	}

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

	async function alternarPrioridad(m: Mesa) {
		try {
			const actualizada = await api.editarMesa(m.id, { prioridad: !m.prioridad });
			items = items.map((it) => (it.id === m.id ? actualizada : it));
		} catch {
			// un fallo al marcar no debe romper el listado
		}
	}

	async function alternarDestacada(m: Mesa) {
		try {
			const actualizada = await api.editarMesa(m.id, { destacada: !m.destacada });
			items = items.map((it) => (it.id === m.id ? actualizada : it));
		} catch {
			// un fallo al marcar no debe romper el listado
		}
	}

	function abrirCierre(id: number) {
		cerrandoId = id;
		errorCierre = null;
		ventanaCierreId = null;
		solucionTexto = '';
		tipoSolucion = 'Modificación en BD';
		fechaCierreReal = ahora();
	}

	async function confirmarCierre(id: number) {
		if (!ventanaCierreId) return (errorCierre = 'Falta seleccionar ventana');
		if (!solucionTexto.trim()) return (errorCierre = 'Falta describir la solución');
		guardandoCierre = true;
		errorCierre = null;
		try {
			const actualizada = await api.cerrarMesa(id, {
				ventana_id: ventanaCierreId,
				solucion: solucionTexto.trim(),
				tipo_solucion: tipoSolucion,
				fecha_cierre_real: fechaCierreReal
			});
			items = items.map((m) => (m.id === id ? actualizada : m));
			cerrandoId = null;
			celebracion?.mostrar(actualizada.logros);
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

<Celebracion bind:this={celebracion} />

<Header titulo="Listado de mesas" />

<div class="barra-superior">
	<input
		type="search"
		placeholder="Buscar por código, título, descripción o solución…"
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
		<a href={api.exportMesasUrl('xlsx', paramsFiltros())} class="boton-primario">Exportar Excel</a>
		<BotonGenerarReporte semana={semanaEtiqueta} />
	</div>
</div>

<div class="tabla-wrap">
	<table>
		<thead>
			<tr>
				<th>Código</th>
				<th>Título</th>
				<th>Fecha carga</th>
				<th>Ventana</th>
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
					<tr
						class:clicable={!!m.solucion}
						title={m.solucion ? 'Ver solución' : undefined}
						onclick={() => alternarSolucion(m)}
					>
						<td class="codigo" onclick={noPropagar}>
							{#if m.enlace}
								<a
									href={m.enlace}
									target="_blank"
									rel="noopener noreferrer"
									class="link-codigo"
									title="Abrir en Proactivanet"
								>
									{m.codigo} ↗
								</a>
							{:else}
								<span class="sin-enlace">{m.codigo}</span>
							{/if}
						</td>
						<td class="titulo-col">
							{#if m.prioridad}<span class="badge-prioridad" title="Prioritaria">❗</span>{/if}
							{#if m.destacada}<span class="badge-destacada" title="Destacada">⭐</span>{/if}
							{m.titulo}
						</td>
						<td>{formatearFechaHora(m.fecha_carga)}</td>
						<td>{m.ventana?.nombre ?? '—'}</td>
						<td>{m.solicitante.nombre}</td>
						<td>{m.resolutor.nombre}</td>
						<td>
							<span class="chip-estado" class:cerrada={!!m.fecha_cierre_real}>
								{m.fecha_cierre_real ? 'Cerrada' : 'Abierta'}
							</span>
						</td>
						<td class="col-acciones" onclick={noPropagar}>
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
									<button
										type="button"
										class="btn-toggle"
										class:activo={m.prioridad}
										title={m.prioridad ? 'Quitar prioridad' : 'Marcar como prioritaria'}
										aria-label={m.prioridad ? 'Quitar prioridad' : 'Marcar como prioritaria'}
										onclick={() => alternarPrioridad(m)}
									>
										❗
									</button>
									<button
										type="button"
										class="btn-toggle"
										class:activo={m.destacada}
										title={m.destacada ? 'Quitar de destacadas' : 'Marcar como destacada'}
										aria-label={m.destacada ? 'Quitar de destacadas' : 'Marcar como destacada'}
										onclick={() => alternarDestacada(m)}
									>
										⭐
									</button>
									{#if !m.fecha_cierre_real}
										<button class="btn-cerrar" onclick={() => abrirCierre(m.id)}>Cerrar</button>
									{/if}
									<a class="btn-editar" href="/mesas/{m.id}/editar">Editar</a>
									<button class="btn-eliminar" title="Eliminar mesa" aria-label="Eliminar mesa" onclick={() => (confirmandoId = m.id)}>
										🗑
									</button>
								</div>
							{/if}
						</td>
					</tr>
					{#if expandidaId === m.id}
						<tr class="fila-solucion">
							<td colspan="8">
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
					{#if cerrandoId === m.id}
						<tr class="fila-cierre">
							<td colspan="8">
								<div class="form-cierre">
									<div class="campo">
										<label for="solucion-{m.id}">Solución</label>
										<textarea id="solucion-{m.id}" rows="2" bind:value={solucionTexto}></textarea>
									</div>
									<ComboboxCreatable id="ventana-{m.id}" catalogo="ventanas-mesa" label="Ventana" bind:selectedId={ventanaCierreId} />
									<div class="campo">
										<label for="tipo-{m.id}">Categoría de la solución</label>
										<select id="tipo-{m.id}" bind:value={tipoSolucion}>
											<option value="Modificación en BD">Modificación en BD</option>
											<option value="Seguimiento de proceso">Seguimiento de proceso</option>
										</select>
									</div>
									<FechaHoraInput id="fecha-cierre-{m.id}" label="Fecha y hora real de cierre" bind:value={fechaCierreReal} />
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

	/* filtros como chips: misma píldora con flecha ▾ que /listado técnico,
	   aplicada aquí también al select nativo de Estado para que combine. */
	.filtros :global(.campo),
	.filtros .campo {
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

	.filtros :global(.campo)::after,
	.filtros .campo::after {
		content: '▾';
		position: absolute;
		right: 12px;
		top: 50%;
		transform: translateY(-50%);
		font-size: 10px;
		color: var(--text-faint);
		pointer-events: none;
	}

	.filtros :global(label),
	.filtros label {
		font-size: 11px;
		white-space: nowrap;
	}

	.filtros :global(input),
	.filtros :global(select),
	.filtros select {
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

	/* ver nota en SelectCatalogo.svelte: el popup nativo de <select> no
	   soporta glass, necesita fondo sólido explícito en <option>. */
	select option {
		background: var(--bg);
		color: var(--text);
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

	/* la celda de código se distingue del resto de la fila con un tinte y borde
	   de acento: aquí el clic abre el enlace externo, mientras el resto de la
	   fila despliega la solución — dos acciones distintas necesitan una señal
	   visual distinta, no solo el cursor. */
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

	.titulo-col {
		max-width: 260px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.badge-prioridad,
	.badge-destacada {
		font-size: 11px;
		margin-right: 4px;
	}

	.btn-toggle {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		min-width: 40px;
		min-height: 40px;
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		color: var(--text-faint);
		cursor: pointer;
		font-size: 13px;
		opacity: 0.55;
	}

	.btn-toggle:hover {
		border-color: var(--accent);
		opacity: 1;
	}

	.btn-toggle.activo {
		border-color: var(--accent);
		background: color-mix(in srgb, var(--accent) 14%, transparent);
		opacity: 1;
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
		display: inline-flex;
		align-items: center;
		min-height: 40px;
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

	.link-codigo {
		color: var(--text);
		text-decoration: none;
	}

	.link-codigo:hover {
		color: var(--accent-strong);
		text-decoration: underline;
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
		grid-template-columns: 2fr 1fr 1fr 1fr auto;
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
		border-radius: 999px;
		min-height: 40px;
		padding: 6px 14px;
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
