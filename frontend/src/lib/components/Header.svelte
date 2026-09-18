<script lang="ts">
	import { semanaActual } from '$lib/semana';
	import ThemeToggle from '$lib/components/ThemeToggle.svelte';
	import Reloj from '$lib/components/Reloj.svelte';
	import { estadoPersonaje } from '$lib/personaje.svelte';

	let { titulo, subtitulo = '' }: { titulo: string; subtitulo?: string } = $props();

	const semana = semanaActual();
	const personaje = $derived(estadoPersonaje.actual);
</script>

<header class="header">
	<div class="titulos">
		<h1 class="font-display">{titulo}</h1>
		{#if subtitulo}<p class="subtitulo">{subtitulo}</p>{/if}
	</div>

	<div class="acciones">
		<div class="reloj-chip"><Reloj /></div>

		<div class="badge-semana" title="Semana ISO en curso">
			<span class="semana-etiqueta">{semana.etiqueta}</span>
			<div class="semana-barra">
				<div class="semana-progreso" style="transform: scaleX({semana.progreso})"></div>
			</div>
		</div>

		<ThemeToggle />

		<a href="/personaje" class="usuario" title="Mi personaje">
			<span class="avatar" aria-hidden="true">{personaje?.avatar ?? '🙂'}</span>
			<span class="usuario-texto">
				<span class="usuario-nombre">{personaje?.nombre ?? 'Mi personaje'}</span>
				<span class="usuario-nivel">
					{personaje ? `Nv. ${personaje.nivel} · ${personaje.titulo}` : 'Sin personaje'}
				</span>
			</span>
		</a>
	</div>
</header>

<style>
	.header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 16px;
		margin-bottom: 24px;
		padding-bottom: 16px;
		border-bottom: 1px solid var(--border);
		flex-wrap: wrap;
	}

	.titulos h1 {
		margin: 0;
		font-size: 22px;
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

	.reloj-chip {
		padding: 6px 14px;
		border-radius: var(--radius);
		background: var(--surface);
		border: 1px solid var(--border);
	}

	.badge-semana {
		display: flex;
		flex-direction: column;
		gap: 6px;
		min-width: 104px;
		padding: 8px 14px;
		border: 1px solid var(--border);
		border-radius: var(--radius);
	}

	.semana-etiqueta {
		font-family: var(--font-mono);
		font-size: 12px;
		font-weight: 600;
		color: var(--text-muted);
	}

	.semana-barra {
		height: 3px;
		background: var(--border);
		border-radius: var(--radius-pill);
		overflow: hidden;
	}

	.semana-progreso {
		width: 100%;
		height: 100%;
		background: var(--success);
		transform-origin: left;
		transition: transform 0.3s ease;
	}

	.usuario {
		display: flex;
		align-items: center;
		gap: 10px;
		padding: 5px 14px 5px 5px;
		border-radius: var(--radius-pill);
		background: var(--surface);
		border: 1px solid var(--border);
		text-decoration: none;
	}

	.usuario:hover {
		border-color: var(--accent);
	}

	.avatar {
		width: 32px;
		height: 32px;
		border-radius: 50%;
		background: var(--accent-gradient);
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 16px;
		flex-shrink: 0;
	}

	.usuario-texto {
		display: flex;
		flex-direction: column;
		line-height: 1.25;
	}

	.usuario-nombre {
		font-size: 13px;
		font-weight: 600;
	}

	.usuario-nivel {
		font-size: 11px;
		color: var(--text-muted);
	}

	@media (max-width: 720px) {
		.reloj-chip,
		.usuario-texto {
			display: none;
		}
	}
</style>
