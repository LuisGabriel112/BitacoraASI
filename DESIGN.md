---
name: Bitácora ASIPONA
description: Bitácora interna de soporte operativo portuario — panel oscuro de superficies elevadas, borde mínimo y acento violeta en gradiente.
colors:
  bg: "oklch(0.19 0.004 286)"
  surface: "oklch(0.24 0.005 286)"
  surface-raised: "oklch(0.29 0.006 286)"
  border: "oklch(0.33 0.007 286)"
  border-strong: "oklch(0.4 0.008 286)"
  text: "oklch(0.98 0.002 286)"
  text-muted: "oklch(0.72 0.008 286)"
  text-faint: "oklch(0.56 0.008 286)"
  accent: "oklch(0.62 0.21 293)"
  accent-strong: "oklch(0.7 0.2 296)"
  accent-gradient: "linear-gradient(140deg, oklch(0.72 0.19 300), oklch(0.55 0.22 288))"
  accent-gradient-light: "linear-gradient(140deg, oklch(0.6 0.21 300), oklch(0.46 0.23 288))"
  accent-2: "oklch(0.83 0.17 95)"
  success: "#34d399"
  warning: "#fbbf24"
  danger: "#f87171"
  sistema-mediport: "#3987e5"
  sistema-pis: "#199e70"
  sistema-proactivanet: "#d95926"
  scrim: "oklch(0 0 0 / 0.5)"
typography:
  display:
    fontFamily: "system-ui, -apple-system, 'Helvetica Neue', Arial, sans-serif"
    fontWeight: 700
    letterSpacing: "-0.015em"
  body:
    fontFamily: "system-ui, -apple-system, 'Helvetica Neue', Arial, sans-serif"
    fontSize: "14px"
    lineHeight: 1.5
  emphasis:
    fontSize: "15px"
    fontWeight: 600
  title:
    fontSize: "16px"
    fontWeight: 600
  secondary:
    fontSize: "13px"
  label:
    fontSize: "12px"
  micro:
    fontSize: "11px"
  mono:
    fontFamily: "ui-monospace, 'SFMono-Regular', Menlo, Consolas, monospace"
rounded:
  sm: "8px"
  md: "10px"
  lg: "16px"
  pill: "999px"
components:
  button-primary:
    backgroundColor: "{colors.accent}"
    textColor: "#ffffff"
    rounded: "{rounded.md}"
  button-primary-hover:
    backgroundColor: "{colors.accent-strong}"
  button-secondary:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text}"
    rounded: "{rounded.md}"
  card:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.lg}"
    padding: "18px"
---

# Design System: Bitácora ASIPONA

## Overview

**Creative North Star: "El panel encendido"**

Bitácora dejó la identidad plana de trazo duro ("el expediente plano": bordes de 2px y sombra offset sin desenfoque) por un panel de control oscuro de superficies elevadas. La página es casi negra; cada tarjeta se separa del lienzo porque está un escalón más clara y lleva una sombra suave, no porque esté delineada. El borde baja a 1px y pasa a ser un divisor discreto, no la firma del sistema.

Sigue siendo una herramienta de trabajo diario para soporte operativo y jefatura de un puerto — no un producto de venta. Por eso la energía visual se concentra en un solo lugar: el gradiente violeta, reservado a la cifra principal de cada pantalla y al ítem de navegación activo. Todo lo demás es neutro, y las cifras mandan.

Los tres colores de sistema (Mediport azul, PIS verde, ProactivaNet naranja) se preservan intactos: están validados por contraste y distinguibilidad CVD (deuteranopía/protanopía) y quedan fuera de esta exploración estética.

**Key Characteristics:**
- Jerarquía por elevación: `--bg` < `--surface` < `--surface-raised`, más sombra suave. El borde no define la tarjeta.
- Un solo acento violeta, con una forma nueva: `--accent-gradient` para la tarjeta destacada y el ítem de nav activo; `--accent` plano para foco, enlaces y estado.
- Borde de 1px en `--border` como divisor de baja jerarquía, uniforme en tarjetas, inputs, tabla y nav.
- Radios más generosos (16px en tarjetas, 10px en controles) y filas de tabla más altas: menos densidad, más aire.
- Badges y chips como pastillas tintadas: el color semántico vive en el texto, el relleno es el mismo color al 16–18%.

## Colors

Paleta restringida de neutros fríos casi acromáticos, un acento violeta que carga toda la acción primaria, más los semánticos y de sistema.

### Primary
- **Violeta** (`--accent`, `oklch(0.62 0.21 293)` oscuro / `oklch(0.52 0.22 293)` claro): botón primario, foco, enlaces de acción, estado.
- **Gradiente violeta** (`--accent-gradient`, `linear-gradient(140deg, …)`): la única superficie con saturación fuerte. Exclusivo de la tarjeta destacada (`StatTile destacada`), del ítem de nav activo, del icono de marca y del avatar.

