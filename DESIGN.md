---
name: Bitácora ASIPONA
description: Bitácora interna de soporte operativo portuario — plana, de borde duro y acento violeta.
colors:
  bg: "oklch(0.14 0.012 250)"
  surface: "oklch(0.19 0.014 250)"
  surface-raised: "oklch(0.24 0.016 250)"
  border: "oklch(0.32 0.016 250)"
  border-strong: "oklch(0.93 0.01 250)"
  text: "oklch(0.97 0.004 250)"
  text-muted: "oklch(0.74 0.012 250)"
  text-faint: "oklch(0.56 0.012 250)"
  accent: "oklch(0.64 0.24 296)"
  accent-strong: "oklch(0.72 0.25 296)"
  accent-2: "oklch(0.83 0.17 95)"
  success: "#3b9b6f"
  warning: "#d97706"
  danger: "#c1443c"
  sistema-mediport: "#3987e5"
  sistema-pis: "#199e70"
  sistema-proactivanet: "#d95926"
typography:
  display:
    fontFamily: "system-ui, -apple-system, 'Helvetica Neue', Arial, sans-serif"
    fontWeight: 700
    letterSpacing: "-0.01em"
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
  lg: "14px"
components:
  button-primary:
    backgroundColor: "{colors.accent}"
    textColor: "#ffffff"
    rounded: "{rounded.sm}"
  button-primary-hover:
    backgroundColor: "{colors.accent-strong}"
  button-secondary:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text}"
    rounded: "{rounded.sm}"
  card:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.lg}"
    padding: "18px"
---

# Design System: Bitácora ASIPONA

## Overview

**Creative North Star: "El expediente plano"**

Bitácora dejó el glassmorphism translúcido (blur, blobs animados, superficies semi-transparentes) por una identidad plana de alto contraste: superficies opacas, bordes duros de 2px y sombras offset sin desenfoque. Es una herramienta de trabajo diario para soporte operativo y jefatura de un puerto — no un producto de venta — así que la energía visual vive en un solo acento violeta contundente y en el trazo duro de cada tarjeta, nunca en compitir con las cifras de una tabla.

Los tres colores de sistema (Mediport azul, PIS verde, ProactivaNet naranja) se preservan intactos: están validados por contraste y distinguibilidad CVD (deuteranopía/protanopía) y no forman parte de esta exploración estética.

**Key Characteristics:**
- Plano y opaco: cero `backdrop-filter`, cero translucidez, cero gradiente decorativo de fondo.
- Un solo acento (violeta) para acción primaria y estado activo — el resto de la paleta es neutro o semántico (éxito/alerta/peligro/sistema).
- Borde duro de 2px como firma estructural, reutilizado en tarjetas, tiles, modales, inputs y nav.
- Sombra offset sin blur (`4px 4px 0 0`) en vez de elevación difusa.

## Colors

Paleta restringida: fondo/superficie neutros y opacos, un acento violeta que carga toda la acción primaria, más los semánticos y de sistema ya validados.

### Primary
- **Violeta contundente** (`oklch(0.64 0.24 296)` oscuro / `oklch(0.5 0.22 296)` claro): botón primario, ítem de nav activo, foco, enlaces de acción. Reservado — no decora superficies grandes.

### Neutral
- **Lienzo** — `--bg` (`oklch(0.14 0.012 250)` oscuro / `oklch(0.97 0.004 250)` claro): fondo de página, plano, sin gradiente.
- **Superficie** — `--surface` (`oklch(0.19 0.014 250)` oscuro / `oklch(1 0 0)` claro): tarjetas, nav, tabla, inputs.
- **Superficie elevada** — `--surface-raised`: hover, dropdowns, popovers.
- **Borde suave** — `--border`: divisores internos de baja jerarquía.
- **Borde duro** — `--border-strong` (`oklch(0.93 0.01 250)` oscuro / `oklch(0.16 0.02 250)` claro): el trazo estructural de 2px que define cada tarjeta, input y elemento flotante; también el color de la sombra offset.
- **Texto** — `--text` / `--text-muted` / `--text-faint`: jerarquía de lectura sobre superficie.

