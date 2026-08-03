<script lang="ts">
	function temaActual(): 'light' | 'dark' {
		const guardado = localStorage.getItem('tema');
		if (guardado === 'light' || guardado === 'dark') return guardado;
		return window.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark';
	}

	let tema = $state<'light' | 'dark'>('dark');

	$effect(() => {
		tema = temaActual();
	});

	function alternar() {
		tema = tema === 'light' ? 'dark' : 'light';
		document.documentElement.dataset.theme = tema;
		localStorage.setItem('tema', tema);
	}
</script>

<button
	class="toggle-tema"
	onclick={alternar}
	aria-label={tema === 'light' ? 'Cambiar a modo oscuro' : 'Cambiar a modo claro'}
	title={tema === 'light' ? 'Modo oscuro' : 'Modo claro'}
>
	{tema === 'light' ? '☾' : '☀'}
</button>

<style>
	.toggle-tema {
		background: none;
		border: 1px solid var(--border-strong);
		border-radius: var(--radius);
		width: 30px;
		height: 30px;
		display: flex;
		align-items: center;
		justify-content: center;
		color: var(--text);
		cursor: pointer;
		font-size: 14px;
		flex-shrink: 0;
	}

	.toggle-tema:hover {
		border-color: var(--accent);
		color: var(--accent-strong);
	}
</style>
