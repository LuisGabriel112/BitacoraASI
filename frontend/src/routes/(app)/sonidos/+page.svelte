<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import { api, type AccionSonido, type Sonido } from '$lib/api/client';
	import {
		ACCIONES_SONIDO,
		ETIQUETA_ACCION,
		PESO_MAXIMO,
		PESO_MINIMO,
		esSintetizado,
		nombreSugerido,
		pesoDe,
		probabilidadDe,
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

	// --- filtro por acción -------------------------------------------------
	let filtro = $state<AccionSonido | 'todas'>('todas');
	const visibles = $derived(
		filtro === 'todas' ? sonidos : sonidos.filter((s) => s.acciones.includes(filtro as AccionSonido))
	);

	/** Las acciones cuya probabilidad se muestra en la fila: con el filtro
	 *  puesto, solo esa; sin filtro, todas las que el sonido tenga marcadas. */
	function accionesVisibles(s: Sonido): AccionSonido[] {
		return filtro === 'todas' ? s.acciones : s.acciones.filter((a) => a === filtro);
	}

	function porcentaje(s: Sonido, accion: AccionSonido): string {
		return `${Math.round(probabilidadDe(s, accion, sonidos) * 100)}%`;
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

	// --- peso de cada acción ----------------------------------------------
	let guardandoPeso = $state<{ id: number; accion: AccionSonido } | null>(null);

	function estaGuardandoPeso(s: Sonido, accion: AccionSonido): boolean {
		return guardandoPeso?.id === s.id && guardandoPeso.accion === accion;
	}

	async function cambiarPeso(s: Sonido, accion: AccionSonido, valor: string) {
		const peso = Number(valor);
		if (!Number.isInteger(peso) || peso < PESO_MINIMO || peso > PESO_MAXIMO) {
			errorCatalogo = `El peso debe ser un número entre ${PESO_MINIMO} y ${PESO_MAXIMO}`;
			return;
		}
		if (peso === pesoDe(s, accion)) return;
		errorCatalogo = null;
		guardandoPeso = { id: s.id, accion };
		try {
			actualizarSonidoEnCache(await api.ajustarPesoSonido(s.id, accion, peso));
		} catch (e) {
			errorCatalogo = e instanceof Error ? e.message : 'No se pudo cambiar la probabilidad';
		} finally {
			guardandoPeso = null;
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

<svelte:window onkeydown={(e) => porEliminar && e.key === 'Escape' && cancelarEliminar()} />

<Header titulo="Sonidos" subtitulo="Lo que suena en cada acción, para todo el equipo." />

{#if cargando}
	<p class="cargando">Cargando sonidos…</p>
{:else}
	{#if errorCarga}<p class="error">{errorCarga}</p>{/if}

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

	<section class="tarjeta catalogo">
		<div class="cabecera-catalogo">
			<h2 class="font-display">
				Catálogo
				<span class="conteo">{enUso} de {sonidos.length} en uso</span>
			</h2>
			<label class="filtro">
				Mostrar
				<select bind:value={filtro}>
					<option value="todas">Todas las acciones</option>
					{#each ACCIONES_SONIDO as a (a.accion)}
						<option value={a.accion}>{a.etiqueta}</option>
					{/each}
				</select>
			</label>
		</div>
		<p class="ayuda">
			Marca en qué acciones puede sonar cada sonido; aplica a todo el equipo. Un sonido sin ninguna acción marcada no
			suena para nadie. La <strong>probabilidad</strong> reparte el sorteo dentro de cada acción: con peso 3 suena el
			triple de seguido que uno con peso 1.
		</p>
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
						<div class="probabilidades">
							{#each accionesVisibles(s) as accion (accion)}
								<span class="probabilidad">
									<label class="etiqueta-peso" for="peso-{s.id}-{accion}">{ETIQUETA_ACCION[accion]}</label>
									<input
										id="peso-{s.id}-{accion}"
										type="number"
										min={PESO_MINIMO}
										max={PESO_MAXIMO}
										step="1"
										value={pesoDe(s, accion)}
										disabled={estaGuardandoPeso(s, accion)}
										title="Peso de {s.nombre} en {ETIQUETA_ACCION[accion]}"
										onchange={(e) => cambiarPeso(s, accion, e.currentTarget.value)}
									/>
									<span class="porcentaje">{porcentaje(s, accion)}</span>
								</span>
							{:else}
								<span class="sin-probabilidad">—</span>
							{/each}
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
						<button
							type="button"
							class="btn-eliminar"
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

	{#if porEliminar}
		<!-- Cerrar con teclado lo cubre Escape en <svelte:window>, no el overlay:
		     un onkeydown aquí no se dispara porque el foco vive dentro del diálogo. -->
		<!-- svelte-ignore a11y_click_events_have_key_events -->
		<!-- svelte-ignore a11y_no_static_element_interactions -->
		<div class="overlay" onclick={cancelarEliminar}>
			<div
				class="modal tarjeta"
				onclick={(e) => e.stopPropagation()}
				role="dialog"
				aria-modal="true"
				aria-labelledby="titulo-eliminar"
				tabindex="-1"
			>
				<h2 id="titulo-eliminar" class="font-display">¿Eliminar "{porEliminar.nombre}"?</h2>
				<p class="ayuda-modal">
					Se quita del catálogo para todo el equipo y no se puede deshacer. Quien lo tuviera elegido para alguna
					acción volverá a escuchar uno al azar.
				</p>
				<div class="acciones-modal">
					<button
						type="button"
						class="btn-cancelar"
						bind:this={botonCancelar}
						disabled={eliminando}
						onclick={cancelarEliminar}
					>
						Cancelar
					</button>
					<button type="button" class="btn-peligro" disabled={eliminando} onclick={confirmarEliminar}>
						{eliminando ? 'Eliminando…' : 'Eliminar'}
					</button>
				</div>
			</div>
		</div>
	{/if}
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
		align-items: baseline;
		justify-content: space-between;
		gap: 14px;
		flex-wrap: wrap;
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
		flex-wrap: wrap;
		align-items: center;
		gap: 10px;
		flex-shrink: 0;
		min-width: 150px;
	}

	.probabilidad {
		display: inline-flex;
		align-items: center;
		gap: 5px;
		font-size: 11px;
		color: var(--text-muted);
	}

	.etiqueta-peso {
		font-size: 11px;
		color: var(--text-faint);
	}

	.probabilidades input[type='number'] {
		width: 52px;
		padding: 4px 6px;
		background: var(--surface);
		border: 2px solid var(--border);
		border-radius: var(--radius);
		color: var(--text);
		font-size: 12px;
		font-family: var(--font-mono);
	}

	.probabilidades input[type='number']:focus {
		border-color: var(--accent);
		outline: none;
	}

	.probabilidades input[type='number']:disabled {
		opacity: 0.6;
	}

	.porcentaje {
		min-width: 34px;
		font-family: var(--font-mono);
		font-size: 11px;
		color: var(--text);
	}

	.sin-probabilidad {
		color: var(--text-faint);
		font-size: 12px;
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

	/* --- modal de confirmación --- */
	.overlay {
		position: fixed;
		inset: 0;
		z-index: 400;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 24px;
		background: var(--scrim);
	}

	.modal {
		width: min(420px, 100%);
		padding: 22px;
		cursor: default;
	}

	.modal h2 {
		margin: 0 0 8px;
		font-size: 16px;
	}

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

	@media (max-width: 900px) {
		.lista-sonidos li {
			flex-wrap: wrap;
		}

		.lista-sonidos .acciones,
		.lista-sonidos .probabilidades {
			width: 100%;
			padding-left: 48px;
		}
	}
</style>
