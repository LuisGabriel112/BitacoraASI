<script lang="ts">
	import { browser } from '$app/environment';
	import { api } from '$lib/api/client';
	import { segundosRestantesCooldown } from '$lib/cooldownPelota';

	const CLAVE_ULTIMO = 'bitacora-pelota-ultimo-intento';
	const CASILLAS = 3;

	let intentoId = $state<number | null>(null);
	let jugando = $state(false);
	let resultado = $state<{ acierto: boolean; posicionCorrecta: number } | null>(null);
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
			const intento = await api.iniciarPelota();
			intentoId = intento.id;
			jugando = true;
		} catch (e) {
			error = e instanceof Error ? e.message : 'Todavía en cooldown';
			marcarIntentoAhora();
		}
	}

	async function elegir(posicion: number) {
		if (!intentoId) return;
		try {
			const r = await api.elegirPelota(intentoId, posicion);
			resultado = { acierto: r.acierto, posicionCorrecta: r.posicion_correcta };
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo resolver el intento';
		} finally {
			jugando = false;
			intentoId = null;
			marcarIntentoAhora();
		}
	}

	function formatearTiempo(segundos: number) {
		const m = Math.floor(segundos / 60);
		const s = segundos % 60;
		return `${m}:${String(s).padStart(2, '0')}`;
	}
</script>

<div class="tarjeta juego-pelota">
	<h2 class="font-display">🎾 Encuentra la pelota</h2>
	<p class="ayuda-juego">Acierta y le bajas vida al jefe.</p>

	{#if jugando}
		<div class="vasos-pelota">
			{#each Array(CASILLAS) as _, i}
				<button type="button" class="vaso-pelota" onclick={() => elegir(i)}>🥤</button>
			{/each}
		</div>
	{:else if resultado}
		<div class="vasos-pelota">
			{#each Array(CASILLAS) as _, i}
				<span class="vaso-pelota" class:correcto={i === resultado.posicionCorrecta}>
					{i === resultado.posicionCorrecta ? '🎾' : '🥤'}
				</span>
			{/each}
		</div>
		<p class="resultado-pelota" class:acierto={resultado.acierto}>
			{resultado.acierto ? '¡Le bajaste vida al jefe!' : 'Fallaste, era otro vaso.'}
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

	.juego-pelota h2 {
		margin: 0 0 4px;
		font-size: 16px;
	}

	.ayuda-juego {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.vasos-pelota {
		display: flex;
		gap: 14px;
		margin-bottom: 14px;
	}

	.vaso-pelota {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		width: 64px;
		height: 64px;
		font-size: 28px;
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		cursor: pointer;
	}

	button.vaso-pelota:hover {
		border-color: var(--accent);
	}

	span.vaso-pelota.correcto {
		border-color: var(--success);
		background: color-mix(in srgb, var(--success) 14%, transparent);
	}

	.resultado-pelota {
		font-size: 13px;
		font-weight: 600;
		color: var(--danger);
		margin: 0 0 14px;
	}

	.resultado-pelota.acierto {
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
