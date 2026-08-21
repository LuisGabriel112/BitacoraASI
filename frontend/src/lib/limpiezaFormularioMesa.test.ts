import { describe, expect, it } from 'vitest';
import { limpiarExceptoResolutor } from './limpiezaFormularioMesa';

type FormularioMesa = {
	resolutorId: number | null;
	resolutorNombre: string;
	titulo: string;
	descripcion: string;
};

const vacio: FormularioMesa = { resolutorId: null, resolutorNombre: '', titulo: '', descripcion: '' };

describe('limpiarExceptoResolutor', () => {
	it('conserva resolutorId y resolutorNombre, limpia el resto', () => {
		const lleno: FormularioMesa = {
			resolutorId: 7,
			resolutorNombre: 'Reyes Cicero, Sergio',
			titulo: 'Algo se cayó',
			descripcion: 'Detalle largo'
		};
		expect(limpiarExceptoResolutor(lleno, vacio)).toEqual({
			...vacio,
			resolutorId: 7,
			resolutorNombre: 'Reyes Cicero, Sergio'
		});
	});

	it('si no había resolutor seleccionado, queda igual que el formulario vacío', () => {
		const lleno: FormularioMesa = { resolutorId: null, resolutorNombre: '', titulo: 'x', descripcion: 'y' };
		expect(limpiarExceptoResolutor(lleno, vacio)).toEqual(vacio);
	});
});
