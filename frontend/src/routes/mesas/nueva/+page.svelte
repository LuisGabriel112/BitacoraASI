<script lang="ts">
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import FechaHoraInput from '$lib/components/FechaHoraInput.svelte';
	import Toast from '$lib/components/Toast.svelte';
	import Header from '$lib/components/Header.svelte';
	import CampoGrupo from '$lib/components/CampoGrupo.svelte';
	import LeyendaGrupos from '$lib/components/LeyendaGrupos.svelte';
	import { api, type Mesa } from '$lib/api/client';

	function hoy() {
		return new Date().toISOString().slice(0, 10);
	}

	function ahora() {
		const d = new Date();
		const pad = (n: number) => String(n).padStart(2, '0');
		return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
	}

	let enlace = $state('');
	let codigo = $state('');
	let titulo = $state('');
	let fechaCarga = $state(ahora());
	let descripcion = $state('');
	let ventanaId = $state<number | null>(null);
	let ventanaNombre = $state('');
	let categoriaId = $state<number | null>(null);
	let categoriaNombre = $state('');
	let solicitanteId = $state<number | null>(null);
	let solicitanteNombre = $state('');
	let resolutorId = $state<number | null>(null);
	let resolutorNombre = $state('');
	let fechaEstimadaResolucion = $state('');

	let yaResuelta = $state(false);
	let solucionTexto = $state('');
	let tipoSolucion = $state<'Modificación en BD' | 'Seguimiento de proceso'>('Modificación en BD');
	let fechaCierreReal = $state(hoy());

	let guardando = $state(false);
	let errorValidacion = $state<string | null>(null);
	let resultado = $state<Mesa | null>(null);
	let errorGuardado = $state<string | null>(null);
	let extrayendo = $state(false);
	let errorExtraccion = $state<string | null>(null);
	let avisoExtraccion = $state<string | null>(null);

	let capturadasHoy = $state<Mesa[]>([]);
	let cargandoCapturadas = $state(true);

	async function cargarCapturadasHoy() {
		cargandoCapturadas = true;
		try {
			const pagina = await api.listadoMesas({ fecha_desde: hoy(), fecha_hasta: hoy(), page_size: 20 });
			capturadasHoy = pagina.items;
		} finally {
			cargandoCapturadas = false;
		}
	}

	$effect(() => {
		cargarCapturadasHoy();
	});

	function limpiar() {
		enlace = '';
		codigo = '';
		titulo = '';
		fechaCarga = ahora();
		descripcion = '';
		ventanaId = null;
		ventanaNombre = '';
		categoriaId = null;
		categoriaNombre = '';
		solicitanteId = null;
		solicitanteNombre = '';
		resolutorId = null;
		resolutorNombre = '';
		fechaEstimadaResolucion = '';
		yaResuelta = false;
		solucionTexto = '';
		tipoSolucion = 'Modificación en BD';
		fechaCierreReal = hoy();
		resultado = null;
		errorExtraccion = null;
		avisoExtraccion = null;
	}

	async function extraerDeImagen(archivo: File) {
		errorExtraccion = null;
		avisoExtraccion = null;
		extrayendo = true;
		try {
			const r = await api.extraerImagenMesa(archivo);
			if (r.codigo) codigo = r.codigo;
			if (r.titulo) titulo = r.titulo;
			if (r.fecha_carga) fechaCarga = r.fecha_carga.slice(0, 16);
			if (r.descripcion) descripcion = r.descripcion;
			if (r.solicitante) {
				solicitanteId = r.solicitante.id;
				solicitanteNombre = r.solicitante.nombre;
			}

			const faltantes: string[] = [];
			if (!r.codigo) faltantes.push('Código');
			if (!r.titulo) faltantes.push('Título');
			if (!r.fecha_carga) faltantes.push('Fecha de carga');
			if (!r.descripcion) faltantes.push('Descripción');
			if (!r.solicitante) faltantes.push('Solicitante');
			if (faltantes.length > 0) {
				errorExtraccion = `No se pudo identificar: ${faltantes.join(', ')}. Complétalo manualmente antes de guardar.`;
			}
			avisoExtraccion = 'Revisa todos los campos antes de guardar — la extracción automática puede equivocarse.';
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

		if (!codigo.trim()) return (errorValidacion = 'Falta código de la mesa');
		if (!titulo.trim()) return (errorValidacion = 'Falta título');
		if (!fechaCarga) return (errorValidacion = 'Falta fecha de carga');
		if (!descripcion.trim()) return (errorValidacion = 'Falta descripción');
		if (!ventanaId) return (errorValidacion = 'Falta seleccionar ventana');
		if (!categoriaId) return (errorValidacion = 'Falta seleccionar categoría');
		if (!solicitanteId) return (errorValidacion = 'Falta seleccionar solicitante');
		if (!resolutorId) return (errorValidacion = 'Falta seleccionar resolutor');
		if (!fechaEstimadaResolucion) return (errorValidacion = 'Falta fecha estimada de resolución');
		if (yaResuelta && !solucionTexto.trim()) return (errorValidacion = 'Falta describir la solución');
		if (yaResuelta && !fechaCierreReal) return (errorValidacion = 'Falta la fecha real de cierre');

		guardando = true;
		try {
			resultado = await api.crearMesa({
				enlace: enlace.trim() || null,
				codigo: codigo.trim(),
				titulo: titulo.trim(),
				fecha_carga: fechaCarga,
				descripcion: descripcion.trim(),
				ventana_id: ventanaId,
				categoria_id: categoriaId,
				solicitante_id: solicitanteId,
				resolutor_id: resolutorId,
				fecha_estimada_resolucion: fechaEstimadaResolucion,
				...(yaResuelta
					? { solucion: solucionTexto.trim(), tipo_solucion: tipoSolucion, fecha_cierre_real: fechaCierreReal }
					: {})
			});
			cargarCapturadasHoy();
		} catch (e) {
			errorGuardado = e instanceof Error ? e.message : 'No se pudo guardar la mesa';
		} finally {
			guardando = false;
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

<Header titulo="Nueva mesa" subtitulo="Bitácora administrativa — Ctrl+Enter para guardar sin usar el mouse." />

<div class="columnas">
	<div class="columna-izquierda">
		<label class="dropzone" class:deshabilitado={extrayendo}>
			<span class="dropzone-icono" aria-hidden="true">⇪</span>
			<span class="dropzone-texto font-display">
				{extrayendo ? 'Analizando imagen…' : 'Adjuntar captura'}
			</span>
			<span class="dropzone-ayuda">o pega una captura con Ctrl+V para autocompletar código, título, fecha, solicitante y descripción</span>
			<input type="file" accept="image/*" onchange={alSeleccionarArchivo} disabled={extrayendo} hidden />
		</label>

		{#if errorExtraccion}
			<Toast tipo="error">{errorExtraccion}</Toast>
		{/if}

		{#if avisoExtraccion}
			<Toast tipo="pendiente">{avisoExtraccion}</Toast>
		{/if}

		<div class="tarjeta capturados">
			<h2 class="font-display">Capturadas hoy</h2>
			{#if cargandoCapturadas}
				<ul class="lista-capturados">
					{#each Array(4) as _}
						<li class="item-capturado">
							<span class="skeleton skeleton-item" aria-hidden="true"></span>
						</li>
					{/each}
				</ul>
			{:else if capturadasHoy.length === 0}
				<p class="sin-capturas">Ninguna mesa capturada todavía hoy.</p>
			{:else}
				<ul class="lista-capturados">
					{#each capturadasHoy as m}
						<li class="item-capturado">
							<div class="item-cabecera">
								<span class="item-codigo">{m.codigo}</span>
								<span class="item-hora">{m.fecha_carga.slice(11, 16)}</span>
							</div>
							<span class="item-titulo">{m.titulo}</span>
							<span class="item-solicitante">{m.solicitante.nombre}</span>
						</li>
					{/each}
				</ul>
			{/if}
		</div>
	</div>

	<div class="columna-derecha">
		<form class="tarjeta formulario" onsubmit={(e) => (e.preventDefault(), guardar())}>
			<LeyendaGrupos />

			<div class="grid-campos">
				<CampoGrupo grupo="a">
					<div class="campo">
						<label for="codigo">Código de la mesa</label>
						<input id="codigo" type="text" bind:value={codigo} placeholder="TCK-001" />
					</div>
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<div class="campo">
						<label for="titulo">Título</label>
						<input id="titulo" type="text" bind:value={titulo} />
					</div>
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<FechaHoraInput id="fecha_carga" label="Fecha y hora de carga" bind:value={fechaCarga} />
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<div class="campo">
						<label for="enlace">Enlace en Proactivanet</label>
						<input id="enlace" type="text" bind:value={enlace} placeholder="https://…" />
					</div>
				</CampoGrupo>
				<CampoGrupo grupo="b">
					<ComboboxCreatable id="ventana" catalogo="ventanas-mesa" label="Ventana" bind:selectedId={ventanaId} nombreSeleccionado={ventanaNombre} />
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<ComboboxCreatable id="categoria" catalogo="categorias-mesa" label="Categoría" bind:selectedId={categoriaId} nombreSeleccionado={categoriaNombre} />
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<ComboboxCreatable id="solicitante" catalogo="solicitantes-mesa" label="Solicitante" bind:selectedId={solicitanteId} nombreSeleccionado={solicitanteNombre} />
				</CampoGrupo>
				<CampoGrupo grupo="c">
					<ComboboxCreatable id="resolutor" catalogo="resolutores-mesa" label="Resolutor" bind:selectedId={resolutorId} nombreSeleccionado={resolutorNombre} />
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<FechaHoraInput id="fecha_estimada" label="Fecha y hora estimada de resolución" bind:value={fechaEstimadaResolucion} />
				</CampoGrupo>
			</div>

			<CampoGrupo grupo="a">
				<div class="campo">
					<label for="descripcion">Descripción</label>
					<textarea id="descripcion" rows="4" bind:value={descripcion} placeholder="Qué se reportó…"></textarea>
				</div>
			</CampoGrupo>

			<label class="check-resuelta">
				<input type="checkbox" bind:checked={yaResuelta} />
				Ya se resolvió — capturar la solución de una vez
			</label>

			{#if yaResuelta}
				<div class="bloque-cierre">
					<CampoGrupo grupo="b">
						<div class="campo">
							<label for="solucion">Solución</label>
							<textarea id="solucion" rows="3" bind:value={solucionTexto} placeholder="Qué se hizo para resolverlo…"></textarea>
						</div>
					</CampoGrupo>
					<div class="grid-campos">
						<div class="campo">
							<label for="tipo_solucion">Tipo de solución</label>
							<select id="tipo_solucion" bind:value={tipoSolucion}>
								<option value="Modificación en BD">Modificación en BD</option>
								<option value="Seguimiento de proceso">Seguimiento de proceso</option>
							</select>
						</div>
						<CampoGrupo grupo="c">
							<div class="campo">
								<label for="fecha_cierre">Fecha real de cierre</label>
								<input id="fecha_cierre" type="date" bind:value={fechaCierreReal} />
							</div>
						</CampoGrupo>
					</div>
				</div>
			{/if}

			{#if errorValidacion}
				<Toast tipo="error">{errorValidacion}</Toast>
			{/if}

			<div class="acciones">
				{#if resultado}
					<button type="button" class="secundario" onclick={limpiar}>Capturar otra</button>
				{/if}
				<button type="submit" class="guardar" disabled={guardando}>
					{guardando ? 'Guardando…' : 'Guardar mesa'}
				</button>
			</div>
		</form>

		{#if errorGuardado}
			<div class="confirmaciones">
				<Toast tipo="error">No se pudo guardar la mesa: {errorGuardado}</Toast>
			</div>
		{/if}

		{#if resultado}
			<div class="confirmaciones">
				<Toast tipo="ok">Mesa {resultado.codigo} guardada en la bitácora administrativa.</Toast>
			</div>
		{/if}
	</div>
</div>

<style>
	.columnas {
		display: grid;
		grid-template-columns: minmax(280px, 360px) 1fr;
		gap: 24px;
		align-items: start;
	}

	.columna-izquierda {
		display: flex;
		flex-direction: column;
		gap: 16px;
		min-width: 0;
	}

	.columna-derecha {
		min-width: 0;
	}

	.dropzone {
		display: flex;
		flex-direction: column;
		align-items: center;
		text-align: center;
		gap: 6px;
		border: 1px dashed var(--border-strong);
		border-radius: var(--radius-lg);
		padding: 28px 16px;
		cursor: pointer;
		background: var(--glass-bg);
		backdrop-filter: var(--glass-blur);
		-webkit-backdrop-filter: var(--glass-blur);
		transition: border-color 0.15s ease;
	}

	.dropzone:hover {
		border-color: var(--accent);
	}

	.dropzone.deshabilitado {
		opacity: 0.6;
		cursor: default;
	}

	.dropzone-icono {
		font-size: 22px;
		color: var(--accent);
	}

	.dropzone-texto {
		font-size: 14px;
		font-weight: 600;
	}

	.dropzone-ayuda {
		color: var(--text-muted);
		font-size: 12px;
	}

	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px;
	}

	.formulario {
		display: flex;
		flex-direction: column;
		gap: 18px;
	}

	.capturados h2 {
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

	.item-codigo {
		font-size: 12px;
		font-family: var(--font-mono);
		color: var(--text-faint);
	}

	.item-hora {
		font-size: 11px;
		color: var(--text-faint);
	}

	.item-titulo {
		font-size: 13px;
		color: var(--text);
	}

	.item-solicitante {
		font-size: 12px;
		color: var(--text-muted);
	}

	.skeleton-item {
		display: block;
		height: 34px;
		width: 100%;
		border-radius: 4px;
	}

	.grid-campos {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 16px;
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

	.check-resuelta {
		display: flex;
		align-items: center;
		gap: 8px;
		font-size: 13px;
		color: var(--text-muted);
		cursor: pointer;
	}

	.bloque-cierre {
		display: flex;
		flex-direction: column;
		gap: 18px;
		padding: 14px;
		border: 1px dashed var(--border-strong);
		border-radius: var(--radius);
	}

	select {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
	}

	.acciones {
		display: flex;
		gap: 12px;
		align-items: center;
		justify-content: flex-end;
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
		display: flex;
		flex-direction: column;
		gap: 10px;
		margin-top: 18px;
	}

	@media (max-width: 800px) {
		.columnas {
			grid-template-columns: 1fr;
		}

		.grid-campos {
			grid-template-columns: 1fr;
		}
	}
</style>
