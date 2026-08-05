<script lang="ts">
	import { api, type Catalogo } from '$lib/api/client';

	let {
		catalogo,
		label,
		selectedId = $bindable(null),
		id
	}: {
		catalogo: 'sistemas' | 'medios' | 'agentes';
		label: string;
		selectedId: number | null;
		id: string;
	} = $props();

	let opciones = $state<Catalogo[]>([]);

	$effect(() => {
		api.catalogo(catalogo).then((r) => (opciones = r));
	});
</script>

<div class="campo">
	<label for={id}>{label}</label>
	<select {id} bind:value={selectedId}>
		<option value={null} disabled selected={selectedId === null}>Selecciona…</option>
		{#each opciones as opcion}
			<option value={opcion.id}>{opcion.nombre}</option>
		{/each}
	</select>
</div>

<style>
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

	select {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
	}

	/* el menú desplegable de <select> lo dibuja el sistema operativo, no
	   nuestro CSS de glass — sin color/fondo explícitos en <option>, puede
	   salir con bajo contraste según el tema del SO. Fondo sólido (no glass)
	   porque el popup nativo no soporta blur/transparencia. */
	select option {
		background: var(--bg);
		color: var(--text);
	}

	select:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}
</style>
