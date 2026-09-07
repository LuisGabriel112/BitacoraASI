<script lang="ts">
	import { generarBanderines } from '$lib/papelPicado';

	let { cantidad }: { cantidad: number } = $props();

	const banderines = $derived(generarBanderines(cantidad));
</script>

<div class="papel-picado" aria-hidden="true">
	{#each banderines as banderin, i (i)}
		<span class="banderin {banderin.color}" style="animation-delay: {banderin.retrasoMs}ms"></span>
	{/each}
</div>

<style>
	.papel-picado {
		display: none;
	}

	:root[data-temporada='patrio'] .papel-picado {
		display: flex;
		position: relative;
		height: 34px;
		border-bottom: 1px solid var(--border);
	}

	.papel-picado::before {
		content: '';
		position: absolute;
		top: 2px;
		left: 0;
		right: 0;
		height: 2px;
		background: #554f47;
	}

	.banderin {
		flex: 1 0 auto;
		width: 26px;
		height: 28px;
		margin-top: 3px;
		/* triángulo exterior = borde/cordel oscuro; el color real vive en ::before,
		   2px más chico. Evita "filter: drop-shadow" sobre un elemento con
		   clip-path: en el Chrome usado para verificar esto, esa combinación
		   pinta el triángulo entero de rojo sólido en vez de dar un contorno —
		   es la única razón de este doble-triángulo en vez de un simple borde. */
		background: var(--border-strong);
		clip-path: polygon(0 0, 100% 0, 50% 100%);
		transform-origin: top center;
		animation: ondear 2.6s ease-in-out infinite;
		position: relative;
	}

	.banderin::before {
		content: '';
		position: absolute;
		top: 2px;
		left: 2px;
		right: 2px;
		bottom: 0;
		clip-path: polygon(0 0, 100% 0, 50% 100%);
	}

	.banderin::after {
		content: '';
		position: absolute;
		top: 8px;
		left: 50%;
		transform: translateX(-50%);
		width: 5px;
		height: 5px;
		border-radius: 50%;
	}

	.banderin.verde::before {
		background: #006341;
	}

	.banderin.verde::after,
	.banderin.rojo::after {
		background: white;
	}

	.banderin.blanco::before {
		background: white;
	}

	.banderin.blanco::after {
		background: #ce1126;
	}

	.banderin.rojo::before {
		background: #ce1126;
	}

	@keyframes ondear {
		0%,
		100% {
			transform: rotate(-5deg);
		}
		50% {
			transform: rotate(5deg);
		}
	}
</style>
