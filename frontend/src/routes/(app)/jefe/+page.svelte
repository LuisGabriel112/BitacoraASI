<script lang="ts">
	import { fade } from 'svelte/transition';
	import Header from '$lib/components/Header.svelte';
	import Enemigo3D from '$lib/components/Enemigo3D.svelte';
	import JuegoGato from '$lib/components/JuegoGato.svelte';
	import JuegoPelota from '$lib/components/JuegoPelota.svelte';
	import JuegoRPS from '$lib/components/JuegoRPS.svelte';
	import JuegoTrivia from '$lib/components/JuegoTrivia.svelte';
	import JuegoMemorama from '$lib/components/JuegoMemorama.svelte';
	import JuegoReaccion from '$lib/components/JuegoReaccion.svelte';
	import JuegoRuleta from '$lib/components/JuegoRuleta.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import type { NombreIcono } from '$lib/icons';
	import { api, type DanioJefeEvento, type Jefe } from '$lib/api/client';

	const INTERVALO_MS = 10_000;

	const ETIQUETA_MOTIVO: Record<string, string> = {
		mesa_creada: 'Mesa creada',
		mesa_cerrada: 'Mesa cerrada',
		registro_creado: 'Soporte registrado',
		minijuego_pelota: 'Encuentra la pelota',
		minijuego_trivia: 'Trivia de soporte',
		minijuego_memorama: 'Memorama relámpago',
		minijuego_reaccion: 'Reacción rápida',
		minijuego_ruleta: 'Ruleta rusa'
	};

	const ICONO_MOTIVO: Record<string, NombreIcono> = {
		mesa_creada: 'ticket',
		mesa_cerrada: 'check-circle-2',
		registro_creado: 'clipboard-list',
		minijuego_pelota: 'target',
		minijuego_trivia: 'brain',
		minijuego_memorama: 'grid-3x3',
		minijuego_reaccion: 'zap',
		minijuego_ruleta: 'dices'
	};

	let jefe = $state<Jefe | null>(null);
	let danos = $state<DanioJefeEvento[]>([]);
	let cargando = $state(true);

	function formatearHora(iso: string) {
		return new Date(iso).toLocaleTimeString('es-MX', { hour: '2-digit', minute: '2-digit' });
	}

	$effect(() => {
		let cancelado = false;

		async function tick() {
			try {
				const [respuestaJefe, respuestaDanos] = await Promise.all([api.jefeActual(), api.danosAlJefeActual()]);
				if (!cancelado) {
					jefe = respuestaJefe;
					danos = respuestaDanos;
				}
			} catch {
				// un fallo de un ciclo de polling no debe romper la UI
			} finally {
				if (!cancelado) cargando = false;
			}
		}

		tick();
		const id = setInterval(tick, INTERVALO_MS);

		return () => {
			cancelado = true;
			clearInterval(id);
		};
	});

	const porcentajeVida = $derived(jefe ? Math.max(0, (jefe.vida_actual / jefe.vida_max) * 100) : 0);
</script>

<Header titulo="Jefe de la semana" subtitulo="Cada mesa y soporte cerrado le baja vida." />

