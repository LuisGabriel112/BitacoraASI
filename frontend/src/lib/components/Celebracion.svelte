<script lang="ts">
	import { MENSAJES_LOGRO } from '$lib/logros';
	import Icon from '$lib/components/Icon.svelte';

	type Particula = {
		id: number;
		left: number;
		color: string;
		delay: number;
		duracion: number;
		rot: number;
		tamano: number;
		redonda: boolean;
	};

	let visible = $state(false);
	let logrosActivos = $state<string[]>([]);
	let particulas = $state<Particula[]>([]);
	let timer: ReturnType<typeof setTimeout>;

	const COLORES = [
		'var(--accent)',
		'var(--accent-2)',
		'var(--success)',
		'var(--sistema-mediport)',
		'var(--sistema-proactivanet)',
		'#f2c14e'
	];

	export function mostrar(logros: string[]) {
		if (logros.length === 0) return;
		clearTimeout(timer);
		logrosActivos = logros;
		particulas = Array.from({ length: 90 }, (_, i) => ({
			id: i,
			left: Math.random() * 100,
			color: COLORES[i % COLORES.length],
			delay: Math.random() * 0.6,
			duracion: 2.2 + Math.random() * 1.6,
			rot: Math.random() * 720 - 360,
			tamano: 7 + Math.random() * 7,
			redonda: Math.random() > 0.5
		}));
		visible = true;
		timer = setTimeout(() => (visible = false), 5200);
	}

	function cerrar() {
		clearTimeout(timer);
		visible = false;
	}
</script>

{#if visible}
	<div class="confeti-capa" aria-hidden="true">
		{#each particulas as p (p.id)}
			<span
				class="confeti"
				class:redonda={p.redonda}
				style="left:{p.left}%; width:{p.tamano}px; height:{p.tamano * 1.4}px; background:{p.color}; animation-delay:{p.delay}s; animation-duration:{p.duracion}s; --rot:{p.rot}deg"
			></span>
		{/each}
	</div>
	<div class="banner-logro" role="status">
		<button class="cerrar" onclick={cerrar} aria-label="Cerrar"><Icon nombre="x" tamano={16} /></button>
		<ul class="lista-logros">
			{#each logrosActivos as clave (clave)}
				<li>
					<span class="punto" aria-hidden="true"></span>
					{MENSAJES_LOGRO[clave] ?? clave}
				</li>
			{/each}
		</ul>
	</div>
{/if}

<style>
	.confeti-capa {
		position: fixed;
		inset: 0;
		pointer-events: none;
		z-index: 200;
		overflow: hidden;
	}

	.confeti {
		position: absolute;
		top: -20px;
		border-radius: 2px;
		animation-name: caer;
		animation-timing-function: ease-in;
		animation-fill-mode: forwards;
	}

	.confeti.redonda {
		border-radius: 50%;
	}

	@keyframes caer {
		0% {
			transform: translateY(0) rotate(0deg);
			opacity: 1;
		}
		100% {
			transform: translateY(100vh) rotate(var(--rot));
			opacity: 0;
		}
	}

	.banner-logro {
		position: fixed;
		top: 20px;
		left: 50%;
		transform: translateX(-50%);
		z-index: 201;
		background: var(--surface-raised);
		backdrop-filter: var(--glass-blur);
		-webkit-backdrop-filter: var(--glass-blur);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius-lg);
		padding: 14px 40px 14px 18px;
		box-shadow: 0 16px 40px -12px oklch(0 0 0 / 0.5);
		animation: entrar 0.35s ease;
		max-width: 380px;
	}

	@keyframes entrar {
		from {
			transform: translate(-50%, -20px);
			opacity: 0;
		}
		to {
			transform: translate(-50%, 0);
			opacity: 1;
		}
	}

	.lista-logros {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-direction: column;
		gap: 8px;
		font-size: 13px;
		color: var(--text);
	}

	.lista-logros li {
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.punto {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		background: var(--accent);
		flex-shrink: 0;
	}

	.cerrar {
		display: flex;
		position: absolute;
		top: 8px;
		right: 10px;
		background: none;
		border: none;
		color: var(--text-faint);
		cursor: pointer;
		padding: 4px;
	}

	.cerrar:hover {
		color: var(--text);
	}

	@media (prefers-reduced-motion: reduce) {
		.confeti {
			animation: none;
			display: none;
		}

		.banner-logro {
			animation: none;
		}
	}
</style>
