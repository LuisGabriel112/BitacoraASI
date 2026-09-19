// Un solo AudioContext para todos los sonidos sintetizados: los navegadores
// limitan cuántos contextos pueden existir a la vez y crear uno por
// reproducción los dejaba abiertos. Se crea la primera vez que hace falta
// (siempre tras un clic del usuario, que es lo que exige el navegador para
// dejar sonar audio) y se reanuda si quedó suspendido.
let contexto: AudioContext | null = null;

export function contextoAudio(): AudioContext {
	if (!contexto) contexto = new AudioContext();
	if (contexto.state === 'suspended') void contexto.resume();
	return contexto;
}
