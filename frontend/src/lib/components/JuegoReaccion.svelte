<script lang="ts">
	import { browser } from '$app/environment';
	import { api } from '$lib/api/client';
	import { segundosRestantesCooldown } from '$lib/cooldownMinijuego';

	const CLAVE_ULTIMO = 'bitacora-reaccion-ultimo-intento';
	const DEMORA_MIN_MS = 1000;
	const DEMORA_MAX_MS = 4000;

	type Estado = 'inactivo' | 'esperando_senal' | 'listo';

	let estado = $state<Estado>('inactivo');
	let intentoId = $state<number | null>(null);
	let tSenal = 0;
	let temporizador: ReturnType<typeof setTimeout> | undefined;
	let resultado = $state<{ acierto: boolean; tiempoMs: number } | null>(null);
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

	$effect(() => () => clearTimeout(temporizador));

	async function iniciar() {
		error = null;
		resultado = null;
		try {
			const intento = await api.iniciarReaccion();
			intentoId = intento.id;
			estado = 'esperando_senal';
			const demora = DEMORA_MIN_MS + Math.random() * (DEMORA_MAX_MS - DEMORA_MIN_MS);
			temporizador = setTimeout(() => {
				estado = 'listo';
				tSenal = performance.now();
			}, demora);
		} catch (e) {
			error = e instanceof Error ? e.message : 'Todavía en cooldown';
			marcarIntentoAhora();
		}
	}

	async function reportar(tiempoMs: number) {
		if (!intentoId) return;
		try {
			const r = await api.reportarReaccion(intentoId, tiempoMs);
			resultado = { acierto: r.acierto, tiempoMs };
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo reportar el intento';
		} finally {
			intentoId = null;
			estado = 'inactivo';
			marcarIntentoAhora();
		}
	}

	function alClicSenal() {
		if (estado === 'listo') {
			reportar(performance.now() - tSenal);
		} else if (estado === 'esperando_senal') {
			clearTimeout(temporizador);
			reportar(0);
		}
	}

	function formatearTiempo(segundos: number) {
		const m = Math.floor(segundos / 60);
		const s = segundos % 60;
		return `${m}:${String(s).padStart(2, '0')}`;
	}
</script>

<div class="tarjeta juego-reaccion">
	<h2 class="font-display">⚡ Reacción rápida</h2>
	<p class="ayuda-juego">Espera la señal verde y haz clic — le bajas vida al jefe.</p>

	{#if estado === 'esperando_senal'}
		<button type="button" class="boton-senal espera" onclick={alClicSenal}>Prepárate…</button>
	{:else if estado === 'listo'}
		<button type="button" class="boton-senal listo" onclick={alClicSenal}>¡CLIC!</button>
	{:else if resultado}
		<p class="resultado-reaccion" class:acierto={resultado.acierto}>
			{resultado.acierto
				? `¡Le bajaste vida al jefe! (${Math.round(resultado.tiempoMs)} ms)`
				: 'No contó — muy rápido para ser real o muy lento.'}
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

	.juego-reaccion h2 {
		margin: 0 0 4px;
		font-size: 16px;
	}

	.ayuda-juego {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.boton-senal {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 100%;
		height: 90px;
		border-radius: var(--radius);
		border: none;
		font-weight: 700;
		font-size: 15px;
		cursor: pointer;
		color: var(--bg);
	}

	.boton-senal.espera {
		background: var(--text-faint);
	}

	.boton-senal.listo {
		background: var(--success);
	}

	.resultado-reaccion {
		font-size: 13px;
		font-weight: 600;
		color: var(--danger);
		margin: 0 0 14px;
	}

	.resultado-reaccion.acierto {
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
