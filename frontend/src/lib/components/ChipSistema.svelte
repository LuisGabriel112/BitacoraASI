<script lang="ts">
	let { nombre }: { nombre: string } = $props();

	const forma: Record<string, string> = {
		Mediport: 'square',
		Pis: 'circle',
		Proactivanet: 'diamond'
	};

	const variable = $derived(`--sistema-${nombre.toLowerCase()}`);
</script>

<span class="chip" data-forma={forma[nombre] ?? 'circle'} style="--chip-color: var({variable}, var(--accent))">
	<span class="marca"></span>
	{nombre}
</span>

<style>
	.chip {
		display: inline-flex;
		align-items: center;
		gap: 6px;
		padding: 2px 8px 2px 6px;
		border-radius: 999px;
		border: 1px solid color-mix(in srgb, var(--chip-color) 45%, transparent);
		background: color-mix(in srgb, var(--chip-color) 14%, transparent);
		color: var(--chip-color);
		font-size: 12px;
		font-weight: 500;
		white-space: nowrap;
	}

	.marca {
		width: 8px;
		height: 8px;
		background: var(--chip-color);
		flex-shrink: 0;
	}

	.chip[data-forma='square'] .marca {
		border-radius: 2px;
	}

	.chip[data-forma='circle'] .marca {
		border-radius: 50%;
	}

	.chip[data-forma='diamond'] .marca {
		border-radius: 2px;
		transform: rotate(45deg);
	}
</style>
