<script lang="ts">
	import * as THREE from 'three';
	import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';

	let {
		colorPiel,
		colorCuerpo,
		accesorio,
		tamano = 220
	}: { colorPiel: string; colorCuerpo: string; accesorio: string; tamano?: number } = $props();

	let contenedor: HTMLDivElement;

	function agregarAccesorio(grupo: THREE.Group, tipo: string) {
		const material = new THREE.MeshStandardMaterial({ color: 0x222222 });

		if (tipo === 'gorra') {
			const gorra = new THREE.Mesh(new THREE.CylinderGeometry(0.5, 0.55, 0.3, 16), material);
			gorra.position.y = 2.05;
			grupo.add(gorra);
		} else if (tipo === 'casco') {
			const casco = new THREE.Mesh(
				new THREE.SphereGeometry(0.55, 16, 16),
				new THREE.MeshStandardMaterial({ color: 0xcccccc, metalness: 0.6, roughness: 0.3 })
			);
			casco.position.y = 1.6;
			grupo.add(casco);
		} else if (tipo === 'antenas') {
			const antenaIzq = new THREE.Mesh(new THREE.CylinderGeometry(0.03, 0.03, 0.5), material);
			antenaIzq.position.set(-0.25, 2.25, 0);
			grupo.add(antenaIzq);
			const antenaDer = antenaIzq.clone();
			antenaDer.position.x = 0.25;
			grupo.add(antenaDer);
		}
	}

	function construirPersonaje(colorPielHex: number, colorCuerpoHex: number, tipoAccesorio: string): THREE.Group {
		const grupo = new THREE.Group();
		const matPiel = new THREE.MeshStandardMaterial({ color: colorPielHex });
		const matCuerpo = new THREE.MeshStandardMaterial({ color: colorCuerpoHex });

		const cabeza = new THREE.Mesh(new THREE.BoxGeometry(0.9, 0.9, 0.9), matPiel);
		cabeza.position.y = 1.55;
		grupo.add(cabeza);

		const torso = new THREE.Mesh(new THREE.BoxGeometry(1, 1.2, 0.6), matCuerpo);
		torso.position.y = 0.6;
		grupo.add(torso);

		const brazoIzq = new THREE.Mesh(new THREE.BoxGeometry(0.35, 1.1, 0.35), matPiel);
		brazoIzq.position.set(-0.7, 0.6, 0);
		grupo.add(brazoIzq);
		const brazoDer = brazoIzq.clone();
		brazoDer.position.x = 0.7;
		grupo.add(brazoDer);

		const piernaIzq = new THREE.Mesh(new THREE.BoxGeometry(0.4, 1.1, 0.4), matCuerpo);
		piernaIzq.position.set(-0.3, -0.55, 0);
		grupo.add(piernaIzq);
		const piernaDer = piernaIzq.clone();
		piernaDer.position.x = 0.3;
		grupo.add(piernaDer);

		agregarAccesorio(grupo, tipoAccesorio);
		return grupo;
	}

	$effect(() => {
		const escena = new THREE.Scene();
		const camara = new THREE.PerspectiveCamera(35, tamano / tamano, 0.1, 100);
		camara.position.set(0, 1, 4.2);

		const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
		renderer.setSize(tamano, tamano);
		renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
		contenedor.appendChild(renderer.domElement);

		escena.add(new THREE.AmbientLight(0xffffff, 0.7));
		const luzDireccional = new THREE.DirectionalLight(0xffffff, 0.8);
		luzDireccional.position.set(2, 4, 3);
		escena.add(luzDireccional);

		const personaje = construirPersonaje(
			new THREE.Color(colorPiel).getHex(),
			new THREE.Color(colorCuerpo).getHex(),
			accesorio
		);
		personaje.position.y = -0.4;
		escena.add(personaje);

		const controles = new OrbitControls(camara, renderer.domElement);
		controles.enableZoom = false;
		controles.autoRotate = true;
		controles.autoRotateSpeed = 4;
		controles.target.set(0, 0.6, 0);

		let idAnimacion: number;
		function animar() {
			idAnimacion = requestAnimationFrame(animar);
			controles.update();
			renderer.render(escena, camara);
		}
		animar();

		return () => {
			cancelAnimationFrame(idAnimacion);
			controles.dispose();
			renderer.dispose();
			escena.traverse((objeto) => {
				if (objeto instanceof THREE.Mesh) {
					objeto.geometry.dispose();
					const materiales = Array.isArray(objeto.material) ? objeto.material : [objeto.material];
					materiales.forEach((m) => m.dispose());
				}
			});
			contenedor.removeChild(renderer.domElement);
		};
	});
</script>

<div class="lienzo" bind:this={contenedor} style="width: {tamano}px; height: {tamano}px;"></div>

<style>
	.lienzo {
		border-radius: var(--radius-lg);
		overflow: hidden;
		background: color-mix(in srgb, var(--accent) 8%, transparent);
	}
</style>
