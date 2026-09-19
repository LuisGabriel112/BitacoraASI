import { contextoAudio } from './audioContexto';

// Sonidos de fábrica sin archivo, generados con Web Audio igual que la
// fanfarria mariachi (sonidoMexicano.ts). Cada uno tiene una "partitura" pura
// (qué suena y cuándo, probada en sonidosSintetizados.test.ts) y un
// reproductor que la agenda en el AudioContext compartido.

export interface Nota {
	frecuenciaHz: number;
	inicioMs: number;
	duracionMs: number;
}

/** Nota con caída de tono: empieza en frecuenciaHz y termina en frecuenciaFinalHz. */
export interface NotaConCaida extends Nota {
	frecuenciaFinalHz: number;
}

export interface Tintineo {
	frecuenciaHz: number;
	inicioMs: number;
	duracionMs: number;
}

export interface Deslizamiento {
	inicioMs: number;
	duracionMs: number;
	frecuenciaInicialHz: number;
	frecuenciaFinalHz: number;
}

const SILENCIO = 0.0001;

// --- utilidades Web Audio ---------------------------------------------------

function ruidoBlanco(contexto: AudioContext, duracionS: number): AudioBufferSourceNode {
	const buffer = contexto.createBuffer(1, Math.ceil(contexto.sampleRate * duracionS), contexto.sampleRate);
	const datos = buffer.getChannelData(0);
	for (let i = 0; i < datos.length; i++) datos[i] = Math.random() * 2 - 1;
	const fuente = contexto.createBufferSource();
	fuente.buffer = buffer;
	return fuente;
}

/** Ganancia con ataque lineal y caída exponencial hasta el silencio en `fin`. */
function envolvente(contexto: AudioContext, inicio: number, ataqueS: number, fin: number, pico: number): GainNode {
	const ganancia = contexto.createGain();
	ganancia.gain.setValueAtTime(0, inicio);
	ganancia.gain.linearRampToValueAtTime(pico, inicio + ataqueS);
	ganancia.gain.exponentialRampToValueAtTime(SILENCIO, fin);
	return ganancia;
}

function golpeDeRuido(
	contexto: AudioContext,
	inicio: number,
	duracionS: number,
	pico: number,
	filtro: { tipo: BiquadFilterType; frecuenciaHz: number; q?: number }
): void {
	const ruido = ruidoBlanco(contexto, duracionS);
	const biquad = contexto.createBiquadFilter();
	biquad.type = filtro.tipo;
	biquad.frequency.value = filtro.frecuenciaHz;
	if (filtro.q !== undefined) biquad.Q.value = filtro.q;
	const ganancia = envolvente(contexto, inicio, 0.003, inicio + duracionS, pico);
	ruido.connect(biquad).connect(ganancia).connect(contexto.destination);
	ruido.start(inicio);
	ruido.stop(inicio + duracionS + 0.02);
}

function tono(
	contexto: AudioContext,
	tipo: OscillatorType,
	frecuenciaHz: number,
	inicio: number,
	fin: number,
	pico: number,
	ataqueS = 0.01
): OscillatorNode {
	const oscilador = contexto.createOscillator();
	oscilador.type = tipo;
	oscilador.frequency.setValueAtTime(frecuenciaHz, inicio);
	oscilador.connect(envolvente(contexto, inicio, ataqueS, fin, pico)).connect(contexto.destination);
	oscilador.start(inicio);
	oscilador.stop(fin + 0.02);
	return oscilador;
}

// --- victoria: campanita ascendente que remata en acorde ---------------------

// Escalera pentatónica D5 → D6 (rápida, ligada) y un acorde de Re mayor
// sostenido como remate: el "level up" de videojuego.
const ESCALERA_VICTORIA_HZ = [587.33, 659.25, 783.99, 880, 1046.5, 1174.66];
const ACORDE_VICTORIA_HZ = [587.33, 739.99, 880, 1174.66];
const PASO_ESCALERA_MS = 70;
const DURACION_PASO_MS = 95;
const DURACION_ACORDE_MS = 620;

export function notasVictoria(): Nota[] {
	const escalera = ESCALERA_VICTORIA_HZ.map((frecuenciaHz, i) => ({
		frecuenciaHz,
		inicioMs: i * PASO_ESCALERA_MS,
		duracionMs: DURACION_PASO_MS
	}));
	const inicioAcorde = ESCALERA_VICTORIA_HZ.length * PASO_ESCALERA_MS;
	const acorde = ACORDE_VICTORIA_HZ.map((frecuenciaHz) => ({
		frecuenciaHz,
		inicioMs: inicioAcorde,
		duracionMs: DURACION_ACORDE_MS
	}));
	return [...escalera, ...acorde];
}

