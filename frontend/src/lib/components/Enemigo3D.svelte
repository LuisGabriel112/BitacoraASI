<script lang="ts">
	import * as THREE from 'three';
	import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';

	let {
		derrotado,
		porcentajeVida,
		tamano = 220
	}: { derrotado: boolean; porcentajeVida: number; tamano?: number } = $props();

	let contenedor: HTMLDivElement;

	const OFFSETS_PINCHOS: [number, number, number][] = [
		[0.6, 0.6, 0.3],
		[-0.6, 0.6, 0.3],
		[0, 0.9, -0.5],
		[0.55, -0.5, 0.45],
		[-0.55, -0.5, 0.45],
		[0, -0.3, -0.85]
	];

	function agregarPinchos(grupo: THREE.Group, color: number) {
		const material = new THREE.MeshStandardMaterial({ color, flatShading: true });
		for (const [x, y, z] of OFFSETS_PINCHOS) {
			const pincho = new THREE.Mesh(new THREE.ConeGeometry(0.18, 0.55, 6), material);
			const direccion = new THREE.Vector3(x, y, z).normalize();
			pincho.quaternion.setFromUnitVectors(new THREE.Vector3(0, 1, 0), direccion);
			pincho.position.set(x, y, z);
			grupo.add(pincho);
		}
	}

	function agregarOjos(grupo: THREE.Group, color: number, intensidad: number) {
		const material = new THREE.MeshStandardMaterial({ color, emissive: color, emissiveIntensity: intensidad });
		const ojoIzq = new THREE.Mesh(new THREE.SphereGeometry(0.14, 12, 12), material);
		ojoIzq.position.set(-0.3, 0.15, 0.75);
		grupo.add(ojoIzq);
		const ojoDer = ojoIzq.clone();
		ojoDer.position.x = 0.3;
		grupo.add(ojoDer);
	}

	function construirEnemigo(estaDerrotado: boolean): THREE.Group {
		const grupo = new THREE.Group();
		const colorCuerpo = estaDerrotado ? 0x4a4a4a : 0x5b1a2b;
		const cuerpo = new THREE.Mesh(
			new THREE.IcosahedronGeometry(0.9, 0),
			new THREE.MeshStandardMaterial({ color: colorCuerpo, flatShading: true, roughness: 0.6 })
		);
		grupo.add(cuerpo);
		agregarPinchos(grupo, 0x1a1a1a);
		agregarOjos(grupo, estaDerrotado ? 0x333333 : 0xff3b30, estaDerrotado ? 0 : 1.2);
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

		const enemigo = construirEnemigo(derrotado);
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
