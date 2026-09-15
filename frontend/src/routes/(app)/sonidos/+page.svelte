<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import { api, type CategoriaSonido, type EventoSonido, type Sonido } from '$lib/api/client';
	import {
		ETIQUETA_CATEGORIA,
		EVENTOS_SONIDO,
		esSintetizado,
		nombreSugerido,
		preferenciaDe,
		validarArchivoSonido
	} from '$lib/sonidos';
	import {
		actualizarPreferenciaEnCache,
		actualizarSonidoEnCache,
		cargarSonidos,
		estadoSonidos,
		reproducirEvento,
		reproducirFuente
	} from '$lib/sonidos.svelte';

	const CATEGORIAS: CategoriaSonido[] = ['exito', 'error'];

	let cargando = $state(true);
	let errorCarga = $state<string | null>(null);

	$effect(() => {
		cargarSonidos(true)
			.then(() => {
				if (!estadoSonidos.cargado) errorCarga = 'No se pudo cargar el catálogo de sonidos.';
			})
			.finally(() => (cargando = false));
	});

	const sonidos = $derived(estadoSonidos.sonidos);

	function sonidosDe(categoria: CategoriaSonido): Sonido[] {
		return sonidos.filter((s) => s.categoria === categoria);
	}

	function origenDe(s: Sonido): string {
		if (esSintetizado(s.url)) return 'Sintetizado';
		return s.url.startsWith('/sonidos/') ? 'De fábrica' : 'Cargado por el equipo';
	}

	// --- vista previa (una sola a la vez) ---------------------------------
	let reproduciendoClave = $state<string | null>(null);
	let audioActual: HTMLAudioElement | null = null;
	let timerSintetizado: ReturnType<typeof setTimeout>;

	function detenerVistaPrevia() {
		audioActual?.pause();
		audioActual = null;
		clearTimeout(timerSintetizado);
		reproduciendoClave = null;
	}

	function previsualizar(clave: string, url: string) {
		if (reproduciendoClave === clave) {
			detenerVistaPrevia();
			return;
		}
		detenerVistaPrevia();
		reproduciendoClave = clave;
		const audio = reproducirFuente(url);
		if (audio) {
			audioActual = audio;
			audio.onended = () => {
				if (reproduciendoClave === clave) detenerVistaPrevia();
			};
			audio.onerror = () => {
				if (reproduciendoClave === clave) detenerVistaPrevia();
			};
		} else {
			// sintetizado: no hay elemento de audio, se apaga el indicador solo
			timerSintetizado = setTimeout(() => {
				if (reproduciendoClave === clave) reproduciendoClave = null;
			}, 900);
		}
	}

	// --- mis sonidos -------------------------------------------------------
	let guardandoEvento = $state<EventoSonido | null>(null);
	let errorPreferencia = $state<string | null>(null);

	function valorSelect(evento: EventoSonido): string {
		const pref = preferenciaDe(evento, estadoSonidos.preferencias);
		if (pref?.silenciado) return 'silencio';
		if (pref?.sonido_id != null) return String(pref.sonido_id);
		return 'aleatorio';
	}

	/** Activos de la categoría, más el elegido aunque lo hayan deshabilitado
	 *  (para que el select no "pierda" la elección y se vea por qué no suena). */
	function opcionesPara(evento: EventoSonido, categoria: CategoriaSonido): Sonido[] {
		const elegidoId = preferenciaDe(evento, estadoSonidos.preferencias)?.sonido_id ?? null;
		return sonidosDe(categoria).filter((s) => s.activo || s.id === elegidoId);
	}

	async function cambiarPreferencia(evento: EventoSonido, valor: string) {
		errorPreferencia = null;
		guardandoEvento = evento;
		try {
			const guardada = await api.guardarPreferenciaSonido(
				valor === 'silencio'
					? { evento, silenciado: true }
					: valor === 'aleatorio'
						? { evento }
						: { evento, sonido_id: Number(valor) }
			);
			actualizarPreferenciaEnCache(guardada);
			if (guardada.sonido_id != null) reproducirEvento(evento);
		} catch (e) {
			errorPreferencia = e instanceof Error ? e.message : 'No se pudo guardar la preferencia';
		} finally {
			guardandoEvento = null;
		}
	}

	// --- habilitar / deshabilitar en general ------------------------------
	let cambiandoId = $state<number | null>(null);
	let errorCatalogo = $state<string | null>(null);

	async function alternarActivo(s: Sonido) {
		errorCatalogo = null;
		cambiandoId = s.id;
		try {
			const actualizado = s.activo ? await api.desactivarSonido(s.id) : await api.activarSonido(s.id);
			actualizarSonidoEnCache(actualizado);
		} catch (e) {
			errorCatalogo = e instanceof Error ? e.message : 'No se pudo cambiar el sonido';
		} finally {
			cambiandoId = null;
		}
	}

	// --- cargar nuevo -------------------------------------------------------
	let archivo = $state<File | null>(null);
	let inputArchivo = $state<HTMLInputElement | undefined>(undefined);
	let nombreNuevo = $state('');
	let categoriaNueva = $state<CategoriaSonido>('exito');
	let subiendo = $state(false);
	let errorSubida = $state<string | null>(null);
	let okSubida = $state<string | null>(null);
	let urlLocal: string | null = null;

	function alElegirArchivo(e: Event) {
		const elegido = (e.target as HTMLInputElement).files?.[0] ?? null;
		errorSubida = null;
		okSubida = null;
		archivo = elegido;
		if (elegido && !nombreNuevo.trim()) nombreNuevo = nombreSugerido(elegido.name);
		if (urlLocal) URL.revokeObjectURL(urlLocal);
		urlLocal = elegido ? URL.createObjectURL(elegido) : null;
	}

	function escucharArchivoLocal() {
		if (urlLocal) previsualizar('local', urlLocal);
	}

	function limpiarFormulario() {
		archivo = null;
		nombreNuevo = '';
		if (inputArchivo) inputArchivo.value = '';
		if (urlLocal) URL.revokeObjectURL(urlLocal);
		urlLocal = null;
	}

	async function subir() {
		errorSubida = null;
		okSubida = null;
		if (!archivo) return (errorSubida = 'Elige primero un archivo de audio');
		if (!nombreNuevo.trim()) return (errorSubida = 'Ponle un nombre al sonido');
		const problema = validarArchivoSonido(archivo);
		if (problema) return (errorSubida = problema);

		subiendo = true;
		try {
			// algunos navegadores no reportan MIME para .ogg/.mp4: forzamos uno
			// genérico para que Supabase acepte la subida y luego lo sirva igual.
			const tipo = archivo.type || 'application/octet-stream';
			const paraSubir = archivo.type ? archivo : new File([archivo], archivo.name, { type: tipo });
			const { url_subida, url_publica } = await api.crearUrlSubidaSonido(archivo.name, tipo);
			await api.subirArchivoDirecto(url_subida, paraSubir);
			const creado = await api.crearSonido({ categoria: categoriaNueva, nombre: nombreNuevo.trim(), url: url_publica });
			actualizarSonidoEnCache(creado);
			okSubida = `"${creado.nombre}" quedó en el catálogo de ${ETIQUETA_CATEGORIA[creado.categoria].toLowerCase()}.`;
			limpiarFormulario();
		} catch (e) {
			errorSubida = e instanceof Error ? e.message : 'No se pudo subir el sonido';
		} finally {
			subiendo = false;
		}
	}

	$effect(() => () => {
		detenerVistaPrevia();
		if (urlLocal) URL.revokeObjectURL(urlLocal);
	});
