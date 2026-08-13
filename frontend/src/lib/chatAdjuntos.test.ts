import { describe, expect, it } from 'vitest';
import { extraerImagenDePortapapeles, extraerPrimerArchivoSoltado } from './chatAdjuntos';

function itemArchivo(type: string, archivo: File | null) {
	return { kind: 'file', type, getAsFile: () => archivo };
}

function itemTexto() {
	return { kind: 'string', type: 'text/plain', getAsFile: () => null };
}

describe('extraerImagenDePortapapeles', () => {
	it('obtiene la imagen cuando el portapapeles trae un archivo de tipo imagen', () => {
		const png = new File(['x'], 'captura.png', { type: 'image/png' });
		expect(extraerImagenDePortapapeles([itemArchivo('image/png', png)])).toBe(png);
	});

	it('ignora un elemento de texto', () => {
		expect(extraerImagenDePortapapeles([itemTexto()])).toBeNull();
	});

	it('devuelve null si el portapapeles esta vacio', () => {
		expect(extraerImagenDePortapapeles([])).toBeNull();
	});

	it('encuentra la imagen aunque venga despues de un elemento de texto', () => {
		const jpg = new File(['x'], 'captura.jpg', { type: 'image/jpeg' });
		const items = [itemTexto(), itemArchivo('image/jpeg', jpg)];
		expect(extraerImagenDePortapapeles(items)).toBe(jpg);
	});
});

describe('extraerPrimerArchivoSoltado', () => {
	it('obtiene el archivo soltado', () => {
		const doc = new File(['x'], 'reporte.pdf', { type: 'application/pdf' });
		expect(extraerPrimerArchivoSoltado([doc])).toBe(doc);
	});

	it('devuelve null si no hay archivos', () => {
		expect(extraerPrimerArchivoSoltado([])).toBeNull();
	});

	it('toma solo el primero cuando se sueltan varios', () => {
		const uno = new File(['x'], 'uno.png', { type: 'image/png' });
		const dos = new File(['x'], 'dos.png', { type: 'image/png' });
		expect(extraerPrimerArchivoSoltado([uno, dos])).toBe(uno);
	});
});
