<script lang="ts">
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
	import { api } from '$lib/api/client';
	import { limpiarPersonaje } from '$lib/personaje.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import PapelPicado from '$lib/components/PapelPicado.svelte';
	import type { NombreIcono } from '$lib/icons';

	async function cerrarSesion() {
		await api.cerrarSesion();
		limpiarPersonaje();
		await goto('/login');
	}

	const itemsOperativa: { href: string; label: string; icon: NombreIcono }[] = [
		{ href: '/', label: 'Panel', icon: 'layout-dashboard' },
		{ href: '/nuevo', label: 'Nuevo registro', icon: 'plus' },
		{ href: '/listado', label: 'Listado', icon: 'list' },
		{ href: '/reporte', label: 'Reporte semanal', icon: 'bar-chart-2' }
	];

	const itemsAdministrativa: { href: string; label: string; icon: NombreIcono }[] = [
		{ href: '/mesas', label: 'Resumen', icon: 'layout-dashboard' },
		{ href: '/mesas/nueva', label: 'Nueva mesa', icon: 'plus' },
		{ href: '/mesas/listado', label: 'Listado', icon: 'list' },
		{ href: '/mesas/manual', label: 'Manual', icon: 'book-open' }
	];

	const itemsRpg: { href: string; label: string; icon: NombreIcono }[] = [
		{ href: '/personaje', label: 'Mi personaje', icon: 'shield' },
		{ href: '/jefe', label: 'Jefe semanal', icon: 'skull' },
		{ href: '/tienda', label: 'Tienda', icon: 'shopping-bag' },
		{ href: '/mascotas', label: 'Mascotas', icon: 'trophy' },
		{ href: '/hub', label: 'En línea', icon: 'circle' },
		{ href: '/chat', label: 'Chat', icon: 'message-circle' }
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
	<div class="franja-patria" aria-hidden="true"><span></span><span></span><span></span></div>
	<div class="marca">
		<span class="marca-icono"><Icon nombre="anchor" tamano={18} /></span>
		<span class="font-display marca-texto">Bitácora ASIPONA</span>
	</div>
	<PapelPicado cantidad={9} />

	<div class="secciones">
		{#each grupos as grupo}
			<div class="seccion">
				<button
					type="button"
					class="seccion-titulo"
					onclick={() => alternarSeccion(grupo.clave)}
					aria-expanded={!colapsadas[grupo.clave]}
				>
					<span>{grupo.titulo}</span>
					<span class="chevron" class:girado={colapsadas[grupo.clave]} aria-hidden="true">
						<Icon nombre="chevron-down" tamano={12} />
					</span>
				</button>
				{#if !colapsadas[grupo.clave]}
					<nav>
						{#each grupo.items as item}
							<a href={item.href} class:activo={$page.url.pathname === item.href}>
								<span class="icono"><Icon nombre={item.icon} tamano={16} /></span>
								{item.label}
							</a>
						{/each}
					</nav>
				{/if}
			</div>
		{/each}
	</div>

	<button type="button" class="cerrar-sesion" onclick={cerrarSesion}>
		<span class="icono"><Icon nombre="power" tamano={16} /></span>
		Cerrar sesión
	</button>
</aside>

<style>
	.nav {
		width: var(--nav-width);
		flex-shrink: 0;
		background: var(--bg);
		display: flex;
		flex-direction: column;
		height: 100vh;
		position: sticky;
		top: 0;
		overflow-y: auto;
		padding: 0 12px 16px;
	}

	.marca {
		display: flex;
		align-items: center;
		gap: 10px;
		padding: 20px 8px 18px;
		font-size: 15px;
	}

	.marca-icono {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 30px;
		height: 30px;
		border-radius: var(--radius);
		background: var(--accent-gradient);
		color: white;
		flex-shrink: 0;
	}

	.marca-texto {
		flex: 1;
		min-width: 0;
	}

	.secciones {
		flex: 1;
		display: flex;
		flex-direction: column;
		gap: 4px;
	}

	.seccion-titulo {
		display: flex;
		align-items: center;
		justify-content: space-between;
		width: 100%;
		padding: 12px 10px 6px;
		background: none;
		border: none;
		font-size: 11px;
		text-transform: uppercase;
		letter-spacing: 0.06em;
		color: var(--text-faint);
		cursor: pointer;
	}

	.seccion-titulo:hover {
		color: var(--text-muted);
	}

	.chevron {
		display: flex;
		transition: transform 0.15s ease;
	}

	.chevron.girado {
		transform: rotate(-90deg);
	}

	nav {
		display: flex;
		flex-direction: column;
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
		transition:
			background 0.15s ease,
			color 0.15s ease;
	}

	nav a:hover {
		background: var(--surface);
		color: var(--text);
	}

	nav a:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: -2px;
	}

	nav a.activo {
		background: var(--accent-gradient);
		color: white;
		box-shadow: var(--shadow-accent);
	}

	.icono {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 16px;
		color: var(--text-faint);
	}

	nav a.activo .icono {
		color: white;
	}

	.cerrar-sesion {
		display: flex;
		align-items: center;
		gap: 10px;
		width: 100%;
		margin-top: 12px;
		padding: 9px 10px;
		border: none;
		border-radius: var(--radius);
		background: none;
		color: var(--text-faint);
		font-size: 13px;
		cursor: pointer;
	}

	.cerrar-sesion:hover {
		background: var(--surface);
		color: var(--danger);
	}

	.cerrar-sesion:hover .icono {
		color: var(--danger);
	}
</style>
