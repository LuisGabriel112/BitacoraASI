<script lang="ts">
	import * as THREE from 'three';
	import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';

	let { color, nombre, tamano = 160 }: { color: string; nombre: string; tamano?: number } = $props();

	const DURACION_SALTO_MS = 550;
	const ALTURA_SALTO = 0.55;

	let contenedor: HTMLDivElement;
	let disparaSalto: () => void = () => {};

	function construirGatito(colorHex: number): { grupo: THREE.Group; cola: THREE.Mesh } {
		const material = new THREE.MeshStandardMaterial({ color: colorHex, flatShading: true, roughness: 0.7 });
		const materialOscuro = new THREE.MeshStandardMaterial({ color: 0x1a1a1a, flatShading: true });
		const materialNariz = new THREE.MeshStandardMaterial({ color: 0xd9738c, flatShading: true });

		const grupo = new THREE.Group();

		const cuerpo = new THREE.Mesh(new THREE.SphereGeometry(0.75, 12, 10), material);
		cuerpo.scale.set(1, 0.85, 1.3);
		grupo.add(cuerpo);

		const cabeza = new THREE.Mesh(new THREE.SphereGeometry(0.5, 12, 10), material);
		cabeza.position.set(0, 0.75, 0.55);
		grupo.add(cabeza);

		for (const lado of [-1, 1]) {
			const oreja = new THREE.Mesh(new THREE.ConeGeometry(0.22, 0.35, 4), material);
			oreja.position.set(0.24 * lado, 1.15, 0.5);
			oreja.rotation.z = 0.3 * lado;
			grupo.add(oreja);

			const ojo = new THREE.Mesh(new THREE.SphereGeometry(0.06, 8, 8), materialOscuro);
			ojo.position.set(0.18 * lado, 0.78, 0.95);
			grupo.add(ojo);

			const pata = new THREE.Mesh(new THREE.SphereGeometry(0.16, 8, 8), material);
			pata.position.set(0.25 * lado, -0.55, 0.5);
			grupo.add(pata);
		}

		const nariz = new THREE.Mesh(new THREE.ConeGeometry(0.06, 0.1, 6), materialNariz);
		nariz.position.set(0, 0.68, 1.0);
		nariz.rotation.x = Math.PI / 2;
		grupo.add(nariz);

		const cola = new THREE.Mesh(new THREE.CylinderGeometry(0.06, 0.1, 1.0, 6), material);
		cola.position.set(0, 0.2, -0.9);
		cola.rotation.x = -0.6;
		grupo.add(cola);

		return { grupo, cola };
	}

	$effect(() => {
		const escena = new THREE.Scene();
		const camara = new THREE.PerspectiveCamera(35, 1, 0.1, 100);
		camara.position.set(0, 0.6, 4.2);

		const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
		renderer.setSize(tamano, tamano);
		renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
		renderer.domElement.style.cursor = 'pointer';
		contenedor.appendChild(renderer.domElement);

		escena.add(new THREE.AmbientLight(0xffffff, 0.75));
		const luzDireccional = new THREE.DirectionalLight(0xffffff, 0.8);
		luzDireccional.position.set(2, 4, 3);
		escena.add(luzDireccional);

		const { grupo, cola } = construirGatito(new THREE.Color(color).getHex());
		grupo.position.y = -0.3;
		escena.add(grupo);

		const controles = new OrbitControls(camara, renderer.domElement);
		controles.enableZoom = false;
		controles.autoRotate = true;
		controles.autoRotateSpeed = 3;
		controles.target.set(0, 0.2, 0);

		let inicioSalto: number | null = null;
		disparaSalto = () => {
			if (inicioSalto === null) inicioSalto = performance.now();
		};
		renderer.domElement.addEventListener('click', disparaSalto);

		let idAnimacion: number;
		function animar(tiempo: number) {
			idAnimacion = requestAnimationFrame(animar);

			cola.rotation.z = Math.sin(tiempo / 300) * 0.25;

			if (inicioSalto === null) {
				grupo.position.y = -0.3 + Math.sin(tiempo / 500) * 0.05;
				grupo.scale.set(1, 1, 1);
			} else {
				const t = Math.min(1, (tiempo - inicioSalto) / DURACION_SALTO_MS);
				const arco = Math.sin(t * Math.PI);
				grupo.position.y = -0.3 + arco * ALTURA_SALTO;
				grupo.rotation.y = t * Math.PI * 2;
				grupo.scale.set(1 - arco * 0.08, 1 + arco * 0.15, 1 - arco * 0.08);
				if (t >= 1) {
					inicioSalto = null;
					grupo.rotation.y = 0;
				}
			}

			controles.update();
			renderer.render(escena, camara);
		}
		animar(0);

		return () => {
			cancelAnimationFrame(idAnimacion);
			renderer.domElement.removeEventListener('click', disparaSalto);
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

<div
	class="lienzo"
	bind:this={contenedor}
	style="width: {tamano}px; height: {tamano}px;"
	role="button"
	tabindex="0"
	aria-label="Acariciar a {nombre}"
	onkeydown={(e) => (e.key === 'Enter' || e.key === ' ') && (e.preventDefault(), disparaSalto())}
></div>

<style>
	.lienzo {
		border-radius: var(--radius-lg);
		overflow: hidden;
		background: color-mix(in srgb, var(--accent) 8%, transparent);
	}
</style>
