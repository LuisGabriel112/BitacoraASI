<script lang="ts">
	import { browser } from '$app/environment';
	import { ErrorApi, api } from '$lib/api/client';
	import { segundosRestantesCooldown } from '$lib/cooldownMinijuego';
	import {
		ALTO_ARENA,
		ANCHO_ARENA,
		MUROS,
		POSICION_INICIAL_JUGADOR,
		RADIO_PERSONAJE,
		VELOCIDAD_BOT,
		VELOCIDAD_JUGADOR,
		moverConColision,
		type Punto
	} from '$lib/brawlArena';
	import {
		CANTIDAD_BOTS,
		RADIO_PROYECTIL,
		VIDA_BOT,
		VIDA_JUGADOR,
		avanzarProyectiles,
		botDebeDisparar,
		botsVivos,
		crearBots,
		crearProyectil,
		direccionDeBot,
		eliminados,
		impactarBots,
		impactarJugador,
		todosEliminados,
		type Bot,
		type Proyectil
	} from '$lib/brawlCombate';

	// v2: la versión anterior marcaba cooldown ante cualquier error del servidor,
	// así que dejaba una marca vieja que bloqueaba el juego. Cambiar de clave
	// ignora esa marca envenenada en los navegadores que ya la tienen guardada.
	const CLAVE_ULTIMO = 'bitacora-brawl-v2-ultimo-intento';
	const COOLDOWN_BRAWL_MS = 2 * 60_000;
	const DURACION_RONDA_MS = 30_000;
	const CADENCIA_DISPARO_JUGADOR_MS = 260;
	const STATUS_COOLDOWN = 429;

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

	let vidaJugador = $state(VIDA_JUGADOR);
	let eliminadosHud = $state(0);
	let segundosRonda = $state(DURACION_RONDA_MS / 1000);

	let jugador: Punto = { ...POSICION_INICIAL_JUGADOR };
	let bots: Bot[] = [];
	let proyectiles: Proyectil[] = [];
	let teclas = new Set<string>();
	let mira: Punto = { x: ANCHO_ARENA, y: ALTO_ARENA / 2 };
	let ultimoDisparoMs = 0;
	let disparando = false;
	let inicioMs = 0;
	let cuadro = 0;
	let siguienteProyectilId = 0;
	let cuadroId = 0;

	function leerUltimoIntento(): number | null {
		if (!browser) return null;
		const guardado = localStorage.getItem(CLAVE_ULTIMO);
		return guardado ? Number(guardado) : null;
	}

	function actualizarCooldown() {
		segundosRestantes = segundosRestantesCooldown(leerUltimoIntento(), Date.now(), COOLDOWN_BRAWL_MS);
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
			const dir = TECLAS_DIRECCION[tecla.length === 1 ? tecla.toLowerCase() : tecla];
			if (!dir) continue;
			dx += dir[0];
			dy += dir[1];
		}
		const magnitud = Math.hypot(dx, dy) || 1;
		return [dx / magnitud, dy / magnitud];
	}

	function manejarTeclaAbajo(e: KeyboardEvent) {
		if (e.key === ' ') {
			e.preventDefault();
			disparando = true;
			return;
		}
		teclas.add(e.key);
	}

	function manejarTeclaArriba(e: KeyboardEvent) {
		if (e.key === ' ') disparando = false;
		teclas.delete(e.key);
	}

	function posicionEnArena(e: MouseEvent): Punto {
		const caja = canvas!.getBoundingClientRect();
		return {
			x: ((e.clientX - caja.left) / caja.width) * ANCHO_ARENA,
			y: ((e.clientY - caja.top) / caja.height) * ALTO_ARENA
		};
	}

	function apuntar(e: MouseEvent) {
		if (canvas) mira = posicionEnArena(e);
	}

	function dispararJugador() {
		const ahora = Date.now();
		if (ahora - ultimoDisparoMs < CADENCIA_DISPARO_JUGADOR_MS) return;
		ultimoDisparoMs = ahora;
		proyectiles = [...proyectiles, crearProyectil(siguienteProyectilId++, jugador, mira, true)];
	}

	function dispararBots() {
		const nuevos = botsVivos(bots)
			.filter((b) => botDebeDisparar(cuadro, b.id))
			.map((b) => crearProyectil(siguienteProyectilId++, b.pos, jugador, false));
		proyectiles = [...proyectiles, ...nuevos];
	}

	function moverBot(b: Bot): Bot {
		if (b.vida <= 0) return b;
		const { dx, dy } = direccionDeBot(b.pos, jugador);
		return { ...b, pos: moverConColision(b.pos, dx, dy, VELOCIDAD_BOT, RADIO_PERSONAJE) };
	}

	function moverBots() {
		bots = bots.map(moverBot);
	}

	function resolverColisiones() {
		const contraBots = impactarBots(proyectiles, bots);
		bots = contraBots.bots;
		const contraJugador = impactarJugador(contraBots.proyectiles, jugador);
		proyectiles = contraJugador.proyectiles;
		if (contraJugador.golpes > 0) vidaJugador = Math.max(0, vidaJugador - contraJugador.golpes);
		eliminadosHud = eliminados(bots);
	}

	function rondaTerminada(): boolean {
		return vidaJugador <= 0 || todosEliminados(bots) || Date.now() - inicioMs >= DURACION_RONDA_MS;
	}

	function paso() {
		cuadro++;
		const [dx, dy] = direccionDesdeTeclas();
		if (dx || dy) jugador = moverConColision(jugador, dx, dy, VELOCIDAD_JUGADOR, RADIO_PERSONAJE);
		if (disparando) dispararJugador();
		dispararBots();

		moverBots();
		proyectiles = avanzarProyectiles(proyectiles);
		resolverColisiones();

		segundosRonda = Math.max(0, Math.ceil((DURACION_RONDA_MS - (Date.now() - inicioMs)) / 1000));
		dibujar();

		if (rondaTerminada()) return terminarRonda();
		cuadroId = requestAnimationFrame(paso);
	}

	function color(nombre: string): string {
		return getComputedStyle(document.documentElement).getPropertyValue(nombre).trim();
	}

	function dibujarCirculo(ctx: CanvasRenderingContext2D, p: Punto, radio: number, relleno: string) {
		ctx.fillStyle = relleno;
		ctx.beginPath();
		ctx.arc(p.x, p.y, radio, 0, Math.PI * 2);
		ctx.fill();
	}

	function dibujarBarraVida(ctx: CanvasRenderingContext2D, p: Punto, vida: number, maximo: number) {
		const ancho = 24;
		ctx.fillStyle = color('--border');
		ctx.fillRect(p.x - ancho / 2, p.y - RADIO_PERSONAJE - 8, ancho, 3);
		ctx.fillStyle = color('--success');
		ctx.fillRect(p.x - ancho / 2, p.y - RADIO_PERSONAJE - 8, (ancho * vida) / maximo, 3);
	}

	function dibujarEscenario(ctx: CanvasRenderingContext2D) {
		ctx.fillStyle = color('--surface-raised');
		ctx.fillRect(0, 0, ANCHO_ARENA, ALTO_ARENA);
		ctx.fillStyle = color('--border-strong');
		for (const muro of MUROS) ctx.fillRect(muro.x, muro.y, muro.ancho, muro.alto);
	}

	function dibujar() {
		const ctx = canvas?.getContext('2d');
		if (!ctx) return;
		dibujarEscenario(ctx);

		for (const bot of botsVivos(bots)) {
			dibujarCirculo(ctx, bot.pos, RADIO_PERSONAJE, color('--danger'));
			dibujarBarraVida(ctx, bot.pos, bot.vida, VIDA_BOT);
		}
		// Cada bando dispara en su propio color: con --accent-2 los proyectiles
		// aliados salían rojos en tema patrio, idénticos a los enemigos.
		for (const p of proyectiles) {
			dibujarCirculo(ctx, p.pos, RADIO_PROYECTIL, color(p.aliado ? '--accent' : '--danger'));
		}

		dibujarCirculo(ctx, jugador, RADIO_PERSONAJE, color('--accent'));
		dibujarBarraVida(ctx, jugador, vidaJugador, VIDA_JUGADOR);
	}

	function quitarEscuchas() {
		window.removeEventListener('keydown', manejarTeclaAbajo);
		window.removeEventListener('keyup', manejarTeclaArriba);
	}

	function terminarRonda() {
		cancelAnimationFrame(cuadroId);
		quitarEscuchas();
		jugando = false;
		marcarIntentoAhora();
		reportarResultado();
	}

	async function reportarResultado() {
		if (intentoId === null) return;
		const total = eliminados(bots);
		try {
			const r = await api.reportarBrawl(intentoId, total);
			resultado = { acierto: r.acierto, eliminados: total };
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo resolver la ronda';
		} finally {
			intentoId = null;
		}
	}

	/** Solo un 429 significa cooldown real. Marcar la espera ante cualquier otro
	 *  error (500, red caída) dejaba al jugador bloqueado sin haber jugado. */
	function manejarFalloAlIniciar(e: unknown) {
		const esCooldown = e instanceof ErrorApi && e.status === STATUS_COOLDOWN;
		error = e instanceof Error ? e.message : 'No se pudo iniciar la ronda';
		if (esCooldown) marcarIntentoAhora();
	}

	function reiniciarEstado() {
		jugador = { ...POSICION_INICIAL_JUGADOR };
		bots = crearBots(CANTIDAD_BOTS);
		proyectiles = [];
		teclas = new Set();
		vidaJugador = VIDA_JUGADOR;
		eliminadosHud = 0;
		segundosRonda = DURACION_RONDA_MS / 1000;
		disparando = false;
		cuadro = 0;
		inicioMs = Date.now();
	}

	async function iniciar() {
		error = null;
		resultado = null;
		try {
			intentoId = (await api.iniciarBrawl()).id;
		} catch (e) {
			manejarFalloAlIniciar(e);
			return;
		}

		reiniciarEstado();
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

	$effect(() => () => {
		cancelAnimationFrame(cuadroId);
		quitarEscuchas();
	});
</script>

<div class="tarjeta juego-brawl">
	<h2 class="font-display">⚔️ Arena rápida</h2>
	<p class="ayuda-juego">
		WASD o flechas para moverte, apunta con el mouse y dispara con click o espacio. Usa los muros de
		cobertura. Elimina 2 de {CANTIDAD_BOTS} y le bajas vida al jefe.
	</p>

	{#if jugando}
		<div class="hud">
			<span class="hud-dato">❤️ {vidaJugador}/{VIDA_JUGADOR}</span>
			<span class="hud-dato">💀 {eliminadosHud}/{CANTIDAD_BOTS}</span>
			<span class="hud-dato">⏱ {segundosRonda}s</span>
		</div>
		<!-- svelte-ignore a11y_no_static_element_interactions -->
		<canvas
			bind:this={canvas}
			width={ANCHO_ARENA}
			height={ALTO_ARENA}
			class="arena"
			onmousemove={apuntar}
			onmousedown={() => (disparando = true)}
			onmouseup={() => (disparando = false)}
			onmouseleave={() => (disparando = false)}
		></canvas>
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

	.hud {
		display: flex;
		gap: 14px;
		margin-bottom: 8px;
		font-family: var(--font-mono);
		font-size: 13px;
		font-weight: 600;
	}

	.arena {
		display: block;
		width: 100%;
		max-width: 360px;
		height: auto;
		border: 2px solid var(--border-strong);
		border-radius: var(--radius);
		cursor: crosshair;
		margin-bottom: 14px;
		touch-action: none;
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