</script>

<Header titulo="Sonidos" subtitulo="Catálogo del equipo y lo que suena en tus acciones." />

{#if cargando}
	<p class="cargando">Cargando sonidos…</p>
{:else}
	{#if errorCarga}<p class="error">{errorCarga}</p>{/if}

	<div class="columnas">
		<section class="tarjeta mis-sonidos">
			<h2 class="font-display">Mis sonidos</h2>
			<p class="ayuda">
				Lo que escuchas tú en cada acción. <strong>Aleatorio</strong> toma uno al azar de los habilitados;
				<strong>Sin sonido</strong> deja la acción muda.
			</p>
			<div class="lista-eventos">
				{#each EVENTOS_SONIDO as e (e.evento)}
					<div class="fila-evento">
						<label class="evento-texto" for="pref-{e.evento}">
							<span class="evento-etiqueta">{e.etiqueta}</span>
							<span class="evento-descripcion">{e.descripcion}</span>
						</label>
						<div class="evento-controles">
							<select
								id="pref-{e.evento}"
								value={valorSelect(e.evento)}
								disabled={guardandoEvento === e.evento}
								onchange={(ev) => cambiarPreferencia(e.evento, ev.currentTarget.value)}
							>
								<option value="aleatorio">Aleatorio ({ETIQUETA_CATEGORIA[e.categoria].toLowerCase()})</option>
								{#each opcionesPara(e.evento, e.categoria) as s (s.id)}
									<option value={String(s.id)}>{s.nombre}{s.activo ? '' : ' (deshabilitado)'}</option>
								{/each}
								<option value="silencio">Sin sonido</option>
							</select>
							<button
								type="button"
								class="btn-icono"
								title="Probar cómo suena"
								aria-label="Probar {e.etiqueta}"
								onclick={() => reproducirEvento(e.evento)}
							>
								<Icon nombre={valorSelect(e.evento) === 'silencio' ? 'volume-x' : 'play'} tamano={15} />
							</button>
						</div>
					</div>
				{/each}
			</div>
			{#if errorPreferencia}<p class="error">{errorPreferencia}</p>{/if}
		</section>

		<section class="tarjeta subir">
			<h2 class="font-display">Cargar sonido nuevo</h2>
			<p class="ayuda">Audio corto (ogg, mp3, wav, m4a, mp4), máximo 2 MB. Queda disponible para todo el equipo.</p>
			<form class="form-subir" onsubmit={(e) => (e.preventDefault(), subir())}>
				<div class="fila-archivo">
					<label class="btn-archivo">
						<Icon nombre="upload" tamano={15} />
						<span class="nombre-archivo">{archivo ? archivo.name : 'Elegir archivo…'}</span>
						<input
							bind:this={inputArchivo}
							type="file"
							accept="audio/*,.ogg,.mp3,.wav,.m4a,.mp4,.webm"
							onchange={alElegirArchivo}
							hidden
						/>
					</label>
					{#if archivo}
						<button
							type="button"
							class="btn-icono"
							class:sonando={reproduciendoClave === 'local'}
							title="Escuchar antes de subir"
							aria-label="Escuchar el archivo elegido"
							onclick={escucharArchivoLocal}
						>
							<Icon nombre="play" tamano={15} />
						</button>
					{/if}
				</div>
				<div class="campos-subir">
					<label class="campo">
						Nombre
						<input type="text" bind:value={nombreNuevo} placeholder="p. ej. tada" maxlength="80" />
					</label>
					<label class="campo">
						Categoría
						<select bind:value={categoriaNueva}>
							<option value="exito">Éxito (guardar / cerrar mesa)</option>
							<option value="error">Error</option>
						</select>
					</label>
				</div>
				<div class="acciones-subir">
					<button type="submit" class="btn-primario" disabled={subiendo || !archivo}>
						{subiendo ? 'Subiendo…' : 'Subir al catálogo'}
					</button>
					{#if okSubida}<span class="ok">{okSubida}</span>{/if}
				</div>
				{#if errorSubida}<p class="error">{errorSubida}</p>{/if}
			</form>
		</section>
	</div>

	<section class="catalogo">
		<h2 class="font-display">Catálogo</h2>
		<p class="ayuda">
			Deshabilitar un sonido aquí lo apaga para todo el equipo: nadie lo escucha ni puede elegirlo hasta volverlo a habilitar.
		</p>
		{#if errorCatalogo}<p class="error">{errorCatalogo}</p>{/if}
		<div class="grupos">
			{#each CATEGORIAS as categoria (categoria)}
				{@const lista = sonidosDe(categoria)}
				<div class="tarjeta grupo">
					<h3>
						{ETIQUETA_CATEGORIA[categoria]}
						<span class="conteo">{lista.filter((s) => s.activo).length} de {lista.length} habilitados</span>
					</h3>
					{#if lista.length === 0}
						<p class="sin-datos">Todavía no hay sonidos de {ETIQUETA_CATEGORIA[categoria].toLowerCase()}.</p>
					{:else}
						<ul class="lista-sonidos">
							{#each lista as s (s.id)}
								<li class:deshabilitado={!s.activo}>
									<button
										type="button"
										class="btn-icono"
										class:sonando={reproduciendoClave === `s${s.id}`}
										title={reproduciendoClave === `s${s.id}` ? 'Detener' : 'Reproducir'}
										aria-label="{reproduciendoClave === `s${s.id}` ? 'Detener' : 'Reproducir'} {s.nombre}"
										onclick={() => previsualizar(`s${s.id}`, s.url)}
									>
										<Icon nombre="play" tamano={15} />
									</button>
									<div class="sonido-texto">
										<span class="sonido-nombre">{s.nombre}</span>
										<span class="sonido-origen">{origenDe(s)}</span>
									</div>
									<button
										type="button"
										class="btn-toggle"
										class:activo={s.activo}
										aria-pressed={s.activo}
										disabled={cambiandoId === s.id}
										onclick={() => alternarActivo(s)}
									>
										<span class="punto" aria-hidden="true"></span>
										{s.activo ? 'Habilitado' : 'Deshabilitado'}
									</button>
								</li>
							{/each}
						</ul>
					{/if}
				</div>
			{/each}
		</div>
	</section>
{/if}

<style>
	.cargando,
	.sin-datos {
		color: var(--text-muted);
		font-size: 13px;
	}

	.ayuda {
		margin: 0 0 14px;
		font-size: 12px;
		color: var(--text-muted);
	}

	.error {
		margin: 8px 0 0;
		color: var(--danger);
		font-size: 13px;
	}

	.ok {
		color: var(--success);
		font-size: 12px;
	}

	.columnas {
		display: grid;
		grid-template-columns: minmax(0, 3fr) minmax(0, 2fr);
		gap: 18px;
		margin-bottom: 28px;
	}

	.tarjeta {
		border-radius: var(--radius-lg);
		padding: 18px;
	}

	.tarjeta h2 {
		margin: 0 0 6px;
		font-size: 16px;
	}

	/* --- mis sonidos --- */
	.lista-eventos {
		display: flex;
		flex-direction: column;
	}

	.fila-evento {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 14px;
		padding: 12px 0;
		border-top: 1px solid var(--border);
	}

	.evento-texto {
		display: flex;
		flex-direction: column;
		gap: 2px;
		min-width: 0;
	}

	.evento-etiqueta {
		font-size: 13px;
		font-weight: 600;
	}

	.evento-descripcion {
		font-size: 12px;
		color: var(--text-muted);
	}

	.evento-controles {
		display: flex;
		align-items: center;
		gap: 8px;
		flex-shrink: 0;
	}

	select,
	input[type='text'] {
		background: var(--surface);
		border: 2px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 8px 10px;
		color: var(--text);
		font-size: 13px;
	}

	.evento-controles select {
		min-width: 200px;
	}

	select option {
		background: var(--bg);
		color: var(--text);
	}

	select:disabled {
		opacity: 0.6;
	}

	.btn-icono {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		width: 36px;
		height: 36px;
		background: none;
		border: 2px solid var(--border-strong);
		border-radius: var(--radius);
		color: var(--text);
		cursor: pointer;
		flex-shrink: 0;
	}

	.btn-icono:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.btn-icono.sonando {
		background: var(--accent);
		border-color: var(--accent);
		color: white;
	}

	/* --- cargar nuevo --- */
	.form-subir {
		display: flex;
		flex-direction: column;
		gap: 12px;
	}

	.fila-archivo {
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.btn-archivo {
		display: inline-flex;
		align-items: center;
		gap: 8px;
		flex: 1;
		min-width: 0;
		min-height: 36px;
		padding: 6px 12px;
		border: 2px dashed var(--border-strong);
		border-radius: var(--radius);
		font-size: 13px;
		cursor: pointer;
	}

	.btn-archivo:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.nombre-archivo {
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.campos-subir {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 10px;
	}

	.campo {
		display: flex;
		flex-direction: column;
		gap: 5px;
		font-size: 12px;
		color: var(--text-muted);
		min-width: 0;
	}

	.acciones-subir {
		display: flex;
		align-items: center;
		gap: 12px;
		flex-wrap: wrap;
	}

	.btn-primario {
		background: var(--accent);
		color: white;
		border: none;
		border-radius: var(--radius);
		padding: 9px 16px;
		font-weight: 600;
		font-size: 13px;
		cursor: pointer;
	}

	.btn-primario:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.btn-primario:disabled {
		opacity: 0.55;
		cursor: default;
	}

	/* --- catálogo --- */
	.catalogo h2 {
		margin: 0 0 6px;
		font-size: 16px;
	}

	.grupos {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
		gap: 18px;
	}

	.grupo h3 {
		display: flex;
		align-items: baseline;
		justify-content: space-between;
		gap: 10px;
		margin: 0 0 8px;
		font-size: 14px;
	}

	.conteo {
		font-size: 11px;
		font-weight: 500;
		color: var(--text-faint);
		font-family: var(--font-mono);
	}

	.lista-sonidos {
		list-style: none;
		margin: 0;
		padding: 0;
	}

	.lista-sonidos li {
		display: flex;
		align-items: center;
		gap: 12px;
		padding: 10px 0;
		border-top: 1px solid var(--border);
	}

	.lista-sonidos li.deshabilitado .sonido-texto {
		opacity: 0.55;
	}

	.sonido-texto {
		display: flex;
		flex-direction: column;
		flex: 1;
		min-width: 0;
	}

	.sonido-nombre {
		font-size: 13px;
		font-weight: 600;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.sonido-origen {
		font-size: 11px;
		color: var(--text-faint);
	}

	.btn-toggle {
		display: inline-flex;
		align-items: center;
		gap: 7px;
		min-height: 32px;
		padding: 4px 12px;
		background: none;
		border: 2px solid var(--border-strong);
		border-radius: 999px;
		color: var(--text-muted);
		font-size: 12px;
		cursor: pointer;
		flex-shrink: 0;
	}

	.btn-toggle .punto {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		background: var(--text-faint);
	}

	.btn-toggle.activo {
		color: var(--text);
		border-color: color-mix(in srgb, var(--success) 60%, var(--border-strong));
	}

	.btn-toggle.activo .punto {
		background: var(--success);
	}

	.btn-toggle:hover:not(:disabled) {
		border-color: var(--accent);
	}

	.btn-toggle:disabled {
		opacity: 0.6;
		cursor: default;
	}

	@media (max-width: 900px) {
		.columnas {
			grid-template-columns: 1fr;
		}
	}
</style>
