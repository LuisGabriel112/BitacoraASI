<script lang="ts">
	import * as THREE from 'three';
	import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
	import { varianteEnemigo } from '$lib/varianteEnemigo';

	let {
		derrotado,
		porcentajeVida,
		nombre,
		tamano = 220
	}: { derrotado: boolean; porcentajeVida: number; nombre: string; tamano?: number } = $props();

	let contenedor: HTMLDivElement;

	const COLOR_VARIANTE = [0x5b1a2b, 0x1a4a5b, 0x4a2f1a, 0x2f5b1a, 0x3a1a5b, 0x1a2f5b];

	const OFFSETS_PINCHOS: [number, number, number][] = [
		[0.6, 0.6, 0.3],
		[-0.6, 0.6, 0.3],
		[0, 0.9, -0.5],
		[0.55, -0.5, 0.45],
		[-0.55, -0.5, 0.45],
		[0, -0.3, -0.85]
	];

	function agregarPinchos(grupo: THREE.Group, offsets: [number, number, number][], color: number) {
		const material = new THREE.MeshStandardMaterial({ color, flatShading: true });
		for (const [x, y, z] of offsets) {
			const pincho = new THREE.Mesh(new THREE.ConeGeometry(0.18, 0.55, 6), material);
			const direccion = new THREE.Vector3(x, y, z).normalize();
			pincho.quaternion.setFromUnitVectors(new THREE.Vector3(0, 1, 0), direccion);
			pincho.position.set(x, y, z);
			grupo.add(pincho);
		}
	}

	function agregarOjosEn(grupo: THREE.Group, posiciones: [number, number, number][], color: number, intensidad: number, radio = 0.14) {
		const material = new THREE.MeshStandardMaterial({ color, emissive: color, emissiveIntensity: intensidad });
		for (const [x, y, z] of posiciones) {
			const ojo = new THREE.Mesh(new THREE.SphereGeometry(radio, 12, 12), material);
			ojo.position.set(x, y, z);
			grupo.add(ojo);
		}
	}

	function construirErizo(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidadOjos: number) {
		grupo.add(new THREE.Mesh(new THREE.IcosahedronGeometry(0.9, 0), matCuerpo));
		agregarPinchos(grupo, OFFSETS_PINCHOS, 0x1a1a1a);
		agregarOjosEn(grupo, [[-0.3, 0.15, 0.75], [0.3, 0.15, 0.75]], colorOjos, intensidadOjos);
	}

	function construirCuernos(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidadOjos: number) {
		grupo.add(new THREE.Mesh(new THREE.BoxGeometry(1.3, 1.3, 1.3), matCuerpo));
		const cuerno = new THREE.Mesh(new THREE.ConeGeometry(0.14, 0.6, 5), matCuerpo);
		cuerno.position.set(-0.35, 0.95, 0);
		cuerno.rotation.z = -0.3;
		grupo.add(cuerno);
		const cuernoDer = cuerno.clone();
		cuernoDer.position.x = 0.35;
		cuernoDer.rotation.z = 0.3;
		grupo.add(cuernoDer);
		agregarOjosEn(grupo, [[-0.28, 0.1, 0.68], [0.28, 0.1, 0.68]], colorOjos, intensidadOjos);
	}

	function construirCiclope(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidadOjos: number) {
		grupo.add(new THREE.Mesh(new THREE.SphereGeometry(1.0, 10, 8), matCuerpo));
		const tentaculos: [number, number, number][] = [
			[-0.5, -0.9, 0.2],
			[-0.15, -1.0, -0.2],
			[0.15, -1.0, 0.2],
			[0.5, -0.9, -0.2]
		];
		agregarPinchos(grupo, tentaculos, (matCuerpo as THREE.MeshStandardMaterial).color.getHex());
		agregarOjosEn(grupo, [[0, 0.15, 0.9]], colorOjos, intensidadOjos, 0.3);
	}

	function construirSlime(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidadOjos: number) {
		const cuerpo = new THREE.Mesh(new THREE.SphereGeometry(0.95, 10, 8), matCuerpo);
		cuerpo.scale.set(1.1, 0.65, 1.1);
		grupo.add(cuerpo);
		const goteos: [number, number, number][] = [
			[-0.4, -0.55, 0.3],
			[0.1, -0.65, -0.3],
			[0.45, -0.5, 0.2]
		];
		for (const [x, y, z] of goteos) {
			const gota = new THREE.Mesh(new THREE.ConeGeometry(0.12, 0.3, 6), matCuerpo);
			gota.position.set(x, y, z);
			gota.rotation.x = Math.PI;
			grupo.add(gota);
		}
		agregarOjosEn(grupo, [[-0.28, 0.05, 0.7], [0.28, 0.05, 0.7]], colorOjos, intensidadOjos);
	}

	function construirGusano(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidadOjos: number) {
		const segmentos: [number, number][] = [
			[0.55, -0.6],
			[0.4, 0.15],
			[0.28, 0.75]
		];
		for (const [radio, y] of segmentos) {
			const segmento = new THREE.Mesh(new THREE.SphereGeometry(radio, 10, 8), matCuerpo);
			segmento.position.y = y;
			grupo.add(segmento);
		}
		agregarOjosEn(grupo, [[-0.16, 0.78, 0.24], [0.16, 0.78, 0.24]], colorOjos, intensidadOjos, 0.09);
	}

	function construirCristal(grupo: THREE.Group, matCuerpo: THREE.Material, colorOjos: number, intensidadOjos: number) {
		const nucleo = new THREE.Mesh(new THREE.OctahedronGeometry(1.05, 0), matCuerpo);
		nucleo.rotation.y = Math.PI / 6;
		grupo.add(nucleo);
		agregarOjosEn(grupo, [[-0.25, 0.05, 0.55], [0.25, 0.05, 0.55]], colorOjos, intensidadOjos, 0.11);
	}

	const CONSTRUCTORES = [construirErizo, construirCuernos, construirCiclope, construirSlime, construirGusano, construirCristal];

	function construirEnemigo(estaDerrotado: boolean, semilla: string): THREE.Group {
		const grupo = new THREE.Group();
		const variante = varianteEnemigo(semilla);
		const colorCuerpo = estaDerrotado ? 0x4a4a4a : COLOR_VARIANTE[variante];
		const matCuerpo = new THREE.MeshStandardMaterial({ color: colorCuerpo, flatShading: true, roughness: 0.6 });
		const colorOjos = estaDerrotado ? 0x333333 : 0xff3b30;
		const intensidadOjos = estaDerrotado ? 0 : 1.2;

		CONSTRUCTORES[variante](grupo, matCuerpo, colorOjos, intensidadOjos);
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
