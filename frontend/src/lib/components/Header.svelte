<script lang="ts">
	import { semanaActual } from '$lib/semana';
	import ThemeToggle from '$lib/components/ThemeToggle.svelte';

	let { titulo, subtitulo = '' }: { titulo: string; subtitulo?: string } = $props();

	const semana = semanaActual();
</script>

<header class="header">
	<div class="titulos">
		<h1 class="font-display">{titulo}</h1>
		{#if subtitulo}<p class="subtitulo">{subtitulo}</p>{/if}
	</div>
	<div class="acciones">
		<span class="badge-semana" title="Semana ISO en curso">{semana.etiqueta}</span>
		<ThemeToggle />
		<span class="avatar" aria-hidden="true">BA</span>
	</div>
</header>

<style>
	.header {
		display: flex;
		align-items: flex-start;
		justify-content: space-between;
		gap: 16px;
		margin-bottom: 24px;
		flex-wrap: wrap;
	}

	.titulos h1 {
		margin: 0;
	}

	.subtitulo {
		margin: 4px 0 0;
		color: var(--text-muted);
		font-size: 13px;
	}

	.acciones {
		display: flex;
		align-items: center;
		gap: 10px;
	}

	.badge-semana {
		background: var(--glass-bg);
		border: 1px solid var(--glass-border);
		border-radius: var(--radius);
		padding: 8px 14px;
		font-family: var(--font-mono);
		font-size: 12px;
		font-weight: 600;
		color: var(--text-muted);
		backdrop-filter: var(--glass-blur);
		-webkit-backdrop-filter: var(--glass-blur);
	}

	.avatar {
		width: 36px;
		height: 36px;
		border-radius: 50%;
		background: var(--accent);
		color: var(--bg);
		display: flex;
		align-items: center;
		justify-content: center;
		font-family: var(--font-display);
		font-weight: 700;
		font-size: 13px;
		flex-shrink: 0;
	}
</style>
