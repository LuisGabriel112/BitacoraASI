<script lang="ts">
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import Header from '$lib/components/Header.svelte';
	import { api, type Mesa } from '$lib/api/client';

	let buscar = $state('');
	let categoriaId = $state<number | null>(null);
	let ventanaId = $state<number | null>(null);
	let tipoSolucion = $state<'' | 'Modificación en BD' | 'Seguimiento de proceso'>('');
	let page = $state(1);
	const pageSize = 10;

	let items = $state<Mesa[]>([]);
	let total = $state(0);
	let cargando = $state(true);
	let timer: ReturnType<typeof setTimeout>;
	let expandidaId = $state<number | null>(null);

	async function cargar() {
		cargando = true;
		try {
			const pagina = await api.listadoMesas({
				page,
				page_size: pageSize,
				buscar: buscar || undefined,
				categoria_id: categoriaId ?? undefined,
				ventana_id: ventanaId ?? undefined,
				tipo_solucion: tipoSolucion || undefined,
				estado: 'cerrada',
				con_solucion: true
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

	function alternarDescripcion(id: number) {
		expandidaId = expandidaId === id ? null : id;
	}

	$effect(() => {
		page; categoriaId; ventanaId; tipoSolucion;
		cargar();
	});

	const totalPaginas = $derived(Math.max(1, Math.ceil(total / pageSize)));
</script>

<Header titulo="Manual de soluciones" subtitulo="Busca cómo se resolvieron incidencias anteriores." />

<div class="barra-superior">
	<input
		type="search"
		placeholder="Buscar por código, título, descripción o solución…"
		value={buscar}
		oninput={alBuscar}
		class="buscador"
	/>
	<div class="filtros">
		<ComboboxCreatable id="manual-categoria" catalogo="categorias-mesa" label="Categoría" bind:selectedId={categoriaId} />
		<ComboboxCreatable id="manual-ventana" catalogo="ventanas-mesa" label="Ventana" bind:selectedId={ventanaId} />
		<div class="campo">
			<label for="manual-tipo">Categoría de la solución</label>
			<select id="manual-tipo" bind:value={tipoSolucion}>
				<option value="">Todas</option>
				<option value="Modificación en BD">Modificación en BD</option>
				<option value="Seguimiento de proceso">Seguimiento de proceso</option>
			</select>
		</div>
	</div>
</div>

<div class="lista-manual">
	{#if cargando}
		<p class="vacio">Cargando…</p>
	{:else if items.length === 0}
		<p class="vacio">Ninguna solución encontrada con estos filtros.</p>
	{:else}
		{#each items as m}
			<article class="tarjeta-manual">
				<div class="cabecera-manual">
					{#if m.enlace}
						<a href={m.enlace} target="_blank" rel="noopener noreferrer" class="codigo-manual" title="Abrir en Proactivanet">
							{m.codigo}
						</a>
					{:else}
						<span class="codigo-manual sin-enlace">{m.codigo}</span>
					{/if}
					<h2 class="titulo-manual font-display">{m.titulo}</h2>
				</div>
				<div class="badges-manual">
					<span class="badge-manual">{m.categoria.nombre}</span>
					{#if m.ventana}<span class="badge-manual">{m.ventana.nombre}</span>{/if}
					{#if m.tipo_solucion}<span class="badge-manual badge-tipo">{m.tipo_solucion}</span>{/if}
				</div>

				<button type="button" class="btn-descripcion" onclick={() => alternarDescripcion(m.id)}>
					{expandidaId === m.id ? '▾ Ocultar descripción original' : '▸ Ver descripción original'}
				</button>
				{#if expandidaId === m.id}
					<p class="descripcion-manual">{m.descripcion}</p>
				{/if}

				<div class="bloque-solucion">
					<span class="etiqueta-solucion">Solución</span>
					<p class="texto-solucion">{m.solucion}</p>
				</div>
			</article>
		{/each}
	{/if}
</div>

<div class="paginacion">
	<span>{total} soluciones</span>
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
		margin-bottom: 20px;
	}

	.buscador {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 12px;
		min-width: 260px;
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

	select option {
		background: var(--bg);
		color: var(--text);
	}

	.lista-manual {
		display: flex;
		flex-direction: column;
		gap: 16px;
	}

	.vacio {
		color: var(--text-muted);
		text-align: center;
		padding: 30px;
	}

	.tarjeta-manual {
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px 20px;
		background: var(--surface);
	}

	.cabecera-manual {
		display: flex;
		align-items: baseline;
		gap: 10px;
		flex-wrap: wrap;
	}

	.codigo-manual {
		font-family: var(--font-mono);
		font-size: 12px;
		color: var(--accent-strong);
		text-decoration: none;
		flex-shrink: 0;
	}

	.codigo-manual.sin-enlace {
		color: var(--text-muted);
	}

	.codigo-manual:not(.sin-enlace):hover {
		text-decoration: underline;
	}

	.titulo-manual {
		margin: 0;
		font-size: 15px;
	}

	.badges-manual {
		display: flex;
		gap: 6px;
		flex-wrap: wrap;
		margin-top: 8px;
	}

	.badge-manual {
		font-size: 11px;
		color: var(--text-muted);
		background: var(--surface-raised);
		border-radius: 999px;
		padding: 2px 10px;
	}

	.badge-tipo {
		color: var(--accent-strong);
		background: color-mix(in srgb, var(--accent) 14%, transparent);
	}

	.btn-descripcion {
		margin-top: 10px;
		background: none;
		border: none;
		color: var(--text-faint);
		cursor: pointer;
		font-size: 12px;
		padding: 0;
	}

	.btn-descripcion:hover {
		color: var(--text-muted);
	}

	.descripcion-manual {
		margin: 8px 0 0;
		font-size: 13px;
		color: var(--text-muted);
		white-space: pre-wrap;
	}

	.bloque-solucion {
		margin-top: 14px;
		padding-top: 14px;
		border-top: 1px solid var(--border);
	}

	.etiqueta-solucion {
		font-size: 11px;
		text-transform: uppercase;
		letter-spacing: 0.04em;
		color: var(--text-muted);
		font-weight: 600;
	}

	.texto-solucion {
		margin: 6px 0 0;
		font-size: 13px;
		color: var(--text);
		white-space: pre-wrap;
	}

	.paginacion {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-top: 20px;
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