export function reproducirVictoria(contexto: AudioContext = contextoAudio()): void {
	const ahora = contexto.currentTime;
	for (const nota of notasVictoria()) {
		const inicio = ahora + nota.inicioMs / 1000;
		const fin = inicio + nota.duracionMs / 1000;
		const esAcorde = nota.duracionMs === DURACION_ACORDE_MS;
		tono(contexto, 'triangle', nota.frecuenciaHz, inicio, fin, esAcorde ? 0.13 : 0.2);
		// brillo una octava arriba, muy suave, para que suene a campana y no a flauta
		tono(contexto, 'sine', nota.frecuenciaHz * 2, inicio, fin, esAcorde ? 0.04 : 0.06);
	}
}

// --- derrota: trombón triste --------------------------------------------------

// Cuatro notas que bajan de semitono en semitono y cada una resbala hacia
// abajo mientras suena; la última se arrastra más y cae hasta La3.
const SEMITONO = 2 ** (1 / 12);
const INICIOS_DERROTA_HZ = [311.13, 293.66, 277.18, 261.63];
const DURACION_NOTA_DERROTA_MS = 260;
const SEPARACION_DERROTA_MS = 300;
const DURACION_ULTIMA_DERROTA_MS = 720;
const FINAL_ULTIMA_DERROTA_HZ = 220;

export function notasDerrota(): NotaConCaida[] {
	return INICIOS_DERROTA_HZ.map((frecuenciaHz, i) => {
		const esUltima = i === INICIOS_DERROTA_HZ.length - 1;
		return {
			frecuenciaHz,
			frecuenciaFinalHz: esUltima ? FINAL_ULTIMA_DERROTA_HZ : frecuenciaHz / SEMITONO,
			inicioMs: i * SEPARACION_DERROTA_MS,
			duracionMs: esUltima ? DURACION_ULTIMA_DERROTA_MS : DURACION_NOTA_DERROTA_MS
		};
	});
}

export function reproducirDerrota(contexto: AudioContext = contextoAudio()): void {
	const ahora = contexto.currentTime;
	for (const nota of notasDerrota()) {
		const inicio = ahora + nota.inicioMs / 1000;
		const fin = inicio + nota.duracionMs / 1000;

		// filtro "wah": se abre al atacar la nota y se cierra mientras cae
		const filtro = contexto.createBiquadFilter();
		filtro.type = 'lowpass';
		filtro.Q.value = 4;
		filtro.frequency.setValueAtTime(450, inicio);
		filtro.frequency.linearRampToValueAtTime(1500, inicio + 0.09);
		filtro.frequency.exponentialRampToValueAtTime(380, fin);
		filtro.connect(envolvente(contexto, inicio, 0.03, fin, 0.22)).connect(contexto.destination);

		for (const desafine of [0, -7]) {
			const oscilador = contexto.createOscillator();
			oscilador.type = 'sawtooth';
			oscilador.detune.value = desafine;
			oscilador.frequency.setValueAtTime(nota.frecuenciaHz, inicio);
			oscilador.frequency.exponentialRampToValueAtTime(nota.frecuenciaFinalHz, fin);
			oscilador.connect(filtro);
			oscilador.start(inicio);
			oscilador.stop(fin + 0.02);
		}
	}
}

// --- compra: caja registradora ("ka-ching") ----------------------------------

/** Momentos (ms) de cada parte del sonido, en el orden en que pasan. */
export const PARTES_CAJA_REGISTRADORA = { tecla: 0, campana: 35, cajon: 190, tope: 340 } as const;

