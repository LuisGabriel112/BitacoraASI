interface ElementoPortapapeles {
	kind: string;
	type: string;
	getAsFile(): File | null;
}

export function extraerImagenDePortapapeles(items: ElementoPortapapeles[]): File | null {
	const item = items.find((i) => i.kind === 'file' && i.type.startsWith('image/'));
	return item?.getAsFile() ?? null;
}

export function extraerPrimerArchivoSoltado(archivos: ArrayLike<File>): File | null {
	return archivos[0] ?? null;
}
