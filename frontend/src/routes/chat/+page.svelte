<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Toast from '$lib/components/Toast.svelte';
	import { api, type MensajeChat } from '$lib/api/client';

	const INTERVALO_MS = 4_000;

	let mensajes = $state<MensajeChat[]>([]);
	let cargando = $state(true);
	let texto = $state('');
	let archivo = $state<File | null>(null);
	let inputArchivo: HTMLInputElement;
	let enviando = $state(false);
	let error = $state<string | null>(null);
	let contenedor: HTMLDivElement;

	function desplazarAbajo() {
		requestAnimationFrame(() => contenedor?.scrollTo({ top: contenedor.scrollHeight }));
	}

	function esImagen(tipo: string | null) {
		return !!tipo?.startsWith('image/');
	}

	function fechaCorta(iso: string) {
		return new Date(iso).toLocaleTimeString('es-MX', { hour: '2-digit', minute: '2-digit' });
	}

	$effect(() => {
		let cancelado = false;
		let pausado = false;

		function alCambiarVisibilidad() {
			pausado = document.visibilityState === 'hidden';
		}

		async function cargarInicial() {
			try {
				const iniciales = await api.mensajesChat();
				if (cancelado) return;
				mensajes = iniciales;
				desplazarAbajo();
			} finally {
				if (!cancelado) cargando = false;
			}
		}

		async function tick() {
			if (pausado || cancelado || mensajes.length === 0) return;
			try {
				const nuevos = await api.mensajesChat(mensajes[mensajes.length - 1].id);
				if (!cancelado && nuevos.length > 0) {
					mensajes = [...mensajes, ...nuevos];
					desplazarAbajo();
				}
			} catch {
				// un fallo de un ciclo de polling no debe romper la UI
			}
		}

		cargarInicial();
		document.addEventListener('visibilitychange', alCambiarVisibilidad);
		const id = setInterval(tick, INTERVALO_MS);

		return () => {
			cancelado = true;
			clearInterval(id);
			document.removeEventListener('visibilitychange', alCambiarVisibilidad);
		};
	});

	function alElegirArchivo(e: Event) {
		archivo = (e.target as HTMLInputElement).files?.[0] ?? null;
	}

	function quitarArchivo() {
		archivo = null;
		if (inputArchivo) inputArchivo.value = '';
	}

	async function subirArchivoSiHay() {
		if (!archivo) return {};
		const { url_subida, url_publica } = await api.crearUrlSubidaChat(archivo.name, archivo.type);
		await api.subirArchivoDirecto(url_subida, archivo);
		return { archivo_url: url_publica, archivo_nombre: archivo.name, archivo_tipo: archivo.type };
	}

	async function enviar() {
		error = null;
		if (!texto.trim() && !archivo) return;

		enviando = true;
		try {
			const datosArchivo = await subirArchivoSiHay();
			const nuevo = await api.enviarMensajeChat({ texto: texto.trim() || undefined, ...datosArchivo });
			mensajes = [...mensajes, nuevo];
			texto = '';
			quitarArchivo();
			desplazarAbajo();
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo enviar el mensaje';
		} finally {
			enviando = false;
		}
	}
</script>

<Header titulo="Chat del equipo" subtitulo="Mensajes y archivos, se actualiza solo." />