### Velo (scrim)
- **Velo de fondo** (`oklch(0 0 0 / 0.5)`): oscurece lo que queda detrás de un modal (`GestionCatalogos`) o de un aviso flotante sobre la arena 3D. Es el único negro translúcido del sistema — antes convivían un 0.5 y un 0.55 sin razón, y se unificaron al 0.5.

### Sistema (fijo, no explorar)
- **Mediport** `#3987e5`, **PIS** `#199e70`, **ProactivaNet** `#d95926` (oscuro); `#1f5db3` / `#0f7a52` / `#b8451a` (claro). Trío validado CVD — cualquier cambio exige re-correr `validate_palette.js`.

### Named Rules
**La regla del acento único.** El violeta es la única superficie con permiso de saturación fuerte. No se introduce un segundo color "de marca"; `--accent-2` (dorado) es un realce puntual (rachas, logros), nunca un segundo protagonista.

## Typography

**Display Font:** system-ui, -apple-system, 'Helvetica Neue', Arial, sans-serif (peso 700, `letter-spacing: -0.01em`)
**Body Font:** la misma pila system-ui (peso 400)
**Mono Font:** ui-monospace / SFMono-Regular / Menlo / Consolas — reservado a cifras, fechas y folios (`font-variant-numeric: tabular-nums` en `body`).

**Character:** una sola familia nativa para todo, sin webfont externo — prioriza densidad de lectura en tablas y velocidad de carga sobre personalidad tipográfica. El peso 700 en encabezados es lo único que distingue "display" de "body".

### Hierarchy

La escala real medida sobre el código, de menor a mayor. No es una escala
modular teórica: son los pasos que el proyecto ya usa, ordenados por frecuencia
de uso real (13px es el más común con 89 apariciones, luego 12px con 69 y 11px
con 37).

- **Micro** (11px): metadatos de baja jerarquía — hora de un evento, autor de un daño, nivel del personaje.
- **Label** (12px): etiquetas de formulario, textos de ayuda, chips, pies de tarjeta.
- **Secondary** (13px): el peso de trabajo de la app — filas de tabla, subtítulos, descripciones, botones.
- **Body** (400, 14px, line-height 1.5): base declarada en `body`; texto corrido y formularios.
- **Emphasis** (600, 15px): marca del nav y etiqueta de semana en la barra lateral.
- **Title** (600, 16px): encabezado de tarjeta (`h2` de minijuegos y paneles).
- **Display** (700, tamaño nativo del navegador por nivel h1/h2/h3, `-0.01em`): títulos de página y de sección.
- **Cifras destacadas** (18–44px): números grandes de KPI en `StatTile` y marcadores; se escogen por tile, no forman escala.
- **Mono**: cifras, fechas, folios y badges de semana, en cualquiera de los pasos de arriba.

### Named Rules
**La regla de los pasos reales.** Cualquier `font-size` nuevo debe caer en
11/12/13/14/15/16px, salvo cifras destacadas. Un paso fuera de esa lista es
deriva, no diseño: si de verdad hace falta, se agrega aquí primero.

## Layout

Sin grid formal ni escala de espaciado tokenizada; el espaciado es ad hoc por componente, comúnmente en pasos de 8/12/16/18/24/28px. Shell de dos columnas: nav lateral fija (`--nav-width: 240px`, `position: sticky`) + `<main>` con `padding: 24px 28px`. Sin comportamiento responsive dedicado (producto de escritorio/oficina únicamente, confirmado en PRODUCT.md).

## Elevation & Depth

Sistema plano con sombra offset como firma, no elevación difusa. Nada usa blur en la sombra; la profundidad se lee por el trazo duro + el desplazamiento sólido, no por difuminado.

### Shadow Vocabulary
- **`--shadow-flat`** (`box-shadow: 4px 4px 0 0 var(--border-strong)`): tarjetas, tiles, toasts, dropdowns y modales pequeños.
- **`--shadow-flat-sm`** (`2px 2px 0 0 var(--border-strong)`): disponible para elementos compactos; aún sin consumidor dedicado.
- **Sombra de modal grande** (`6px 6px 0 0 var(--border-strong)`, inline en login y `GestionCatalogos`): momentos de mayor peso (tarjeta de login, modal de catálogos).

