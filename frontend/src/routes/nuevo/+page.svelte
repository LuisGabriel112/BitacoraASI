<script lang="ts">
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import SelectCatalogo from '$lib/components/SelectCatalogo.svelte';
	import ChipSistema from '$lib/components/ChipSistema.svelte';
	import Toast from '$lib/components/Toast.svelte';
	import { api, type Registro, type RegistroCreado } from '$lib/api/client';

	function hoy() {
		return new Date().toISOString().slice(0, 10);
	}

	function hora(iso: string) {
		return new Date(iso).toLocaleTimeString('es-MX', { hour: '2-digit', minute: '2-digit' });
	}

	let fecha = $state(hoy());
	let empresaId = $state<number | null>(null);
	let sistemaId = $state<number | null>(null);
	let medioId = $state<number | null>(null);
	let moduloId = $state<number | null>(null);
	let atendioId = $state<number | null>(null);
	let descripcion = $state('');
	let empresaNombre = $state('');
	let moduloNombre = $state('');

	let guardando = $state(false);
	let errorValidacion = $state<string | null>(null);
	let resultado = $state<RegistroCreado | null>(null);
	let errorGuardado = $state<string | null>(null);
	let reintentando = $state(false);
	let extrayendo = $state(false);
	let errorExtraccion = $state<string | null>(null);

	let capturadosHoy = $state<Registro[]>([]);
	let cargandoCapturados = $state(true);

	async function cargarCapturadosHoy() {
		cargandoCapturados = true;
		try {
			const pagina = await api.listado({
				fecha_desde: hoy(),
				fecha_hasta: hoy(),
				page_size: 20
			});
			capturadosHoy = pagina.items;
		} finally {
			cargandoCapturados = false;
		}
	}

	$effect(() => {
		cargarCapturadosHoy();
	});

	function limpiar() {
		fecha = hoy();
		empresaId = null;
		sistemaId = null;
		medioId = null;
		moduloId = null;
		atendioId = null;
		descripcion = '';
		empresaNombre = '';
		moduloNombre = '';
		resultado = null;
	}

	async function extraerDeImagen(archivo: File) {
		errorExtraccion = null;
		extrayendo = true;
		try {
			const r = await api.extraerImagen(archivo);
			if (r.fecha) fecha = r.fecha;
			if (r.empresa) {
				empresaId = r.empresa.id;
				empresaNombre = r.empresa.nombre;
			}
			if (r.sistema) sistemaId = r.sistema.id;
			if (r.medio) medioId = r.medio.id;
			if (r.modulo) {
				moduloId = r.modulo.id;
				moduloNombre = r.modulo.nombre;
			}
			if (r.atendio) atendioId = r.atendio.id;
			if (r.descripcion) descripcion = r.descripcion;
		} catch (e) {
			errorExtraccion = e instanceof Error ? e.message : 'No se pudo extraer información de la imagen';
		} finally {
			extrayendo = false;
		}
	}

	function alSeleccionarArchivo(e: Event) {
		const archivo = (e.target as HTMLInputElement).files?.[0];
		if (archivo) extraerDeImagen(archivo);
		(e.target as HTMLInputElement).value = '';
	}

	function alPegar(e: ClipboardEvent) {
		const item = Array.from(e.clipboardData?.items ?? []).find((i) => i.type.startsWith('image/'));
		const archivo = item?.getAsFile();
		if (archivo) extraerDeImagen(archivo);
	}

	async function guardar() {
		errorValidacion = null;
		errorGuardado = null;

		if (!empresaId) return (errorValidacion = 'Falta seleccionar empresa');
		if (!sistemaId) return (errorValidacion = 'Falta seleccionar sistema');
		if (!medioId) return (errorValidacion = 'Falta seleccionar medio');
		if (!moduloId) return (errorValidacion = 'Falta seleccionar módulo');
		if (!atendioId) return (errorValidacion = 'Falta seleccionar quién atendió');
		if (!descripcion.trim()) return (errorValidacion = 'Falta descripción');

		guardando = true;
		try {
			resultado = await api.crearRegistro({
				fecha,
				empresa_id: empresaId,
				sistema_id: sistemaId,
				medio_id: medioId,
				modulo_id: moduloId,
				atendio_id: atendioId,
				descripcion: descripcion.trim()
			});
			cargarCapturadosHoy();
		} catch (e) {
			errorGuardado = e instanceof Error ? e.message : 'No se pudo guardar el registro';
		} finally {
			guardando = false;
		}
	}

	async function reintentarTrello() {
		if (!resultado) return;
		reintentando = true;
		try {
			resultado = await api.reintentarTrello(resultado.registro.id);
		} finally {
			reintentando = false;
		}
	}

	function alTeclado(e: KeyboardEvent) {
		if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
			e.preventDefault();
			guardar();
		}
	}
