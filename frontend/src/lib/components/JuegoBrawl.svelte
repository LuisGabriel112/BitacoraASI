<script lang="ts">
	import { browser } from '$app/environment';
	import { tick as tickSvelte } from 'svelte';
	import { ErrorApi, api } from '$lib/api/client';
	import { segundosRestantesCooldown } from '$lib/cooldownMinijuego';
	import { reproducirFanfarriaMexicana } from '$lib/sonidoMexicano';
	import {
		miJugador,
		otrosJugadores,
		urlWebSocketBrawl,
		type EstadoSala,
		type JugadorRemoto
	} from '$lib/brawlRed';
	import {
		ALTO_ARENA,
		ANCHO_ARENA,
		RADIO_PERSONAJE,
		VELOCIDAD_JUGADOR,
		moverConColision,
		type Punto
	} from '$lib/brawlArena';
	import type EscenaBrawl3D from '$lib/components/EscenaBrawl3D.svelte';

	const CLAVE_ULTIMO = 'bitacora-brawl-v2-ultimo-intento';
	const COOLDOWN_BRAWL_MS = 2 * 60_000;
	const STATUS_COOLDOWN = 429;
	const VIDA_MAX_JUGADOR = 8;
	const VIDA_MAX_BOT = 4;
	const MS_ENTRE_ENVIOS = 50;
	const TIEMPO_ESPERA_BIENVENIDA_MS = 10_000;
	const URL_BACKEND_WS = import.meta.env.VITE_BACKEND_WS_URL ?? '';

	const TECLAS_DIRECCION: Record<string, [number, number]> = {
		arrowup: [0, -1],
		arrowdown: [0, 1],
		arrowleft: [-1, 0],
		arrowright: [1, 0],
		w: [0, -1],
		s: [0, 1],
		a: [-1, 0],
		d: [1, 0]
	};

	let intentoId = $state<number | null>(null);
	let jugando = $state(false);
	let conectando = $state(false);
	let resultado = $state<{ acierto: boolean; eliminados: number } | null>(null);
	let error = $state<string | null>(null);
	let segundosRestantes = $state(0);

	let estadoSala = $state<EstadoSala | null>(null);
	let miId = $state('');
	let avisos = $state<string[]>([]);

	let escena = $state<EscenaBrawl3D | undefined>(undefined);
	let ComponenteEscena = $state<typeof EscenaBrawl3D | null>(null);
	let lienzo = $state<HTMLDivElement | undefined>(undefined);

	let socket: WebSocket | null = null;
	let jugador: Punto = { x: ANCHO_ARENA / 2, y: ALTO_ARENA - 50 };
	let mira: Punto = { x: ANCHO_ARENA / 2, y: 0 };
	let teclas = new Set<string>();
	let disparando = false;
	let ultimoEnvio = 0;
	let cuadroId = 0;
	let esperaBienvenida: ReturnType<typeof setTimeout>;
	let bajasPrevias = 0;
	let vidaPrevia = VIDA_MAX_JUGADOR;
	let botsVivosPrevios = -1;

	const miJugadorActual = $derived(estadoSala ? miJugador(estadoSala, miId) : undefined);
	const companeros = $derived(estadoSala ? otrosJugadores(estadoSala, miId) : ([] as JugadorRemoto[]));

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

	function anunciar(texto: string) {
		avisos = [...avisos, texto].slice(-3);
		setTimeout(() => (avisos = avisos.slice(1)), 1800);
	}

	function direccionDesdeTeclas(): [number, number] {
		let dx = 0;
		let dy = 0;
		for (const tecla of teclas) {
			const dir = TECLAS_DIRECCION[tecla];
			if (!dir) continue;
			dx += dir[0];
			dy += dir[1];
		}
		const magnitud = Math.hypot(dx, dy) || 1;
		return [dx / magnitud, dy / magnitud];
	}

	function manejarTeclaAbajo(e: KeyboardEvent) {
		const tecla = e.key.toLowerCase();
		if (tecla === ' ') {
			e.preventDefault();
			disparando = true;
			return;
		}
		if (TECLAS_DIRECCION[tecla]) e.preventDefault();
		teclas.add(tecla);
	}

	function manejarTeclaArriba(e: KeyboardEvent) {
		const tecla = e.key.toLowerCase();
		if (tecla === ' ') disparando = false;
		teclas.delete(tecla);
	}

	function apuntar(e: MouseEvent) {
		const caja = lienzo?.getBoundingClientRect();
		if (!caja) return;
		mira = {
			x: ((e.clientX - caja.left) / caja.width) * ANCHO_ARENA,
			y: ((e.clientY - caja.top) / caja.height) * ALTO_ARENA
		};
	}

	function enviar(mensaje: object) {
		if (socket?.readyState === WebSocket.OPEN) socket.send(JSON.stringify(mensaje));
	}

	function celebrarBaja(estado: EstadoSala) {
		const caido = estado.bots.find((b) => b.vida <= 0);
		if (caido) escena?.explotar(caido.x, caido.y);
		escena?.sacudir(1);
		anunciar('¡Eliminado! 💥');
	}

	function recibirGolpe() {
		escena?.sacudir(0.6);
		anunciar('¡Te dieron! 💢');
	}

	/** Los avisos y la sacudida salen de comparar contra el estado anterior,
	 *  porque el servidor manda el mundo completo, no eventos sueltos. */
	function reaccionarA(estado: EstadoSala) {
		const yo = miJugador(estado, miId);
		if (!yo) return;
		if (yo.bajas > bajasPrevias) celebrarBaja(estado);
		if (yo.vida < vidaPrevia) recibirGolpe();
		bajasPrevias = yo.bajas;
		vidaPrevia = yo.vida;
	}

	function avisarBotsCaidos(estado: EstadoSala) {
		const vivos = estado.bots.filter((b) => b.vida > 0).length;
		if (botsVivosPrevios > 1 && vivos === 1) anunciar('¡Queda uno! 🔥');
		botsVivosPrevios = vivos;
	}

	function manejarEstado(estado: EstadoSala) {
		estadoSala = estado;
		reaccionarA(estado);
		avisarBotsCaidos(estado);
		escena?.dibujarMuros(estado.muros);
		if (estado.estado === 'terminada') terminarRonda();
	}

	function manejarMensaje(evento: MessageEvent) {
		const mensaje = JSON.parse(evento.data);
		if (mensaje.tipo === 'bienvenida') {
			miId = mensaje.jugador_id;
			clearTimeout(esperaBienvenida);
			return;
		}
		if (mensaje.tipo === 'estado') manejarEstado(mensaje as EstadoSala);
	}

	/** Mi personaje se dibuja con la posición local, no con la que regresa el
	 *  servidor: esperar el eco de la red haría que moverse se sintiera lento. */
	function jugadoresConMiPosicion(estado: EstadoSala): JugadorRemoto[] {
		return estado.jugadores.map((j) => (j.id === miId ? { ...j, x: jugador.x, y: jugador.y } : j));
	}

	function paso() {
		cuadroId = requestAnimationFrame(paso);
		const [dx, dy] = direccionDesdeTeclas();
		if (dx || dy) jugador = moverConColision(jugador, dx, dy, VELOCIDAD_JUGADOR, RADIO_PERSONAJE);

		const ahora = performance.now();
		if (ahora - ultimoEnvio >= MS_ENTRE_ENVIOS) {
			ultimoEnvio = ahora;
			enviar({ tipo: 'mover', x: jugador.x, y: jugador.y });
			if (disparando) enviar({ tipo: 'disparar', x: mira.x, y: mira.y });
		}

		if (!estadoSala) return;
		escena?.actualizar({
			jugadores: jugadoresConMiPosicion(estadoSala),
			bots: estadoSala.bots,
			proyectiles: estadoSala.proyectiles,
			miId,
			vidaMaxJugador: VIDA_MAX_JUGADOR,
			vidaMaxBot: VIDA_MAX_BOT,
			mira
		});
	}

	async function cargarEscena() {
		if (ComponenteEscena) return;
		ComponenteEscena = (await import('$lib/components/EscenaBrawl3D.svelte')).default;
		await tickSvelte();
	}

	function manejarFalloAlIniciar(e: unknown) {
		const esCooldown = e instanceof ErrorApi && e.status === STATUS_COOLDOWN;
		error = e instanceof Error ? e.message : 'No se pudo iniciar la ronda';
		if (esCooldown) marcarIntentoAhora();
		conectando = false;
	}

	/** Si el ticket no sirve, el servidor cierra con 4401 — pero ese frame de
	 *  cierre no siempre llega al navegador a través del proxy, y la partida se
	 *  quedaba colgada en "Entrando a la arena…" para siempre. El saludo del
	 *  servidor es la única señal confiable de que la conexión sirve. */
	function vigilarBienvenida() {
		clearTimeout(esperaBienvenida);
		esperaBienvenida = setTimeout(() => {
			if (miId) return;
			error = 'La arena no respondió. Vuelve a intentar.';
			jugando = false;
			conectando = false;
			socket?.close();
			socket = null;
		}, TIEMPO_ESPERA_BIENVENIDA_MS);
	}

	function abrirSocket(ticket: string) {
		socket = new WebSocket(urlWebSocketBrawl(window.location.origin, URL_BACKEND_WS, ticket));
		socket.onmessage = manejarMensaje;
		socket.onerror = () => (error = 'Se perdió la conexión con la arena');
		socket.onclose = () => terminarRonda();
		vigilarBienvenida();
	}

	function reiniciarEstado() {
		jugador = { x: ANCHO_ARENA / 2, y: ALTO_ARENA - 50 };
		mira = { x: ANCHO_ARENA / 2, y: 0 };
		teclas = new Set();
		disparando = false;
		bajasPrevias = 0;
		vidaPrevia = VIDA_MAX_JUGADOR;
		botsVivosPrevios = -1;
		avisos = [];
		estadoSala = null;
	}

	async function iniciar() {
		error = null;
		resultado = null;
		conectando = true;
		reiniciarEstado();
		try {
			intentoId = (await api.iniciarBrawl()).id;
			const { ticket } = await api.ticketBrawl();
			await cargarEscena();
			abrirSocket(ticket);
		} catch (e) {
			manejarFalloAlIniciar(e);
			return;
		}

		conectando = false;
		jugando = true;
		window.addEventListener('keydown', manejarTeclaAbajo);
		window.addEventListener('keyup', manejarTeclaArriba);
		cuadroId = requestAnimationFrame(paso);
	}

	function quitarEscuchas() {
		window.removeEventListener('keydown', manejarTeclaAbajo);
		window.removeEventListener('keyup', manejarTeclaArriba);
	}

	function terminarRonda() {
		if (!jugando) return;
		jugando = false;
		clearTimeout(esperaBienvenida);
		cancelAnimationFrame(cuadroId);
		quitarEscuchas();
		socket?.close();
		socket = null;
		marcarIntentoAhora();
		reportarResultado();
	}

	async function reportarResultado() {
		if (intentoId === null) return;
		const total = bajasPrevias;
		try {
			const r = await api.reportarBrawl(intentoId, total);
			resultado = { acierto: r.acierto, eliminados: total };
			if (r.acierto) reproducirFanfarriaMexicana();
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo resolver la ronda';
		} finally {
			intentoId = null;
		}
	}

	function formatearTiempo(segundos: number) {
		const m = Math.floor(segundos / 60);
		const s = segundos % 60;
		return `${m}:${String(s).padStart(2, '0')}`;
	}

	$effect(() => () => {
		cancelAnimationFrame(cuadroId);
		quitarEscuchas();
		socket?.close();
	});
