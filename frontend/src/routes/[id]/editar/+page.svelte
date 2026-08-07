<script lang="ts">
	import { page } from '$app/stores';
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import SelectCatalogo from '$lib/components/SelectCatalogo.svelte';
	import Toast from '$lib/components/Toast.svelte';
	import { api, type Registro } from '$lib/api/client';

	const registroId = $derived(Number($page.params.id));

	let cargando = $state(true);
	let errorCarga = $state<string | null>(null);

	let fecha = $state('');
	let empresaId = $state<number | null>(null);
	let empresaNombre = $state('');
	let sistemaId = $state<number | null>(null);
	let medioId = $state<number | null>(null);
	let moduloId = $state<number | null>(null);
	let moduloNombre = $state('');
	let atendioId = $state<number | null>(null);
	let descripcion = $state('');

	let guardando = $state(false);
	let errorValidacion = $state<string | null>(null);
	let errorGuardado = $state<string | null>(null);
	let guardadoOk = $state(false);

	function cargarEnFormulario(r: Registro) {
		fecha = r.fecha;
		empresaId = r.empresa.id;
		empresaNombre = r.empresa.nombre;
		sistemaId = r.sistema.id;
		medioId = r.medio.id;
		moduloId = r.modulo.id;
		moduloNombre = r.modulo.nombre;
		atendioId = r.atendio.id;
		descripcion = r.descripcion;
	}

	async function cargar() {
		cargando = true;
		errorCarga = null;
		try {
			const r = await api.registroPorId(registroId);
			cargarEnFormulario(r);
		} catch (e) {
			errorCarga = e instanceof Error ? e.message : 'No se pudo cargar el registro';
		} finally {
			cargando = false;
		}
	}

	$effect(() => {
		registroId;
		cargar();
	});

	function validar(): string | null {
		if (!empresaId) return 'Falta seleccionar empresa';
		if (!sistemaId) return 'Falta seleccionar sistema';
		if (!medioId) return 'Falta seleccionar medio';
		if (!moduloId) return 'Falta seleccionar módulo';
		if (!atendioId) return 'Falta seleccionar quién atendió';
		if (!descripcion.trim()) return 'Falta descripción';
		return null;
	}

	async function guardar() {
		errorValidacion = validar();
		errorGuardado = null;
		guardadoOk = false;
		if (errorValidacion) return;

		guardando = true;
		try {
			await api.editarRegistro(registroId, {
				fecha,
				empresa_id: empresaId!,
				sistema_id: sistemaId!,
				medio_id: medioId!,
				modulo_id: moduloId!,
				atendio_id: atendioId!,
				descripcion: descripcion.trim()
			});
			guardadoOk = true;
		} catch (e) {
			errorGuardado = e instanceof Error ? e.message : 'No se pudo guardar el registro';
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

<h1 class="font-display">Editar registro</h1>
<p class="subtitulo"><a href="/listado">← Volver al listado</a></p>

{#if cargando}
	<p class="cargando">Cargando registro…</p>
{:else if errorCarga}
	<Toast tipo="error">{errorCarga}</Toast>
{:else}
	<form class="formulario" onsubmit={(e) => (e.preventDefault(), guardar())}>
		<div class="grid-campos">
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
			/>
			<SelectCatalogo id="sistema" catalogo="sistemas" label="Sistema" bind:selectedId={sistemaId} />
			<SelectCatalogo id="medio" catalogo="medios" label="Medio" bind:selectedId={medioId} />
			<ComboboxCreatable
				id="modulo"
				catalogo="modulos"
				label="Módulo"
				bind:selectedId={moduloId}
				nombreSeleccionado={moduloNombre}
			/>
			<SelectCatalogo id="atendio" catalogo="agentes" label="Atendió" bind:selectedId={atendioId} />
		</div>

		<div class="campo">
			<label for="descripcion">Descripción</label>
			<textarea id="descripcion" rows="4" bind:value={descripcion}></textarea>
		</div>

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
	}

	.subtitulo a {
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

	.confirmaciones {
		max-width: 720px;
		display: flex;
		flex-direction: column;
		gap: 10px;
		margin-top: 18px;
	}

	@media (max-width: 640px) {
		.grid-campos {
			grid-template-columns: 1fr;
		}
	}
</style>
