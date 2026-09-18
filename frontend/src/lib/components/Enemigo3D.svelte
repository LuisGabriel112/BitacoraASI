<script lang="ts">
	import * as THREE from 'three';
	import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
	import { MODELOS_ENEMIGO } from '$lib/modelosEnemigo';
	import { varianteEnemigo } from '$lib/varianteEnemigo';

	let {
		derrotado,
		porcentajeVida,
		nombre,
		tamano = 220
	}: { derrotado: boolean; porcentajeVida: number; nombre: string; tamano?: number } = $props();

	let contenedor: HTMLDivElement;

	function construirEnemigo(estaDerrotado: boolean, semilla: string): THREE.Group {
		const grupo = new THREE.Group();
		const modelo = MODELOS_ENEMIGO[varianteEnemigo(semilla)];
		const colorCuerpo = estaDerrotado ? 0x4a4a4a : modelo.color;
		const matCuerpo = new THREE.MeshStandardMaterial({ color: colorCuerpo, flatShading: true, roughness: 0.6 });
		const colorOjos = estaDerrotado ? 0x333333 : 0xff3b30;
		const intensidadOjos = estaDerrotado ? 0 : 1.2;

		modelo.construir(grupo, matCuerpo, colorOjos, intensidadOjos);
		return grupo;
	}

	$effect(() => {
		const escena = new THREE.Scene();
		const camara = new THREE.PerspectiveCamera(35, 1, 0.1, 100);
		camara.position.set(0, 0.6, 4.2);

		const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
		renderer.setSize(tamano, tamano);
		renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
		contenedor.appendChild(renderer.domElement);

		escena.add(new THREE.AmbientLight(0xffffff, 0.7));
		const luzDireccional = new THREE.DirectionalLight(0xffffff, 0.8);
		luzDireccional.position.set(2, 4, 3);
		escena.add(luzDireccional);

		const enemigo = construirEnemigo(derrotado, nombre);
		enemigo.rotation.z = derrotado ? Math.PI / 2.2 : 0;
		escena.add(enemigo);

		const controles = new OrbitControls(camara, renderer.domElement);
		controles.enableZoom = false;
		controles.autoRotate = !derrotado;
		controles.autoRotateSpeed = 4;
		controles.target.set(0, 0, 0);

		const velocidadPulso = 1.5 + (100 - porcentajeVida) / 20;
		let idAnimacion: number;
		function animar(tiempo: number) {
			idAnimacion = requestAnimationFrame(animar);
			if (!derrotado) {
				enemigo.position.y = Math.sin(tiempo / 500) * 0.08;
				const pulso = 0.8 + Math.abs(Math.sin(tiempo / (1000 / velocidadPulso))) * 0.8;
				escena.traverse((o) => {
					if (o instanceof THREE.Mesh && (o.material as THREE.MeshStandardMaterial).emissiveIntensity) {
						(o.material as THREE.MeshStandardMaterial).emissiveIntensity = pulso;
					}
				});
			}
			controles.update();
			renderer.render(escena, camara);
		}
		animar(0);

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
		background: color-mix(in srgb, var(--danger) 8%, transparent);
	}
</style>