{#if cargando}
	<p class="cargando">Cargando jefe…</p>
{:else if jefe}
	<div class="columnas">
		<section class="tarjeta ficha-jefe" in:fade={{ duration: 250 }}>
			<Enemigo3D derrotado={jefe.derrotado} {porcentajeVida} tamano={200} />
			<h2 class="font-display">{jefe.nombre}</h2>
			<span class="semana">{jefe.semana}</span>

			<div class="barra-vida" title="{jefe.vida_actual} / {jefe.vida_max}">
				<div class="barra-vida-relleno" class:derrotado={jefe.derrotado} style="width: {porcentajeVida}%"></div>
			</div>
			<span class="vida-detalle">{jefe.vida_actual} / {jefe.vida_max} de vida</span>

			{#if jefe.derrotado}
				<p class="mensaje-derrota">
					<Icon nombre="party-popper" tamano={16} />
					¡El equipo derrotó al jefe de esta semana!
				</p>
			{/if}
		</section>

		<section class="tarjeta historial-danos" in:fade={{ duration: 250, delay: 60 }}>
			<h2 class="font-display">Acciones que le bajaron vida</h2>
			{#if danos.length === 0}
				<p class="vacio-danos">Nadie le ha bajado vida al jefe todavía esta semana.</p>
			{:else}
				<ul class="lista-danos">
					{#each danos as d, i (d.id)}
						<li in:fade={{ duration: 200, delay: Math.min(i, 15) * 20 }}>
							<span class="icono-dano"><Icon nombre={ICONO_MOTIVO[d.motivo] ?? 'swords'} tamano={16} /></span>
							<div class="dano-info">
								<span class="dano-motivo">{ETIQUETA_MOTIVO[d.motivo] ?? d.motivo}</span>
								<span class="dano-autor">{d.nombre_capturado}</span>
							</div>
							<span class="dano-cantidad">-{d.cantidad}</span>
							<span class="dano-hora">{formatearHora(d.created_at)}</span>
						</li>
					{/each}
				</ul>
			{/if}
		</section>
	</div>

	<div class="columnas juegos" in:fade={{ duration: 250, delay: 120 }}>
		<JuegoGato />
		<JuegoRPS />
		<JuegoPelota />
		<JuegoTrivia />
		<JuegoMemorama />
		<JuegoReaccion />
		<JuegoRuleta />
	</div>
{/if}

<style>
	.cargando {
		color: var(--text-muted);
	}

	.columnas {
		display: grid;
		grid-template-columns: minmax(280px, 480px) 1fr;
		gap: 20px;
		align-items: start;
	}

	.columnas.juegos {
		margin-top: 20px;
		grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	}

	.tarjeta {
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 32px;
	}

	.ficha-jefe {
		display: flex;
		flex-direction: column;
		align-items: center;
		text-align: center;
		gap: 6px;
	}

	.ficha-jefe h2 {
		margin: 6px 0 0;
	}

	.semana {
		color: var(--text-muted);
		font-size: 13px;
		margin-bottom: 16px;
	}

	.barra-vida {
		width: 100%;
		height: 16px;
		background: var(--border);
		border-radius: 999px;
		overflow: hidden;
	}

	.barra-vida-relleno {
		height: 100%;
		background: var(--danger);
		transition: width 0.4s ease;
	}

	.barra-vida-relleno.derrotado {
		background: var(--text-faint);
	}

	.vida-detalle {
		font-size: 12px;
		color: var(--text-faint);
		margin-top: 8px;
	}

	.mensaje-derrota {
		display: flex;
		align-items: center;
		gap: 8px;
		margin-top: 16px;
		font-weight: 600;
		color: var(--success);
	}

	.historial-danos {
		padding: 20px;
		min-height: 200px;
	}

	.historial-danos h2 {
		font-size: 14px;
		margin: 0 0 14px;
		color: var(--text-muted);
	}

	.vacio-danos {
		color: var(--text-muted);
		font-size: 13px;
	}

	.lista-danos {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 4px;
		max-height: 520px;
		overflow-y: auto;
	}

	.lista-danos li {
		display: flex;
		align-items: center;
		gap: 12px;
		padding: 9px 6px;
		border-bottom: 1px solid var(--border);
	}

	.lista-danos li:last-child {
		border-bottom: none;
	}

	.icono-dano {
		display: flex;
		flex-shrink: 0;
	}

	.dano-info {
		flex: 1;
		min-width: 0;
		display: flex;
		flex-direction: column;
	}

	.dano-motivo {
		font-size: 13px;
		color: var(--text);
	}

	.dano-autor {
		font-size: 11px;
		color: var(--text-muted);
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	.dano-cantidad {
		font-family: var(--font-mono);
		font-weight: 600;
		font-size: 13px;
		color: var(--danger);
		flex-shrink: 0;
	}

	.dano-hora {
		font-size: 11px;
		color: var(--text-faint);
		flex-shrink: 0;
		min-width: 42px;
		text-align: right;
	}

	@media (max-width: 860px) {
		.columnas {
			grid-template-columns: 1fr;
		}
	}
</style>
