<script lang="ts">
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import SelectCatalogo from '$lib/components/SelectCatalogo.svelte';
	import Toast from '$lib/components/Toast.svelte';
	import { api, type RegistroCreado } from '$lib/api/client';

	function hoy() {
		return new Date().toISOString().slice(0, 10);
	}

	let fecha = $state(hoy());
	let empresaId = $state<number | null>(null);
	let sistemaId = $state<number | null>(null);
	let medioId = $state<number | null>(null);
	let moduloId = $state<number | null>(null);
	let atendioId = $state<number | null>(null);
	let descripcion = $state('');

	let guardando = $state(false);
	let errorValidacion = $state<string | null>(null);
	let resultado = $state<RegistroCreado | null>(null);
	let errorGuardado = $state<string | null>(null);
	let reintentando = $state(false);

	function limpiar() {
		fecha = hoy();
		empresaId = null;
		sistemaId = null;
		medioId = null;
		moduloId = null;
		atendioId = null;
		descripcion = '';
		resultado = null;
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

<svelte:window onkeydown={alTeclado} />

<h1 class="font-display">Nuevo registro</h1>
<p class="subtitulo">Captura rápida — Ctrl+Enter para guardar sin usar el mouse.</p>

<form class="formulario" onsubmit={(e) => (e.preventDefault(), guardar())}>
	<div class="fila">
		<div class="campo">
			<label for="fecha">Fecha</label>
			<input id="fecha" type="date" bind:value={fecha} />
		</div>
		<ComboboxCreatable id="empresa" catalogo="empresas" label="Empresa" bind:selectedId={empresaId} autofocus />
	</div>

	<div class="fila tres">
		<SelectCatalogo id="sistema" catalogo="sistemas" label="Sistema" bind:selectedId={sistemaId} />
		<SelectCatalogo id="medio" catalogo="medios" label="Medio" bind:selectedId={medioId} />
		<ComboboxCreatable id="modulo" catalogo="modulos" label="Módulo" bind:selectedId={moduloId} />
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

<style>
	.subtitulo {
		color: var(--text-muted);
		margin-top: -8px;
		margin-bottom: 24px;
		font-size: 13px;
	}

	.formulario {
		display: flex;
		flex-direction: column;
		gap: 18px;
		max-width: 720px;
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
