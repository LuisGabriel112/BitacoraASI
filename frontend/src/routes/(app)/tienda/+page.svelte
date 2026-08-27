<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import { api, type Objeto, type TiendaEstado } from '$lib/api/client';

	let catalogo = $state<Objeto[]>([]);
	let estado = $state<TiendaEstado | null>(null);
	let cargando = $state(true);
	let comprandoId = $state<string | null>(null);
	let error = $state<string | null>(null);

	async function cargar() {
		const [c, e] = await Promise.all([api.tiendaCatalogo(), api.tiendaEstado()]);
		catalogo = c;
		estado = e;
	}

	$effect(() => {
		cargando = true;
		cargar().finally(() => (cargando = false));
	});

	const basicos = $derived(catalogo.filter((o) => !o.requiere));
	const combinados = $derived(catalogo.filter((o) => o.requiere));
	const idsEquipados = $derived(new Set((estado?.equipados ?? []).map((o) => o.id)));

	function yaEquipado(objeto: Objeto): boolean {
		return idsEquipados.has(objeto.id);
	}

	function faltaCredito(objeto: Objeto): boolean {
		return (estado?.creditos_disponibles ?? 0) < objeto.costo;
	}

	function partesFaltantes(objeto: Objeto): string[] {
		if (!objeto.requiere) return [];
		return objeto.requiere.filter((id) => !idsEquipados.has(id));
	}

	function nombreDe(id: string): string {
		return catalogo.find((o) => o.id === id)?.nombre ?? id;
	}

	function puedeComprar(objeto: Objeto): boolean {
		return !yaEquipado(objeto) && !faltaCredito(objeto) && partesFaltantes(objeto).length === 0;
	}

	function razonBloqueo(objeto: Objeto): string | undefined {
		const faltantes = partesFaltantes(objeto);
		if (faltantes.length > 0) return `Falta: ${faltantes.map(nombreDe).join(', ')}`;
		if (faltaCredito(objeto)) return 'Créditos insuficientes';
		return undefined;
	}

	type ObjetoStats = Pick<Objeto, 'danio_pct' | 'critico_pct' | 'cooldown_pct' | 'xp_pct'>;

	function stats(objeto: ObjetoStats): { texto: string }[] {
		const lista: { texto: string }[] = [];
		if (objeto.danio_pct) lista.push({ texto: `+${objeto.danio_pct}% daño` });
		if (objeto.critico_pct) lista.push({ texto: `+${objeto.critico_pct}% crítico` });
		if (objeto.cooldown_pct) lista.push({ texto: `-${objeto.cooldown_pct}% cooldown` });
		if (objeto.xp_pct) lista.push({ texto: `+${objeto.xp_pct}% XP` });
		return lista;
	}

	const bonoTotal = $derived.by(() => {
		const equipados = estado?.equipados ?? [];
		return {
			danio_pct: equipados.reduce((s, o) => s + o.danio_pct, 0),
			critico_pct: equipados.reduce((s, o) => s + o.critico_pct, 0),
			cooldown_pct: equipados.reduce((s, o) => s + o.cooldown_pct, 0),
			xp_pct: equipados.reduce((s, o) => s + o.xp_pct, 0)
		};
	});
	const statsBonoTotal = $derived(stats(bonoTotal));

	async function comprar(objeto: Objeto) {
		comprandoId = objeto.id;
		error = null;
		try {
			estado = await api.tiendaComprar(objeto.id);
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo comprar el objeto';
		} finally {
			comprandoId = null;
		}
	}
</script>

<Header
	titulo="Tienda"
	subtitulo="Gana créditos cerrando mesas y creando registros. Los objetos y créditos se reinician cada semana junto con el jefe."
/>

