<script lang="ts">
	import { api } from '$lib/api/client';

	let { semana }: { semana: string } = $props();

	let abierto = $state(false);

	function alternar() {
		abierto = !abierto;
	}

	function cerrar() {
		abierto = false;
	}
</script>

<div class="generar-reporte">
	<button type="button" class="boton-generar" onclick={alternar} disabled={!semana}>
		Generar reporte
	</button>
	{#if abierto}
		<ul class="menu-formato" role="menu">
			<li><a role="menuitem" href={api.exportReporteMesasUrl(semana, 'xlsx')} onclick={cerrar}>Excel</a></li>
			<li><a role="menuitem" href={api.exportReporteMesasUrl(semana, 'pptx')} onclick={cerrar}>PowerPoint</a></li>
			<li><a role="menuitem" href={api.exportReporteMesasUrl(semana, 'pdf')} onclick={cerrar}>PDF</a></li>
		</ul>
	{/if}
</div>

<style>
	.generar-reporte {
		position: relative;
	}

	.boton-generar {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 8px 16px;
		font-weight: 600;
		font-family: var(--font-display);
		font-size: 13px;
		cursor: pointer;
	}

	.boton-generar:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.boton-generar:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.menu-formato {
		position: absolute;
		z-index: 20;
		top: calc(100% + 4px);
		right: 0;
		min-width: 150px;
		background: color-mix(in oklch, var(--bg) 96%, var(--surface-raised));
		backdrop-filter: var(--glass-blur);
		-webkit-backdrop-filter: var(--glass-blur);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		box-shadow: 0 12px 30px -8px oklch(0 0 0 / 0.45);
		list-style: none;
		margin: 0;
		padding: 4px;
	}

	.menu-formato a {
		display: block;
		padding: 8px 10px;
		border-radius: var(--radius);
		color: var(--text);
		text-decoration: none;
		font-size: 13px;
	}

	.menu-formato a:hover {
		background: var(--accent);
		color: var(--bg);
	}
</style>
