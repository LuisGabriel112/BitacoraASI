<script lang="ts">
	import '../lib/tokens.css';

	let { children } = $props();
</script>

<div class="fondo-decorativo" aria-hidden="true">
	<span class="blob blob-1"></span>
	<span class="blob blob-2"></span>
	<span class="blob blob-3"></span>
</div>

{@render children()}
