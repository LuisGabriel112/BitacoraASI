<script lang="ts">
	import { api, type JugadaRPS, type PartidaRPS } from '$lib/api/client';
	import { miSimbolo } from '$lib/simboloJugador';

	const INTERVALO_MS = 1500;
	const OPCIONES: { jugada: JugadaRPS; icono: string }[] = [
		{ jugada: 'piedra', icono: '🪨' },
		{ jugada: 'papel', icono: '📄' },
		{ jugada: 'tijera', icono: '✂️' }
	];

	let miNombre = $state('');
	let partida = $state<PartidaRPS | null>(null);
	let buscando = $state(false);
	let error = $state<string | null>(null);
	let timer: ReturnType<typeof setInterval> | undefined;

	$effect(() => {
		api.miPersonaje().then((p) => (miNombre = p.nombre));
	});

	function detenerPolling() {
		clearInterval(timer);
		timer = undefined;
	}

	async function refrescar(id: number) {
		try {
			partida = await api.obtenerPartidaRPS(id);
			if (partida.estado === 'terminada') detenerPolling();
		} catch {
			// un fallo de un ciclo de polling no debe romper la UI
		}
	}

	async function buscarPartida() {
		error = null;
		buscando = true;
		try {
			partida = await api.buscarPartidaRPS();
			detenerPolling();
			timer = setInterval(() => refrescar(partida!.id), INTERVALO_MS);
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo buscar partida';
		} finally {
			buscando = false;
		}
	}

	async function salir() {
		if (!partida) return;
		detenerPolling();
		await api.salirRPS(partida.id);
		partida = null;
	}

	function jugarDeNuevo() {
		detenerPolling();
		partida = null;
	}

	async function jugar(jugada: JugadaRPS) {
		if (!partida) return;
		try {
			partida = await api.jugarRPS(partida.id, jugada);
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo registrar tu jugada';
		}
	}

	const simbolo = $derived(partida ? miSimbolo(partida, miNombre) : null);
	const miJugada = $derived(!partida ? null : simbolo === 'X' ? partida.jugada_x : partida.jugada_o);
	const rival = $derived(
		!partida ? null : simbolo === 'X' ? (partida.jugador_o?.nombre ?? 'esperando…') : partida.jugador_x.nombre
	);

	$effect(() => () => detenerPolling());
</script>

<div class="tarjeta juego-rps">
	<h2 class="font-display">🪨📄✂️ Piedra, papel o tijera</h2>

	{#if !partida}
		<p class="ayuda-juego">Reta a quien esté en línea a una ronda rápida.</p>
		<button type="button" class="btn-jugar" onclick={buscarPartida} disabled={buscando}>
			{buscando ? 'Buscando…' : 'Buscar partida'}
		</button>
	{:else if partida.estado === 'esperando'}
		<p class="ayuda-juego">Esperando rival…</p>
		<button type="button" class="btn-secundario" onclick={salir}>Cancelar</button>
	{:else}
		<p class="ayuda-juego">
			{#if partida.estado === 'terminada'}
				{partida.resultado === 'empate' ? 'Empate' : partida.resultado === simbolo ? '¡Ganaste!' : 'Perdiste'}
			{:else if miJugada}
				Esperando al rival…
			{:else}
				Elige tu jugada
			{/if}
			· vs {rival}
		</p>
		<div class="opciones-rps">
			{#each OPCIONES as o}
				<button
					type="button"
					class="opcion-rps"
					class:elegida={miJugada === o.jugada}
					disabled={!!miJugada || partida.estado === 'terminada'}
					onclick={() => jugar(o.jugada)}
				>
					{o.icono}
				</button>
			{/each}
		</div>
		{#if partida.estado === 'terminada'}
			<button type="button" class="btn-secundario" onclick={jugarDeNuevo}>Jugar de nuevo</button>
		{/if}
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

	.juego-rps h2 {
		margin: 0 0 4px;
		font-size: 16px;
	}

	.ayuda-juego {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.opciones-rps {
		display: flex;
		gap: 10px;
		margin-bottom: 14px;
	}

	.opcion-rps {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		width: 56px;
		height: 56px;
		font-size: 26px;
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		cursor: pointer;
	}

	.opcion-rps:not(:disabled):hover {
		border-color: var(--accent);
	}

	.opcion-rps:disabled {
		cursor: default;
	}

	.opcion-rps.elegida {
		border-color: var(--accent);
		background: color-mix(in srgb, var(--accent) 16%, transparent);
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

	.btn-secundario {
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 16px;
		color: var(--text);
		cursor: pointer;
	}

	.btn-secundario:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.error-juego {
		color: var(--danger);
		font-size: 12px;
		margin: 10px 0 0;
	}
</style>
