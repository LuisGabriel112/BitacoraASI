<script lang="ts">
	import { api, type Catalogo } from '$lib/api/client';
	import { invalidarCache } from '$lib/catalogoCache';
	import Icon from '$lib/components/Icon.svelte';

	type CatalogoMesa = 'categorias-mesa' | 'solicitantes-mesa' | 'resolutores-mesa' | 'ventanas-mesa';

	const PESTANAS: { catalogo: CatalogoMesa; etiqueta: string }[] = [
		{ catalogo: 'categorias-mesa', etiqueta: 'Categorías' },
		{ catalogo: 'solicitantes-mesa', etiqueta: 'Solicitantes' },
		{ catalogo: 'resolutores-mesa', etiqueta: 'Resolutores' },
		{ catalogo: 'ventanas-mesa', etiqueta: 'Ventanas' }
	];

	let visible = $state(false);
	let pestanaActiva = $state<CatalogoMesa>('ventanas-mesa');
	let items = $state<Catalogo[]>([]);
	let cargando = $state(false);
	let confirmandoId = $state<number | null>(null);
	let eliminandoId = $state<number | null>(null);
	let error = $state<string | null>(null);

	async function cargar() {
		cargando = true;
		error = null;
		try {
			items = await api.catalogo(pestanaActiva, '', 200);
		} finally {
			cargando = false;
		}
	}

	export function abrir() {
		visible = true;
		confirmandoId = null;
		error = null;
		cargar();
	}

	function cerrar() {
		visible = false;
	}

	function elegirPestana(catalogo: CatalogoMesa) {
		pestanaActiva = catalogo;
		confirmandoId = null;
		error = null;
		cargar();
	}

	async function eliminar(id: number) {
		eliminandoId = id;
		error = null;
		try {
			await api.eliminarCatalogo(pestanaActiva, id);
			items = items.filter((i) => i.id !== id);
			invalidarCache(pestanaActiva);
			confirmandoId = null;
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo eliminar';
		} finally {
			eliminandoId = null;
		}
	}
</script>

{#if visible}
	<div
		class="overlay"
		onclick={cerrar}
		onkeydown={(e) => e.key === 'Escape' && cerrar()}
		role="button"
		tabindex="-1"
	>
		<div
			class="modal"
			onclick={(e) => e.stopPropagation()}
			onkeydown={(e) => e.stopPropagation()}
			role="dialog"
			aria-modal="true"
			tabindex="-1"
		>
			<div class="modal-cabecera">
				<h2 class="font-display">Gestionar catálogos</h2>
				<button class="cerrar" onclick={cerrar} aria-label="Cerrar"><Icon nombre="x" tamano={16} /></button>
			</div>

			<div class="pestanas">
				{#each PESTANAS as p}
					<button
						type="button"
						class:activa={pestanaActiva === p.catalogo}
						onclick={() => elegirPestana(p.catalogo)}
					>
						{p.etiqueta}
					</button>
				{/each}
			</div>

			{#if error}<p class="error-catalogo">{error}</p>{/if}

			<div class="lista-catalogo">
				{#if cargando}
					<p class="vacio-catalogo">Cargando…</p>
				{:else if items.length === 0}
					<p class="vacio-catalogo">Sin opciones registradas.</p>
				{:else}
					<ul>
						{#each items as item}
							<li>
								<span>{item.nombre}</span>
								{#if confirmandoId === item.id}
									<span class="confirmar">
										¿Eliminar?
										<button
											class="btn-confirmar"
											disabled={eliminandoId === item.id}
											onclick={() => eliminar(item.id)}
										>
											{eliminandoId === item.id ? 'Eliminando…' : 'Sí'}
										</button>
										<button class="btn-cancelar" onclick={() => (confirmandoId = null)}>No</button>
									</span>
								{:else}
									<button
										type="button"
										class="btn-eliminar"
										title="Eliminar opción"
										aria-label="Eliminar opción"
										onclick={() => (confirmandoId = item.id)}
									>
										<Icon nombre="trash-2" tamano={14} />
									</button>
								{/if}
							</li>
						{/each}
					</ul>
				{/if}
			</div>
		</div>
	</div>
{/if}

<style>
	.overlay {
		position: fixed;
		inset: 0;
		background: oklch(0 0 0 / 0.5);
		z-index: 250;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 20px;
	}

	.modal {
		background: color-mix(in oklch, var(--bg) 96%, var(--surface-raised));
		backdrop-filter: var(--glass-blur);
		-webkit-backdrop-filter: var(--glass-blur);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius-lg);
		box-shadow: 0 20px 50px -12px oklch(0 0 0 / 0.5);
		width: 100%;
		max-width: 480px;
		max-height: 80vh;
		display: flex;
		flex-direction: column;
		padding: 20px;
		gap: 14px;
	}

	.modal-cabecera {
		display: flex;
		align-items: center;
		justify-content: space-between;
	}

	.modal-cabecera h2 {
		margin: 0;
		font-size: 16px;
	}

	.cerrar {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		background: none;
		border: none;
		color: var(--text-faint);
		cursor: pointer;
	}

	.cerrar:hover {
		color: var(--text);
	}

	.pestanas {
		display: flex;
		gap: 6px;
		flex-wrap: wrap;
	}

	.pestanas button {
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: 999px;
		padding: 6px 12px;
		font-size: 12px;
		color: var(--text);
		cursor: pointer;
	}

	.pestanas button:hover {
		border-color: var(--accent);
	}

	.pestanas button.activa {
		background: var(--accent);
		color: var(--bg);
		border-color: var(--accent);
		font-weight: 600;
	}

	.lista-catalogo {
		overflow-y: auto;
		flex: 1;
	}

	.lista-catalogo ul {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 6px;
	}

	.lista-catalogo li {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 10px;
		padding: 8px 10px;
		border: 1px solid var(--border);
		border-radius: var(--radius);
		font-size: 13px;
	}

	.vacio-catalogo {
		color: var(--text-muted);
		font-size: 13px;
		text-align: center;
		padding: 20px 0;
	}

	.btn-eliminar {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		background: none;
		border: 1px solid transparent;
		border-radius: var(--radius);
		color: var(--text-faint);
		cursor: pointer;
		padding: 4px 8px;
		flex-shrink: 0;
	}

	.btn-eliminar:hover {
		border-color: var(--danger);
		color: var(--danger);
		background: color-mix(in srgb, var(--danger) 12%, transparent);
	}

	.confirmar {
		display: flex;
		align-items: center;
		gap: 6px;
		font-size: 12px;
		color: var(--text-muted);
		white-space: nowrap;
		flex-shrink: 0;
	}

	.btn-confirmar {
		background: var(--danger);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 3px 8px;
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
		padding: 3px 8px;
		color: var(--text);
		cursor: pointer;
	}

	.btn-cancelar:hover {
		border-color: var(--accent);
	}

	.error-catalogo {
		color: var(--danger);
		font-size: 12px;
		margin: 0;
	}
</style>
