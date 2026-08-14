<script lang="ts">
	import { api, type PartidaGato } from '$lib/api/client';
	import { miSimbolo } from '$lib/simboloGato';

	const INTERVALO_MS = 1500;

	let miNombre = $state('');
	let partida = $state<PartidaGato | null>(null);
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
			partida = await api.obtenerPartidaGato(id);
			if (partida.estado === 'terminada') detenerPolling();
		} catch {
			// un fallo de un ciclo de polling no debe romper la UI
		}
	}

	async function buscarPartida() {
		error = null;
		buscando = true;
		try {
			partida = await api.buscarPartidaGato();
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
		await api.salirGato(partida.id);
		partida = null;
	}

	function jugarDeNuevo() {
		detenerPolling();
		partida = null;
	}

	async function jugar(posicion: number) {
		if (!partida) return;
		try {
			partida = await api.jugarGato(partida.id, posicion);
		} catch (e) {
			error = e instanceof Error ? e.message : 'Movimiento inválido';
		}
	}

	const simbolo = $derived(partida ? miSimbolo(partida, miNombre) : null);
	const esMiTurno = $derived(!!partida && partida.estado === 'jugando' && partida.turno === simbolo);
	const rival = $derived(
		!partida ? null : simbolo === 'X' ? (partida.jugador_o?.nombre ?? 'esperando…') : partida.jugador_x.nombre
	);

	$effect(() => () => detenerPolling());
</script>

<div class="tarjeta juego-gato">
	<h2 class="font-display">❌⭕ Gato</h2>

	{#if !partida}
		<p class="ayuda-juego">Reta a quien esté en línea a una partida rápida.</p>
		<button type="button" class="btn-jugar" onclick={buscarPartida} disabled={buscando}>
			{buscando ? 'Buscando…' : 'Buscar partida'}
		</button>
	{:else if partida.estado === 'esperando'}
		<p class="ayuda-juego">Esperando rival…</p>
		<button type="button" class="btn-secundario" onclick={salir}>Cancelar</button>
	{:else}
		<p class="ayuda-juego">
			{#if partida.estado === 'terminada'}
				{partida.ganador === 'empate' ? 'Empate' : partida.ganador === simbolo ? '¡Ganaste!' : 'Perdiste'}
			{:else}
				{esMiTurno ? 'Tu turno' : 'Turno del rival'}
			{/if}
			· vs {rival}
		</p>
		<div class="tablero-gato">
			{#each Array(9) as _, i}
				<button
					type="button"
					class="casilla-gato"
					disabled={!esMiTurno || partida.tablero[i] !== ' '}
					onclick={() => jugar(i)}
				>
					{partida.tablero[i] === ' ' ? '' : partida.tablero[i]}
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

	.juego-gato h2 {
		margin: 0 0 4px;
		font-size: 16px;
	}

	.ayuda-juego {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0 0 16px;
	}

	.tablero-gato {
		display: grid;
		grid-template-columns: repeat(3, 56px);
		grid-template-rows: repeat(3, 56px);
		gap: 6px;
		margin-bottom: 14px;
	}

	.casilla-gato {
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 22px;
		font-weight: 700;
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		color: var(--text);
		cursor: pointer;
	}

	.casilla-gato:not(:disabled):hover {
		border-color: var(--accent);
	}

	.casilla-gato:disabled {
		cursor: default;
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
