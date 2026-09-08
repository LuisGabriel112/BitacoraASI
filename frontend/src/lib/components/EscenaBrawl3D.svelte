<script lang="ts">
	import * as THREE from 'three';
	import {
		ALTO_MUNDO,
		ANCHO_MUNDO,
		ESCALA_MUNDO,
		aMundo,
		alturaRebote,
		colorVida,
		crearParticulas,
		intensidadSacudida,
		particulaViva,
		posicionParticula,
		type Particula
	} from '$lib/brawlVisual';
	import type { BotRemoto, JugadorRemoto, MuroRemoto, ProyectilRemoto } from '$lib/brawlRed';

	let { ancho = 640, alto = 420 }: { ancho?: number; alto?: number } = $props();

	const COLOR_YO = 0x7c3aed;
	const COLOR_ALIADO = 0x2563eb;
	const COLOR_BOT = 0xc1443c;
	const COLOR_PISO = 0x1d2433;
	const COLOR_MURO = 0x8b7355;
	const ALTURA_MURO = 0.55;
	const RADIO_CUERPO = 0.11;

	let contenedor = $state<HTMLDivElement | undefined>(undefined);

	let escena: THREE.Scene;
	let camara: THREE.PerspectiveCamera;
	let renderer: THREE.WebGLRenderer;
	let grupoMuros: THREE.Group;
	let grupoEntidades: THREE.Group;
	let grupoParticulas: THREE.Group;

	let sacudidaInicial = 0;
	let sacudidaInicio = -99999;
	let particulas: { dato: Particula; malla: THREE.Mesh; nacida: number }[] = [];
	const mallasPorClave = new Map<string, THREE.Object3D>();
	const vidaPrevia = new Map<string, number>();

	function crearPiso(): THREE.Mesh {
		const piso = new THREE.Mesh(
			new THREE.PlaneGeometry(ANCHO_MUNDO, ALTO_MUNDO),
			new THREE.MeshStandardMaterial({ color: COLOR_PISO, roughness: 0.95 })
		);
		piso.rotation.x = -Math.PI / 2;
		piso.receiveShadow = true;
		return piso;
	}

	function crearLuces() {
		escena.add(new THREE.AmbientLight(0xffffff, 0.55));
		const sol = new THREE.DirectionalLight(0xffffff, 1.5);
		sol.position.set(3, 8, 4);
		sol.castShadow = true;
		sol.shadow.mapSize.set(1024, 1024);
		sol.shadow.camera.left = -3;
		sol.shadow.camera.right = 3;
		sol.shadow.camera.top = 3;
		sol.shadow.camera.bottom = -3;
		escena.add(sol);
	}

	function crearBarraVida(): THREE.Mesh {
		const barra = new THREE.Mesh(
			new THREE.PlaneGeometry(0.26, 0.045),
			new THREE.MeshBasicMaterial({ color: 0x3b9b6f, depthTest: false, transparent: true })
		);
		barra.position.y = 0.46;
		barra.renderOrder = 10;
		barra.name = 'vida';
		return barra;
	}

	function crearCuerpo(color: number): THREE.Group {
		const grupo = new THREE.Group();
		const cuerpo = new THREE.Mesh(
			new THREE.CapsuleGeometry(RADIO_CUERPO, 0.14, 4, 12),
			new THREE.MeshStandardMaterial({ color, roughness: 0.45 })
		);
		cuerpo.position.y = 0.18;
		cuerpo.castShadow = true;
		cuerpo.name = 'cuerpo';
		grupo.add(cuerpo);

		const visor = new THREE.Mesh(
			new THREE.BoxGeometry(0.13, 0.045, 0.03),
			new THREE.MeshStandardMaterial({ color: 0x0b0f16, roughness: 0.2 })
		);
		visor.position.set(0, 0.25, RADIO_CUERPO - 0.005);
		grupo.add(visor);

		grupo.add(crearBarraVida());
		return grupo;
	}

	function crearProyectil(aliado: boolean): THREE.Mesh {
		const color = aliado ? 0xfbbf24 : COLOR_BOT;
		return new THREE.Mesh(
			new THREE.SphereGeometry(0.045, 10, 10),
			new THREE.MeshStandardMaterial({ color, emissive: color, emissiveIntensity: 2.2 })
		);
	}

	function obtenerMalla(clave: string, crear: () => THREE.Object3D): THREE.Object3D {
		const existente = mallasPorClave.get(clave);
		if (existente) return existente;
		const nueva = crear();
		mallasPorClave.set(clave, nueva);
		grupoEntidades.add(nueva);
		return nueva;
	}

	function actualizarBarra(grupo: THREE.Object3D, fraccion: number) {
		const barra = grupo.getObjectByName('vida') as THREE.Mesh | undefined;
		if (!barra) return;
		barra.scale.x = Math.max(0.001, fraccion);
		barra.position.x = -0.13 * (1 - fraccion);
		(barra.material as THREE.MeshBasicMaterial).color.setHex(colorVida(fraccion));
		barra.quaternion.copy(camara.quaternion);
	}

	function colocar(grupo: THREE.Object3D, x: number, y: number, altura: number) {
		const { x: mx, z: mz } = aMundo(x, y);
		grupo.position.set(mx, altura, mz);
	}

	function mirarHacia(grupo: THREE.Object3D, haciaX: number, haciaY: number) {
		const destino = aMundo(haciaX, haciaY);
		grupo.rotation.y = Math.atan2(destino.x - grupo.position.x, destino.z - grupo.position.z);
	}

	export function sacudir(intensidad: number) {
		sacudidaInicial = Math.max(sacudidaInicial, intensidad);
		sacudidaInicio = performance.now();
	}

	/** Destello blanco sobre el cuerpo: es lo que hace que un impacto se lea al
	 *  instante, sin tener que mirar la barra de vida. */
	function destellar(grupo: THREE.Object3D) {
		const cuerpo = grupo.getObjectByName('cuerpo') as THREE.Mesh | undefined;
		if (!cuerpo) return;
		const material = cuerpo.material as THREE.MeshStandardMaterial;
		material.emissive.setHex(0xffffff);
		material.emissiveIntensity = 1.4;
		setTimeout(() => (material.emissiveIntensity = 0), 110);
	}

	/** El servidor manda el mundo entero, no eventos de golpe: comparar la vida
	 *  contra la del estado anterior es la única forma de saber quién acaba de
	 *  recibir un impacto. */
	function destellarSiPerdioVida(clave: string, grupo: THREE.Object3D, vida: number) {
		const previa = vidaPrevia.get(clave);
		if (previa !== undefined && vida < previa) destellar(grupo);
		vidaPrevia.set(clave, vida);
	}

	export function explotar(x: number, y: number, color = COLOR_BOT) {
		const { x: mx, z: mz } = aMundo(x, y);
		const ahora = performance.now();
		for (const dato of crearParticulas(14, mx, 0.25, mz, color)) {
			const malla = new THREE.Mesh(
				new THREE.SphereGeometry(0.03, 6, 6),
				new THREE.MeshBasicMaterial({ color, transparent: true })
			);
			grupoParticulas.add(malla);
			particulas.push({ dato, malla, nacida: ahora });
		}
	}

	function actualizarParticulas(ahora: number) {
		particulas = particulas.filter(({ dato, malla, nacida }) => {
			const transcurrido = ahora - nacida;
			if (!particulaViva(dato, transcurrido)) {
				grupoParticulas.remove(malla);
				return false;
			}
			const p = posicionParticula(dato, transcurrido);
			malla.position.set(p.x, Math.max(0.02, p.y), p.z);
			(malla.material as THREE.MeshBasicMaterial).opacity = p.opacidad;
			return true;
		});
	}

	export function dibujarMuros(muros: MuroRemoto[]) {
		if (!grupoMuros) return;
		grupoMuros.clear();
		const material = new THREE.MeshStandardMaterial({ color: COLOR_MURO, roughness: 0.8 });
		for (const muro of muros) {
			const caja = new THREE.Mesh(
				new THREE.BoxGeometry(muro.ancho * ESCALA_MUNDO, ALTURA_MURO, muro.alto * ESCALA_MUNDO),
				material
			);
			const centro = aMundo(muro.x + muro.ancho / 2, muro.y + muro.alto / 2);
			caja.position.set(centro.x, ALTURA_MURO / 2, centro.z);
			caja.castShadow = true;
			caja.receiveShadow = true;
			grupoMuros.add(caja);
		}
	}

	function sincronizarJugadores(
		jugadores: JugadorRemoto[],
		miId: string,
		vidaMax: number,
		ahora: number,
		mira: { x: number; y: number }
	) {
		for (const j of jugadores) {
			const esMio = j.id === miId;
			const clave = `j:${j.id}`;
			const grupo = obtenerMalla(clave, () => crearCuerpo(esMio ? COLOR_YO : COLOR_ALIADO));
			grupo.visible = j.vida > 0;
			colocar(grupo, j.x, j.y, alturaRebote(ahora, esMio ? 1 : 0));
			if (esMio) mirarHacia(grupo, mira.x, mira.y);
			actualizarBarra(grupo, Math.max(0, j.vida / vidaMax));
			destellarSiPerdioVida(clave, grupo, j.vida);
		}
	}

	function sincronizarBots(bots: BotRemoto[], vidaMax: number) {
		for (const b of bots) {
			const clave = `b:${b.id}`;
			const grupo = obtenerMalla(clave, () => crearCuerpo(COLOR_BOT));
			grupo.visible = b.vida > 0;
			colocar(grupo, b.x, b.y, 0);
			actualizarBarra(grupo, Math.max(0, b.vida / vidaMax));
			destellarSiPerdioVida(clave, grupo, b.vida);
		}
	}

	function sincronizarProyectiles(proyectiles: ProyectilRemoto[]) {
		const vivos = new Set(proyectiles.map((p) => `p:${p.id}`));
		for (const p of proyectiles) {
			const malla = obtenerMalla(`p:${p.id}`, () => crearProyectil(p.aliado));
			colocar(malla, p.x, p.y, 0.22);
		}
		for (const [clave, malla] of mallasPorClave) {
			if (!clave.startsWith('p:') || vivos.has(clave)) continue;
			grupoEntidades.remove(malla);
			mallasPorClave.delete(clave);
		}
	}

	export function actualizar(datos: {
		jugadores: JugadorRemoto[];
		bots: BotRemoto[];
		proyectiles: ProyectilRemoto[];
		miId: string;
		vidaMaxJugador: number;
		vidaMaxBot: number;
		mira: { x: number; y: number };
	}) {
		if (!grupoEntidades) return;
		const ahora = performance.now();
		sincronizarJugadores(datos.jugadores, datos.miId, datos.vidaMaxJugador, ahora, datos.mira);
		sincronizarBots(datos.bots, datos.vidaMaxBot);
		sincronizarProyectiles(datos.proyectiles);
	}

	function aplicarSacudida(ahora: number) {
		const fuerza = intensidadSacudida(sacudidaInicial, sacudidaInicio, ahora) * 0.12;
		camara.position.x = Math.sin(ahora / 18) * fuerza;
		camara.position.z = 3.0 + Math.cos(ahora / 14) * fuerza;
	}

	$effect(() => {
		escena = new THREE.Scene();
		escena.background = new THREE.Color(0x0b0f16);
		// Arranca más allá de la esquina lejana de la arena (~2.9 unidades de la
		// cámara): con niebla desde 5 la mitad del mapa se perdía en el fondo.
		// Empieza más allá de la esquina lejana (~6.5 desde la cámara): con niebla
		// más cerca, media arena se perdía en el fondo.
		escena.fog = new THREE.Fog(0x0b0f16, 8, 14);

		// Encuadra la arena completa (4.5 x 3.25) con margen: desde más cerca, las
		// esquinas cercanas caían fuera del cono horizontal y cortaban a los bots.
		camara = new THREE.PerspectiveCamera(48, ancho / alto, 0.1, 100);
		camara.position.set(0, 4.0, 3.0);
		camara.lookAt(0, 0, 0);

		renderer = new THREE.WebGLRenderer({ antialias: true });
		renderer.setSize(ancho, alto);
		renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
		renderer.shadowMap.enabled = true;
		renderer.shadowMap.type = THREE.PCFSoftShadowMap;
		contenedor?.appendChild(renderer.domElement);

		crearLuces();
		escena.add(crearPiso());
		grupoMuros = new THREE.Group();
		grupoEntidades = new THREE.Group();
		grupoParticulas = new THREE.Group();
		escena.add(grupoMuros, grupoEntidades, grupoParticulas);

		let idAnimacion = 0;
		function animar() {
			idAnimacion = requestAnimationFrame(animar);
			const ahora = performance.now();
			actualizarParticulas(ahora);
			aplicarSacudida(ahora);
			camara.lookAt(0, 0, 0);
			renderer.render(escena, camara);
		}
		animar();

		return () => {
			cancelAnimationFrame(idAnimacion);
			renderer.dispose();
			renderer.domElement.remove();
			mallasPorClave.clear();
			particulas = [];
		};
	});
</script>

<div class="lienzo" bind:this={contenedor}></div>

<style>
	.lienzo {
		display: block;
		line-height: 0;
		border: 2px solid var(--border-strong);
		border-radius: var(--radius);
		overflow: hidden;
	}

	.lienzo :global(canvas) {
		display: block;
		width: 100% !important;
		height: auto !important;
	}
</style>
