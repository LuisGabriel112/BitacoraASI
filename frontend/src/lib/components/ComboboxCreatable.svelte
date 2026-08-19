<script lang="ts">
	import { api, type Catalogo } from '$lib/api/client';
	import { coincidenciaExacta } from '$lib/catalogoMatch';
	import { agregarAlCache, catalogoCompleto } from '$lib/catalogoCache';
	import Icon from '$lib/components/Icon.svelte';

	let {
		catalogo,
		label,
		selectedId = $bindable(null),
		autofocus = false,
		id,
		nombreSeleccionado = ''
	}: {
		catalogo: 'empresas' | 'modulos' | 'categorias-mesa' | 'solicitantes-mesa' | 'resolutores-mesa' | 'ventanas-mesa';
		label: string;
		selectedId: number | null;
		autofocus?: boolean;
		id: string;
		nombreSeleccionado?: string;
	} = $props();

	const LIMITE_VISIBLE = 20;

	let texto = $state('');
	let abierto = $state(false);
	let cargando = $state(true);
	let resaltado = $state(0);
	let listaCompleta = $state<Catalogo[]>([]);
	let inputEl: HTMLInputElement;

	$effect(() => {
		cargando = true;
		catalogoCompleto(catalogo).then((lista) => {
			listaCompleta = lista;
			cargando = false;
		});
	});

	const opciones = $derived.by(() => {
		const q = texto.trim().toLowerCase();
		const filtradas = q ? listaCompleta.filter((o) => o.nombre.toLowerCase().startsWith(q)) : listaCompleta;
		return filtradas.slice(0, LIMITE_VISIBLE);
	});

	function alEscribir(e: Event) {
		texto = (e.target as HTMLInputElement).value;
		selectedId = null;
		abierto = true;
		resaltado = 0;
	}

	const hayCoincidenciaExacta = $derived(coincidenciaExacta(opciones, texto) !== null);

	const totalFilas = $derived(opciones.length + (texto.trim() && !hayCoincidenciaExacta ? 1 : 0));

	function elegir(item: Catalogo) {
		selectedId = item.id;
		texto = item.nombre;
		abierto = false;
	}

	async function crear() {
		const nombre = texto.trim();
		if (!nombre) return;
		const item = await api.crearCatalogo(catalogo, nombre);
		await agregarAlCache(catalogo, item);
		listaCompleta = await catalogoCompleto(catalogo);
		elegir(item);
	}

	export async function resolverPendiente() {
		if (selectedId || !texto.trim()) return;
		const exacta = coincidenciaExacta(listaCompleta, texto);
		if (exacta) elegir(exacta);
		else await crear();
	}

	function alTeclado(e: KeyboardEvent) {
		if (!abierto && (e.key === 'ArrowDown' || e.key === 'ArrowUp')) {
			abierto = true;
			return;
		}
		if (e.key === 'ArrowDown') {
			e.preventDefault();
			resaltado = Math.min(resaltado + 1, totalFilas - 1);
		} else if (e.key === 'ArrowUp') {
			e.preventDefault();
			resaltado = Math.max(resaltado - 1, 0);
		} else if (e.key === 'Enter') {
			if (!abierto) return;
			e.preventDefault();
			if (resaltado < opciones.length) {
				elegir(opciones[resaltado]);
			} else {
				crear();
			}
		} else if (e.key === 'Escape') {
			abierto = false;
		}
	}

	$effect(() => {
		if (autofocus) inputEl?.focus();
	});

	$effect(() => {
		texto = nombreSeleccionado;
	});
</script>

<div class="campo">
	<label for={id}>{label}</label>
	<div class="combobox">
		<input
			bind:this={inputEl}
			{id}
			type="text"
			autocomplete="off"
			placeholder="Escribe para buscar o crear…"
			value={texto}
			oninput={alEscribir}
			onfocus={() => (abierto = true)}
			onblur={() => setTimeout(() => ((abierto = false), resolverPendiente()), 120)}
			onkeydown={alTeclado}
		/>
		{#if selectedId}<span class="marca-ok" title="Seleccionado"><Icon nombre="check" tamano={13} /></span>{/if}

		{#if abierto && (opciones.length > 0 || (texto.trim() && !cargando))}
			<ul class="lista" role="listbox">
				{#each opciones as opcion, i}
					<li>
						<button
							type="button"
							class:resaltado={i === resaltado}
							onmousedown={() => elegir(opcion)}
						>
							{opcion.nombre}
						</button>
					</li>
				{/each}
				{#if texto.trim() && !hayCoincidenciaExacta}
					<li>
						<button
							type="button"
							class="crear"
							class:resaltado={resaltado === opciones.length}
							onmousedown={crear}
						>
							+ Crear "{texto.trim()}"
						</button>
					</li>
				{/if}
			</ul>
		{/if}
	</div>
</div>

<style>
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

	.combobox {
		position: relative;
	}

	input {
		width: 100%;
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 32px 9px 10px;
		color: var(--text);
	}

	input:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}

	.marca-ok {
		display: flex;
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		color: var(--success);
		pointer-events: none;
	}

	/* fondo casi opaco a propósito: este menú flota sobre el resto del
	   formulario (position: absolute) y var(--surface-raised) es demasiado
	   transparente (11% en modo oscuro) sin blur — el contenido de atrás se
	   transparentaba y hacía difícil leer las opciones. */
	.lista {
		position: absolute;
		z-index: 20;
		top: calc(100% + 4px);
		left: 0;
		right: 0;
		background: color-mix(in oklch, var(--bg) 96%, var(--surface-raised));
		backdrop-filter: var(--glass-blur);
		-webkit-backdrop-filter: var(--glass-blur);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		box-shadow: 0 12px 30px -8px oklch(0 0 0 / 0.45);
		max-height: 220px;
		overflow-y: auto;
		list-style: none;
		margin: 0;
		padding: 4px;
	}

	.lista button {
		display: block;
		width: 100%;
		text-align: left;
		background: none;
		border: none;
		padding: 8px 10px;
		border-radius: var(--radius);
		color: var(--text);
		cursor: pointer;
	}

	.lista button:hover,
	.lista button.resaltado {
		background: var(--accent);
		color: var(--bg);
	}

	.lista button.crear {
		color: var(--success);
	}

	.lista button.crear:hover,
	.lista button.crear.resaltado {
		background: var(--success);
		color: var(--bg);
	}
</style>
