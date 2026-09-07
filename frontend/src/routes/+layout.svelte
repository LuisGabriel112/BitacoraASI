<script lang="ts">
	import '../lib/tokens.css';

	let { children } = $props();
</script>

<!--
THESIS: Bitácora deja el glassmorphism translúcido por una identidad plana y de
alto contraste — cada pantalla se lee de un vistazo, sin blur ni blobs.
OWN-WORLD: superficies planas y opacas, borde duro de 2px, sombra offset sin
blur (4px 4px 0); radios moderados (8/14px); acento violeta reservado a
acciones primarias y estado activo; los tres colores de sistema (Mediport/
PIS/ProactivaNet) se preservan intactos por su validación CVD.
STORY: soporte y jefatura ven de inmediato qué está activo, qué acción es
primaria y qué dato pertenece a qué sistema, sin ruido compitiendo con cifras.
FIRST VIEWPORT: nav lateral opaca con borde duro y pastilla violeta sólida en
el ítem activo; header con título grande; contenido en tarjetas planas con
sombra offset.
FORM: flat + bold color, dirección fijada por el usuario (bypassa el roll de
concept-seed); seed key: user-pinned-flat-bold.
FINISH: unreviewed and undocumented is unfinished; this build ends with the
finish review, the verdict, DESIGN.md, and every shipping raster carrying its
provenance.
-->

{@render children()}
