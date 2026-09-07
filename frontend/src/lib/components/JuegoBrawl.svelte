<script lang="ts">
	import { browser } from '$app/environment';
	import { api } from '$lib/api/client';
	import { segundosRestantesCooldown } from '$lib/cooldownMinijuego';
	import {
		ALCANCE_DISPARO,
		ALTO_ARENA,
		ANCHO_ARENA,
		RADIO_CONTACTO,
		VELOCIDAD_BOT,
		VELOCIDAD_JUGADOR,
		crearBotsIniciales,
		disparar,
		enemigosEliminados,
		jugadorFueGolpeado,
		moverBotHaciaJugador,
		moverPunto,
		partidaGanada,
		type Bot,
		type Punto
	} from '$lib/brawlArena';

	const CLAVE_ULTIMO = 'bitacora-brawl-ultimo-intento';
	const DURACION_RONDA_MS = 20_000;
	const TECLAS_DIRECCION: Record<string, [number, number]> = {
		ArrowUp: [0, -1],
		ArrowDown: [0, 1],
		ArrowLeft: [-1, 0],
		ArrowRight: [1, 0],
		w: [0, -1],
		s: [0, 1],
		a: [-1, 0],
		d: [1, 0]
	};

	let intentoId = $state<number | null>(null);
	let jugando = $state(false);
	let resultado = $state<{ acierto: boolean; eliminados: number } | null>(null);
	let error = $state<string | null>(null);
	let segundosRestantes = $state(0);
	let canvas = $state<HTMLCanvasElement | undefined>(undefined);

	let jugador: Punto = { x: ANCHO_ARENA / 2, y: ALTO_ARENA / 2 };
	let bots: Bot[] = [];
	let teclas = new Set<string>();
	let inicioMs = 0;
	let cuadroId = 0;

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

	function direccionDesdeTeclas(): [number, number] {
		let dx = 0;
		let dy = 0;
		for (const tecla of teclas) {
			const dir = TECLAS_DIRECCION[tecla];
			if (dir) {
				dx += dir[0];
				dy += dir[1];
			}
		}
		const mag = Math.hypot(dx, dy) || 1;
		return [dx / mag, dy / mag];
	}

	function manejarTeclaAbajo(e: KeyboardEvent) {
		teclas.add(e.key);
		if (e.key === ' ') disparo();
	}

	function manejarTeclaArriba(e: KeyboardEvent) {
		teclas.delete(e.key);
	}

	function disparo() {
		bots = disparar(jugador, bots, ALCANCE_DISPARO);
	}

	function dibujar() {
		const ctx = canvas?.getContext('2d');
		if (!ctx) return;
		const estilos = getComputedStyle(document.documentElement);
		ctx.clearRect(0, 0, ANCHO_ARENA, ALTO_ARENA);
		ctx.fillStyle = estilos.getPropertyValue('--surface-raised');
		ctx.fillRect(0, 0, ANCHO_ARENA, ALTO_ARENA);
		ctx.fillStyle = estilos.getPropertyValue('--danger');
		for (const bot of bots) {
			if (!bot.vivo) continue;
			ctx.beginPath();
			ctx.arc(bot.pos.x, bot.pos.y, 12, 0, Math.PI * 2);
			ctx.fill();
		}
		ctx.fillStyle = estilos.getPropertyValue('--accent');
		ctx.beginPath();
		ctx.arc(jugador.x, jugador.y, 12, 0, Math.PI * 2);
		ctx.fill();
	}

	function terminarRonda() {
		cancelAnimationFrame(cuadroId);
		window.removeEventListener('keydown', manejarTeclaAbajo);
		window.removeEventListener('keyup', manejarTeclaArriba);
		jugando = false;
		marcarIntentoAhora();
		reportarResultado();
	}

	async function reportarResultado() {
		if (!intentoId) return;
		const eliminados = enemigosEliminados(bots);
		try {
			const r = await api.reportarBrawl(intentoId, eliminados);
			resultado = { acierto: r.acierto, eliminados };
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo resolver la ronda';
		} finally {
			intentoId = null;
		}
	}

	function paso() {
		const [dx, dy] = direccionDesdeTeclas();
		if (dx || dy) jugador = moverPunto(jugador, dx, dy, VELOCIDAD_JUGADOR);
		bots = bots.map((b) => (b.vivo ? { ...b, pos: moverBotHaciaJugador(b.pos, jugador, VELOCIDAD_BOT) } : b));
		dibujar();

		if (jugadorFueGolpeado(jugador, bots, RADIO_CONTACTO)) return terminarRonda();
		if (partidaGanada(bots)) return terminarRonda();
		if (Date.now() - inicioMs >= DURACION_RONDA_MS) return terminarRonda();
		cuadroId = requestAnimationFrame(paso);
	}

	async function iniciar() {
		error = null;
		resultado = null;
		try {
			const intento = await api.iniciarBrawl();
			intentoId = intento.id;
		} catch (e) {
			error = e instanceof Error ? e.message : 'Todavía en cooldown';
			marcarIntentoAhora();
			return;
		}

		jugador = { x: ANCHO_ARENA / 2, y: ALTO_ARENA / 2 };
		bots = crearBotsIniciales(3);
		teclas = new Set();
		inicioMs = Date.now();
		jugando = true;
		window.addEventListener('keydown', manejarTeclaAbajo);
		window.addEventListener('keyup', manejarTeclaArriba);
		cuadroId = requestAnimationFrame(paso);
	}

	function formatearTiempo(segundos: number) {
		const m = Math.floor(segundos / 60);
		const s = segundos % 60;
		return `${m}:${String(s).padStart(2, '0')}`;
	}
</script>

<div class="tarjeta juego-brawl">
	<h2 class="font-display">⚔️ Arena rápida</h2>
	<p class="ayuda-juego">Flechas/WASD para moverte, espacio o click para disparar. Elimina 2 de 3 y bájale vida al jefe.</p>

	{#if jugando}
		<canvas bind:this={canvas} width={ANCHO_ARENA} height={ALTO_ARENA} onclick={disparo} class="arena"></canvas>
	{:else if resultado}
		<p class="resultado-brawl" class:acierto={resultado.acierto}>
			{resultado.acierto
				? `¡Eliminaste ${resultado.eliminados} y le bajaste vida al jefe!`
				: `Solo eliminaste ${resultado.eliminados}, necesitas al menos 2.`}
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
		border: 2px solid var(--border-strong);
		border-radius: var(--radius-lg);
		padding: 24px;
	}

	.juego-brawl h2 {
		margin: 0 0 4px;
		font-size: 16px;
	}

	.ayuda-juego {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.arena {
		display: block;
		width: 100%;
		max-width: 320px;
		height: auto;
		border: 2px solid var(--border-strong);
		border-radius: var(--radius);
		cursor: crosshair;
		margin-bottom: 14px;
	}

	.resultado-brawl {
		font-size: 13px;
		font-weight: 600;
		color: var(--danger);
		margin: 0 0 14px;
	}

	.resultado-brawl.acierto {
		color: var(--success);
	}

	.btn-jugar {
		background: var(--accent);
		color: white;
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
