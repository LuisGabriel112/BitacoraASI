<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import Modal from '$lib/components/Modal.svelte';
	import { api, type AccionSonido, type Sonido } from '$lib/api/client';
	import {
		ACCIONES_SONIDO,
		ETIQUETA_ACCION,
		PESO_MAXIMO,
		esSintetizado,
		nombreSugerido,
		pesoCompartido,
		validarArchivoSonido
	} from '$lib/sonidos';
	import {
		actualizarSonidoEnCache,
		cargarSonidos,
		estadoSonidos,
		quitarSonidoDelCache,
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

	let editando = $state(false);
	let guardandoEdicion = $state(false);
	let borrador = $state<Sonido[]>([]);
	function iniciarEdicion() {
		borrador = sonidos.map((s) => ({ ...s }));
		errorCatalogo = null;
		editando = true;
	}
	let sonidoArrastrado = $state<number | null>(null);
	let destinoArrastre = $state<number | null>(null);
	function moverSonido(id: number, destino: number) {
		const indice = borrador.findIndex((s) => s.id === id);
		if (indice < 0 || destino < 0 || destino >= borrador.length || indice === destino) return;
		const nuevo = [...borrador];
		const [sonido] = nuevo.splice(indice, 1);
		nuevo.splice(destino, 0, sonido);
		borrador = nuevo;
	}
	function arrastrarSonido(e: PointerEvent) {
		if (sonidoArrastrado === null) return;
		const fila = document.elementFromPoint(e.clientX, e.clientY)?.closest<HTMLElement>('[data-sonido-id]');
		if (fila) destinoArrastre = Number(fila.dataset.sonidoId);
	}
	function terminarArrastre(confirmar = false) {
		if (confirmar && sonidoArrastrado !== null && destinoArrastre !== null) {
			moverSonido(sonidoArrastrado, borrador.findIndex((s) => s.id === destinoArrastre));
		}
		sonidoArrastrado = null;
		destinoArrastre = null;
	}
	async function guardarEdicion() {
		errorCatalogo = null;
		const nombres = borrador.map((s) => s.nombre.trim().replace(/\s+/g, ' '));
		if (nombres.some((n) => !n) || new Set(nombres.map((n) => n.toLowerCase())).size !== nombres.length) {
			errorCatalogo = 'Los nombres deben ser únicos y no estar vacíos.';
			return;
		}
		guardandoEdicion = true;
		try {
			estadoSonidos.sonidos = await api.editarCatalogoSonidos(borrador.map((s, i) => ({ id: s.id, nombre: nombres[i] })));
			editando = false;
		} catch (e) {
			errorCatalogo = e instanceof Error ? e.message : 'No se pudo guardar el catálogo';
		} finally { guardandoEdicion = false; }
	}

	// --- filtro por acción -------------------------------------------------
	let filtro = $state<AccionSonido | 'todas'>('todas');
	const visibles = $derived(
		editando ? borrador : filtro === 'todas' ? sonidos : sonidos.filter((s) => s.acciones.includes(filtro as AccionSonido))
	);

	/** Las acciones cuya probabilidad se muestra en la fila: con el filtro
	 *  puesto, solo esa; sin filtro, todas, incluidas las apagadas. */
	function accionesVisibles(): AccionSonido[] {
		return filtro === 'todas' ? ACCIONES_SONIDO.map((a) => a.accion) : [filtro];
	}

	let mostrandoValores = $state(false);
	const teclasSlider = ['ArrowLeft', 'ArrowRight', 'ArrowUp', 'ArrowDown', 'Home', 'End', 'PageUp', 'PageDown'];
	let arrastrando = $state<{ id: number; peso: number } | null>(null);
	function pesoMostrado(s: Sonido): number {
		return arrastrando?.id === s.id ? arrastrando.peso : pesoCompartido(s);
	}
	function porcentaje(s: Sonido, accion: AccionSonido): string {
		if (!s.acciones.includes(accion)) return '0%';
		const total = sonidos.filter((otro) => otro.acciones.includes(accion))
			.reduce((suma, otro) => suma + pesoMostrado(otro), 0);
		return `${Math.round(total === 0 ? 0 : pesoMostrado(s) / total * 100)}%`;
	}

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

	let errorCatalogo = $state<string | null>(null);

	// --- eliminar del catálogo --------------------------------------------
	let porEliminar = $state<Sonido | null>(null);
	let eliminando = $state(false);
	let botonCancelar = $state<HTMLButtonElement | undefined>(undefined);

	// Al abrir, el foco se queda en el botón de la fila (fuera del diálogo), así
	// que Escape no llegaría y el lector de pantalla no anunciaría el modal.
	$effect(() => {
		if (porEliminar) botonCancelar?.focus();
	});

	function pedirConfirmacion(s: Sonido) {
		errorCatalogo = null;
		porEliminar = s;
	}

	function cancelarEliminar() {
		if (eliminando) return;
		porEliminar = null;
	}

	async function confirmarEliminar() {
		if (!porEliminar) return;
		const sonido = porEliminar;
		eliminando = true;
		try {
			await api.eliminarSonido(sonido.id);
			if (reproduciendoClave === `s${sonido.id}`) detenerVistaPrevia();
			quitarSonidoDelCache(sonido.id);
			porEliminar = null;
		} catch (e) {
			errorCatalogo = e instanceof Error ? e.message : 'No se pudo eliminar el sonido';
			porEliminar = null;
		} finally {
			eliminando = false;
		}
	}

	let guardandoPeso = $state<number | null>(null);
	let cambiandoAccion = $state<number | null>(null);

	async function alternarAccion(s: Sonido, accion: AccionSonido) {
		cambiandoAccion = s.id;
		errorCatalogo = null;
		try {
			actualizarSonidoEnCache(s.acciones.includes(accion)
				? await api.desmarcarAccionSonido(s.id, accion)
				: await api.marcarAccionSonido(s.id, accion));
		} catch (e) {
			errorCatalogo = e instanceof Error ? e.message : 'No se pudo cambiar la acción';
		} finally { cambiandoAccion = null; }
	}

	async function cambiarPeso(s: Sonido, valor: string) {
		const peso = Number(valor);
		if (!Number.isInteger(peso) || peso < 1 || peso > PESO_MAXIMO) return;
		arrastrando = { id: s.id, peso };
		guardandoPeso = s.id;
		errorCatalogo = null;
		try {
			actualizarSonidoEnCache(await api.ajustarPesoCompartidoSonido(s.id, peso));
		} catch (e) {
			errorCatalogo = e instanceof Error ? e.message : 'No se pudo guardar la probabilidad';
		} finally {
			guardandoPeso = null;
			arrastrando = null;
		}
	}

	// --- cargar nuevo -------------------------------------------------------
	let abriendoCarga = $state(false);
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
			abriendoCarga = false;
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

<svelte:window
	onkeydown={(e) => porEliminar && e.key === 'Escape' && cancelarEliminar()}
	onpointermove={arrastrarSonido}
	onpointerup={(e) => { mostrandoValores = false; arrastrarSonido(e); terminarArrastre(true); }}
	onpointercancel={() => { mostrandoValores = false; terminarArrastre(); }}
	onblur={() => { mostrandoValores = false; terminarArrastre(); }}
/>

<Header titulo="Sonidos" subtitulo="Lo que suena en cada acción, para todo el equipo." />

{#if cargando}
	<p class="cargando">Cargando sonidos…</p>
{:else}
	{#if errorCarga}<p class="error">{errorCarga}</p>{/if}

	<Modal
		titulo="Cargar sonido nuevo"
		abierto={abriendoCarga}
		cerrable={!subiendo}
		alCerrar={() => (abriendoCarga = false)}
	>
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
				<button type="button" class="btn-cancelar" disabled={subiendo} onclick={() => (abriendoCarga = false)}>
					Cancelar
				</button>
				<button type="submit" class="btn-primario" disabled={subiendo || !archivo}>
					{subiendo ? 'Subiendo…' : 'Subir al catálogo'}
				</button>
			</div>
			{#if errorSubida}<p class="error">{errorSubida}</p>{/if}
	</form>
	</Modal>

	<section class="tarjeta catalogo">
		<div class="cabecera-catalogo">
			<h2 class="font-display">
				Catálogo
				<span class="conteo">{enUso} de {sonidos.length} en uso</span>
			</h2>
			<div class="controles-catalogo">
				{#if editando}
					<button type="button" class="btn-primario" disabled={guardandoEdicion} onclick={guardarEdicion}>{guardandoEdicion ? 'Guardando…' : 'Guardar cambios'}</button>
					<button type="button" class="btn-cancelar" disabled={guardandoEdicion} onclick={() => (editando = false)}>Cancelar</button>
				{:else}
					<button type="button" class="btn-cancelar" onclick={iniciarEdicion}>Editar catálogo</button>
				{/if}
				<button type="button" class="btn-primario" disabled={editando} onclick={() => (abriendoCarga = true)}>
					<Icon nombre="upload" tamano={15} />
					Cargar sonido
				</button>
				<label class="filtro">
					Mostrar
					<select bind:value={filtro} disabled={editando}>
						<option value="todas">Todas las acciones</option>
						{#each ACCIONES_SONIDO as a (a.accion)}
							<option value={a.accion}>{a.etiqueta}</option>
						{/each}
					</select>
				</label>
			</div>
		</div>
		<p class="ayuda">
			Enciende las acciones en las que debe sonar. El slider de <strong>probabilidad</strong>, de 1 a 10,
			se comparte entre todas sus acciones. Mantén presionado un slider para ver todos los pesos y porcentajes.
		</p>
		{#if okSubida}<p class="ok">{okSubida}</p>{/if}
		{#if errorCatalogo}<p class="error">{errorCatalogo}</p>{/if}
		{#if visibles.length === 0}
			<p class="sin-datos">
				{sonidos.length === 0
					? 'Todavía no hay sonidos en el catálogo.'
					: `Ningún sonido está marcado para ${ETIQUETA_ACCION[filtro as AccionSonido]}.`}
			</p>
		{:else}
			<ul class="lista-sonidos">
				{#each visibles as s (s.id)}
					<li data-sonido-id={s.id} class:arrastrando-fila={sonidoArrastrado === s.id} class:destino-arrastre={destinoArrastre === s.id && sonidoArrastrado !== s.id} class:sin-acciones={s.acciones.length === 0}>
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
							{#if editando}
								<input class="nombre-edicion" type="text" aria-label="Nombre del sonido" bind:value={s.nombre} maxlength="80" disabled={guardandoEdicion} />
								<button type="button" class="agarre-orden" aria-label="Arrastrar {s.nombre} para reordenar" title="Arrastra para reordenar; usa las flechas del teclado para mover"
									disabled={guardandoEdicion}
									onpointerdown={(e) => { if (e.button !== 0) return; sonidoArrastrado = s.id; destinoArrastre = s.id; e.currentTarget.setPointerCapture(e.pointerId); }}
									onlostpointercapture={() => terminarArrastre()}
									onkeydown={(e) => { if (e.key === 'ArrowUp' || e.key === 'ArrowDown') { e.preventDefault(); moverSonido(s.id, borrador.findIndex((otro) => otro.id === s.id) + (e.key === 'ArrowUp' ? -1 : 1)); } }}>
									<span aria-hidden="true">⠿</span> Arrastrar
								</button>
							{:else}<span class="sonido-nombre">{s.nombre}</span>{/if}
							<span class="sonido-origen">
								{origenDe(s)}{s.acciones.length === 0 ? ' · sin acciones, no suena' : ''}
							</span>
						</div>
						<div class="probabilidades">
							<label class="peso-compartido" for="peso-{s.id}">
								<span>Probabilidad <strong class="valor-slider" class:oculto={!mostrandoValores} aria-hidden={!mostrandoValores}>{pesoMostrado(s)}/10</strong></span>
								<input id="peso-{s.id}" type="range" min="1" max={PESO_MAXIMO} step="1"
									value={pesoMostrado(s)} disabled={editando || guardandoPeso !== null || cambiandoAccion !== null}
									onpointerdown={() => (mostrandoValores = true)}
									onkeydown={(e) => { if (teclasSlider.includes(e.key)) mostrandoValores = true; }}
									onkeyup={(e) => { if (teclasSlider.includes(e.key)) mostrandoValores = false; }}
									onblur={() => (mostrandoValores = false)}
									oninput={(e) => (arrastrando = { id: s.id, peso: Number(e.currentTarget.value) })}
									onchange={(e) => cambiarPeso(s, e.currentTarget.value)} />
							</label>
							<div class="acciones acciones-catalogo">
								{#each accionesVisibles() as accion (accion)}
									<button type="button" class="btn-accion" class:marcada={s.acciones.includes(accion)}
										aria-pressed={s.acciones.includes(accion)} disabled={editando || guardandoPeso !== null || cambiandoAccion !== null}
										title={s.acciones.includes(accion) ? 'Apagar' : 'Encender'} onclick={() => alternarAccion(s, accion)}>
										<span class="punto" aria-hidden="true"></span>
										{ETIQUETA_ACCION[accion]} <span class="porcentaje" class:oculto={!mostrandoValores} aria-hidden={!mostrandoValores}>{porcentaje(s, accion)}</span>
									</button>
								{/each}
							</div>
						</div>
						<button
							type="button"
							class="btn-eliminar"
							disabled={editando}
							title="Eliminar del catálogo"
							aria-label="Eliminar {s.nombre} del catálogo"
							onclick={() => pedirConfirmacion(s)}
						>
							<Icon nombre="trash-2" tamano={15} />
						</button>
					</li>
				{/each}
			</ul>
		{/if}
	</section>

	<Modal
		titulo={`¿Eliminar "${porEliminar?.nombre ?? ''}"?`}
		abierto={porEliminar !== null}
		cerrable={!eliminando}
		alCerrar={cancelarEliminar}
	>
		<p class="ayuda-modal">
			Se quita del catálogo para todo el equipo y no se puede deshacer. Quien lo tuviera elegido para alguna
			acción volverá a escuchar uno al azar.
		</p>
		<div class="acciones-modal">
			<button type="button" class="btn-cancelar" disabled={eliminando} onclick={cancelarEliminar}>
				Cancelar
			</button>
			<button type="button" class="btn-peligro" disabled={eliminando} onclick={confirmarEliminar}>
				{eliminando ? 'Eliminando…' : 'Eliminar'}
			</button>
		</div>
	</Modal>
{/if}

<style>
	.nombre-edicion { box-sizing: border-box; width: 100%; min-width: 0; }
	.agarre-orden { display: inline-flex; align-items: center; justify-content: center; gap: 6px; margin-top: 6px; height: 30px; border: 1px solid var(--border-strong); border-radius: var(--radius); background: var(--surface); color: var(--text-muted); cursor: grab; touch-action: none; user-select: none; }
	.agarre-orden:active { cursor: grabbing; }
	.agarre-orden:disabled { opacity: 0.4; cursor: default; }
	.destino-arrastre { box-shadow: inset 0 0 0 2px var(--accent); background: var(--accent-soft); }
	.arrastrando-fila { background: var(--accent-soft); outline: 1px solid var(--accent); }
	.btn-eliminar:disabled { opacity: 0.4; cursor: default; }

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

	.tarjeta {
		border-radius: var(--radius-lg);
		padding: 18px;
	}

	.tarjeta h2 {
		margin: 0 0 6px;
		font-size: 16px;
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


	select option {
		background: var(--bg);
		color: var(--text);
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

	.cabecera-catalogo {
		display: flex;
		align-items: center;
		justify-content: space-between;
		margin-bottom: 20px;
		gap: 20px;
		flex-wrap: wrap;
	}

	.controles-catalogo {
		display: flex;
		align-items: center;
		flex-wrap: wrap;
		gap: 16px 24px;
	}

	.filtro {
		display: inline-flex;
		align-items: center;
		gap: 8px;
		font-size: 12px;
		color: var(--text-muted);
	}

	.filtro select {
		min-width: 170px;
	}

	.probabilidades {
		display: flex;
		flex-wrap: nowrap;
		align-items: center;
		min-width: 0;
		gap: 28px;
		padding: 4px;
	}

	.peso-compartido {
		display: grid;
		gap: 6px;
		flex: 0 0 120px;
		font-size: 11px;
		color: var(--text-muted);
	}
	.peso-compartido span { display: flex; justify-content: space-between; gap: 8px; }
	.acciones-catalogo { flex-wrap: nowrap; }
	.acciones-catalogo .btn-accion {
		box-sizing: border-box;
		width: 132px;
		height: 36px;
		justify-content: center;
		flex-shrink: 0;
		white-space: nowrap;
	}

	@container (max-width: 1100px) {
		.probabilidades {
			display: grid;
			grid-template-columns: minmax(80px, 120px) minmax(0, 1fr);
			align-items: start;
			gap: 20px;
		}
		.acciones-catalogo {
			display: grid;
			grid-template-columns: repeat(2, minmax(0, 1fr));
			min-width: 0;
		}
		.acciones-catalogo .btn-accion {
			width: 100%;
			min-width: 0;
		}
	}

	@container (max-width: 440px) {
		.probabilidades {
			grid-template-columns: minmax(0, 1fr);
		}
		.peso-compartido { max-width: 180px; }
		.acciones-catalogo {
			grid-template-columns: repeat(auto-fit, minmax(min(100%, 140px), 1fr));
		}
	}

	/* La barra se dibuja a mano para que el riel y el tirador usen los tokens
	   del sistema: el control nativo ignora currentColor en casi todo. */
	.probabilidades input[type='range'] {
		width: 100%;
		min-width: 0;
		height: 18px;
		margin: 0;
		background: none;
		cursor: pointer;
		appearance: none;
		-webkit-appearance: none;
	}

	.probabilidades input[type='range']::-webkit-slider-runnable-track {
		height: 4px;
		border-radius: 999px;
		background: var(--border-strong);
	}

	.probabilidades input[type='range']::-moz-range-track {
		height: 4px;
		border-radius: 999px;
		background: var(--border-strong);
	}

	.probabilidades input[type='range']::-webkit-slider-thumb {
		appearance: none;
		-webkit-appearance: none;
		width: 14px;
		height: 14px;
		margin-top: -5px;
		border: none;
		border-radius: 50%;
		background: var(--accent);
	}

	.probabilidades input[type='range']::-moz-range-thumb {
		width: 14px;
		height: 14px;
		border: none;
		border-radius: 50%;
		background: var(--accent);
	}

	.probabilidades input[type='range']:hover::-webkit-slider-thumb {
		background: var(--accent-strong);
	}

	.probabilidades input[type='range']:hover::-moz-range-thumb {
		background: var(--accent-strong);
	}

	.probabilidades input[type='range']:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 3px;
	}

	.probabilidades input[type='range']:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.oculto {
		visibility: hidden;
	}

	.porcentaje {
		min-width: 34px;
		font-family: var(--font-mono);
		font-size: 11px;
		color: var(--text);
	}

	.lista-sonidos {
		list-style: none;
		margin: 0;
		padding: 0;
	}

	.lista-sonidos li {
		container-type: inline-size;
		display: grid;
		grid-template-columns: 36px minmax(80px, 130px) minmax(0, 1fr) 32px;
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
		overflow-wrap: anywhere;
		font-size: 11px;
		color: var(--text-faint);
	}

	.btn-eliminar {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		width: 32px;
		height: 32px;
		background: none;
		border: 2px solid transparent;
		border-radius: var(--radius);
		color: var(--text-faint);
		cursor: pointer;
		flex-shrink: 0;
	}

	.btn-eliminar:hover {
		border-color: var(--danger);
		color: var(--danger);
	}

	/* --- modales --- */



	.ayuda-modal {
		margin: 0 0 18px;
		font-size: 13px;
		color: var(--text-muted);
	}

	.acciones-modal {
		display: flex;
		justify-content: flex-end;
		gap: 10px;
	}

	.btn-cancelar,
	.btn-peligro {
		border-radius: var(--radius);
		padding: 9px 16px;
		font-size: 13px;
		font-weight: 600;
		cursor: pointer;
	}

	.btn-cancelar {
		background: none;
		border: 2px solid var(--border-strong);
		color: var(--text);
	}

	.btn-peligro {
		background: var(--danger);
		border: 2px solid var(--danger);
		color: white;
	}

	.btn-peligro:hover:not(:disabled) {
		filter: brightness(1.1);
	}

	.btn-cancelar:disabled,
	.btn-peligro:disabled {
		opacity: 0.6;
		cursor: default;
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

	@media (max-width: 700px) {
		.lista-sonidos li {
			grid-template-columns: 36px minmax(0, 1fr) 32px;
		}

		.lista-sonidos .probabilidades {
			grid-column: 1 / -1;
			grid-row: 2;
		}

		.lista-sonidos .btn-eliminar {
			grid-column: 3;
			grid-row: 1;
		}
	}
</style>