</script>

<div class="tarjeta juego-brawl">
	<h2 class="font-display">⚔️ Arena 3D</h2>
	<p class="ayuda-juego">
		WASD para moverte, apunta con el mouse, dispara con click o espacio. Cúbrete tras los muros.
		Elimina 2 de 3 y le bajas vida al jefe.
	</p>

	{#if jugando}
		<div class="hud">
			<span class="hud-dato">❤️ {miJugadorActual?.vida ?? VIDA_MAX_JUGADOR}/{VIDA_MAX_JUGADOR}</span>
			<span class="hud-dato">💀 {miJugadorActual?.bajas ?? 0}</span>
			<span class="hud-dato">⏱ {estadoSala?.segundos_restantes ?? 30}s</span>
			{#each companeros as c (c.id)}
				<span class="hud-aliado" title="Tu compañero de sala">{c.avatar} {c.nombre}</span>
			{/each}
		</div>

		{#if estadoSala?.estado === 'esperando'}
			<p class="buscando">Buscando rival… si nadie llega, entras contra los bots.</p>
		{/if}

		<!-- svelte-ignore a11y_no_static_element_interactions -->
		<div
			class="arena"
			bind:this={lienzo}
			onmousemove={apuntar}
			onmousedown={() => (disparando = true)}
			onmouseup={() => (disparando = false)}
			onmouseleave={() => (disparando = false)}
		>
			{#if ComponenteEscena}
				<ComponenteEscena bind:this={escena} ancho={640} alto={430} />
			{/if}
			<div class="avisos">
				{#each avisos as aviso, i (aviso + i)}
					<span class="aviso">{aviso}</span>
				{/each}
			</div>
		</div>
	{:else if resultado}
		<p class="resultado-brawl" class:acierto={resultado.acierto}>
			{resultado.acierto
				? `¡${resultado.eliminados} bajas y le bajaste vida al jefe!`
				: `Solo ${resultado.eliminados} bajas, necesitas al menos 2.`}
		</p>
		<button type="button" class="btn-jugar" onclick={iniciar} disabled={segundosRestantes > 0}>
			{segundosRestantes > 0 ? `Espera ${formatearTiempo(segundosRestantes)}` : 'Revancha'}
		</button>
	{:else}
		<button
			type="button"
			class="btn-jugar"
			onclick={iniciar}
			disabled={segundosRestantes > 0 || conectando}
		>
			{#if conectando}
				Entrando a la arena…
			{:else if segundosRestantes > 0}
				Espera {formatearTiempo(segundosRestantes)}
			{:else}
				Jugar
			{/if}
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
		flex-wrap: wrap;
		align-items: center;
		gap: 14px;
		margin-bottom: 8px;
		font-family: var(--font-mono);
		font-size: 13px;
		font-weight: 600;
	}

	.hud-aliado {
		margin-left: auto;
		color: var(--text-muted);
		font-family: var(--font-display);
	}

	.buscando {
		margin: 0 0 8px;
		font-size: 12px;
		color: var(--text-muted);
	}

	.arena {
		position: relative;
		max-width: 640px;
		cursor: crosshair;
		margin-bottom: 14px;
		touch-action: none;
	}

	.avisos {
		position: absolute;
		top: 12px;
		left: 0;
		right: 0;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 4px;
		pointer-events: none;
	}

	.aviso {
		background: oklch(0 0 0 / 0.55);
		color: white;
		font-weight: 700;
		font-size: 15px;
		padding: 4px 12px;
		border-radius: 999px;
		animation: subir 0.25s ease;
	}

	@keyframes subir {
		from {
			transform: translateY(8px) scale(0.9);
			opacity: 0;
		}
		to {
			transform: translateY(0) scale(1);
			opacity: 1;
		}
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
