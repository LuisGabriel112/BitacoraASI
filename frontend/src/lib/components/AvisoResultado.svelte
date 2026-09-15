<script lang="ts">
	import type { TipoAviso } from '$lib/notificaciones';
	import type { FuenteSonido } from '$lib/sonidos';
	import { reproducirEvento, reproducirFuente } from '$lib/sonidos.svelte';
	import Icon from '$lib/components/Icon.svelte';

	let visible = $state(false);
	let tipo = $state<TipoAviso>('exito');
	let mensaje = $state('');
	let timer: ReturnType<typeof setTimeout>;

	function reproducirSonido(fuente: FuenteSonido) {
		if (fuente === null) return;
		if (typeof fuente === 'function') {
			fuente();
			return;
		}
		if (typeof fuente === 'string') {
			reproducirFuente(fuente);
			return;
		}
		reproducirEvento(fuente.evento);
	}

	/** Un error siempre suena con la preferencia del usuario para "error".
	 *  El éxito no tiene acción implícita: quien lo muestra pasa la fuente
	 *  ({ evento: 'guardar_mesa' }, una ruta, una función) o null para silencio. */
	export function mostrar(t: TipoAviso, m: string, sonido?: FuenteSonido) {
		clearTimeout(timer);
		const fuente: FuenteSonido = sonido === undefined ? (t === 'error' ? { evento: 'error' } : null) : sonido;
		reproducirSonido(fuente);
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
		<span class="icono"><Icon nombre={tipo === 'exito' ? 'check' : 'x'} tamano={16} /></span>
		<span class="mensaje">{mensaje}</span>
		<button class="cerrar" onclick={cerrar} aria-label="Cerrar"><Icon nombre="x" tamano={14} /></button>
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
		box-shadow: var(--shadow-flat);
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
		display: flex;
		flex-shrink: 0;
	}

	.mensaje {
		flex: 1;
	}

	.cerrar {
		display: flex;
		position: absolute;
		top: 8px;
		right: 10px;
		background: none;
		border: none;
		color: white;
		opacity: 0.8;
		cursor: pointer;
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
