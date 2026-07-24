<script lang="ts">
	let {
		tipo,
		children,
		accion
	}: {
		tipo: 'ok' | 'error' | 'pendiente';
		children: import('svelte').Snippet;
		accion?: { texto: string; onClick: () => void };
	} = $props();
</script>

<div class="toast" data-tipo={tipo} role="status">
	<span class="icono" aria-hidden="true">
		{#if tipo === 'ok'}✓{:else if tipo === 'error'}✕{:else}…{/if}
	</span>
	<span class="mensaje">{@render children()}</span>
	{#if accion}
		<button type="button" class="accion" onclick={accion.onClick}>{accion.texto}</button>
	{/if}
</div>

<style>
	.toast {
		display: flex;
		align-items: center;
		gap: 10px;
		padding: 10px 14px;
		border-radius: var(--radius);
		border: 1px solid var(--border-strong);
		background: var(--surface-raised);
		font-size: 13px;
	}

	.toast[data-tipo='ok'] {
		border-color: color-mix(in srgb, var(--success) 50%, var(--border-strong));
	}

	.toast[data-tipo='ok'] .icono {
		color: var(--success);
	}

	.toast[data-tipo='error'] {
		border-color: color-mix(in srgb, var(--warning) 50%, var(--border-strong));
	}

	.toast[data-tipo='error'] .icono {
		color: var(--warning);
	}

	.toast[data-tipo='pendiente'] .icono {
		color: var(--text-muted);
	}

	.mensaje {
		flex: 1;
	}

	.accion {
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 4px 10px;
		color: var(--text);
		cursor: pointer;
	}

	.accion:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}
</style>