export function reproducirCajaRegistradora(contexto: AudioContext = contextoAudio()): void {
	const ahora = contexto.currentTime;
	const en = (ms: number) => ahora + ms / 1000;

	// clic mecánico de la tecla
	golpeDeRuido(contexto, en(PARTES_CAJA_REGISTRADORA.tecla), 0.025, 0.45, { tipo: 'lowpass', frecuenciaHz: 3200 });

	// campana brillante con un parcial metálico, decae largo
	const inicioCampana = en(PARTES_CAJA_REGISTRADORA.campana);
	tono(contexto, 'sine', 2637, inicioCampana, inicioCampana + 0.75, 0.35, 0.004);
	tono(contexto, 'sine', 3951, inicioCampana, inicioCampana + 0.45, 0.14, 0.004);
	tono(contexto, 'triangle', 1318.5, inicioCampana, inicioCampana + 0.3, 0.08, 0.004);

	// el cajón que se desliza y el tope al abrirse
	golpeDeRuido(contexto, en(PARTES_CAJA_REGISTRADORA.cajon), 0.14, 0.22, { tipo: 'bandpass', frecuenciaHz: 900, q: 0.8 });
	const inicioTope = en(PARTES_CAJA_REGISTRADORA.tope);
	golpeDeRuido(contexto, inicioTope, 0.04, 0.4, { tipo: 'lowpass', frecuenciaHz: 500 });
	tono(contexto, 'sine', 150, inicioTope, inicioTope + 0.07, 0.3, 0.003);
}

// --- compra: monedas ------------------------------------------------------------

const CANTIDAD_MONEDAS = 6;
const FRECUENCIAS_MONEDA_HZ = [2093, 2349.3, 2637, 2793.8, 3136, 3520];
const SEPARACION_MONEDAS_MIN_MS = 55;
const SEPARACION_MONEDAS_MAX_MS = 95;
const DURACION_TINTINEO_MIN_MS = 180;
const DURACION_TINTINEO_MAX_MS = 260;

/** Seis monedas que caen una tras otra, cada una con su tono y su separación. */
export function tintineosMonedas(aleatorio: () => number = Math.random): Tintineo[] {
	const tintineos: Tintineo[] = [];
	let inicioMs = 0;
	for (let i = 0; i < CANTIDAD_MONEDAS; i++) {
		const base = FRECUENCIAS_MONEDA_HZ[Math.floor(aleatorio() * FRECUENCIAS_MONEDA_HZ.length)];
		tintineos.push({
			frecuenciaHz: base * (1 + (aleatorio() - 0.5) * 0.06),
			inicioMs,
			duracionMs: DURACION_TINTINEO_MIN_MS + aleatorio() * (DURACION_TINTINEO_MAX_MS - DURACION_TINTINEO_MIN_MS)
		});
		inicioMs += SEPARACION_MONEDAS_MIN_MS + aleatorio() * (SEPARACION_MONEDAS_MAX_MS - SEPARACION_MONEDAS_MIN_MS);
	}
	return tintineos;
}

export function reproducirMonedas(contexto: AudioContext = contextoAudio()): void {
	const ahora = contexto.currentTime;
	for (const t of tintineosMonedas()) {
		const inicio = ahora + t.inicioMs / 1000;
		const fin = inicio + t.duracionMs / 1000;
		tono(contexto, 'sine', t.frecuenciaHz, inicio, fin, 0.22, 0.003);
		// parcial no armónico: lo que hace que suene a metal y no a flauta
		tono(contexto, 'sine', t.frecuenciaHz * 2.76, inicio, inicio + t.duracionMs / 2000, 0.07, 0.003);
	}
}

// --- ruleta de casino (al jugar la Ruleta rusa) ---------------------------------

const INTERVALO_INICIAL_RULETA_MS = 40;
const FACTOR_FRENADO_RULETA = 1.09;
const INTERVALO_FINAL_RULETA_MS = 240;
const COLA_RULETA_MS = 320;

/** Instantes (ms) en que la bola pega con los separadores: cada vez más
 *  espaciados, como la rueda que frena, hasta que se asienta. */
export function golpesRuleta(): number[] {
	const golpes: number[] = [];
	let t = 0;
	let intervalo = INTERVALO_INICIAL_RULETA_MS;
	while (intervalo <= INTERVALO_FINAL_RULETA_MS) {
		golpes.push(Math.round(t));
		t += intervalo;
		intervalo *= FACTOR_FRENADO_RULETA;
	}
	return golpes;
}

function ultimoGolpeRuleta(): number {
	const golpes = golpesRuleta();
	return golpes[golpes.length - 1];
}

/** Cuánto dura el giro completo: lo que espera el minijuego antes de revelar. */
export const DURACION_RULETA_MS = ultimoGolpeRuleta() + COLA_RULETA_MS;

