<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Gatito3D from '$lib/components/Gatito3D.svelte';
	import { colorGatito } from '$lib/colorGatito';
	import { api, type Mascota } from '$lib/api/client';

	let mascotas = $state<Mascota[]>([]);
	let cargando = $state(true);

	$effect(() => {
		api.mascotas()
			.then((m) => (mascotas = m))
			.finally(() => (cargando = false));
	});
</script>

<Header titulo="Mascotas" subtitulo="Cada jefe semanal que derrotamos se convierte en gatito. Tócalo para jugar." />

{#if cargando}
	<p class="cargando">Cargando mascotas…</p>
{:else if mascotas.length === 0}
	<p class="vacio">Todavía no hay mascotas — ¡derroten al jefe de esta semana!</p>
{:else}
	<div class="rejilla">
		{#each mascotas as m}
			<div class="tarjeta">
				<Gatito3D color={colorGatito(m.semana + m.nombre)} nombre={m.nombre} tamano={140} />
				<h2 class="font-display">{m.nombre}</h2>
				<span class="semana">{m.semana}</span>
				<span class="vida-max">{m.vida_max} de vida máxima</span>
			</div>
		{/each}
	</div>
{/if}

<style>
	.cargando,
	.vacio {
		color: var(--text-muted);
	}

	.rejilla {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
		gap: 20px;
	}

	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 24px;
		display: flex;
		flex-direction: column;
		align-items: center;
		text-align: center;
		gap: 4px;
	}

	.tarjeta h2 {
		margin: 6px 0 0;
		font-size: 16px;
	}

	.semana {
		color: var(--text-muted);
		font-size: 12px;
	}

	.vida-max {
		color: var(--text-faint);
		font-size: 11px;
	}
</style>
