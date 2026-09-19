<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import { api, type AccionSonido, type EventoSonido, type Sonido } from '$lib/api/client';
	import {
		ACCIONES_SONIDO,
		ETIQUETA_ACCION,
		EVENTOS_SONIDO,
		accionDeEvento,
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
	const enUso = $derived(sonidos.filter((s) => s.acciones.length > 0).length);

	function origenDe(s: Sonido): string {
		if (esSintetizado(s.url)) return 'Sintetizado';
		return s.url.startsWith('/sonidos/') ? 'De fábrica' : 'Cargado por el equipo';
	}

	function etiquetas(acciones: readonly AccionSonido[]): string {
		return acciones.map((a) => ETIQUETA_ACCION[a]).join(', ');
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
			}, 1200);
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

	/** Los marcados para la acción, más el elegido aunque lo hayan desmarcado
	 *  (para que el select no "pierda" la elección y se vea por qué no suena). */
	function opcionesPara(evento: EventoSonido): Sonido[] {
		const accion = accionDeEvento(evento);
		const elegidoId = preferenciaDe(evento, estadoSonidos.preferencias)?.sonido_id ?? null;
		return sonidos.filter((s) => s.acciones.includes(accion) || s.id === elegidoId);
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

	// --- marcar / desmarcar acciones en el catálogo -----------------------
	let cambiando = $state<{ id: number; accion: AccionSonido } | null>(null);
	let errorCatalogo = $state<string | null>(null);

	function estaCambiando(s: Sonido, accion: AccionSonido): boolean {
		return cambiando?.id === s.id && cambiando.accion === accion;
	}

	async function alternarAccion(s: Sonido, accion: AccionSonido) {
		errorCatalogo = null;
		cambiando = { id: s.id, accion };
		try {
			const actualizado = s.acciones.includes(accion)
				? await api.desmarcarAccionSonido(s.id, accion)
				: await api.marcarAccionSonido(s.id, accion);
			actualizarSonidoEnCache(actualizado);
		} catch (e) {
			errorCatalogo = e instanceof Error ? e.message : 'No se pudo cambiar el sonido';
		} finally {
			cambiando = null;
		}
	}

	// --- cargar nuevo -------------------------------------------------------
	let archivo = $state<File | null>(null);
	let inputArchivo = $state<HTMLInputElement | undefined>(undefined);
	let nombreNuevo = $state('');
	let accionesNuevas = $state<AccionSonido[]>([]);
	let subiendo = $state(false);
	let errorSubida = $state<string | null>(null);
	let okSubida = $state<string | null>(null);
	let urlLocal: string | null = null;

	function alternarAccionNueva(accion: AccionSonido) {
		accionesNuevas = accionesNuevas.includes(accion)
			? accionesNuevas.filter((a) => a !== accion)
			: [...accionesNuevas, accion];
	}

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
		accionesNuevas = [];
		if (inputArchivo) inputArchivo.value = '';
		if (urlLocal) URL.revokeObjectURL(urlLocal);
		urlLocal = null;
	}

	async function subir() {
		errorSubida = null;
		okSubida = null;
		if (!archivo) return (errorSubida = 'Elige primero un archivo de audio');
		if (!nombreNuevo.trim()) return (errorSubida = 'Ponle un nombre al sonido');
		if (accionesNuevas.length === 0) return (errorSubida = 'Marca al menos una acción en la que suene');
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
			const creado = await api.crearSonido({ nombre: nombreNuevo.trim(), url: url_publica, acciones: accionesNuevas });
			actualizarSonidoEnCache(creado);
			okSubida = `"${creado.nombre}" quedó en el catálogo para ${etiquetas(creado.acciones)}.`;
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
				Lo que escuchas tú en cada acción. <strong>Aleatorio</strong> toma uno al azar de los marcados para esa
				acción en el catálogo; <strong>Sin sonido</strong> deja la acción muda.
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
								<option value="aleatorio">Aleatorio ({ETIQUETA_ACCION[e.accion]})</option>
								{#each opcionesPara(e.evento) as s (s.id)}
									<option value={String(s.id)}>{s.nombre}{s.acciones.includes(e.accion) ? '' : ' (desmarcado)'}</option>
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
				<label class="campo">
					Nombre
					<input type="text" bind:value={nombreNuevo} placeholder="p. ej. tada" maxlength="80" />
				</label>
				<fieldset class="campo campo-acciones">
					<legend>Suena en</legend>
					<div class="acciones">
						{#each ACCIONES_SONIDO as a (a.accion)}
							<button
								type="button"
								class="btn-accion"
								class:marcada={accionesNuevas.includes(a.accion)}
								aria-pressed={accionesNuevas.includes(a.accion)}
								title={a.descripcion}
								onclick={() => alternarAccionNueva(a.accion)}
							>
								<span class="punto" aria-hidden="true"></span>
								{a.etiqueta}
							</button>
						{/each}
					</div>
				</fieldset>
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

	<section class="tarjeta catalogo">
		<h2 class="font-display">
			Catálogo
			<span class="conteo">{enUso} de {sonidos.length} en uso</span>
		</h2>
		<p class="ayuda">
			Marca en qué acciones puede sonar cada sonido; aplica a todo el equipo. Un sonido sin ninguna acción marcada no
			suena para nadie ni se puede elegir.
		</p>
		{#if errorCatalogo}<p class="error">{errorCatalogo}</p>{/if}
		{#if sonidos.length === 0}
			<p class="sin-datos">Todavía no hay sonidos en el catálogo.</p>
		{:else}
			<ul class="lista-sonidos">
				{#each sonidos as s (s.id)}
					<li class:sin-acciones={s.acciones.length === 0}>
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
							<span class="sonido-origen">
								{origenDe(s)}{s.acciones.length === 0 ? ' · sin acciones, no suena' : ''}
							</span>
						</div>
						<div class="acciones" role="group" aria-label="Acciones de {s.nombre}">
							{#each ACCIONES_SONIDO as a (a.accion)}
								{@const marcada = s.acciones.includes(a.accion)}
								<button
									type="button"
									class="btn-accion"
									class:marcada
									aria-pressed={marcada}
									disabled={estaCambiando(s, a.accion)}
									title="{a.etiqueta} · {a.descripcion}"
									onclick={() => alternarAccion(s, a.accion)}
								>
									<span class="punto" aria-hidden="true"></span>
									{a.etiqueta}
								</button>
							{/each}
						</div>
					</li>
				{/each}
			</ul>
		{/if}
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

	.campo {
		display: flex;
		flex-direction: column;
		gap: 5px;
		font-size: 12px;
		color: var(--text-muted);
		min-width: 0;
	}

	.campo-acciones {
		margin: 0;
		padding: 0;
		border: none;
	}

	.campo-acciones legend {
		padding: 0;
		margin-bottom: 5px;
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
		display: flex;
		align-items: baseline;
		justify-content: space-between;
		gap: 10px;
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

	.lista-sonidos li.sin-acciones .sonido-texto {
		opacity: 0.55;
	}

	.sonido-texto {
		display: flex;
		flex-direction: column;
		flex: 1;
		min-width: 160px;
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

	/* --- botones de acción (catálogo y formulario) --- */
	.acciones {
		display: flex;
		flex-wrap: wrap;
		gap: 6px;
		flex-shrink: 0;
	}

	.btn-accion {
		display: inline-flex;
		align-items: center;
		gap: 6px;
		min-height: 30px;
		padding: 3px 11px;
		background: none;
		border: 2px solid var(--border);
		border-radius: 999px;
		color: var(--text-muted);
		font-size: 12px;
		cursor: pointer;
	}

	.btn-accion .punto {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		background: var(--text-faint);
	}

	.btn-accion.marcada {
		color: var(--text);
		border-color: var(--accent);
		background: color-mix(in srgb, var(--accent) 14%, transparent);
	}

	.btn-accion.marcada .punto {
		background: var(--accent-strong);
	}

	.btn-accion:hover:not(:disabled) {
		border-color: var(--accent);
		color: var(--text);
	}

	.btn-accion:disabled {
		opacity: 0.6;
		cursor: default;
	}

	@media (max-width: 900px) {
		.columnas {
			grid-template-columns: 1fr;
		}

		.lista-sonidos li {
			flex-wrap: wrap;
		}

		.lista-sonidos .acciones {
			width: 100%;
			padding-left: 48px;
		}
	}
</style>