### Named Rules
**La regla sin blur.** Ninguna sombra de UI lleva desenfoque. Si algo necesita separarse del fondo, se separa con trazo duro + offset sólido, nunca con blur.

## Shapes

Radios moderados, no pill/blob: `--radius` (8px) para inputs, botones y dropdowns; `--radius-lg` (14px) para tarjetas y modales. Todo elemento con superficie propia (tarjeta, tile, toast, modal, dropdown) lleva borde de 2px sólido en `--border-strong` — ese trazo, no el radio, es la firma de forma del sistema.

## Components

### Buttons
- **Shape:** `--radius` (8px).
- **Primary:** fondo `--accent`, texto blanco; usado en CTAs (Entrar, avatar de header, ítem de nav activo).
- **Hover:** fondo `--accent-strong`.
- **Secondary (`.boton-secundario`):** fondo `--surface`, borde `--border-strong`.

### Cards / Containers (`.tarjeta`, `.tile`, `.toast`)
- **Corner Style:** `--radius-lg` (14px) en tarjetas; `--radius` (8px) en toasts/tiles pequeños.
- **Background:** `--surface`, opaco.
- **Shadow Strategy:** `--shadow-flat` (ver Elevation & Depth).
- **Border:** 2px sólido `--border-strong`.

### Inputs / Fields
- **Style:** fondo `--surface`, borde 2px `--border-strong`, radio `--radius`.
- **Focus:** contorno `2px solid var(--accent)` con `outline-offset: 2px` (sin glow ni blur).

### Navigation
- **Style:** `.nav` lateral opaca (`--surface`) con borde derecho duro. Ítems inactivos en `--text-muted`; ítem activo con fondo sólido `--accent` y texto/ícono blanco (pastilla plana, sin mezcla de color ni inset shadow).

## Do's and Don'ts

### Do:
- **Do** usar `--border-strong` a 2px sólido como firma estructural de cualquier superficie nueva (tarjeta, modal, input, dropdown).
- **Do** reservar el violeta (`--accent`) a acción primaria y estado activo; todo lo demás vive en superficie neutra.
- **Do** preservar los tres colores de sistema (Mediport/PIS/ProactivaNet) exactamente como están — están validados por contraste y CVD.
- **Do** usar `--shadow-flat` (sin blur) para separar elementos flotantes del fondo.

### Seasonal exception (mes patrio)

En septiembre, `app.html` fija `data-temporada="patrio"` en `<html>` (detectado por fecha del navegador, sin preferencia de usuario). Ese atributo sustituye `--accent`/`--accent-strong`/`--accent-2` por verde (`#006341`) y rojo (`#ce1126`) bandera, y activa: `.franja-patria` en `Nav.svelte` (franja tricolor de 10px), un fondo tintado en `.marca`, y el componente `PapelPicado.svelte` — banderines reales (no SVG estático) con ondeo animado (`@keyframes ondear`, rotación ±5° escalonada por `generarBanderines()`), presente en `Nav.svelte`, `Header.svelte` (toda página autenticada) y la tarjeta de `/login`. Es la única excepción a la regla del acento único y a "sin decoración adicional" — vencida el resto del año, vuelve sola al violeta.

### Don't:
- **Don't** reintroducir `backdrop-filter`, superficies translúcidas o blobs animados de fondo — es exactamente el mundo visual que este redesign reemplazó.
- **Don't** usar gradiente decorativo en fondo de página o de tarjeta (el `conic-gradient` del donut y el shimmer del skeleton son funcionales, no decorativos, y quedan exceptuados).
- **Don't** introducir un segundo color de marca saturado compitiendo con el violeta; `--accent-2` es solo realce puntual.
- **Don't** aplicar este sistema a los avatares/creaturas 3D (Enemigo3D, Gatito3D, Personaje3D) ni a los minijuegos — son arte de la capa RPG, fuera del alcance de este redesign operativo.
