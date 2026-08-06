<script lang="ts">
	import { parsearFechaHoraPegada } from '$lib/fechaHora';

	let {
		id,
		label,
		value = $bindable('')
	}: {
		id: string;
		label: string;
		value: string;
	} = $props();

	function alPegar(e: ClipboardEvent) {
		const texto = e.clipboardData?.getData('text') ?? '';
		const parseado = parsearFechaHoraPegada(texto);
		if (parseado) {
			e.preventDefault();
			value = parseado;
		}
	}
</script>

<div class="campo">
	<label for={id}>{label}</label>
	<input {id} type="datetime-local" bind:value onpaste={alPegar} />
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
