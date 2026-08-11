<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Personaje3D from '$lib/components/Personaje3D.svelte';
	import { ACCESORIOS } from '$lib/apariencia';
	import { api, type Accesorio, type Catalogo, type EventoXp, type Personaje, type RankingItem } from '$lib/api/client';
	import { actualizarPersonaje } from '$lib/personaje.svelte';

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
	let agentes = $state<Catalogo[]>([]);
	let resolutores = $state<Catalogo[]>([]);
	let agenteSeleccionado = $state<number | null>(null);
	let resolutorSeleccionado = $state<number | null>(null);
	let vinculando = $state(false);
	let errorVinculo = $state<string | null>(null);
	let cargando = $state(true);

	let colorPielEdit = $state('#f2c9a1');
	let colorCuerpoEdit = $state('#3b82f6');
	let accesorioEdit = $state<Accesorio>('ninguno');
	let inicializadoApariencia = $state(false);
	let guardandoApariencia = $state(false);
	let errorApariencia = $state<string | null>(null);
	let okApariencia = $state(false);

	$effect(() => {
		if (!personaje || inicializadoApariencia) return;
		colorPielEdit = personaje.color_piel;
		colorCuerpoEdit = personaje.color_cuerpo;
		accesorioEdit = personaje.accesorio;
		inicializadoApariencia = true;
	});

	async function guardarApariencia() {
		errorApariencia = null;
		okApariencia = false;
		guardandoApariencia = true;
		try {
			personaje = await api.actualizarApariencia({
				color_piel: colorPielEdit,
				color_cuerpo: colorCuerpoEdit,
				accesorio: accesorioEdit
			});
			actualizarPersonaje(personaje);
			okApariencia = true;
		} catch (e) {
			errorApariencia = e instanceof Error ? e.message : 'No se pudo guardar la apariencia';
		} finally {
			guardandoApariencia = false;
		}
	}

	async function cargar() {
		cargando = true;
		try {
			[personaje, historial, ranking, agentes, resolutores] = await Promise.all([
				api.miPersonaje(),
				api.miHistorial(),
				api.ranking(),
				api.catalogo('agentes'),
				api.catalogo('resolutores-mesa')
			]);
			actualizarPersonaje(personaje);
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

	const agenteVinculado = $derived(agentes.find((a) => a.usuario_id === personaje?.id) ?? null);
	const resolutorVinculado = $derived(resolutores.find((r) => r.usuario_id === personaje?.id) ?? null);

	async function recargarCatalogosVinculo() {
		[agentes, resolutores] = await Promise.all([api.catalogo('agentes'), api.catalogo('resolutores-mesa')]);
	}

	async function vincular(tipo: 'agentes' | 'resolutores-mesa', id: number | null) {
		if (!id) return;
		errorVinculo = null;
		vinculando = true;
		try {
			await api.vincularCatalogo(tipo, id);
			await recargarCatalogosVinculo();
		} catch (e) {
			errorVinculo = e instanceof Error ? e.message : 'No se pudo vincular';
		} finally {
			vinculando = false;
		}
	}

	async function desvincular(tipo: 'agentes' | 'resolutores-mesa', id: number) {
		errorVinculo = null;
		try {
			await api.desvincularCatalogo(tipo, id);
			await recargarCatalogosVinculo();
		} catch (e) {
			errorVinculo = e instanceof Error ? e.message : 'No se pudo desvincular';
		}
	}
</script>

<Header titulo="Mi personaje" subtitulo="Nivel, XP y actividad reciente." />

{#if cargando}
	<p class="cargando">Cargando personaje…</p>
{:else if personaje}
	<div class="columnas">
		<section class="tarjeta ficha">
			<Personaje3D colorPiel={colorPielEdit} colorCuerpo={colorCuerpoEdit} accesorio={accesorioEdit} tamano={200} />
			<h2 class="font-display">{personaje.nombre}</h2>
			<span class="titulo-nivel">Nivel {personaje.nivel} · {personaje.titulo}</span>
			<div class="barra-xp" title="{personaje.xp_en_nivel_actual} / {personaje.xp_para_siguiente_nivel} XP">
				<div class="barra-xp-relleno" style="width: {porcentajeXp}%"></div>
			</div>
			<span class="xp-detalle">
				{personaje.xp_en_nivel_actual} / {personaje.xp_para_siguiente_nivel} XP para el siguiente nivel ·
				{personaje.xp} XP total
			</span>

			<div class="personalizar">
				<div class="fila-personalizar">
					<label>
						Piel
						<input type="color" bind:value={colorPielEdit} />
					</label>
					<label>
						Ropa
						<input type="color" bind:value={colorCuerpoEdit} />
					</label>
				</div>
				<label class="campo-accesorio">
					Accesorio
					<select bind:value={accesorioEdit}>
						{#each ACCESORIOS as opcion}
							<option value={opcion.valor}>{opcion.etiqueta}</option>
						{/each}
					</select>
				</label>
				<button type="button" class="btn-guardar-apariencia" disabled={guardandoApariencia} onclick={guardarApariencia}>
					{guardandoApariencia ? 'Guardando…' : 'Guardar apariencia'}
				</button>
				{#if okApariencia}<p class="ok-apariencia">Apariencia guardada.</p>{/if}
				{#if errorApariencia}<p class="error-apariencia">{errorApariencia}</p>{/if}
			</div>
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

		<section class="tarjeta vincular">
			<h2 class="font-display">Vincular tu cuenta</h2>
			<p class="ayuda-vincular">
				Si tu nombre de agente/resolutor no es igual al de tu cuenta, vincúlalo aquí para que el XP te llegue.
			</p>

			<div class="campo-vincular">
				<span class="etiqueta-vinculo">Agente (soporte)</span>
				{#if agenteVinculado}
					<div class="vinculo-actual">
						<span>{agenteVinculado.nombre}</span>
						<button type="button" onclick={() => desvincular('agentes', agenteVinculado.id)}>Desvincular</button>
					</div>
				{:else}
					<div class="elegir-vinculo">
						<select bind:value={agenteSeleccionado}>
							<option value={null} disabled selected>Selecciona…</option>
							{#each agentes as a}
								<option value={a.id}>{a.nombre}</option>
							{/each}
						</select>
						<button
							type="button"
							disabled={vinculando || !agenteSeleccionado}
							onclick={() => vincular('agentes', agenteSeleccionado)}
						>
							Vincular
						</button>
					</div>
				{/if}
			</div>

			<div class="campo-vincular">
				<span class="etiqueta-vinculo">Resolutor (mesas)</span>
				{#if resolutorVinculado}
					<div class="vinculo-actual">
						<span>{resolutorVinculado.nombre}</span>
						<button type="button" onclick={() => desvincular('resolutores-mesa', resolutorVinculado.id)}>
							Desvincular
						</button>
					</div>
				{:else}
					<div class="elegir-vinculo">
						<select bind:value={resolutorSeleccionado}>
							<option value={null} disabled selected>Selecciona…</option>
							{#each resolutores as r}
								<option value={r.id}>{r.nombre}</option>
							{/each}
						</select>
						<button
							type="button"
							disabled={vinculando || !resolutorSeleccionado}
							onclick={() => vincular('resolutores-mesa', resolutorSeleccionado)}
						>
							Vincular
						</button>
					</div>
				{/if}
			</div>

			{#if errorVinculo}
				<p class="error-vinculo">{errorVinculo}</p>
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

	.personalizar {
		width: 100%;
		margin-top: 18px;
		padding-top: 16px;
		border-top: 1px solid var(--border);
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.fila-personalizar {
		display: flex;
		gap: 16px;
		justify-content: center;
	}

	.personalizar label {
		display: flex;
		flex-direction: column;
		gap: 4px;
		font-size: 11px;
		color: var(--text-muted);
	}

	.campo-accesorio {
		align-items: center;
	}

	.personalizar input[type='color'] {
		width: 44px;
		height: 32px;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		background: var(--surface);
		padding: 2px;
		cursor: pointer;
	}

	.personalizar select {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 7px 10px;
		color: var(--text);
	}

	.personalizar select option {
		background: var(--bg);
		color: var(--text);
	}

	.btn-guardar-apariencia {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 8px 16px;
		font-weight: 600;
		font-size: 13px;
		cursor: pointer;
	}

	.btn-guardar-apariencia:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.btn-guardar-apariencia:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.ok-apariencia {
		color: var(--success);
		font-size: 12px;
		margin: 0;
	}

	.error-apariencia {
		color: var(--danger);
		font-size: 12px;
		margin: 0;
	}

	.vincular {
		grid-column: 1 / -1;
	}

	.ayuda-vincular {
		color: var(--text-muted);
		font-size: 12px;
		margin: 0 0 14px;
	}

	.campo-vincular {
		display: flex;
		align-items: center;
		gap: 12px;
		padding: 10px 0;
		border-bottom: 1px solid var(--border);
	}

	.campo-vincular:last-of-type {
		border-bottom: none;
	}

	.etiqueta-vinculo {
		width: 140px;
		flex-shrink: 0;
		font-size: 13px;
		color: var(--text-muted);
	}

	.vinculo-actual,
	.elegir-vinculo {
		display: flex;
		align-items: center;
		gap: 8px;
		flex: 1;
	}

	.vinculo-actual span {
		font-size: 13px;
		font-weight: 600;
	}

	.campo-vincular select {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 7px 10px;
		color: var(--text);
		min-width: 200px;
	}

	.campo-vincular select option {
		background: var(--bg);
		color: var(--text);
	}

	.campo-vincular button {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 7px 12px;
		color: var(--text);
		font-size: 12px;
		cursor: pointer;
	}

	.campo-vincular button:hover:not(:disabled) {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.campo-vincular button:disabled {
		opacity: 0.5;
		cursor: default;
	}

	.error-vinculo {
		color: var(--danger);
		font-size: 12px;
		margin: 10px 0 0;
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
