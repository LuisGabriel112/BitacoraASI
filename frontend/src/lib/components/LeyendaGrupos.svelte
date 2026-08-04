<div class="leyenda-grupos">
	<span class="item"><span class="punto grupo-a" aria-hidden="true"></span>Copiado de Mesa de ayuda</span>
	<span class="item"><span class="punto grupo-b" aria-hidden="true"></span>Con criterio propio</span>
	<span class="item"><span class="punto grupo-c" aria-hidden="true"></span>A discreción, sin análisis</span>
</div>

<style>
	.leyenda-grupos {
		display: flex;
		flex-wrap: wrap;
		gap: 16px;
		font-size: 12px;
		color: var(--text-muted);
	}

	.item {
		display: inline-flex;
		align-items: center;
		gap: 6px;
	}

	.punto {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		flex-shrink: 0;
	}

	.grupo-a {
		background: var(--accent);
	}

	.grupo-b {
		background: var(--accent-2);
	}

	.grupo-c {
		background: var(--danger);
	}
</style>
