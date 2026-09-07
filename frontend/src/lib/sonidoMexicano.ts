export interface NotaFanfarria {
	frecuenciaHz: number;
	inicioMs: number;
	duracionMs: number;
}

// Arpegio ascendente C5-E5-G5-C6: el "sting" de trompeta mariachi típico,
// sostenido en la última nota como remate.
const FRECUENCIAS_HZ = [523.25, 659.25, 783.99, 1046.5];
const DURACION_NOTA_MS = 130;
const DURACION_NOTA_FINAL_MS = 380;

export function notasFanfarriaMexicana(): NotaFanfarria[] {
	let inicioMs = 0;
	return FRECUENCIAS_HZ.map((frecuenciaHz, indice) => {
		const esUltima = indice === FRECUENCIAS_HZ.length - 1;
		const duracionMs = esUltima ? DURACION_NOTA_FINAL_MS : DURACION_NOTA_MS;
		const nota: NotaFanfarria = { frecuenciaHz, inicioMs, duracionMs };
		inicioMs += duracionMs;
		return nota;
	});
}

// Reproducción real vía Web Audio: dos osciladores de diente de sierra
// (uno ligeramente desafinado) filtrados en paso-bajo, para una textura más
// "de metal" que un tono puro — sin depender de ningún archivo de audio.
export function reproducirFanfarriaMexicana(contexto: AudioContext = new AudioContext()): void {
	const ahora = contexto.currentTime;

	for (const nota of notasFanfarriaMexicana()) {
		const inicio = ahora + nota.inicioMs / 1000;
		const duracion = nota.duracionMs / 1000;
		const fin = inicio + duracion;

		const filtro = contexto.createBiquadFilter();
		filtro.type = 'lowpass';
		filtro.frequency.value = 2200;
		filtro.connect(contexto.destination);

		const ganancia = contexto.createGain();
		ganancia.gain.setValueAtTime(0, inicio);
		ganancia.gain.linearRampToValueAtTime(0.25, inicio + 0.015);
		ganancia.gain.linearRampToValueAtTime(0, fin);
		ganancia.connect(filtro);

		for (const desafine of [0, 6]) {
			const oscilador = contexto.createOscillator();
			oscilador.type = 'sawtooth';
			oscilador.frequency.value = nota.frecuenciaHz;
			oscilador.detune.value = desafine;
			oscilador.connect(ganancia);
			oscilador.start(inicio);
			oscilador.stop(fin);
		}
	}
}
