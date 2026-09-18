import type { Accesorio, Apariencia, Cara, Espalda, FormaCuerpo } from './api/client';

export const ACCESORIOS: { valor: Accesorio; etiqueta: string }[] = [
	{ valor: 'ninguno', etiqueta: 'Ninguno' },
	{ valor: 'gorra', etiqueta: 'Gorra' },
	{ valor: 'casco', etiqueta: 'Casco' },
	{ valor: 'antenas', etiqueta: 'Antenas' },
	{ valor: 'sombrero', etiqueta: 'Sombrero' },
	{ valor: 'diadema', etiqueta: 'Diadema' },
	{ valor: 'aureola', etiqueta: 'Aureola' },
	{ valor: 'cuernos', etiqueta: 'Cuernos' },
	{ valor: 'visor', etiqueta: 'Visor' },
	{ valor: 'corona', etiqueta: 'Corona' }
];

export const FORMAS_CUERPO: { valor: FormaCuerpo; etiqueta: string }[] = [
	{ valor: 'normal', etiqueta: 'Normal' },
	{ valor: 'robusto', etiqueta: 'Robusto' },
	{ valor: 'delgado', etiqueta: 'Delgado' }
];

export const CARAS: { valor: Cara; etiqueta: string }[] = [
	{ valor: 'feliz', etiqueta: 'Feliz' },
	{ valor: 'serio', etiqueta: 'Serio' },
	{ valor: 'enojado', etiqueta: 'Enojado' },
	{ valor: 'kawaii', etiqueta: 'Kawaii' },
	{ valor: 'robot', etiqueta: 'Robot' }
];

export const ESPALDAS: { valor: Espalda; etiqueta: string }[] = [
	{ valor: 'ninguna', etiqueta: 'Nada' },
	{ valor: 'capa', etiqueta: 'Capa' },
	{ valor: 'mochila', etiqueta: 'Mochila' },
	{ valor: 'alas', etiqueta: 'Alas' }
];

export const COLOR_PIEL_DEFECTO = '#f2c9a1';
export const COLOR_CUERPO_DEFECTO = '#3b82f6';
export const COLOR_DETALLE_DEFECTO = '#222222';

export const APARIENCIA_DEFECTO: Apariencia = {
	color_piel: COLOR_PIEL_DEFECTO,
	color_cuerpo: COLOR_CUERPO_DEFECTO,
	accesorio: 'ninguno',
	color_detalle: COLOR_DETALLE_DEFECTO,
	forma_cuerpo: 'normal',
	cara: 'feliz',
	espalda: 'ninguna'
};
