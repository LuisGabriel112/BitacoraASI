<script lang="ts">
	import { fechaHoraActualLocal, formatearFechaHora, parsearFechaHoraPegada } from '$lib/fechaHora';

	let {
		id,
		label,
		value = $bindable(''),
		comoTexto = false,
		actualizarAlHacerClic = false
	}: {
		id: string;
		label: string;
		value: string;
		comoTexto?: boolean;
		actualizarAlHacerClic?: boolean;
	} = $props();

	function alHacerClic() {
		if (actualizarAlHacerClic) value = fechaHoraActualLocal();
	}

	function alPegar(e: ClipboardEvent) {
		const texto = e.clipboardData?.getData('text') ?? '';
		const parseado = parsearFechaHoraPegada(texto);
		if (parseado) {
			e.preventDefault();
			value = parseado;
		}
	}

	let texto = $state(formatearFechaHora(value));

	$effect(() => {
		texto = formatearFechaHora(value);
	});

	function alEscribirTexto(e: Event) {
		texto = (e.target as HTMLInputElement).value;
		const parseado = parsearFechaHoraPegada(texto);
		if (parseado) value = parseado;
	}

	function alPerderFocoTexto() {
		texto = formatearFechaHora(value);
	}
</script>

<div class="campo">
	<label for={id}>{label}</label>
	{#if comoTexto}
		<input
			{id}
			type="text"
			placeholder="DD/MM/AAAA HH:mm"
			bind:value={texto}
			oninput={alEscribirTexto}
			onblur={alPerderFocoTexto}
		/>
	{:else}
		<input {id} type="datetime-local" bind:value onpaste={alPegar} onclick={alHacerClic} />
	{/if}
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

	input {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
	}

	input:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}
</style>
