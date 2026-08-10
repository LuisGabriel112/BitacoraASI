<script lang="ts">
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
	import { semanaActual } from '$lib/semana';
	import { api, type Personaje } from '$lib/api/client';

	const semana = semanaActual();
	let personaje = $state<Personaje | null>(null);

	async function cargarPersonaje() {
		try {
			personaje = await api.miPersonaje();
		} catch {
			personaje = null;
		}
	}

	$effect(() => {
		cargarPersonaje();
	});

	async function cerrarSesion() {
		await api.cerrarSesion();
		personaje = null;
		await goto('/login');
	}

	const itemsOperativa = [
		{ href: '/', label: 'Panel', icon: '▤' },
		{ href: '/nuevo', label: 'Nuevo registro', icon: '＋' },
		{ href: '/listado', label: 'Listado', icon: '☰' },
		{ href: '/reporte', label: 'Reporte semanal', icon: '▥' }
	];

	const itemsAdministrativa = [
		{ href: '/mesas', label: 'Resumen', icon: '▤' },
		{ href: '/mesas/nueva', label: 'Nueva mesa', icon: '＋' },
		{ href: '/mesas/listado', label: 'Listado', icon: '☰' }
	];

	const itemsRpg = [
		{ href: '/personaje', label: 'Mi personaje', icon: '🛡' },
		{ href: '/jefe', label: 'Jefe semanal', icon: '👹' },
		{ href: '/hub', label: 'En línea', icon: '🟢' },
		{ href: '/chat', label: 'Chat', icon: '💬' }
	];

	const grupos = [
		{ clave: 'operativa', titulo: 'Bitácora operativa', items: itemsOperativa },
		{ clave: 'administrativa', titulo: 'Bitácora administrativa', items: itemsAdministrativa },
		{ clave: 'rpg', titulo: 'Modo RPG', items: itemsRpg }
	];

	const CLAVE_ALMACENAMIENTO = 'bitacora-nav-colapsadas';

	function cargarColapsadas(): Record<string, boolean> {
		if (typeof localStorage === 'undefined') return {};
		try {
			return JSON.parse(localStorage.getItem(CLAVE_ALMACENAMIENTO) ?? '{}');
		} catch {
			return {};
		}
	}

	let colapsadas = $state<Record<string, boolean>>(cargarColapsadas());

	function alternarSeccion(clave: string) {
		colapsadas = { ...colapsadas, [clave]: !colapsadas[clave] };
		localStorage.setItem(CLAVE_ALMACENAMIENTO, JSON.stringify(colapsadas));
	}
</script>

<aside class="nav">
	<div class="marca">
		<span class="marca-icono">⚓</span>
		<span class="font-display marca-texto">Bitácora ASIPONA</span>
	</div>

	<div class="semana-actual" title="Semana ISO en curso">
		<span class="semana-label">{semana.etiqueta}</span>
		<div class="semana-barra">
			<div class="semana-progreso" style="width: {semana.progreso * 100}%"></div>
		</div>
	</div>

	{#if personaje}
		<div class="personaje-badge">
			<span class="personaje-avatar" aria-hidden="true">{personaje.avatar}</span>
			<div class="personaje-info">
				<span class="personaje-nombre">{personaje.nombre}</span>
				<span class="personaje-nivel">Nv. {personaje.nivel} · {personaje.titulo}</span>
			</div>
			<button type="button" class="cerrar-sesion" onclick={cerrarSesion} title="Cerrar sesión" aria-label="Cerrar sesión">
				⏻
			</button>
		</div>
	{/if}

	{#each grupos as grupo, i}
		<div class="seccion" class:primero={i === 0}>
			<button
				type="button"
				class="seccion-titulo"
				onclick={() => alternarSeccion(grupo.clave)}
				aria-expanded={!colapsadas[grupo.clave]}
			>
				<span>{grupo.titulo}</span>
				<span class="chevron" class:girado={colapsadas[grupo.clave]} aria-hidden="true">▾</span>
			</button>
			{#if !colapsadas[grupo.clave]}
				<nav>
					{#each grupo.items as item}
						<a href={item.href} class:activo={$page.url.pathname === item.href}>
							<span class="icono" aria-hidden="true">{item.icon}</span>
							{item.label}
						</a>
					{/each}
				</nav>
			{/if}
		</div>
	{/each}
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
		overflow-y: auto;
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

	.marca-texto {
		flex: 1;
		min-width: 0;
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

	.personaje-badge {
		display: flex;
		align-items: center;
		gap: 8px;
		padding: 12px 16px;
		border-bottom: 1px solid var(--border);
	}

	.personaje-avatar {
		font-size: 20px;
		flex-shrink: 0;
	}

	.personaje-info {
		display: flex;
		flex-direction: column;
		min-width: 0;
		flex: 1;
	}

	.personaje-nombre {
		font-size: 13px;
		font-weight: 600;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.personaje-nivel {
		font-size: 11px;
		color: var(--text-muted);
	}

	.cerrar-sesion {
		background: none;
		border: none;
		color: var(--text-faint);
		cursor: pointer;
		font-size: 14px;
		padding: 4px;
		flex-shrink: 0;
	}

	.cerrar-sesion:hover {
		color: var(--danger);
	}

	nav {
		display: flex;
		flex-direction: column;
		padding: 4px 8px 12px;
		gap: 2px;
	}

	.seccion {
		opacity: 0.72;
		transition: opacity 0.15s ease;
	}

	.seccion:hover,
	.seccion:focus-within {
		opacity: 1;
	}

	.seccion-titulo {
		display: flex;
		align-items: center;
		justify-content: space-between;
		width: 100%;
		padding: 10px 18px 4px;
		background: none;
		border: none;
		border-top: 1px solid var(--border);
		margin-top: 4px;
		font-size: 11px;
		text-transform: uppercase;
		letter-spacing: 0.04em;
		color: var(--text-faint);
		cursor: pointer;
	}

	.seccion.primero .seccion-titulo {
		border-top: none;
		margin-top: 0;
	}

	.seccion-titulo:hover {
		color: var(--text-muted);
	}

	.chevron {
		font-size: 9px;
		transition: transform 0.15s ease;
	}

	.chevron.girado {
		transform: rotate(-90deg);
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

	/* fondo más opaco que var(--surface-raised): el blob decorativo del fondo
	   usa el mismo var(--accent) que este highlight, y a través del glass del
	   nav ambos se mezclaban en un bloque de color confuso en modo oscuro. */
	nav a.activo {
		background: color-mix(in oklch, var(--bg) 55%, var(--surface-raised));
		color: var(--accent);
		box-shadow: inset 3px 0 0 var(--accent);
	}

	.icono {
		width: 16px;
		text-align: center;
		color: var(--text-faint);
	}

	nav a.activo .icono {
		color: var(--accent);
	}
</style>
