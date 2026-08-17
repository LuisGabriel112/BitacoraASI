<script lang="ts">
	import { browser } from '$app/environment';
	import { api } from '$lib/api/client';
	import { segundosRestantesCooldown } from '$lib/cooldownMinijuego';
	import { generarMazo } from '$lib/memorama';

	const CLAVE_ULTIMO = 'bitacora-memorama-ultimo-intento';
	const SIMBOLOS = ['🐱', '🐶', '🐭', '🦊', '🐼', '🐸'];
	const DEMORA_VOLTEAR_MS = 700;

	let intentoId = $state<number | null>(null);
	let mazo = $state<string[]>([]);
	let volteadas = $state<number[]>([]);
	let resueltas = $state<Set<number>>(new Set());
	let bloqueado = $state(false);
	let resultado = $state<{ acierto: boolean } | null>(null);
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
			const intento = await api.iniciarMemorama();
			intentoId = intento.id;
			mazo = generarMazo(SIMBOLOS);
			volteadas = [];
			resueltas = new Set();
		} catch (e) {
			error = e instanceof Error ? e.message : 'Todavía en cooldown';
			marcarIntentoAhora();
		}
	}

	async function completar() {
		if (!intentoId) return;
		try {
			const r = await api.completarMemorama(intentoId);
			resultado = { acierto: r.acierto };
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo completar el intento';
		} finally {
			intentoId = null;
			marcarIntentoAhora();
		}
	}

	function voltear(indice: number) {
		if (bloqueado || volteadas.includes(indice) || resueltas.has(indice)) return;
		volteadas = [...volteadas, indice];
		if (volteadas.length < 2) return;

		bloqueado = true;
		const [a, b] = volteadas;
		if (mazo[a] === mazo[b]) {
			resueltas = new Set([...resueltas, a, b]);
			volteadas = [];
			bloqueado = false;
			if (resueltas.size === mazo.length) completar();
		} else {
			setTimeout(() => {
				volteadas = [];
				bloqueado = false;
			}, DEMORA_VOLTEAR_MS);
		}
	}

	function formatearTiempo(segundos: number) {
		const m = Math.floor(segundos / 60);
		const s = segundos % 60;
		return `${m}:${String(s).padStart(2, '0')}`;
	}
</script>

<div class="tarjeta juego-memorama">
	<h2 class="font-display">🃏 Memorama relámpago</h2>
	<p class="ayuda-juego">Encuentra los 6 pares y le bajas vida al jefe.</p>

	{#if intentoId}
		<div class="tablero-memorama">
			{#each mazo as simbolo, i}
				<button
					type="button"
					class="carta-memorama"
					class:volteada={volteadas.includes(i) || resueltas.has(i)}
					class:resuelta={resueltas.has(i)}
					disabled={resueltas.has(i)}
					onclick={() => voltear(i)}
				>
					{volteadas.includes(i) || resueltas.has(i) ? simbolo : '❔'}
				</button>
			{/each}
		</div>
	{:else if resultado}
		<p class="resultado-memorama" class:acierto={resultado.acierto}>
			{resultado.acierto ? '¡Le bajaste vida al jefe!' : 'Muy rápido para ser real — no contó.'}
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

	.juego-memorama h2 {
		margin: 0 0 4px;
		font-size: 16px;
	}

	.ayuda-juego {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.tablero-memorama {
		display: grid;
		grid-template-columns: repeat(4, 48px);
		gap: 6px;
		margin-bottom: 14px;
	}

	.carta-memorama {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 48px;
		height: 48px;
		font-size: 20px;
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		cursor: pointer;
	}

	.carta-memorama:not(:disabled):hover {
		border-color: var(--accent);
	}

	.carta-memorama.volteada {
		background: color-mix(in srgb, var(--accent) 12%, transparent);
	}

	.carta-memorama.resuelta {
		border-color: var(--success);
		background: color-mix(in srgb, var(--success) 14%, transparent);
		cursor: default;
	}

	.resultado-memorama {
		font-size: 13px;
		font-weight: 600;
		color: var(--danger);
		margin: 0 0 14px;
	}

	.resultado-memorama.acierto {
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
