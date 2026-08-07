<script lang="ts">
	import { goto } from '$app/navigation';
	import Toast from '$lib/components/Toast.svelte';
	import { api } from '$lib/api/client';

	const AVATARES = ['🙂', '🦾', '🛡️', '🧠', '🚀', '🐉', '🦉', '⚡'];

	let modo = $state<'login' | 'registro'>('login');
	let nombre = $state('');
	let pin = $state('');
	let confirmarPin = $state('');
	let avatar = $state(AVATARES[0]);
	let enviando = $state(false);
	let error = $state<string | null>(null);
	let inputNombre: HTMLInputElement;

	$effect(() => {
		inputNombre?.focus();
	});

	function alternarModo() {
		modo = modo === 'login' ? 'registro' : 'login';
		error = null;
	}

	function validar(): string | null {
		if (!nombre.trim()) return 'Falta tu nombre';
		if (!pin.trim()) return 'Falta tu PIN';
		if (modo === 'registro' && pin !== confirmarPin) return 'Los PIN no coinciden';
		return null;
	}

	async function enviar() {
		error = validar();
		if (error) return;

		enviando = true;
		try {
			if (modo === 'login') await api.iniciarSesion(nombre.trim(), pin);
			else await api.registrarse(nombre.trim(), pin, avatar);
			await goto('/', { invalidateAll: true });
		} catch (e) {
			error = e instanceof Error ? e.message : 'No se pudo continuar';
		} finally {
			enviando = false;
		}
	}
</script>

<div class="pantalla">
	<form class="tarjeta" onsubmit={(e) => (e.preventDefault(), enviar())}>
		<h1 class="font-display">{modo === 'login' ? 'Iniciar sesión' : 'Crear personaje'}</h1>
		<p class="subtitulo">Bitácora ASIPONA — identifícate con tu nombre y PIN.</p>

		<div class="campo">
			<label for="nombre">Nombre</label>
			<input id="nombre" type="text" bind:value={nombre} autocomplete="username" bind:this={inputNombre} />
		</div>

		<div class="campo">
			<label for="pin">PIN</label>
			<input id="pin" type="password" inputmode="numeric" bind:value={pin} autocomplete="current-password" />
		</div>

		{#if modo === 'registro'}
			<div class="campo">
				<label for="confirmar-pin">Confirmar PIN</label>
				<input id="confirmar-pin" type="password" inputmode="numeric" bind:value={confirmarPin} />
			</div>

			<div class="campo">
				<span class="etiqueta-avatar">Avatar</span>
				<div class="avatares">
					{#each AVATARES as opcion}
						<button
							type="button"
							class="avatar"
							class:elegido={avatar === opcion}
							onclick={() => (avatar = opcion)}
							aria-label="Elegir avatar {opcion}"
						>
							{opcion}
						</button>
					{/each}
				</div>
			</div>
		{/if}

		{#if error}
			<Toast tipo="error">{error}</Toast>
		{/if}

		<button type="submit" class="enviar" disabled={enviando}>
			{enviando ? 'Un momento…' : modo === 'login' ? 'Entrar' : 'Crear personaje'}
		</button>

		<button type="button" class="alternar" onclick={alternarModo}>
			{modo === 'login' ? '¿No tienes cuenta? Crea tu personaje' : '¿Ya tienes cuenta? Inicia sesión'}
		</button>
	</form>
</div>

<style>
	.pantalla {
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 24px;
	}

	.tarjeta {
		width: 100%;
		max-width: 380px;
		display: flex;
		flex-direction: column;
		gap: 14px;
		background: var(--surface);
		border: 1px solid var(--border);
		border-radius: var(--radius-lg);
		padding: 28px;
		box-shadow: 0 16px 40px -12px oklch(0 0 0 / 0.4);
	}

	h1 {
		margin: 0;
	}

	.subtitulo {
		margin: -6px 0 4px;
		color: var(--text-muted);
		font-size: 13px;
	}

	.campo {
		display: flex;
		flex-direction: column;
		gap: 6px;
	}

	label,
	.etiqueta-avatar {
		font-size: 12px;
		color: var(--text-muted);
		font-family: var(--font-display);
	}

	input {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		padding: 9px 10px;
		color: var(--text);
	}

	input:focus-visible {
		outline: 2px solid var(--accent);
		outline-offset: 1px;
	}

	.avatares {
		display: flex;
		gap: 6px;
		flex-wrap: wrap;
	}

	.avatar {
		background: var(--surface);
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		width: 38px;
		height: 38px;
		font-size: 18px;
		cursor: pointer;
	}

	.avatar.elegido {
		border-color: var(--accent);
		background: color-mix(in srgb, var(--accent) 16%, transparent);
	}

	.enviar {
		background: var(--accent);
		color: var(--bg);
		border: none;
		border-radius: var(--radius);
		padding: 10px 16px;
		font-weight: 600;
		font-family: var(--font-display);
		cursor: pointer;
	}

	.enviar:hover:not(:disabled) {
		background: var(--accent-strong);
	}

	.enviar:disabled {
		opacity: 0.6;
		cursor: default;
	}

	.alternar {
		background: none;
		border: none;
		color: var(--text-muted);
		font-size: 12px;
		cursor: pointer;
		text-decoration: underline;
	}

	.alternar:hover {
		color: var(--accent-strong);
	}
</style>
