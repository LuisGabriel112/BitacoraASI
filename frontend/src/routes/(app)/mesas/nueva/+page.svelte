<script lang="ts">
	import { browser } from '$app/environment';
	import ComboboxCreatable from '$lib/components/ComboboxCreatable.svelte';
	import FechaHoraInput from '$lib/components/FechaHoraInput.svelte';
	import Toast from '$lib/components/Toast.svelte';
	import Header from '$lib/components/Header.svelte';
	import CampoGrupo from '$lib/components/CampoGrupo.svelte';
	import LeyendaGrupos from '$lib/components/LeyendaGrupos.svelte';
	import Celebracion from '$lib/components/Celebracion.svelte';
	import type AnimacionExito3D from '$lib/components/AnimacionExito3D.svelte';
	import AvisoResultado from '$lib/components/AvisoResultado.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import { api, type Mesa, type SintesisSolucion } from '$lib/api/client';
	import { sugerenciasParaCategoria } from '$lib/sugerenciasSolucion';
	import { ordenarPorActividadReciente } from '$lib/ordenActividadMesa';
	import { tick } from 'svelte';

	let celebracion: Celebracion;
	let ComponenteAnimacionExito = $state<typeof AnimacionExito3D | null>(null);
	let animacionExito = $state<AnimacionExito3D | undefined>(undefined);
	let aviso: AvisoResultado;
	let comboboxCategoria: ComboboxCreatable;
	let comboboxSolicitante: ComboboxCreatable;
	let comboboxResolutor: ComboboxCreatable;
	let comboboxVentana = $state<ComboboxCreatable | undefined>(undefined);

	function ahora() {
		const d = new Date();
		const pad = (n: number) => String(n).padStart(2, '0');
		return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
	}

	function hace7Dias() {
		const d = new Date();
		d.setDate(d.getDate() - 7);
		return d.toISOString().slice(0, 10);
	}

	const CLAVE_BORRADOR = 'bitacora-nueva-mesa-borrador';

	type Borrador = {
		enlace: string; codigo: string; titulo: string; fechaCarga: string; descripcion: string;
		ventanaId: number | null; ventanaNombre: string; categoriaId: number | null; categoriaNombre: string;
		solicitanteId: number | null; solicitanteNombre: string; resolutorId: number | null; resolutorNombre: string;
		fechaEstimadaResolucion: string; yaResuelta: boolean; solucionTexto: string;
		tipoSolucion: 'Modificación en BD' | 'Seguimiento de proceso'; fechaCierreReal: string;
		medidasImpacto: boolean;
	};

	function leerBorrador(): Partial<Borrador> | null {
		if (!browser) return null;
		try {
			const guardado = sessionStorage.getItem(CLAVE_BORRADOR);
			return guardado ? JSON.parse(guardado) : null;
		} catch {
			return null;
		}
	}

	const borrador = leerBorrador();

	let enlace = $state(borrador?.enlace ?? '');
	let codigo = $state(borrador?.codigo ?? '');
	let titulo = $state(borrador?.titulo ?? '');
	let fechaCarga = $state(borrador?.fechaCarga ?? ahora());
	let descripcion = $state(borrador?.descripcion ?? '');
	let ventanaId = $state<number | null>(borrador?.ventanaId ?? null);
	let ventanaNombre = $state(borrador?.ventanaNombre ?? '');
	let categoriaId = $state<number | null>(borrador?.categoriaId ?? null);
	let categoriaNombre = $state(borrador?.categoriaNombre ?? '');
	let solicitanteId = $state<number | null>(borrador?.solicitanteId ?? null);
	let solicitanteNombre = $state(borrador?.solicitanteNombre ?? '');
	let resolutorId = $state<number | null>(borrador?.resolutorId ?? null);
	let resolutorNombre = $state(borrador?.resolutorNombre ?? '');
	let fechaEstimadaResolucion = $state(borrador?.fechaEstimadaResolucion ?? '');

	let yaResuelta = $state(borrador?.yaResuelta ?? false);
	let solucionTexto = $state(borrador?.solucionTexto ?? '');
	let tipoSolucion = $state<'Modificación en BD' | 'Seguimiento de proceso'>(
		borrador?.tipoSolucion ?? 'Modificación en BD'
	);
	let fechaCierreReal = $state(borrador?.fechaCierreReal ?? ahora());
	let medidasImpacto = $state(borrador?.medidasImpacto ?? false);

	let guardando = $state(false);
	let errorValidacion = $state<string | null>(null);
	let resultado = $state<Mesa | null>(null);
	let errorGuardado = $state<string | null>(null);

	let mesasRecientes = $state<Mesa[]>([]);
	let cargandoRecientes = $state(true);
	let buscarRecientes = $state('');
	let expandidaId = $state<number | null>(null);
	let timerRecientes: ReturnType<typeof setTimeout>;
	let sintesisSoluciones = $state<SintesisSolucion[]>([]);

	$effect(() => {
		if (!browser) return;
		const datos: Borrador = {
			enlace, codigo, titulo, fechaCarga, descripcion, ventanaId, ventanaNombre, categoriaId,
			categoriaNombre, solicitanteId, solicitanteNombre, resolutorId, resolutorNombre,
			fechaEstimadaResolucion, yaResuelta, solucionTexto, tipoSolucion, fechaCierreReal, medidasImpacto
		};
		sessionStorage.setItem(CLAVE_BORRADOR, JSON.stringify(datos));
	});

	const sugerenciasSolucion = $derived(sugerenciasParaCategoria(sintesisSoluciones, categoriaId));

	function usarSugerencia(s: SintesisSolucion) {
		solucionTexto = s.texto;
		if (s.tipo_solucion === 'Modificación en BD' || s.tipo_solucion === 'Seguimiento de proceso') {
			tipoSolucion = s.tipo_solucion;
		}
	}

	async function cargarMesasRecientes() {
		cargandoRecientes = true;
		try {
			const texto = buscarRecientes.trim();
			const pagina = await api.listadoMesas(
				texto ? { buscar: texto, page_size: 20 } : { actividad_desde: hace7Dias(), page_size: 20 }
			);
			mesasRecientes = ordenarPorActividadReciente(pagina.items);
		} finally {
			cargandoRecientes = false;
		}
	}

	function alBuscarRecientes(e: Event) {
		buscarRecientes = (e.target as HTMLInputElement).value;
		clearTimeout(timerRecientes);
		timerRecientes = setTimeout(cargarMesasRecientes, 250);
	}

	function alternarExpandida(id: number) {
		expandidaId = expandidaId === id ? null : id;
	}

	$effect(() => {
		cargarMesasRecientes();
		api.sintesisSoluciones().then((s) => (sintesisSoluciones = s));
	});

	function vaciarCierre() {
		ventanaId = null;
		ventanaNombre = '';
		solucionTexto = '';
		tipoSolucion = 'Modificación en BD';
		fechaCierreReal = ahora();
		medidasImpacto = false;
	}

	function limpiar() {
		enlace = '';
		codigo = '';
		titulo = '';
		fechaCarga = ahora();
		descripcion = '';
		ventanaId = null;
		ventanaNombre = '';
		categoriaId = null;
		categoriaNombre = '';
		solicitanteId = null;
		solicitanteNombre = '';
		resolutorId = null;
		resolutorNombre = '';
		fechaEstimadaResolucion = '';
		yaResuelta = false;
		solucionTexto = '';
		tipoSolucion = 'Modificación en BD';
		fechaCierreReal = ahora();
		medidasImpacto = false;
		resultado = null;
		if (browser) sessionStorage.removeItem(CLAVE_BORRADOR);
	}

	function validar(): string | null {
		if (!codigo.trim()) return 'Falta código de la mesa';
		if (!titulo.trim()) return 'Falta título';
		if (!fechaCarga) return 'Falta fecha de carga';
		if (!descripcion.trim()) return 'Falta descripción';
		if (!categoriaId) return 'Falta seleccionar categoría';
		if (!solicitanteId) return 'Falta seleccionar solicitante';
		if (!resolutorId) return 'Falta seleccionar resolutor';
		if (!fechaEstimadaResolucion) return 'Falta fecha estimada de resolución';
		if (yaResuelta && !ventanaId) return 'Falta seleccionar ventana';
		if (yaResuelta && !solucionTexto.trim()) return 'Falta describir la solución';
		if (yaResuelta && !fechaCierreReal) return 'Falta la fecha real de cierre';
		return null;
	}

	// AnimacionExito3D carga three.js (500+ KB) — se difiere hasta el primer
	// guardado exitoso en vez de pesar en cada carga de esta pantalla.
	async function mostrarAnimacionExito() {
		if (!ComponenteAnimacionExito) {
			ComponenteAnimacionExito = (await import('$lib/components/AnimacionExito3D.svelte')).default;
			await tick();
		}
		animacionExito?.mostrar();
	}

	async function resolverCombosPendientes() {
		await Promise.all([
			comboboxCategoria.resolverPendiente(),
			comboboxSolicitante.resolverPendiente(),
			comboboxResolutor.resolverPendiente(),
			comboboxVentana?.resolverPendiente()
		]);
	}

	async function guardar() {
		await resolverCombosPendientes();
		errorValidacion = validar();
		errorGuardado = null;
		if (errorValidacion) {
			aviso?.mostrar('error', errorValidacion);
			return;
		}

		guardando = true;
		try {
			resultado = await api.crearMesa({
				enlace: enlace.trim() || null,
				codigo: codigo.trim(),
				titulo: titulo.trim(),
				fecha_carga: fechaCarga,
				descripcion: descripcion.trim(),
				categoria_id: categoriaId!,
				solicitante_id: solicitanteId!,
				resolutor_id: resolutorId!,
				fecha_estimada_resolucion: fechaEstimadaResolucion,
				...(yaResuelta
					? {
							ventana_id: ventanaId!,
							solucion: solucionTexto.trim(),
							tipo_solucion: tipoSolucion,
							fecha_cierre_real: fechaCierreReal,
							medidas_impacto: medidasImpacto
						}
					: {})
			});
			cargarMesasRecientes();
			celebracion?.mostrar(resultado.logros);
			mostrarAnimacionExito();
			aviso?.mostrar('exito', `Mesa ${resultado.codigo} guardada en la bitácora administrativa.`);
			limpiar();
		} catch (e) {
			errorGuardado = e instanceof Error ? e.message : 'No se pudo guardar la mesa';
			aviso?.mostrar('error', `No se pudo guardar la mesa: ${errorGuardado}`);
		} finally {
			guardando = false;
		}
	}

	function alTeclado(e: KeyboardEvent) {
		if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
			e.preventDefault();
			guardar();
		}
	}
