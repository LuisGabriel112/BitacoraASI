<script lang="ts">
	import { page } from '$app/stores';
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import FechaHoraInput from '$lib/components/FechaHoraInput.svelte';
	import Toast from '$lib/components/Toast.svelte';
	import CampoGrupo from '$lib/components/CampoGrupo.svelte';
	import LeyendaGrupos from '$lib/components/LeyendaGrupos.svelte';
	import Celebracion from '$lib/components/Celebracion.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import { api, type Mesa } from '$lib/api/client';

	let celebracion: Celebracion;

	function ahora() {
		const d = new Date();
		const pad = (n: number) => String(n).padStart(2, '0');
		return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
	}

	const mesaId = $derived(Number($page.params.id));

	let cargando = $state(true);
	let errorCarga = $state<string | null>(null);

	let enlace = $state('');
	let codigo = $state('');
	let titulo = $state('');
	let fechaCarga = $state('');
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

	let prioridad = $state(false);
	let destacada = $state(false);

	let cerrada = $state(false);
	let solucionTexto = $state('');
	let tipoSolucion = $state<'Modificación en BD' | 'Seguimiento de proceso'>('Modificación en BD');
	let fechaCierreReal = $state('');
	let medidasImpacto = $state(false);

	let guardando = $state(false);
	let errorValidacion = $state<string | null>(null);
	let errorGuardado = $state<string | null>(null);
	let guardadoOk = $state(false);

	function cargarEnFormulario(m: Mesa) {
		enlace = m.enlace ?? '';
		codigo = m.codigo;
		titulo = m.titulo;
		fechaCarga = m.fecha_carga.slice(0, 16);
		descripcion = m.descripcion;
		ventanaId = m.ventana?.id ?? null;
		ventanaNombre = m.ventana?.nombre ?? '';
		categoriaId = m.categoria.id;
		categoriaNombre = m.categoria.nombre;
		solicitanteId = m.solicitante.id;
		solicitanteNombre = m.solicitante.nombre;
		resolutorId = m.resolutor.id;
		resolutorNombre = m.resolutor.nombre;
		fechaEstimadaResolucion = m.fecha_estimada_resolucion.slice(0, 16);
		prioridad = m.prioridad;
		destacada = m.destacada;
		cerrada = !!m.fecha_cierre_real;
		solucionTexto = m.solucion ?? '';
		tipoSolucion = (m.tipo_solucion as 'Modificación en BD' | 'Seguimiento de proceso') ?? 'Modificación en BD';
		fechaCierreReal = m.fecha_cierre_real?.slice(0, 16) ?? ahora();
		medidasImpacto = m.medidas_impacto;
	}

	async function cargar() {
		cargando = true;
		errorCarga = null;
		try {
			const m = await api.mesaPorId(mesaId);
			cargarEnFormulario(m);
		} catch (e) {
			errorCarga = e instanceof Error ? e.message : 'No se pudo cargar la mesa';
		} finally {
			cargando = false;
		}
	}

	$effect(() => {
		mesaId;
		cargar();
	});

	async function guardar() {
		errorValidacion = null;
		errorGuardado = null;
		guardadoOk = false;

		if (!codigo.trim()) return (errorValidacion = 'Falta código de la mesa');
		if (!titulo.trim()) return (errorValidacion = 'Falta título');
		if (!fechaCarga) return (errorValidacion = 'Falta fecha de carga');
		if (!descripcion.trim()) return (errorValidacion = 'Falta descripción');
		if (!categoriaId) return (errorValidacion = 'Falta seleccionar categoría');
		if (!solicitanteId) return (errorValidacion = 'Falta seleccionar solicitante');
		if (!resolutorId) return (errorValidacion = 'Falta seleccionar resolutor');
		if (!fechaEstimadaResolucion) return (errorValidacion = 'Falta fecha estimada de resolución');
		if (cerrada && !ventanaId) return (errorValidacion = 'Falta seleccionar ventana');
		if (cerrada && !solucionTexto.trim()) return (errorValidacion = 'Falta describir la solución');
		if (cerrada && !fechaCierreReal) return (errorValidacion = 'Falta la fecha real de cierre');

		guardando = true;
		try {
			const actualizada = await api.editarMesa(mesaId, {
				enlace: enlace.trim() || null,
				codigo: codigo.trim(),
				titulo: titulo.trim(),
				fecha_carga: fechaCarga,
				descripcion: descripcion.trim(),
				ventana_id: cerrada ? ventanaId : null,
				categoria_id: categoriaId,
				solicitante_id: solicitanteId,
				resolutor_id: resolutorId,
				fecha_estimada_resolucion: fechaEstimadaResolucion,
				prioridad,
				destacada,
				solucion: cerrada ? solucionTexto.trim() : null,
				tipo_solucion: cerrada ? tipoSolucion : null,
				fecha_cierre_real: cerrada ? fechaCierreReal : null,
				medidas_impacto: cerrada ? medidasImpacto : false
			});
			guardadoOk = true;
			celebracion?.mostrar(actualizada.logros);
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

<svelte:window onkeydown={alTeclado} />

<Celebracion bind:this={celebracion} />

<h1 class="font-display">Editar mesa</h1>
<p class="subtitulo">
	<a href="/mesas/listado"><Icon nombre="chevron-left" tamano={14} /> Volver al listado</a>
	{#if enlace}
		· <a href={enlace} target="_blank" rel="noopener noreferrer">Abrir en Proactivanet <Icon nombre="external-link" tamano={13} /></a>
	{/if}
</p>

{#if cargando}
	<p class="cargando">Cargando mesa…</p>
{:else if errorCarga}
	<Toast tipo="error">{errorCarga}</Toast>
{:else}
	<form class="formulario" onsubmit={(e) => (e.preventDefault(), guardar())}>
		<LeyendaGrupos />

		<div class="grid-campos">
			<CampoGrupo grupo="a">
				<div class="campo">
					<label for="codigo">Código de la mesa</label>
					<input id="codigo" type="text" bind:value={codigo} />
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
			<CampoGrupo grupo="a">
				<ComboboxCreatable id="categoria" catalogo="categorias-mesa" label="Categoría" bind:selectedId={categoriaId} nombreSeleccionado={categoriaNombre} />
			</CampoGrupo>
			<CampoGrupo grupo="a">
				<ComboboxCreatable id="solicitante" catalogo="solicitantes-mesa" label="Solicitante" bind:selectedId={solicitanteId} nombreSeleccionado={solicitanteNombre} />
			</CampoGrupo>
			<CampoGrupo grupo="b">
				<ComboboxCreatable id="resolutor" catalogo="resolutores-mesa" label="Resolutor" bind:selectedId={resolutorId} nombreSeleccionado={resolutorNombre} />
			</CampoGrupo>
			<CampoGrupo grupo="a">
				<FechaHoraInput id="fecha_estimada" label="Fecha y hora estimada de resolución" bind:value={fechaEstimadaResolucion} />
			</CampoGrupo>
		</div>

		<CampoGrupo grupo="a">
			<div class="campo">
				<label for="descripcion">Descripción</label>
				<textarea id="descripcion" rows="4" bind:value={descripcion}></textarea>
			</div>
		</CampoGrupo>

		<div class="fila-checks">
			<label class="check-resuelta">
				<input type="checkbox" bind:checked={cerrada} />
				Mesa cerrada
			</label>
			<label class="check-resuelta">
				<input type="checkbox" bind:checked={prioridad} />
				Prioritaria
			</label>
			<label class="check-resuelta">
				<input type="checkbox" bind:checked={destacada} />
				Destacada
			</label>
		</div>

		{#if cerrada}
			<div class="bloque-cierre">
				<CampoGrupo grupo="b">
					<div class="campo">
						<label for="solucion">Solución</label>
						<textarea id="solucion" rows="3" bind:value={solucionTexto}></textarea>
					</div>
				</CampoGrupo>
				<div class="grid-cierre">
					<CampoGrupo grupo="b">
						<ComboboxCreatable id="ventana" catalogo="ventanas-mesa" label="Ventana" bind:selectedId={ventanaId} nombreSeleccionado={ventanaNombre} />
					</CampoGrupo>
					<div class="campo">
						<label for="tipo_solucion">Categoría de la solución</label>
						<select id="tipo_solucion" bind:value={tipoSolucion}>
							<option value="Modificación en BD">Modificación en BD</option>
							<option value="Seguimiento de proceso">Seguimiento de proceso</option>
						</select>
					</div>
					<CampoGrupo grupo="b">
						<FechaHoraInput id="fecha_cierre" label="Fecha y hora real de cierre" bind:value={fechaCierreReal} />
					</CampoGrupo>
				</div>
				<label class="check-resuelta">
					<input type="checkbox" bind:checked={medidasImpacto} />
					Medidas para disminuir el impacto
				</label>
			</div>
		{/if}

		{#if errorValidacion}
			<Toast tipo="error">{errorValidacion}</Toast>
		{/if}

		<div class="acciones">
			<button type="submit" class="guardar" disabled={guardando}>
				{guardando ? 'Guardando…' : 'Guardar cambios'}
			</button>
		</div>
	</form>

	{#if errorGuardado}
		<div class="confirmaciones">
			<Toast tipo="error">No se pudo guardar: {errorGuardado}</Toast>
		</div>
	{/if}

	{#if guardadoOk}
		<div class="confirmaciones">
			<Toast tipo="ok">Cambios guardados.</Toast>
		</div>
	{/if}
{/if}

<style>
	.subtitulo {
		color: var(--text-muted);
		margin-top: -8px;
		margin-bottom: 24px;
		font-size: 13px;
		display: flex;
		gap: 6px;
	}

	.subtitulo a {
		display: inline-flex;
		align-items: center;
		gap: 4px;
		color: var(--accent-strong);
	}

	.cargando {
		color: var(--text-muted);
	}

	.formulario {
		display: flex;
		flex-direction: column;
		gap: 18px;
		max-width: 720px;
	}

	.grid-campos {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 16px;
	}

	.grid-cierre {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
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
	textarea,
	select {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
		resize: vertical;
	}

	select option {
		background: var(--bg);
		color: var(--text);
	}

	input:focus-visible,
	textarea:focus-visible,
	select:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}

	.fila-checks {
		display: flex;
		gap: 20px;
		flex-wrap: wrap;
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

	.confirmaciones {
		max-width: 720px;
		display: flex;
		flex-direction: column;
		gap: 10px;
		margin-top: 18px;
	}

	@media (max-width: 640px) {
		.grid-campos,
		.grid-cierre {
			grid-template-columns: 1fr;
		}
	}
</style>
