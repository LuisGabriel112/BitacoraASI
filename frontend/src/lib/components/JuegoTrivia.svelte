<script lang="ts">
	import { browser } from '$app/environment';
	import { api, type PreguntaTrivia } from '$lib/api/client';
	import { segundosRestantesCooldown } from '$lib/cooldownMinijuego';

	const CLAVE_ULTIMO = 'bitacora-trivia-ultimo-intento';

	let pregunta = $state<PreguntaTrivia | null>(null);
	let resultado = $state<{ acierto: boolean; respuestaCorrecta: number; elegida: number; opciones: string[] } | null>(
		null
	);
	let error = $state<string | null>(null);
	let segundosRestantes = $state(0);

	function leerUltimoIntento(): number | null {
		if (!browser) return null;
		const guardado = localStorage.getItem(CLAVE_ULTIMO);
		return guardado ? Number(guardado) : null;
	}

	function actualizarCooldown() {
		segundosRestantes = segundosRestantesCooldown(leerUltimoIntento(), Date.now());
	}

	function marcarIntentoAhora() {
		if (browser) localStorage.setItem(CLAVE_ULTIMO, String(Date.now()));
		actualizarCooldown();
	}

	$effect(() => {
		actualizarCooldown();
		const id = setInterval(actualizarCooldown, 1000);
		return () => clearInterval(id);
	});

	async function iniciar() {
		error = null;
		resultado = null;
		try {
			pregunta = await api.iniciarTrivia();
		} catch (e) {
			error = e instanceof Error ? e.message : 'Todavía en cooldown';
			marcarIntentoAhora();
		}
	}

	async function responder(opcion: number) {
		if (!pregunta) return;
		try {
			const r = await api.responderTrivia(pregunta.intento_id, opcion);
			resultado = {
				acierto: r.acierto,
				respuestaCorrecta: r.respuesta_correcta,
				elegida: opcion,
				opciones: pregunta.opciones
			};
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo responder';
		} finally {
			pregunta = null;
			marcarIntentoAhora();
		}
	}

	function formatearTiempo(segundos: number) {
		const m = Math.floor(segundos / 60);
		const s = segundos % 60;
		return `${m}:${String(s).padStart(2, '0')}`;
	}
</script>

<div class="tarjeta juego-trivia">
	<h2 class="font-display">🧠 Trivia de soporte</h2>
	<p class="ayuda-juego">Acierta y le bajas vida al jefe.</p>

	{#if pregunta}
		<p class="texto-pregunta">{pregunta.texto}</p>
		<div class="opciones-trivia">
			{#each pregunta.opciones as opcion, i}
				<button type="button" class="opcion-trivia" onclick={() => responder(i)}>{opcion}</button>
			{/each}
		</div>
	{:else if resultado}
		<div class="opciones-trivia">
			{#each resultado.opciones as opcion, i}
				<span
					class="opcion-trivia resultado"
					class:correcta={i === resultado.respuestaCorrecta}
					class:incorrecta={i === resultado.elegida && !resultado.acierto}
				>
					{i === resultado.respuestaCorrecta ? '✓' : i === resultado.elegida ? '✗' : ''}
					{opcion}
				</span>
			{/each}
		</div>
		<p class="resultado-trivia" class:acierto={resultado.acierto}>
			{resultado.acierto ? '¡Le bajaste vida al jefe!' : 'Fallaste, esa no era.'}
		</p>
		<button type="button" class="btn-jugar" onclick={iniciar} disabled={segundosRestantes > 0}>
			{segundosRestantes > 0 ? `Espera ${formatearTiempo(segundosRestantes)}` : 'Jugar de nuevo'}
		</button>
	{:else}
		<button type="button" class="btn-jugar" onclick={iniciar} disabled={segundosRestantes > 0}>
			{segundosRestantes > 0 ? `Espera ${formatearTiempo(segundosRestantes)}` : 'Jugar'}
		</button>
	{/if}

	{#if error}<p class="error-juego">{error}</p>{/if}
</div>

<style>
	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 24px;
	}

	.juego-trivia h2 {
		margin: 0 0 4px;
		font-size: 16px;
	}

	.ayuda-juego {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.texto-pregunta {
		font-size: 14px;
		color: var(--text);
		margin: 0 0 12px;
	}

	.opciones-trivia {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 8px;
		margin-bottom: 14px;
	}

	.opcion-trivia {
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		font-size: 12px;
		color: var(--text);
		cursor: pointer;
		text-align: left;
	}

	button.opcion-trivia:hover {
		border-color: var(--accent);
	}

	span.opcion-trivia.resultado {
		display: flex;
		align-items: center;
		gap: 6px;
		text-align: left;
		font-weight: 400;
		cursor: default;
	}

	span.opcion-trivia.correcta {
		border-color: var(--success);
		background: color-mix(in srgb, var(--success) 14%, transparent);
		color: var(--success);
	}

	span.opcion-trivia.incorrecta {
		border-color: var(--danger);
		background: color-mix(in srgb, var(--danger) 14%, transparent);
		color: var(--danger);
	}

	.resultado-trivia {
		font-size: 13px;
		font-weight: 600;
		color: var(--danger);
		margin: 0 0 14px;
	}

	.resultado-trivia.acierto {
		color: var(--success);
	}

	.btn-jugar {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 10px 18px;
		font-weight: 600;
		cursor: pointer;
	}

	.btn-jugar:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.btn-jugar:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.error-juego {
		color: var(--danger);
		font-size: 12px;
		margin: 10px 0 0;
	}
</style>
