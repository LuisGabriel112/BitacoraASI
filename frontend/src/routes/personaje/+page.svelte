<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import { api, type EventoXp, type Personaje, type RankingItem } from '$lib/api/client';

	const MOTIVOS: Record<string, string> = {
		registro_creado: 'Registro de soporte creado',
		mesa_creada: 'Mesa creada',
		mesa_cerrada: 'Mesa cerrada'
	};

	function etiquetaMotivo(motivo: string) {
		return MOTIVOS[motivo] ?? motivo;
	}

	function fechaCorta(iso: string) {
		return new Date(iso).toLocaleString('es-MX', {
			day: '2-digit',
			month: '2-digit',
			hour: '2-digit',
			minute: '2-digit'
		});
	}

	let personaje = $state<Personaje | null>(null);
	let historial = $state<EventoXp[]>([]);
	let ranking = $state<RankingItem[]>([]);
	let cargando = $state(true);

	async function cargar() {
		cargando = true;
		try {
			[personaje, historial, ranking] = await Promise.all([
				api.miPersonaje(),
				api.miHistorial(),
				api.ranking()
			]);
		} finally {
			cargando = false;
		}
	}

	$effect(() => {
		cargar();
	});

	const porcentajeXp = $derived(
		personaje ? Math.min(100, (personaje.xp_en_nivel_actual / personaje.xp_para_siguiente_nivel) * 100) : 0
	);
</script>

<Header titulo="Mi personaje" subtitulo="Nivel, XP y actividad reciente." />

{#if cargando}
	<p class="cargando">Cargando personaje…</p>
{:else if personaje}
	<div class="columnas">
		<section class="tarjeta ficha">
			<span class="avatar-grande" aria-hidden="true">{personaje.avatar}</span>
			<h2 class="font-display">{personaje.nombre}</h2>
			<span class="titulo-nivel">Nivel {personaje.nivel} · {personaje.titulo}</span>
			<div class="barra-xp" title="{personaje.xp_en_nivel_actual} / {personaje.xp_para_siguiente_nivel} XP">
				<div class="barra-xp-relleno" style="width: {porcentajeXp}%"></div>
			</div>
			<span class="xp-detalle">
				{personaje.xp_en_nivel_actual} / {personaje.xp_para_siguiente_nivel} XP para el siguiente nivel ·
				{personaje.xp} XP total
			</span>
		</section>

		<section class="tarjeta historial">
			<h2 class="font-display">Actividad reciente</h2>
			{#if historial.length === 0}
				<p class="sin-datos">Todavía no hay XP registrado.</p>
			{:else}
				<ul class="lista-eventos">
					{#each historial as evento}
						<li>
							<span class="evento-motivo">{etiquetaMotivo(evento.motivo)}</span>
							<span class="evento-xp">+{evento.cantidad} XP</span>
							<span class="evento-fecha">{fechaCorta(evento.created_at)}</span>
						</li>
					{/each}
				</ul>
			{/if}
		</section>

		<section class="tarjeta ranking">
			<h2 class="font-display">Ranking</h2>
			{#if ranking.length === 0}
				<p class="sin-datos">Todavía no hay personajes registrados.</p>
			{:else}
				<ol class="lista-ranking">
					{#each ranking as item, i}
						<li class:propio={item.nombre === personaje.nombre}>
							<span class="ranking-puesto">{i + 1}</span>
							<span class="ranking-avatar" aria-hidden="true">{item.avatar}</span>
							<span class="ranking-nombre">{item.nombre}</span>
							<span class="ranking-nivel">Nv. {item.nivel}</span>
							<span class="ranking-xp">{item.xp} XP</span>
						</li>
					{/each}
				</ol>
			{/if}
		</section>
	</div>
{/if}

<style>
	.cargando,
	.sin-datos {
		color: var(--text-muted);
	}

	.columnas {
		display: grid;
		grid-template-columns: minmax(240px, 320px) 1fr;
		grid-template-rows: auto auto;
		gap: 18px;
	}

	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 20px;
	}

	.tarjeta h2 {
		font-size: 14px;
		margin: 0 0 14px;
		color: var(--text-muted);
	}

	.ficha {
		grid-row: span 2;
		display: flex;
		flex-direction: column;
		align-items: center;
		text-align: center;
		gap: 6px;
	}

	.avatar-grande {
		font-size: 48px;
	}

	.ficha h2 {
		margin: 4px 0 0;
		color: var(--text);
		font-size: 18px;
	}

	.titulo-nivel {
		color: var(--text-muted);
		font-size: 13px;
		margin-bottom: 10px;
	}

	.barra-xp {
		width: 100%;
		height: 10px;
		background: var(--border);
		border-radius: 999px;
		overflow: hidden;
	}

	.barra-xp-relleno {
		height: 100%;
		background: var(--accent);
		transition: width 0.3s ease;
	}

	.xp-detalle {
		font-size: 11px;
		color: var(--text-faint);
		margin-top: 8px;
	}

	.lista-eventos {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.lista-eventos li {
		display: flex;
		align-items: center;
		gap: 10px;
		font-size: 13px;
		padding-bottom: 10px;
		border-bottom: 1px solid var(--border);
	}

	.lista-eventos li:last-child {
		border-bottom: none;
		padding-bottom: 0;
	}

	.evento-motivo {
		flex: 1;
	}

	.evento-xp {
		color: var(--success);
		font-weight: 600;
		font-size: 12px;
	}

	.evento-fecha {
		color: var(--text-faint);
		font-size: 11px;
	}

	.lista-ranking {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 8px;
	}

	.lista-ranking li {
		display: flex;
		align-items: center;
		gap: 10px;
		font-size: 13px;
		padding: 6px 8px;
		border-radius: var(--radius);
	}

	.lista-ranking li.propio {
		background: color-mix(in srgb, var(--accent) 12%, transparent);
	}

	.ranking-puesto {
		width: 20px;
		color: var(--text-faint);
		font-family: var(--font-mono);
	}

	.ranking-avatar {
		font-size: 16px;
	}

	.ranking-nombre {
		flex: 1;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.ranking-nivel {
		color: var(--text-muted);
		font-size: 12px;
	}

	.ranking-xp {
		color: var(--text-faint);
		font-size: 12px;
		min-width: 60px;
		text-align: right;
	}

	@media (max-width: 720px) {
		.columnas {
			grid-template-columns: 1fr;
		}

		.ficha {
			grid-row: auto;
		}
	}
</style>
