<script lang="ts">
	import { ICONOS, type NombreIcono } from '$lib/icons';

	let { nombre, tamano = 16, trazo = 2 }: { nombre: NombreIcono; tamano?: number; trazo?: number } = $props();
</script>

<svg
	class="icono-svg"
	width={tamano}
	height={tamano}
	viewBox="0 0 24 24"
	fill="none"
	stroke="currentColor"
	stroke-width={trazo}
	stroke-linecap="round"
	stroke-linejoin="round"
	aria-hidden="true"
>
	{@html ICONOS[nombre]}
</svg>

<style>
	.icono-svg {
		flex-shrink: 0;
		display: inline-block;
		vertical-align: middle;
	}
</style>
