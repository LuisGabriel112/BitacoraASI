export function hashTexto(texto: string): number {
	let h = 0;
	for (let i = 0; i < texto.length; i++) h = (h * 31 + texto.charCodeAt(i)) | 0;
	return Math.abs(h);
}