export function reproducirRuletaCasino(contexto: AudioContext = contextoAudio()): void {
	const ahora = contexto.currentTime;
	const golpes = golpesRuleta();
	const finGiro = ahora + DURACION_RULETA_MS / 1000;

	// zumbido de la rueda girando, que se apaga conforme frena
	const rueda = ruidoBlanco(contexto, DURACION_RULETA_MS / 1000);
	const filtroRueda = contexto.createBiquadFilter();
	filtroRueda.type = 'lowpass';
	filtroRueda.frequency.setValueAtTime(700, ahora);
	filtroRueda.frequency.exponentialRampToValueAtTime(180, finGiro);
	const gananciaRueda = contexto.createGain();
	gananciaRueda.gain.setValueAtTime(0.12, ahora);
	gananciaRueda.gain.exponentialRampToValueAtTime(SILENCIO, finGiro);
	rueda.connect(filtroRueda).connect(gananciaRueda).connect(contexto.destination);
	rueda.start(ahora);
	rueda.stop(finGiro);

	// la bola pegando con los separadores
	for (const ms of golpes) {
		golpeDeRuido(contexto, ahora + ms / 1000, 0.012, 0.6, { tipo: 'bandpass', frecuenciaHz: 3200, q: 1.5 });
	}

	// se asienta: dos rebotes cortos y un golpe seco grave
	const ultimo = ahora + ultimoGolpeRuleta() / 1000;
	for (const rebote of [0.09, 0.15]) {
		golpeDeRuido(contexto, ultimo + rebote, 0.01, 0.35, { tipo: 'bandpass', frecuenciaHz: 2600, q: 1.5 });
	}
	const asiento = ultimo + 0.2;
	golpeDeRuido(contexto, asiento, 0.05, 0.35, { tipo: 'lowpass', frecuenciaHz: 600 });
	const grave = tono(contexto, 'sine', 190, asiento, asiento + 0.12, 0.3, 0.003);
	grave.frequency.exponentialRampToValueAtTime(90, asiento + 0.12);
}

// --- vasos sobre la mesa (al empezar Encuentra la pelota) ------------------------

const CANTIDAD_DESLIZAMIENTOS = 4;
const DURACION_DESLIZAMIENTO_MS = 220;
const SEPARACION_DESLIZAMIENTOS_MS = 235;
const VARIACION_INICIO_MS = 20;
const FRECUENCIAS_VASO_HZ: [number, number] = [520, 820];

/** Cuatro vasos que se arrastran uno tras otro, alternando el sentido del
 *  roce (el filtro sube o baja de tono) para que no suenen iguales. */
export function deslizamientosVasos(aleatorio: () => number = Math.random): Deslizamiento[] {
	const [grave, agudo] = FRECUENCIAS_VASO_HZ;
	return Array.from({ length: CANTIDAD_DESLIZAMIENTOS }, (_, i) => {
		const haciaArriba = i % 2 === 0;
		return {
			inicioMs: i * SEPARACION_DESLIZAMIENTOS_MS + Math.round((aleatorio() - 0.5) * 2 * VARIACION_INICIO_MS),
			duracionMs: DURACION_DESLIZAMIENTO_MS,
			frecuenciaInicialHz: haciaArriba ? grave : agudo,
			frecuenciaFinalHz: haciaArriba ? agudo : grave
		};
	});
}

export function reproducirVasosMesa(contexto: AudioContext = contextoAudio()): void {
	const ahora = contexto.currentTime;
	for (const d of deslizamientosVasos()) {
		const inicio = ahora + Math.max(0, d.inicioMs) / 1000;
		const fin = inicio + d.duracionMs / 1000;

		// el roce del vaso: ruido en banda que se mueve mientras se arrastra
		const roce = ruidoBlanco(contexto, d.duracionMs / 1000);
		const filtro = contexto.createBiquadFilter();
		filtro.type = 'bandpass';
		filtro.Q.value = 1.2;
		filtro.frequency.setValueAtTime(d.frecuenciaInicialHz, inicio);
		filtro.frequency.exponentialRampToValueAtTime(d.frecuenciaFinalHz, fin);
		const ganancia = contexto.createGain();
		ganancia.gain.setValueAtTime(0, inicio);
		ganancia.gain.linearRampToValueAtTime(0.5, inicio + (d.duracionMs * 0.35) / 1000);
		ganancia.gain.linearRampToValueAtTime(SILENCIO, fin);
		roce.connect(filtro).connect(ganancia).connect(contexto.destination);
		roce.start(inicio);
		roce.stop(fin + 0.02);

		// el vaso se detiene: toque seco contra la mesa
		golpeDeRuido(contexto, fin, 0.018, 0.4, { tipo: 'lowpass', frecuenciaHz: 1800 });
		tono(contexto, 'sine', 320, fin, fin + 0.045, 0.22, 0.002);
	}
}
