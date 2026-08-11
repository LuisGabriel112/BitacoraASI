<script lang="ts">
	import { fade } from 'svelte/transition';
	import Header from '$lib/components/Header.svelte';
	import { api, type RankingItem } from '$lib/api/client';

	const INTERVALO_MS = 10_000;

	let enLinea = $state<RankingItem[]>([]);
	let cargando = $state(true);

	$effect(() => {
		let cancelado = false;

		async function tick() {
			try {
				const respuesta = await api.enLinea();
				if (!cancelado) enLinea = respuesta;
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
</script>

<Header titulo="En línea" subtitulo="Quién está usando la bitácora ahora mismo." />

{#if cargando}
	<p class="cargando">Cargando…</p>
{:else if enLinea.length === 0}
	<p class="sin-datos">Nadie está en línea ahora mismo.</p>
{:else}
	<ul class="lista-en-linea">
		{#each enLinea as u, i}
			<li in:fade={{ duration: 200, delay: i * 40 }}>
				<span class="punto-en-linea" aria-hidden="true"></span>
				<span class="avatar" aria-hidden="true">{u.avatar}</span>
				<span class="nombre">{u.nombre}</span>
				<span class="nivel">Nv. {u.nivel}</span>
			</li>
		{/each}
	</ul>
{/if}

<style>
	.cargando,
	.sin-datos {
		color: var(--text-muted);
	}

	.lista-en-linea {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 10px;
		max-width: 420px;
	}

	.lista-en-linea li {
		display: flex;
		align-items: center;
		gap: 10px;
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius);
		padding: 10px 14px;
	}

	.punto-en-linea {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		background: var(--success);
		flex-shrink: 0;
	}

	.avatar {
		font-size: 18px;
	}

	.nombre {
		flex: 1;
		font-size: 13px;
		font-weight: 600;
	}

	.nivel {
		font-size: 12px;
		color: var(--text-muted);
	}
</style>
