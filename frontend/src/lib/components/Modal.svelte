<script lang="ts">
	import type { Snippet } from 'svelte';
	import Icon from '$lib/components/Icon.svelte';

	// Cerrar con teclado es Escape a nivel de ventana, no un onkeydown en el
	// velo: el foco vive dentro del diálogo, así que un evento en el velo no se
	// dispararía nunca.
	let {
		titulo,
		abierto,
		cerrable = true,
		ancho = '420px',
		alCerrar,
		children
	}: {
		titulo: string;
		abierto: boolean;
		/** false mientras hay algo en curso que no conviene interrumpir. */
		cerrable?: boolean;
		ancho?: string;
		/** Lo dispara Escape, el clic en el velo y la X; el padre decide qué
		 *  hacer, porque suele tener que limpiar su propio estado. */
		alCerrar: () => void;
		children: Snippet;
	} = $props();

	let dialogo = $state<HTMLDivElement | undefined>(undefined);

	function cerrar() {
		if (cerrable) alCerrar();
	}

	// Al abrir, el foco está en el botón que lo abrió (fuera del diálogo): se
	// trae adentro para que Escape y el lector de pantalla funcionen.
	$effect(() => {
		if (abierto) dialogo?.focus();
	});
</script>

<svelte:window onkeydown={(e) => abierto && e.key === 'Escape' && cerrar()} />

{#if abierto}
	<!-- svelte-ignore a11y_click_events_have_key_events -->
	<!-- svelte-ignore a11y_no_static_element_interactions -->
	<div class="overlay" onclick={cerrar}>
		<div
			class="modal tarjeta"
			bind:this={dialogo}
			onclick={(e) => e.stopPropagation()}
			role="dialog"
			aria-modal="true"
			aria-labelledby="titulo-modal"
			tabindex="-1"
			style:width="min({ancho}, 100%)"
		>
			<div class="cabecera">
				<h2 id="titulo-modal" class="font-display">{titulo}</h2>
				<button type="button" class="cerrar" onclick={cerrar} disabled={!cerrable} aria-label="Cerrar">
					<Icon nombre="x" tamano={16} />
				</button>
			</div>
			{@render children()}
		</div>
	</div>
{/if}

<style>
	.overlay {
		position: fixed;
		inset: 0;
		z-index: 400;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 24px;
		background: var(--scrim);
		overflow-y: auto;
	}

	.modal {
		padding: 22px;
		cursor: default;
	}

	.cabecera {
		display: flex;
		align-items: baseline;
		justify-content: space-between;
		gap: 12px;
		margin-bottom: 10px;
	}

	.cabecera h2 {
		margin: 0;
		font-size: 16px;
	}

	.cerrar {
		display: flex;
		background: none;
		border: none;
		color: var(--text-muted);
		cursor: pointer;
		padding: 2px;
	}

	.cerrar:hover:not(:disabled) {
		color: var(--text);
	}

	.cerrar:disabled {
		opacity: 0.5;
		cursor: default;
	}
</style>
