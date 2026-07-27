<script lang="ts">
	import { api, type Catalogo } from '$lib/api/client';

	let {
		catalogo,
		label,
		selectedId = $bindable(null),
		autofocus = false,
		id,
		nombreSeleccionado = ''
	}: {
		catalogo: 'empresas' | 'modulos';
		label: string;
		selectedId: number | null;
		autofocus?: boolean;
		id: string;
		nombreSeleccionado?: string;
	} = $props();

	let texto = $state('');
	let opciones = $state<Catalogo[]>([]);
	let abierto = $state(false);
	let cargando = $state(false);
	let resaltado = $state(0);
	let inputEl: HTMLInputElement;
	let timer: ReturnType<typeof setTimeout>;

	function buscar(valor: string) {
		clearTimeout(timer);
		timer = setTimeout(async () => {
			cargando = true;
			try {
				opciones = await api.catalogo(catalogo, valor);
			} finally {
				cargando = false;
			}
		}, 150);
	}

	function alEscribir(e: Event) {
		texto = (e.target as HTMLInputElement).value;
		selectedId = null;
		abierto = true;
		resaltado = 0;
		buscar(texto);
	}

	const hayCoincidenciaExacta = $derived(
		opciones.some((o) => o.nombre.toLowerCase() === texto.trim().toLowerCase())
	);

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
		elegir(item);
	}

	function alTeclado(e: KeyboardEvent) {
		if (!abierto && (e.key === 'ArrowDown' || e.key === 'ArrowUp')) {
			abierto = true;
			buscar(texto);
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
		if (nombreSeleccionado) texto = nombreSeleccionado;
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
			onfocus={() => {
				abierto = true;
				buscar(texto);
			}}
			onblur={() => setTimeout(() => (abierto = false), 120)}
			onkeydown={alTeclado}
		/>
		{#if selectedId}<span class="marca-ok" title="Seleccionado">✓</span>{/if}

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
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		color: var(--success);
		pointer-events: none;
	}

	.lista {
		position: absolute;
		z-index: 20;
		top: calc(100% + 4px);
		left: 0;
		right: 0;
		background: var(--surface-raised);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
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