### Neutral
- **Lienzo** — `--bg` (`oklch(0.19 0.004 286)` oscuro / `oklch(0.97 0.003 286)` claro): fondo de página y del sidebar. Sin gradiente decorativo.
- **Superficie** — `--surface` (`oklch(0.24 0.005 286)` oscuro / blanco puro en claro): tarjetas, tiles, tabla, inputs, chips de la topbar.
- **Superficie elevada** — `--surface-raised`: hover de fila, dropdowns, popovers, toasts.
- **Borde** — `--border`: el divisor de 1px que usa todo el sistema.
- **Borde marcado** — `--border-strong`: separación de mayor contraste cuando 1px en `--border` no alcanza (rara). Ya no es un trazo estructural ni el color de ninguna sombra.
- **Texto** — `--text` / `--text-muted` / `--text-faint`: jerarquía de lectura sobre superficie.

### Semánticos y tintes
- `--success` `#34d399`, `--warning` `#fbbf24`, `--danger` `#f87171` en oscuro; `#0f7a52`, `#a85c02`, `#b3261e` en claro.
- `--accent-soft` (18%), `--success-soft`, `--warning-soft`, `--danger-soft` (16%): rellenos translúcidos de badge y de chip de icono. Nunca se usan como color de texto.

### Velo (scrim)
- **Velo de fondo** (`oklch(0 0 0 / 0.5)`): oscurece lo que queda detrás de un modal (`GestionCatalogos`) o de un aviso flotante sobre la arena 3D. Es el único negro translúcido del sistema.

### Sistema (fijo, no explorar)
- **Mediport** `#3987e5`, **PIS** `#199e70`, **ProactivaNet** `#d95926` (oscuro); `#1f5db3` / `#0f7a52` / `#b8451a` (claro). Trío validado CVD — cualquier cambio exige re-correr `validate_palette.js`.

### Named Rules
**La regla del gradiente único.** El gradiente violeta marca una sola cosa por pantalla: dónde está la cifra que importa. Si dos superficies lo llevan al mismo tiempo, ninguna destaca y la regla está rota. El ítem de nav activo es la excepción permanente, porque nunca compite por la misma mirada.

## Typography

**Display Font:** system-ui, -apple-system, 'Helvetica Neue', Arial, sans-serif (peso 700, `letter-spacing: -0.015em`)
**Body Font:** la misma pila system-ui (peso 400)
**Mono Font:** ui-monospace / SFMono-Regular / Menlo / Consolas — reservado a cifras, fechas y folios (`font-variant-numeric: tabular-nums` en `body`).

**Character:** una sola familia nativa para todo, sin webfont externo — prioriza densidad de lectura en tablas y velocidad de carga sobre personalidad tipográfica. El peso 700 en encabezados es lo único que distingue "display" de "body".

### Hierarchy

- **Micro** (11px): metadatos de baja jerarquía — hora de un evento, nivel del personaje, pie de tile.
- **Label** (12px): etiquetas de formulario, chips, etiqueta y nota de `StatTile`.
- **Secondary** (13px): el peso de trabajo de la app — filas de tabla, subtítulos, ítems de nav, botones.
- **Body** (400, 14px, line-height 1.5): base declarada en `body`; texto corrido y formularios.
- **Emphasis** (600, 15px): marca del sidebar.
- **Title** (600, 16px): encabezado de tarjeta.
- **Page title** (700, 22px): `h1` de la topbar.
- **Cifras destacadas** (28px en `StatTile`, hasta 44px en marcadores): números grandes de KPI; se escogen por tile, no forman escala.
- **Mono**: cifras, fechas, folios y badge de semana, en cualquiera de los pasos de arriba.

### Named Rules
**La regla de los pasos reales.** Cualquier `font-size` nuevo debe caer en 11/12/13/14/15/16/22px, salvo cifras destacadas. Un paso fuera de esa lista es deriva, no diseño: si de verdad hace falta, se agrega aquí primero.

## Layout

Shell de dos columnas: sidebar fijo (`--nav-width: 240px`, `position: sticky`) sobre el mismo `--bg` que la página, sin borde divisorio, y `<main>` con `padding: 24px 28px`.

Dentro de `main`, cada pantalla abre con la topbar (`Header.svelte`): título y subtítulo a la izquierda; reloj, semana ISO, toggle de tema e identidad del usuario a la derecha, separados por un divisor de 1px.

El panel principal se lee en tres bandas, de arriba abajo:
1. **Fila de cifras** — cuatro `StatTile` en grid de 4 columnas; la primera es la destacada con gradiente y sparkline.
2. **Fila de gráficas** — grid `1.6fr 1fr`: volumen diario ancho + distribución por módulo angosto.
3. **Tabla** — ancho completo, con sus filtros en la cabecera de la tarjeta.

Puntos de quiebre: a 1100px las cifras pasan a 2 columnas y las gráficas se apilan; a 720px la topbar oculta reloj y texto de usuario; a 640px todo va a una columna.

## Elevation & Depth

La profundidad se lee por elevación real: superficie más clara + sombra difusa. Nada usa sombra offset sólida.