</script>

<svelte:window onkeydown={alTeclado} />

<Celebracion bind:this={celebracion} />
{#if ComponenteAnimacionExito}
	<ComponenteAnimacionExito bind:this={animacionExito} />
{/if}
<AvisoResultado bind:this={aviso} />

<Header titulo="Nueva mesa" subtitulo="Bitácora administrativa — Ctrl+Enter para guardar sin usar el mouse." />

<div class="columnas">
	<div class="columna-izquierda">
		<div class="tarjeta recientes">
			<h2 class="font-display">Mesas recientes</h2>
			<input
				type="search"
				class="buscador-recientes"
				placeholder="Buscar código, título, solicitante, descripción o solución…"
				value={buscarRecientes}
				oninput={alBuscarRecientes}
			/>
			{#if cargandoRecientes}
				<ul class="lista-capturados">
					{#each Array(4) as _}
						<li class="item-capturado">
							<span class="skeleton skeleton-item" aria-hidden="true"></span>
						</li>
					{/each}
				</ul>
			{:else if mesasRecientes.length === 0}
				<p class="sin-capturas">
					{buscarRecientes.trim() ? 'Sin resultados para esa búsqueda.' : 'Sin mesas en los últimos 7 días.'}
				</p>
			{:else}
				<ul class="lista-capturados">
					{#each mesasRecientes as m}
						<li class="item-capturado">
							<button type="button" class="item-boton" onclick={() => alternarExpandida(m.id)}>
								<div class="item-cabecera">
									<span class="item-codigo">{m.codigo}</span>
									<span class="chip-estado" class:cerrada={!!m.fecha_cierre_real}>
										{m.fecha_cierre_real ? 'Cerrada' : 'Abierta'}
									</span>
								</div>
								<span class="item-titulo">{m.titulo}</span>
								<span class="item-solicitante">{m.solicitante.nombre}</span>
							</button>
							{#if expandidaId === m.id}
								<div class="item-detalle">
									<span class="detalle-etiqueta">Descripción</span>
									<p class="detalle-texto">{m.descripcion}</p>
									{#if m.solucion}
										<span class="detalle-etiqueta">Solución</span>
										<p class="detalle-texto">{m.solucion}</p>
									{/if}
								</div>
							{/if}
						</li>
					{/each}
				</ul>
			{/if}
		</div>
	</div>

	<div class="columna-derecha">
		<form class="tarjeta formulario" onsubmit={(e) => (e.preventDefault(), guardar())}>
			<LeyendaGrupos />

			<div class="grid-campos">
				<CampoGrupo grupo="a">
					<div class="campo">
						<label for="codigo">Código de la mesa</label>
						<input id="codigo" type="text" bind:value={codigo} placeholder="TCK-001" />
					</div>
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<div class="campo">
						<label for="titulo">Título</label>
						<input id="titulo" type="text" bind:value={titulo} />
					</div>
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<FechaHoraInput id="fecha_carga" label="Fecha y hora de carga" bind:value={fechaCarga} comoTexto />
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<div class="campo">
						<label for="enlace">Enlace en Proactivanet</label>
						<input id="enlace" type="text" bind:value={enlace} placeholder="https://…" />
					</div>
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<ComboboxCreatable bind:this={comboboxCategoria} id="categoria" catalogo="categorias-mesa" label="Categoría" bind:selectedId={categoriaId} nombreSeleccionado={categoriaNombre} />
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<ComboboxCreatable bind:this={comboboxSolicitante} id="solicitante" catalogo="solicitantes-mesa" label="Solicitante" bind:selectedId={solicitanteId} nombreSeleccionado={solicitanteNombre} />
				</CampoGrupo>
				<CampoGrupo grupo="b">
					<ComboboxCreatable bind:this={comboboxResolutor} id="resolutor" catalogo="resolutores-mesa" label="Resolutor" bind:selectedId={resolutorId} nombreSeleccionado={resolutorNombre} />
				</CampoGrupo>
				<CampoGrupo grupo="a">
					<FechaHoraInput
					id="fecha_estimada"
					label="Fecha y hora estimada de resolución"
					bind:value={fechaEstimadaResolucion}
					comoTexto
				/>
				</CampoGrupo>
			</div>

			<CampoGrupo grupo="a">
				<div class="campo">
					<label for="descripcion">Descripción</label>
					<textarea id="descripcion" rows="4" bind:value={descripcion} placeholder="Qué se reportó…"></textarea>
				</div>
			</CampoGrupo>

			<div class="fila-toggle-cierre">
				<button
					type="button"
					class="btn-info-cierre"
					class:activo={yaResuelta}
					onclick={() => (yaResuelta = !yaResuelta)}
				>
					{#if yaResuelta}<Icon nombre="check" tamano={13} />{/if}
					{yaResuelta ? 'Información de cierre agregada' : '+ Agregar información de cierre'}
				</button>
				<button type="button" class="btn-vaciar-cierre" onclick={vaciarCierre}>
					Vaciar cierre
				</button>
			</div>

			{#if yaResuelta}
				<div class="bloque-cierre">
					<CampoGrupo grupo="b">
						<div class="campo">
							<label for="solucion">Solución</label>
							{#if sugerenciasSolucion.length > 0}
								<div class="sugerencias-solucion">
									{#each sugerenciasSolucion as s}
										<button type="button" class="pill-sugerencia" title={s.texto} onclick={() => usarSugerencia(s)}>
											<Icon nombre="lightbulb" tamano={12} /> {s.titulo}
										</button>
									{/each}
								</div>
							{/if}
							<textarea id="solucion" rows="3" bind:value={solucionTexto} placeholder="Qué se hizo para resolverlo…"></textarea>
						</div>
					</CampoGrupo>
					<div class="grid-cierre">
						<CampoGrupo grupo="b">
							<ComboboxCreatable bind:this={comboboxVentana} id="ventana" catalogo="ventanas-mesa" label="Ventana" bind:selectedId={ventanaId} nombreSeleccionado={ventanaNombre} />
						</CampoGrupo>
						<div class="campo">
							<label for="tipo_solucion">Categoría de la solución</label>
							<select id="tipo_solucion" bind:value={tipoSolucion}>
								<option value="Modificación en BD">Modificación en BD</option>
								<option value="Seguimiento de proceso">Seguimiento de proceso</option>
							</select>
						</div>
						<CampoGrupo grupo="b">
							<FechaHoraInput id="fecha_cierre" label="Fecha y hora real de cierre" bind:value={fechaCierreReal} />
						</CampoGrupo>
					</div>
					<label class="check-medidas">
						<input type="checkbox" bind:checked={medidasImpacto} />
						Medidas para disminuir el impacto
					</label>
				</div>
			{/if}

			{#if errorValidacion}
				<Toast tipo="error">{errorValidacion}</Toast>
			{/if}

			<div class="acciones">
				<button type="submit" class="guardar" disabled={guardando}>
					{guardando ? 'Guardando…' : 'Guardar mesa'}
				</button>
			</div>
		</form>

		{#if errorGuardado}
			<div class="confirmaciones">
				<Toast tipo="error">No se pudo guardar la mesa: {errorGuardado}</Toast>
			</div>
		{/if}
	</div>
</div>

<style>
	.columnas {
		display: grid;
		grid-template-columns: minmax(280px, 360px) 1fr;
		gap: 24px;
		align-items: start;
	}

	.columna-izquierda {
		display: flex;
		flex-direction: column;
		gap: 16px;
		min-width: 0;
	}

	.columna-derecha {
		min-width: 0;
	}

	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 18px;
	}

	.formulario {
		display: flex;
		flex-direction: column;
		gap: 18px;
	}

	.recientes h2 {
		font-size: 14px;
		margin: 0 0 14px;
		color: var(--text-muted);
	}

	.buscador-recientes {
		width: 100%;
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 8px 10px;
		color: var(--text);
		font-size: 13px;
		margin-bottom: 14px;
	}

	.buscador-recientes:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}

	.sin-capturas {
		color: var(--text-muted);
		font-size: 13px;
	}

	.lista-capturados {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 12px;
	}

	.item-capturado {
		padding-bottom: 12px;
		border-bottom: 1px solid var(--border);
	}

	.item-capturado:last-child {
		border-bottom: none;
		padding-bottom: 0;
	}

	.item-boton {
		display: flex;
		flex-direction: column;
		gap: 4px;
		width: 100%;
		background: none;
		border: none;
		padding: 0;
		text-align: left;
		cursor: pointer;
		font: inherit;
		color: inherit;
	}

	.item-cabecera {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 8px;
	}

	.item-codigo {
		font-size: 12px;
		font-family: var(--font-mono);
		color: var(--text-faint);
	}

	.chip-estado {
		display: inline-block;
		padding: 2px 8px;
		border-radius: var(--radius);
		font-size: 10px;
		font-weight: 600;
		background: color-mix(in srgb, var(--accent) 16%, transparent);
		color: var(--accent-strong);
	}

	.chip-estado.cerrada {
		background: color-mix(in srgb, var(--success) 16%, transparent);
		color: var(--success);
	}

	.item-titulo {
		font-size: 13px;
		color: var(--text);
	}

	.item-solicitante {
		font-size: 12px;
		color: var(--text-muted);
	}

	.item-detalle {
		margin-top: 8px;
		padding: 8px 10px;
		background: var(--surface-raised);
		border-radius: var(--radius);
		display: flex;
		flex-direction: column;
		gap: 4px;
	}

	.detalle-etiqueta {
		font-size: 10px;
		text-transform: uppercase;
		letter-spacing: 0.04em;
		color: var(--text-muted);
		font-weight: 600;
	}

	.detalle-texto {
		margin: 0 0 4px;
		font-size: 12px;
		color: var(--text);
		white-space: pre-wrap;
	}

	.skeleton-item {
		display: block;
		height: 34px;
		width: 100%;
		border-radius: 4px;
	}

	.grid-campos {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 16px;
	}

	.grid-cierre {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
		gap: 16px;
	}

	.campo {
		display: flex;
		flex-direction: column;
		gap: 6px;
	}

	label {
		font-size: 12px;
		color: var(--text-muted);
		font-family: var(--font-display);
	}

	input,
	textarea {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
		resize: vertical;
	}

	input:focus-visible,
	textarea:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}

	.sugerencias-solucion {
		display: flex;
		flex-wrap: wrap;
		gap: 6px;
	}

	.pill-sugerencia {
		background: color-mix(in srgb, var(--accent) 12%, transparent);
		border: 1px solid var(--border-strong);
		border-radius: 999px;
		padding: 5px 12px;
		font-size: 12px;
		color: var(--accent-strong);
		cursor: pointer;
		text-align: left;
	}

	.pill-sugerencia:hover {
		background: color-mix(in srgb, var(--accent) 22%, transparent);
	}

	.fila-toggle-cierre {
		display: flex;
		gap: 10px;
		align-items: center;
	}

	.btn-vaciar-cierre {
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 12px 16px;
		font-size: 13px;
		color: var(--text-muted);
		cursor: pointer;
		min-height: 44px;
	}

	.btn-vaciar-cierre:hover {
		border-color: var(--danger);
		color: var(--danger);
	}

	.btn-info-cierre {
		display: inline-flex;
		align-items: center;
		gap: 6px;
		align-self: flex-start;
		background: none;
		border: 1px dashed var(--border-strong);
		border-radius: var(--radius);
		padding: 12px 18px;
		font-size: 13px;
		font-weight: 600;
		font-family: var(--font-display);
		color: var(--text-muted);
		cursor: pointer;
		min-height: 44px;
	}

	.btn-info-cierre:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}

	.btn-info-cierre.activo {
		border-style: solid;
		border-color: var(--success);
		background: color-mix(in srgb, var(--success) 12%, transparent);
		color: var(--success);
	}

	.check-medidas {
		display: flex;
		align-items: center;
		gap: 8px;
		font-size: 13px;
		color: var(--text-muted);
		cursor: pointer;
	}

	.bloque-cierre {
		display: flex;
		flex-direction: column;
		gap: 18px;
		padding: 14px;
		border: 1px dashed var(--border-strong);
		border-radius: var(--radius);
	}

	select {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
	}

	select option {
		background: var(--bg);
		color: var(--text);
	}

	.acciones {
		display: flex;
		gap: 12px;
		align-items: center;
		justify-content: flex-end;
	}

	.guardar {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 10px 20px;
		font-weight: 600;
		font-family: var(--font-display);
		cursor: pointer;
	}

	.guardar:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.guardar:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.confirmaciones {
		display: flex;
		flex-direction: column;
		gap: 10px;
		margin-top: 18px;
	}

	@media (max-width: 800px) {
		.columnas {
			grid-template-columns: 1fr;
		}

		.grid-campos,
		.grid-cierre {
			grid-template-columns: 1fr;
		}
	}
</style>
