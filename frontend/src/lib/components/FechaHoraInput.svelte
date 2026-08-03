<script lang="ts">
	let {
		id,
		label,
		value = $bindable('')
	}: {
		id: string;
		label: string;
		value: string;
	} = $props();

	function parsearPegado(texto: string): string | null {
		const m = texto.trim().match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})[ T](\d{1,2}):(\d{2})$/);
		if (!m) return null;
		const [, d, mes, anio, hora, min] = m;
		return `${anio}-${mes.padStart(2, '0')}-${d.padStart(2, '0')}T${hora.padStart(2, '0')}:${min}`;
	}

	function alPegar(e: ClipboardEvent) {
		const texto = e.clipboardData?.getData('text') ?? '';
		const parseado = parsearPegado(texto);
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
