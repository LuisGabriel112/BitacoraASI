<script lang="ts">
	import { fade } from 'svelte/transition';
	import { api, type SintesisSolucion } from '$lib/api/client';

	let sintesis = $state<SintesisSolucion[]>([]);
	let cargando = $state(true);
	let generando = $state(false);
	let error = $state<string | null>(null);
	let resultado = $state<string | null>(null);

	async function cargar() {
		cargando = true;
		try {
			sintesis = await api.sintesisSoluciones();
		} finally {
			cargando = false;
		}
	}

	async function generar() {
		generando = true;
		error = null;
		resultado = null;
		try {
			const resumen = await api.generarSintesisSoluciones();
			resultado = `${resumen.grupos_generados} patrones generados a partir de ${resumen.mesas_cubiertas} mesas.`;
			await cargar();
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo generar la síntesis';
		} finally {
			generando = false;
		}
	}

	function formatearFecha(iso: string) {
		return new Date(iso).toLocaleDateString('es-MX', { day: '2-digit', month: 'short', year: 'numeric' });
	}

	$effect(() => {
		cargar();
	});
</script>

<div class="cabecera-sintesis">
	<p class="explicacion">
		Patrones sintetizados por IA a partir de soluciones repetidas (misma categoría y tipo de solución).
	</p>
	<button type="button" class="btn-generar" disabled={generando} onclick={generar}>
		{generando ? 'Generando…' : 'Generar síntesis'}
	</button>
</div>

{#if error}<p class="error-sintesis">{error}</p>{/if}
{#if resultado}<p class="resultado-sintesis">{resultado}</p>{/if}

{#if cargando}
	<p class="vacio">Cargando…</p>
{:else if sintesis.length === 0}
	<p class="vacio">Aún no hay síntesis generada. Usa "Generar síntesis" para detectar patrones repetidos.</p>
{:else}
	<div class="lista-sintesis">
		{#each sintesis as s, i}
			<article class="tarjeta-sintesis" in:fade={{ duration: 200, delay: Math.min(i, 12) * 40 }}>
				<div class="badges-manual">
					<span class="badge-manual">{s.categoria.nombre}</span>
					{#if s.tipo_solucion}<span class="badge-manual badge-tipo">{s.tipo_solucion}</span>{/if}
					<span class="badge-manual">{s.cantidad_mesas} mesas</span>
				</div>
				<h2 class="titulo-manual font-display">{s.titulo}</h2>
				<p class="texto-solucion">{s.texto}</p>
				<span class="fecha-generado">Generado el {formatearFecha(s.generado_en)}</span>
			</article>
		{/each}
	</div>
{/if}

<style>
	.cabecera-sintesis {
		display: flex;
		justify-content: space-between;
		align-items: center;
		gap: 14px;
		margin-bottom: 16px;
		flex-wrap: wrap;
	}

	.explicacion {
		color: var(--text-muted);
		font-size: 13px;
		margin: 0;
	}

	.btn-generar {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 8px 16px;
		font-weight: 600;
		font-family: var(--font-display);
		font-size: 13px;
		cursor: pointer;
		white-space: nowrap;
	}

	.btn-generar:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.btn-generar:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.error-sintesis {
		color: var(--danger);
		font-size: 13px;
	}

	.resultado-sintesis {
		color: var(--success);
		font-size: 13px;
	}

	.vacio {
		color: var(--text-muted);
		text-align: center;
		padding: 30px;
	}

	.lista-sintesis {
		display: flex;
		flex-direction: column;
		gap: 16px;
	}

	.tarjeta-sintesis {
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px 20px;
		background: var(--surface);
	}

	.badges-manual {
		display: flex;
		gap: 6px;
		flex-wrap: wrap;
		margin-bottom: 8px;
	}

	.badge-manual {
		font-size: 11px;
		color: var(--text-muted);
		background: var(--surface-raised);
		border-radius: 999px;
		padding: 2px 10px;
	}

	.badge-tipo {
		color: var(--accent-strong);
		background: color-mix(in srgb, var(--accent) 14%, transparent);
	}

	.titulo-manual {
		margin: 0 0 8px;
		font-size: 15px;
	}

	.texto-solucion {
		margin: 0;
		font-size: 13px;
		color: var(--text);
		white-space: pre-wrap;
	}

	.fecha-generado {
		display: block;
		margin-top: 10px;
		font-size: 11px;
		color: var(--text-faint);
	}
</style>
