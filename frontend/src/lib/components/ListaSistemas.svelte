<script lang="ts">
	import ChipSistema from '$lib/components/ChipSistema.svelte';
	import type { FilaSistema } from '$lib/volumenSistemas';

	let { filas, loading = false }: { filas: FilaSistema[]; loading?: boolean } = $props();
</script>

{#if loading}
	<ul class="lista">
		{#each Array(3) as _}
			<li class="fila"><span class="skeleton skeleton-fila" aria-hidden="true"></span></li>
		{/each}
	</ul>
{:else if filas.length === 0}
	<p class="vacio">Ningún registro esta semana.</p>
{:else}
	<ul class="lista">
		{#each filas as fila}
			<li class="fila">
				<div class="encabezado">
					<ChipSistema nombre={fila.nombre} />
					<span class="total font-display">{fila.total}</span>
				</div>
				<div class="barra">
					<div
						class="relleno"
						style="transform: scaleX({fila.fraccion}); background: var(--sistema-{fila.nombre.toLowerCase()}, var(--accent))"
					></div>
				</div>
			</li>
		{/each}
	</ul>
{/if}

<style>
	.lista {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 16px;
	}

	.fila {
		display: flex;
		flex-direction: column;
		gap: 8px;
	}

	.encabezado {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 10px;
	}

	.total {
		font-size: 15px;
		font-weight: 700;
	}

	.barra {
		height: 6px;
		background: var(--surface-raised);
		border-radius: var(--radius-pill);
		overflow: hidden;
	}

	.relleno {
		width: 100%;
		height: 100%;
		transform-origin: left;
		transition: transform 0.3s ease;
	}

	.skeleton-fila {
		display: block;
		height: 30px;
		width: 100%;
		border-radius: var(--radius-sm);
	}

	.vacio {
		margin: 0;
		color: var(--text-muted);
		font-size: 13px;
	}
</style>
