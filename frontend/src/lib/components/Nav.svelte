<script lang="ts">
	import { page } from '$app/stores';
	import { semanaActual } from '$lib/semana';

	const semana = semanaActual();

	const items = [
		{ href: '/', label: 'Panel', icon: '▤' },
		{ href: '/nuevo', label: 'Nuevo registro', icon: '＋' },
		{ href: '/listado', label: 'Listado', icon: '☰' },
		{ href: '/reporte', label: 'Reporte semanal', icon: '▥' }
	];
</script>

<aside class="nav">
	<div class="marca">
		<span class="marca-icono">⚓</span>
		<span class="font-display">Bitácora ASIPONA</span>
	</div>

	<div class="semana-actual" title="Semana ISO en curso">
		<span class="semana-label">{semana.etiqueta}</span>
		<div class="semana-barra">
			<div class="semana-progreso" style="width: {semana.progreso * 100}%"></div>
		</div>
	</div>

	<nav>
		{#each items as item}
			<a href={item.href} class:activo={$page.url.pathname === item.href}>
				<span class="icono" aria-hidden="true">{item.icon}</span>
				{item.label}
			</a>
		{/each}
	</nav>
</aside>

<style>
	.nav {
		width: var(--nav-width);
		flex-shrink: 0;
		background: var(--surface);
		border-right: 1px solid var(--border);
		display: flex;
		flex-direction: column;
		height: 100vh;
		position: sticky;
		top: 0;
	}

	.marca {
		display: flex;
		align-items: center;
		gap: 8px;
		padding: 18px 16px;
		font-size: 15px;
		border-bottom: 1px solid var(--border);
	}

	.marca-icono {
		color: var(--accent-strong);
	}

	.semana-actual {
		padding: 14px 16px;
		border-bottom: 1px solid var(--border);
	}

	.semana-label {
		display: block;
		font-family: var(--font-mono);
		font-weight: 600;
		font-size: 15px;
		letter-spacing: 0.02em;
		margin-bottom: 8px;
	}

	.semana-barra {
		height: 4px;
		background: var(--border);
		border-radius: 2px;
		overflow: hidden;
	}

	.semana-progreso {
		height: 100%;
		background: var(--success);
		transition: width 0.3s ease;
	}

	nav {
		display: flex;
		flex-direction: column;
		padding: 12px 8px;
		gap: 2px;
	}

	nav a {
		display: flex;
		align-items: center;
		gap: 10px;
		padding: 9px 10px;
		border-radius: var(--radius);
		text-decoration: none;
		color: var(--text-muted);
		font-size: 13px;
	}

	nav a:hover {
		background: var(--surface-raised);
		color: var(--text);
	}

	nav a:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: -2px;
	}

	nav a.activo {
		background: var(--surface-raised);
		color: var(--text);
		box-shadow: inset 2px 0 0 var(--accent-strong);
	}

	.icono {
		width: 16px;
		text-align: center;
		color: var(--text-faint);
	}

	nav a.activo .icono {
		color: var(--accent-strong);
	}
</style>