### Shadow Vocabulary
- **`--shadow-sm`** (`0 1px 2px 0` negro al 35% en oscuro / 6% en claro): tarjetas, tiles, tabla. Es el default de toda superficie.
- **`--shadow-md`** (`0 8px 24px -6px`): elementos que flotan sobre el contenido — dropdowns, toasts, avisos, modales.
- **`--shadow-accent`** (`0 10px 28px -8px` violeta): halo de la tarjeta destacada y del ítem de nav activo. Es la única sombra teñida.

### Named Rules
**La regla de la capa.** Si un elemento flota sobre el contenido, sube a `--shadow-md`; si vive en el flujo, se queda en `--shadow-sm`. No existe un tercer nivel neutro.

## Shapes

- **sm** (8px, `--radius-sm`): detalles chicos — skeletons, segmentos, realces internos.
- **md** (10px, `--radius`): inputs, botones, dropdowns, ítems de nav, chips de icono.
- **lg** (16px, `--radius-lg`): tarjetas, tiles, modales, contenedores.
- **pill** (999px, `--radius-pill`): chips de sistema, badges, barras de progreso, bloque de usuario.

### Named Rules
**La regla de los cuatro radios.** Solo existen 8px, 10px, 16px y 999px, siempre por token. Quedan en el código unos pocos 2px, 3px y 6px sueltos: son deriva heredada y deben converger a `sm` cuando se toque ese componente.

## Components

### Buttons
- **Shape:** `--radius` (10px).
- **Primary:** fondo `--accent`, texto blanco.
- **Hover:** fondo `--accent-strong`.
- **Secondary (`.boton-secundario`):** fondo `--surface`, borde 1px `--border`.

### Cards / Containers (`.tarjeta`, `.tile`, `.toast`)
- **Corner Style:** `--radius-lg` (16px).
- **Background:** `--surface`, opaco.
- **Shadow Strategy:** `--shadow-sm`; `--shadow-md` si flota.
- **Border:** 1px sólido `--border`.

### StatTile
- Chip de icono de 32px (`--radius`, fondo `--accent-soft`) sobre la etiqueta.
- Etiqueta 12px muted, cifra 28px peso 700, nota 12px faint debajo.
- Variante `destacada`: fondo `--accent-gradient`, texto blanco, `--shadow-accent`, sin borde. Acepta un snippet hijo (la sparkline) que hereda `--color-sparkline`.

### Inputs / Fields
- **Style:** fondo `--surface`, borde 1px `--border`, radio `--radius` (10px).
- **Focus:** contorno `2px solid var(--accent)` con `outline-offset: 2px`.

### Tables
- Cabecera 11px mayúsculas muted con divisor de 1px; filas de 13px con `padding: 13px 12px`.
- Hover de fila en `--surface-raised`; la última fila no lleva divisor.

### Navigation
- **Sidebar:** sobre `--bg`, sin borde derecho. Ítems inactivos en `--text-muted` con icono `--text-faint`; ítem activo con `--accent-gradient`, texto e icono blancos y `--shadow-accent`. Títulos de sección en 11px mayúsculas `--text-faint`, colapsables y persistidos en `localStorage`.
- **Topbar:** identidad del usuario como pastilla (`--radius-pill`) con avatar en gradiente, nombre y nivel.

## Do's and Don'ts

### Do:
- **Do** separar superficies con elevación (`--surface` + `--shadow-sm`), no con trazo.
- **Do** reservar `--accent-gradient` a una sola superficie por pantalla más el ítem de nav activo.
- **Do** usar los tokens `*-soft` para el relleno de cualquier badge o chip de estado.
- **Do** preservar los tres colores de sistema (Mediport/PIS/ProactivaNet) exactamente como están — están validados por contraste y CVD.

### Seasonal exception (mes patrio)

En septiembre, `app.html` fija `data-temporada="patrio"` en `<html>` (detectado por fecha del navegador, sin preferencia de usuario). Ese atributo activa `.franja-patria` en `Nav.svelte` (franja tricolor de 10px) y el componente `PapelPicado.svelte` — banderines reales con ondeo animado (`@keyframes ondear`, rotación ±5° escalonada por `generarBanderines()`), presente en `Nav.svelte`, `Header.svelte` (toda página autenticada) y la tarjeta de `/login`.

La temporada vive solo en esa decoración: no toca `--accent`, `--accent-gradient` ni ningún otro token. Antes sí los sustituía por verde y rojo bandera, y el resultado era que durante un mes entero la app no se parecía a sí misma. El violeta es la identidad los doce meses.

### Don't:
- **Don't** reintroducir bordes de 2px ni sombras offset sin desenfoque — es exactamente el sistema que este rediseño reemplazó.
- **Don't** usar `backdrop-filter`, superficies translúcidas ni blobs animados de fondo.
- **Don't** poner gradiente decorativo en el fondo de página ni en tarjetas normales (el `conic-gradient` del donut y el shimmer del skeleton son funcionales y quedan exceptuados).
- **Don't** introducir un segundo color de marca saturado compitiendo con el violeta; `--accent-2` es solo realce puntual.
- **Don't** aplicar este sistema a los avatares/creaturas 3D (Enemigo3D, Gatito3D, Personaje3D) ni a los minijuegos — son arte de la capa RPG, fuera del alcance de este rediseño operativo.
