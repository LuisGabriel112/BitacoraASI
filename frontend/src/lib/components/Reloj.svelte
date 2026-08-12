<script lang="ts">
	const ZONA = 'America/Mexico_City';

	let ahora = $state(new Date());

	$effect(() => {
		const id = setInterval(() => (ahora = new Date()), 1000);
		return () => clearInterval(id);
	});

	const hora = $derived(
		ahora.toLocaleTimeString('es-MX', { timeZone: ZONA, hour: '2-digit', minute: '2-digit', second: '2-digit' })
	);
	const fecha = $derived(
		ahora.toLocaleDateString('es-MX', { timeZone: ZONA, weekday: 'long', day: 'numeric', month: 'long' })
	);
</script>

<div class="reloj" title="Hora de Ciudad de México">
	<span class="reloj-hora">{hora}</span>
	<span class="reloj-fecha">{fecha}</span>
</div>

<style>
	.reloj {
		display: flex;
		flex-direction: column;
		gap: 2px;
	}

	.reloj-hora {
		font-family: var(--font-mono);
		font-weight: 600;
		font-size: 15px;
		letter-spacing: 0.02em;
	}

	.reloj-fecha {
		font-size: 11px;
		color: var(--text-muted);
		text-transform: capitalize;
	}
</style>
