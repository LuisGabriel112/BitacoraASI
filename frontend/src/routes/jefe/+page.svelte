<script lang="ts">
	import { fade } from 'svelte/transition';
	import Header from '$lib/components/Header.svelte';
	import Enemigo3D from '$lib/components/Enemigo3D.svelte';
	import { api, type Jefe } from '$lib/api/client';

	const INTERVALO_MS = 10_000;

	let jefe = $state<Jefe | null>(null);
	let cargando = $state(true);

	$effect(() => {
		let cancelado = false;

		async function tick() {
			try {
				const respuesta = await api.jefeActual();
				if (!cancelado) jefe = respuesta;
			} catch {
				// un fallo de un ciclo de polling no debe romper la UI
			} finally {
				if (!cancelado) cargando = false;
			}
		}

		tick();
		const id = setInterval(tick, INTERVALO_MS);

		return () => {
			cancelado = true;
			clearInterval(id);
		};
	});

	const porcentajeVida = $derived(jefe ? Math.max(0, (jefe.vida_actual / jefe.vida_max) * 100) : 0);
</script>

<Header titulo="Jefe de la semana" subtitulo="Cada mesa y soporte cerrado le baja vida." />

{#if cargando}
	<p class="cargando">Cargando jefe…</p>
{:else if jefe}
	<section class="tarjeta" in:fade={{ duration: 250 }}>
		<Enemigo3D derrotado={jefe.derrotado} {porcentajeVida} tamano={200} />
		<h2 class="font-display">{jefe.nombre}</h2>
		<span class="semana">{jefe.semana}</span>

		<div class="barra-vida" title="{jefe.vida_actual} / {jefe.vida_max}">
			<div class="barra-vida-relleno" class:derrotado={jefe.derrotado} style="width: {porcentajeVida}%"></div>
		</div>
		<span class="vida-detalle">{jefe.vida_actual} / {jefe.vida_max} de vida</span>

		{#if jefe.derrotado}
			<p class="mensaje-derrota">¡El equipo derrotó al jefe de esta semana! 🎉</p>
		{/if}
	</section>
{/if}

<style>
	.cargando {
		color: var(--text-muted);
	}

	.tarjeta {
		max-width: 480px;
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 32px;
		display: flex;
		flex-direction: column;
		align-items: center;
		text-align: center;
		gap: 6px;
	}

	.tarjeta h2 {
		margin: 6px 0 0;
	}

	.semana {
		color: var(--text-muted);
		font-size: 13px;
		margin-bottom: 16px;
	}

	.barra-vida {
		width: 100%;
		height: 16px;
		background: var(--border);
		border-radius: 999px;
		overflow: hidden;
	}

	.barra-vida-relleno {
		height: 100%;
		background: var(--danger);
		transition: width 0.4s ease;
	}

	.barra-vida-relleno.derrotado {
		background: var(--text-faint);
	}

	.vida-detalle {
		font-size: 12px;
		color: var(--text-faint);
		margin-top: 8px;
	}

	.mensaje-derrota {
		margin-top: 16px;
		font-weight: 600;
		color: var(--success);
	}
</style>
