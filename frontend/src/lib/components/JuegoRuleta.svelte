<script lang="ts">
	import { browser } from '$app/environment';
	import { api } from '$lib/api/client';
	import { segundosRestantesCooldown } from '$lib/cooldownMinijuego';

	const CLAVE_ULTIMO = 'bitacora-ruleta-ultimo-intento';

	let jugando = $state(false);
	let resultado = $state<{ gano: boolean } | null>(null);
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

	async function jugar() {
		error = null;
		jugando = true;
		try {
			const r = await api.jugarRuleta();
			resultado = { gano: r.gano };
		} catch (e) {
			error = e instanceof Error ? e.message : 'Todavía en cooldown';
		} finally {
			jugando = false;
			marcarIntentoAhora();
		}
	}

	function formatearTiempo(segundos: number) {
		const m = Math.floor(segundos / 60);
		const s = segundos % 60;
		return `${m}:${String(s).padStart(2, '0')}`;
	}
</script>

<div class="tarjeta juego-ruleta">
	<h2 class="font-display">🎲 Ruleta rusa</h2>
	<p class="ayuda-juego">Arriesga: si ganas, mucho daño al jefe. Si pierdes, pierdes algo de XP.</p>

	{#if resultado}
		<p class="resultado-ruleta" class:gano={resultado.gano}>
			{resultado.gano ? '¡Ganaste! Le bajaste mucha vida al jefe.' : 'Perdiste algo de XP.'}
		</p>
	{/if}

	<button type="button" class="btn-arriesgar" onclick={jugar} disabled={jugando || segundosRestantes > 0}>
		{segundosRestantes > 0 ? `Espera ${formatearTiempo(segundosRestantes)}` : jugando ? 'Girando…' : '🎲 Arriesgar'}
	</button>

	{#if error}<p class="error-juego">{error}</p>{/if}
</div>

<style>
	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 24px;
	}

	.juego-ruleta h2 {
		margin: 0 0 4px;
		font-size: 16px;
	}

	.ayuda-juego {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.resultado-ruleta {
		font-size: 13px;
		font-weight: 600;
		color: var(--danger);
		margin: 0 0 14px;
	}

	.resultado-ruleta.gano {
		color: var(--success);
	}

	.btn-arriesgar {
		background: var(--danger);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 10px 18px;
		font-weight: 600;
		cursor: pointer;
	}

	.btn-arriesgar:hover:not(:disabled) {
		filter: brightness(1.1);
	}

	.btn-arriesgar:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.error-juego {
		color: var(--danger);
		font-size: 12px;
		margin: 10px 0 0;
	}
</style>
