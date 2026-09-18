<script lang="ts">
	import * as THREE from 'three';
	import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
	import type { Accesorio, Cara, Espalda, FormaCuerpo } from '$lib/api/client';
	import { agregarAccesorio, agregarCara, agregarEspalda, construirCuerpo } from '$lib/modelosPersonaje';

	let {
		colorPiel,
		colorCuerpo,
		accesorio,
		colorDetalle = '#222222',
		formaCuerpo = 'normal',
		cara = 'feliz',
		espalda = 'ninguna',
		tamano = 220
	}: {
		colorPiel: string;
		colorCuerpo: string;
		accesorio: Accesorio;
		colorDetalle?: string;
		formaCuerpo?: FormaCuerpo;
		cara?: Cara;
		espalda?: Espalda;
		tamano?: number;
	} = $props();

	let contenedor: HTMLDivElement;

	function construirPersonaje(): THREE.Group {
		const grupo = new THREE.Group();
		const hexDetalle = new THREE.Color(colorDetalle).getHex();
		construirCuerpo(grupo, formaCuerpo, new THREE.Color(colorPiel).getHex(), new THREE.Color(colorCuerpo).getHex());
		agregarCara(grupo, cara, hexDetalle);
		agregarAccesorio(grupo, accesorio, hexDetalle);
		agregarEspalda(grupo, espalda, hexDetalle);
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

		const personaje = construirPersonaje();
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