<div class="chat">
	<div class="mensajes" bind:this={contenedor}>
		{#if cargando}
			<p class="cargando">Cargando mensajes…</p>
		{:else if mensajes.length === 0}
			<p class="sin-mensajes">Todavía no hay mensajes. Sé el primero en escribir.</p>
		{:else}
			{#each mensajes as m (m.id)}
				<div class="mensaje">
					<span class="avatar" aria-hidden="true">{m.autor.avatar}</span>
					<div class="cuerpo">
						<div class="cabecera">
							<span class="autor">{m.autor.nombre}</span>
							<span class="hora">{fechaCorta(m.created_at)}</span>
						</div>
						{#if m.texto}<p class="texto">{m.texto}</p>{/if}
						{#if m.archivo_url}
							{#if esImagen(m.archivo_tipo)}
								<a href={m.archivo_url} target="_blank" rel="noopener noreferrer">
									<img class="adjunto-imagen" src={m.archivo_url} alt={m.archivo_nombre ?? 'adjunto'} />
								</a>
							{:else}
								<a class="adjunto-archivo" href={m.archivo_url} target="_blank" rel="noopener noreferrer">
									📎 {m.archivo_nombre ?? 'Archivo adjunto'}
								</a>
							{/if}
						{/if}
					</div>
				</div>
			{/each}
		{/if}
	</div>

	{#if error}
		<Toast tipo="error">{error}</Toast>
	{/if}

	<form class="form-envio" onsubmit={(e) => (e.preventDefault(), enviar())}>
		{#if archivo}
			<span class="archivo-elegido">
				📎 {archivo.name}
				<button type="button" onclick={quitarArchivo} aria-label="Quitar archivo">✕</button>
			</span>
		{/if}
		<div class="fila-envio">
			<label class="btn-adjuntar" title="Adjuntar archivo">
				📎
				<input bind:this={inputArchivo} type="file" onchange={alElegirArchivo} hidden />
			</label>
			<input
				type="text"
				placeholder="Escribe un mensaje…"
				bind:value={texto}
				disabled={enviando}
				class="campo-texto"
			/>
			<button type="submit" class="btn-enviar" disabled={enviando || (!texto.trim() && !archivo)}>
				{enviando ? 'Enviando…' : 'Enviar'}
			</button>
		</div>
	</form>
</div>

<style>
	.chat {
		display: flex;
		flex-direction: column;
		height: calc(100vh - 140px);
		max-width: 720px;
	}

	.mensajes {
		flex: 1;
		overflow-y: auto;
		display: flex;
		flex-direction: column;
		gap: 14px;
		padding: 4px 4px 14px;
	}

	.cargando,
	.sin-mensajes {
		color: var(--text-muted);
		font-size: 13px;
	}

	.mensaje {
		display: flex;
		gap: 10px;
	}

	.avatar {
		font-size: 20px;
		flex-shrink: 0;
	}

	.cuerpo {
		min-width: 0;
	}

	.cabecera {
		display: flex;
		align-items: baseline;
		gap: 8px;
	}

	.autor {
		font-size: 13px;
		font-weight: 600;
	}

	.hora {
		font-size: 11px;
		color: var(--text-faint);
	}

	.texto {
		margin: 4px 0 0;
		font-size: 13px;
		white-space: pre-wrap;
		word-break: break-word;
	}

	.adjunto-imagen {
		display: block;
		max-width: 260px;
		max-height: 260px;
		border-radius: var(--radius);
		margin-top: 6px;
	}

	.adjunto-archivo {
		display: inline-block;
		margin-top: 6px;
		font-size: 12px;
		color: var(--accent-strong);
	}

	.form-envio {
		border-top: 1px solid var(--border);
		padding-top: 12px;
		display: flex;
		flex-direction: column;
		gap: 8px;
	}

	.archivo-elegido {
		display: inline-flex;
		align-items: center;
		gap: 8px;
		font-size: 12px;
		color: var(--text-muted);
		width: fit-content;
	}

	.archivo-elegido button {
		background: none;
		border: none;
		color: var(--text-faint);
		cursor: pointer;
	}

	.fila-envio {
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.btn-adjuntar {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		width: 40px;
		height: 40px;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		cursor: pointer;
		flex-shrink: 0;
	}

	.campo-texto {
		flex: 1;
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 12px;
		color: var(--text);
	}

	.campo-texto:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}

	.btn-enviar {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 9px 18px;
		font-weight: 600;
		cursor: pointer;
		flex-shrink: 0;
	}

	.btn-enviar:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.btn-enviar:disabled {
		opacity: 0.6;
		cursor: default;
	}
</style>