{#if cargando}
	<p class="cargando">Cargando tienda…</p>
{:else}
	<div class="creditos-actuales">
		<span class="creditos-etiqueta">Créditos disponibles esta semana</span>
		<span class="creditos-valor font-display">{estado?.creditos_disponibles ?? 0}</span>
	</div>

	{#if error}<p class="error-tienda">{error}</p>{/if}

	<section class="seccion-tienda">
		<h2 class="font-display">Mi inventario</h2>
		{#if (estado?.equipados.length ?? 0) === 0}
			<p class="inventario-vacio">Sin objetos equipados todavía — compra algo de abajo.</p>
		{:else}
			<div class="inventario">
				<div class="inventario-objetos">
					{#each estado?.equipados ?? [] as objeto}
						<span class="chip-inventario">{objeto.nombre}</span>
					{/each}
				</div>
				{#if statsBonoTotal.length > 0}
					<div class="inventario-bono">
						<span class="inventario-bono-etiqueta">Bono total:</span>
						{#each statsBonoTotal as s}<span class="stat-chip">{s.texto}</span>{/each}
					</div>
				{/if}
			</div>
		{/if}
	</section>

	<section class="seccion-tienda">
		<h2 class="font-display">Objetos básicos</h2>
		<div class="rejilla-objetos">
			{#each basicos as objeto}
				<div class="tarjeta-objeto" class:equipado={yaEquipado(objeto)}>
					<h3>{objeto.nombre}</h3>
					<p class="descripcion-objeto">{objeto.descripcion}</p>
					<div class="stats-objeto">
						{#each stats(objeto) as s}<span class="stat-chip">{s.texto}</span>{/each}
					</div>
					<div class="pie-objeto">
						<span class="costo-objeto">{objeto.costo} créditos</span>
						<button
							type="button"
							class="btn-comprar"
							disabled={!puedeComprar(objeto) || comprandoId === objeto.id}
							title={razonBloqueo(objeto)}
							onclick={() => comprar(objeto)}
						>
							{#if yaEquipado(objeto)}
								Equipado
							{:else if comprandoId === objeto.id}
								Comprando…
							{:else}
								Comprar
							{/if}
						</button>
					</div>
				</div>
			{/each}
		</div>
	</section>

	<section class="seccion-tienda">
		<h2 class="font-display">Objetos combinados</h2>
		<div class="rejilla-objetos">
			{#each combinados as objeto}
				<div class="tarjeta-objeto" class:equipado={yaEquipado(objeto)}>
					<h3>{objeto.nombre}</h3>
					<p class="descripcion-objeto">{objeto.descripcion}</p>
					<div class="stats-objeto">
						{#each stats(objeto) as s}<span class="stat-chip">{s.texto}</span>{/each}
					</div>
					<p class="requiere-objeto" class:incompleto={partesFaltantes(objeto).length > 0}>
						Requiere: {objeto.requiere?.map(nombreDe).join(' + ')}
					</p>
					<div class="pie-objeto">
						<span class="costo-objeto">+{objeto.costo} créditos</span>
						<button
							type="button"
							class="btn-comprar"
							disabled={!puedeComprar(objeto) || comprandoId === objeto.id}
							title={razonBloqueo(objeto)}
							onclick={() => comprar(objeto)}
						>
							{#if yaEquipado(objeto)}
								Equipado
							{:else if comprandoId === objeto.id}
								Comprando…
							{:else}
								Comprar
							{/if}
						</button>
					</div>
				</div>
			{/each}
		</div>
	</section>
{/if}

<style>
	.cargando {
		color: var(--text-muted);
	}

	.creditos-actuales {
		display: flex;
		align-items: baseline;
		gap: 10px;
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 16px 20px;
		margin-bottom: 24px;
	}

	.creditos-etiqueta {
		color: var(--text-muted);
		font-size: 13px;
	}

	.creditos-valor {
		font-size: 24px;
		font-weight: 700;
		color: var(--accent-strong);
	}

	.error-tienda {
		color: var(--danger);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.inventario-vacio {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0;
	}

	.inventario {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 16px 20px;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.inventario-objetos {
		display: flex;
		flex-wrap: wrap;
		gap: 8px;
	}

	.chip-inventario {
		font-size: 12px;
		font-weight: 600;
		color: var(--text);
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 6px 12px;
	}

	.inventario-bono {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		gap: 6px;
		padding-top: 8px;
		border-top: 1px solid var(--border);
	}

	.inventario-bono-etiqueta {
		font-size: 12px;
		color: var(--text-muted);
		margin-right: 2px;
	}

	.seccion-tienda {
		margin-bottom: 28px;
	}

	.seccion-tienda h2 {
		font-size: 14px;
		color: var(--text-muted);
		margin: 0 0 14px;
	}

	.rejilla-objetos {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
		gap: 16px;
	}

	.tarjeta-objeto {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px;
		display: flex;
		flex-direction: column;
		gap: 8px;
		min-width: 0;
	}

	.tarjeta-objeto.equipado {
		border-color: var(--accent);
		background: color-mix(in srgb, var(--accent) 8%, var(--surface));
	}

	.tarjeta-objeto h3 {
		margin: 0;
		font-size: 14px;
	}

	.descripcion-objeto {
		margin: 0;
		font-size: 12px;
		color: var(--text-muted);
		flex: 1;
	}

	.stats-objeto {
		display: flex;
		flex-wrap: wrap;
		gap: 6px;
	}

	.stat-chip {
		font-size: 11px;
		font-weight: 600;
		color: var(--accent-strong);
		background: color-mix(in srgb, var(--accent) 14%, transparent);
		border-radius: 999px;
		padding: 3px 9px;
	}

	.requiere-objeto {
		margin: 0;
		font-size: 11px;
		color: var(--text-faint);
	}

	.requiere-objeto.incompleto {
		color: var(--danger);
	}

	.pie-objeto {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 10px;
		margin-top: auto;
		padding-top: 4px;
	}

	.costo-objeto {
		font-family: var(--font-mono);
		font-size: 13px;
		color: var(--text);
		white-space: nowrap;
	}

	.btn-comprar {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 8px 14px;
		font-weight: 600;
		font-size: 12px;
		cursor: pointer;
		white-space: nowrap;
		flex-shrink: 0;
	}

	.btn-comprar:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.btn-comprar:disabled {
		opacity: 0.55;
		cursor: default;
	}
</style>
