<script lang="ts">
	import type { Snippet } from 'svelte';
	import Icon from '$lib/components/Icon.svelte';
	import type { NombreIcono } from '$lib/icons';

	let {
		label,
		value,
		loading = false,
		icono = undefined,
		nota = '',
		destacada = false,
		children = undefined
	}: {
		label: string;
		value: number | string;
		loading?: boolean;
		icono?: NombreIcono;
		nota?: string;
		destacada?: boolean;
		children?: Snippet;
	} = $props();
</script>

<div class="tile" class:destacada>
	{#if icono}
		<span class="chip-icono"><Icon nombre={icono} tamano={16} /></span>
	{/if}
	<span class="label">{label}</span>
	{#if loading}
		<span class="skeleton skeleton-valor" aria-hidden="true"></span>
	{:else}
		<span class="valor font-display">{value}</span>
	{/if}
	{#if nota}<span class="nota">{nota}</span>{/if}
	{#if children}{@render children()}{/if}
</div>

<style>
	.tile {
		padding: 16px 18px;
		display: flex;
		flex-direction: column;
		gap: 6px;
		min-width: 140px;
	}

	/* la tarjeta destacada es la única superficie con gradiente: marca de un
	   vistazo cuál es la cifra principal de la pantalla */
	.tile.destacada {
		background: var(--accent-gradient);
		border-color: transparent;
		box-shadow: var(--shadow-accent);
		color: white;
	}

	.chip-icono {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 32px;
		height: 32px;
		margin-bottom: 4px;
		border-radius: var(--radius);
		background: var(--accent-soft);
		color: var(--accent-strong);
	}

	.destacada .chip-icono {
		background: oklch(1 0 0 / 0.18);
		color: white;
	}

	.label {
		font-size: 12px;
		color: var(--text-muted);
	}

	.destacada .label,
	.destacada .nota {
		color: oklch(1 0 0 / 0.82);
	}

	.valor {
		font-size: 28px;
		font-weight: 700;
		line-height: 1.15;
	}

	.nota {
		font-size: 12px;
		color: var(--text-faint);
	}

	.skeleton-valor {
		height: 28px;
		width: 60px;
		border-radius: var(--radius-sm);
	}
</style>