</script>

<svelte:window onkeydown={alTeclado} onpaste={alPegar} />

<h1 class="font-display">Nuevo registro</h1>
<p class="subtitulo">Captura rápida — Ctrl+Enter para guardar sin usar el mouse.</p>

<div class="captura">
	<label class="boton-captura" class:deshabilitado={extrayendo}>
		{extrayendo ? 'Analizando imagen…' : 'Adjuntar captura'}
		<input type="file" accept="image/*" onchange={alSeleccionarArchivo} disabled={extrayendo} hidden />
	</label>
	<span class="ayuda-captura">o pega una captura con Ctrl+V para autocompletar el formulario</span>
</div>

{#if errorExtraccion}
	<Toast tipo="error">{errorExtraccion}</Toast>
{/if}

<div class="columnas">
<div class="columna-izquierda">
<form class="formulario" onsubmit={(e) => (e.preventDefault(), guardar())}>
	<div class="fila">
		<div class="campo">
			<label for="fecha">Fecha</label>
			<input id="fecha" type="date" bind:value={fecha} />
		</div>
		<ComboboxCreatable
			id="empresa"
			catalogo="empresas"
			label="Empresa"
			bind:selectedId={empresaId}
			nombreSeleccionado={empresaNombre}
			autofocus
		/>
	</div>

	<div class="fila tres">
		<SelectCatalogo id="sistema" catalogo="sistemas" label="Sistema" bind:selectedId={sistemaId} />
		<SelectCatalogo id="medio" catalogo="medios" label="Medio" bind:selectedId={medioId} />
		<ComboboxCreatable
			id="modulo"
			catalogo="modulos"
			label="Módulo"
			bind:selectedId={moduloId}
			nombreSeleccionado={moduloNombre}
		/>
	</div>

	<div class="fila">
		<SelectCatalogo id="atendio" catalogo="agentes" label="Atendió" bind:selectedId={atendioId} />
	</div>

	<div class="campo">
		<label for="descripcion">Descripción</label>
		<textarea id="descripcion" rows="4" bind:value={descripcion} placeholder="Qué se reportó y qué se hizo…"
		></textarea>
	</div>

	{#if errorValidacion}
		<Toast tipo="error">{errorValidacion}</Toast>
	{/if}

	<div class="acciones">
		<button type="submit" class="guardar" disabled={guardando}>
			{guardando ? 'Guardando…' : 'Guardar registro'}
		</button>
		{#if resultado}
			<button type="button" class="secundario" onclick={limpiar}>Capturar otro</button>
		{/if}
	</div>
</form>

{#if errorGuardado}
	<div class="confirmaciones">
		<Toast tipo="error">No se pudo guardar el registro: {errorGuardado}</Toast>
	</div>
{/if}

{#if resultado}
	<div class="confirmaciones">
		<Toast tipo="ok">Registro guardado en la bitácora.</Toast>
		{#if resultado.trello_ok}
			<Toast tipo="ok">Tarjeta creada en Trello.</Toast>
		{:else if resultado.trello_error}
			<Toast
				tipo="error"
				accion={{ texto: reintentando ? 'Reintentando…' : 'Reintentar', onClick: reintentarTrello }}
			>
				No se pudo crear la tarjeta en Trello: {resultado.trello_error}
			</Toast>
		{/if}
	</div>
{/if}
</div>

	<aside class="sidebar">
		<h2 class="font-display">Capturados hoy</h2>
		{#if cargandoCapturados}
			<ul class="lista-capturados">
				{#each Array(4) as _}
					<li class="item-capturado">
						<span class="skeleton skeleton-item" aria-hidden="true"></span>
					</li>
				{/each}
			</ul>
		{:else if capturadosHoy.length === 0}
			<p class="sin-capturas">Ningún registro capturado todavía hoy.</p>
		{:else}
			<ul class="lista-capturados">
				{#each capturadosHoy as r}
					<li class="item-capturado">
						<div class="item-cabecera">
							<span class="item-hora">{hora(r.created_at)}</span>
							<ChipSistema nombre={r.sistema.nombre} />
						</div>
						<span class="item-empresa">{r.empresa.nombre}</span>
						<span class="item-modulo">{r.modulo.nombre}</span>
					</li>
				{/each}
			</ul>
		{/if}
	</aside>
</div>

<style>
	.subtitulo {
		color: var(--text-muted);
		margin-top: -8px;
		margin-bottom: 24px;
		font-size: 13px;
	}

	.captura {
		display: flex;
		align-items: center;
		gap: 12px;
		margin-bottom: 18px;
	}

	.boton-captura {
		background: none;
		border: 1px dashed var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 16px;
		color: var(--text);
		cursor: pointer;
		font-size: 13px;
	}

	.boton-captura:hover {
		border-color: var(--accent);
	}

	.boton-captura.deshabilitado {
		opacity: 0.6;
		cursor: default;
	}

	.ayuda-captura {
		color: var(--text-muted);
		font-size: 12px;
	}

	.columnas {
		display: flex;
		gap: 32px;
		align-items: flex-start;
	}

	.columna-izquierda {
		flex: 1 1 640px;
		max-width: 720px;
		min-width: 0;
	}

	.formulario {
		display: flex;
		flex-direction: column;
		gap: 18px;
	}

	.sidebar {
		flex: 1 1 260px;
		max-width: 320px;
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px;
		position: sticky;
		top: 24px;
	}

	.sidebar h2 {
		font-size: 14px;
		margin: 0 0 14px;
		color: var(--text-muted);
	}

	.sin-capturas {
		color: var(--text-muted);
		font-size: 13px;
	}

	.lista-capturados {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 12px;
	}

	.item-capturado {
		padding-bottom: 12px;
		border-bottom: 1px solid var(--border);
		display: flex;
		flex-direction: column;
		gap: 4px;
	}

	.item-capturado:last-child {
		border-bottom: none;
		padding-bottom: 0;
	}

	.item-cabecera {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 8px;
	}

	.item-hora {
		font-size: 12px;
		color: var(--text-faint);
	}

	.item-empresa {
		font-size: 13px;
		color: var(--text);
	}

	.item-modulo {
		font-size: 12px;
		color: var(--text-muted);
	}

	.skeleton-item {
		display: block;
		height: 34px;
		width: 100%;
		border-radius: 4px;
	}

	.fila {
		display: grid;
		grid-template-columns: 1fr 2fr;
		gap: 16px;
	}

	.fila.tres {
		grid-template-columns: 1fr 1fr 1fr;
	}

	.campo {
		display: flex;
		flex-direction: column;
		gap: 6px;
	}

	label {
		font-size: 12px;
		color: var(--text-muted);
		font-family: var(--font-display);
	}

	input,
	textarea {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
		resize: vertical;
	}

	input:focus-visible,
	textarea:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}

	.acciones {
		display: flex;
		gap: 12px;
		align-items: center;
	}

	.guardar {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 10px 20px;
		font-weight: 600;
		font-family: var(--font-display);
		cursor: pointer;
	}

	.guardar:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.guardar:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.secundario {
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 10px 16px;
		color: var(--text);
		cursor: pointer;
	}

	.confirmaciones {
		max-width: 720px;
		display: flex;
		flex-direction: column;
		gap: 10px;
		margin-top: 18px;
	}
</style>
