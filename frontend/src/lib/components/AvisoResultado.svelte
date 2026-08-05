<script lang="ts">
	import { rutaSonidoParaAviso, type TipoAviso } from '$lib/notificaciones';

	let visible = $state(false);
	let tipo = $state<TipoAviso>('exito');
	let mensaje = $state('');
	let timer: ReturnType<typeof setTimeout>;

	function reproducirSonido(t: TipoAviso) {
		const audio = new Audio(rutaSonidoParaAviso(t));
		audio.play().catch(() => {});
	}

	export function mostrar(t: TipoAviso, m: string) {
		clearTimeout(timer);
		reproducirSonido(t);
		tipo = t;
		mensaje = m;
		visible = true;
		timer = setTimeout(() => (visible = false), 4200);
	}

	function cerrar() {
		clearTimeout(timer);
		visible = false;
	}
</script>

{#if visible}
	<div class="popup-aviso" class:exito={tipo === 'exito'} class:error={tipo === 'error'} role="status">
		<span class="icono" aria-hidden="true">{tipo === 'exito' ? '✓' : '✕'}</span>
		<span class="mensaje">{mensaje}</span>
		<button class="cerrar" onclick={cerrar} aria-label="Cerrar">✕</button>
	</div>
{/if}

<style>
	.popup-aviso {
		position: fixed;
		top: 20px;
		right: 20px;
		z-index: 300;
		display: flex;
		align-items: center;
		gap: 10px;
		padding: 14px 40px 14px 18px;
		border-radius: var(--radius-lg);
		box-shadow: 0 16px 40px -12px oklch(0 0 0 / 0.5);
		max-width: 380px;
		font-size: 14px;
		font-weight: 600;
		color: white;
		animation: entrar 0.25s ease;
	}

	.popup-aviso.exito {
		background: var(--success);
	}

	.popup-aviso.error {
		background: var(--danger);
	}

	.icono {
		font-size: 16px;
	}

	.mensaje {
		flex: 1;
	}

	.cerrar {
		position: absolute;
		top: 8px;
		right: 10px;
		background: none;
		border: none;
		color: white;
		opacity: 0.8;
		cursor: pointer;
		font-size: 12px;
		padding: 4px;
	}

	.cerrar:hover {
		opacity: 1;
	}

	@keyframes entrar {
		from {
			transform: translateY(-16px);
			opacity: 0;
		}
		to {
			transform: translateY(0);
			opacity: 1;
		}
	}
</style>
