# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Personal de soporte operativo y administrativo del puerto (ASIPONA), operando desde escritorio/oficina. Registran incidencias de terminales, aduanas, naviera y control de accesos; jefatura/administrativos revisan reportes y síntesis. Uso exclusivamente en desktop, no en campo.

## Product Purpose

Bitácora interna de soporte operativo portuario. Reemplaza el Excel semanal que antes se entregaba al cliente portuario, centralizando el registro de incidencias por sistema/módulo, su seguimiento (Trello) y la generación de reportes/gráficas para el cliente.

## Positioning

Registro estructurado y trazable de incidencias operativas (con catálogo de módulos que crece por uso real, no por lista precargada), en vez de una hoja de cálculo manual entregada semanalmente.

## Operating Context

- Registro de incidencias por sistema (Mediport, PIS, ProactivaNet) y módulo.
- Cada registro nuevo crea tarjeta en Trello; si Trello falla, el registro igual se guarda y se puede reintentar sin perderlo.
- Reportes/gráficas para entrega periódica al cliente portuario.
- Incluye capas de gamificación interna (mascotas, personaje, logros, minijuegos, easter eggs) como capa de moral/engagement del equipo, separada del flujo operativo core.
- Roles: soporte operativo (alta/consulta de registros) y jefatura/administrativo (reportes, gestión de catálogos, vista "jefe").

## Capabilities and Constraints

- Stack existente: FastAPI + PostgreSQL (Supabase) + SvelteKit/Svelte 5 + Docker. No se cambia el stack en este trabajo, solo la capa visual.
- Solo desktop/oficina — no se optimiza para campo, luz exterior ni tablet en este momento.
- Sin restricción de marca institucional: libertad total de paleta y tipografía para el redesign.
- Tokens de sistema por color (Mediport/PIS/ProactivaNet) están validados por contraste y daltonismo (CVD deutan/protan) — cualquier cambio de paleta debe re-validar ese trío, no solo sustituirlo a gusto.

## Product Principles

- Claridad operativa antes que estética: es una herramienta de trabajo diario, no un producto de venta.
- Consistencia total entre bitácora técnica y vista administrativa/jefe.
- La capa lúdica (mascotas/minijuegos/logros) es bienvenida pero secundaria al flujo de registro y reporte.
- Datos y cifras siempre legibles primero (tabular-nums, jerarquía clara) — el estilo no debe sacrificar escaneo rápido de tablas/reportes.

## Accessibility & Inclusion

Paleta de sistemas (Mediport/PIS/ProactivaNet) ya validada para contraste ≥3:1 sobre superficie y distinguibilidad CVD (deuteranopía/protanopía). Preservar ese estándar en cualquier paleta nueva.
