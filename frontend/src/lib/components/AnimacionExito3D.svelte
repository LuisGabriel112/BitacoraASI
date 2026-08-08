<script lang="ts">
	import * as THREE from 'three';
	import { easeOutBack } from '$lib/animacion';

	const TAMANO = 180;
	const DURACION_MS = 1400;

	let visible = $state(false);

	export function mostrar() {
		visible = true;
	}

	let contenedor = $state<HTMLDivElement>();

	function construirCheck(): THREE.Group {
		const grupo = new THREE.Group();
		const material = new THREE.MeshStandardMaterial({ color: 0x22c55e, transparent: true });

		const trazoCorto = new THREE.Mesh(new THREE.BoxGeometry(0.9, 0.28, 0.28), material);
		trazoCorto.position.set(-0.55, -0.15, 0);
		trazoCorto.rotation.z = Math.PI / 4;
		grupo.add(trazoCorto);

		const trazoLargo = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.28, 0.28), material);
		trazoLargo.position.set(0.25, 0.15, 0);
		trazoLargo.rotation.z = -Math.PI / 4;
		grupo.add(trazoLargo);

		return grupo;
	}

	function construirParticulas(): THREE.Points {
		const cantidad = 24;
		const posiciones = new Float32Array(cantidad * 3);
		for (let i = 0; i < cantidad; i++) {
			const angulo = (i / cantidad) * Math.PI * 2;
			const radio = 1.4 + Math.random() * 0.6;
			posiciones[i * 3] = Math.cos(angulo) * radio;
			posiciones[i * 3 + 1] = Math.sin(angulo) * radio;
			posiciones[i * 3 + 2] = (Math.random() - 0.5) * 0.5;
		}
		const geometria = new THREE.BufferGeometry();
		geometria.setAttribute('position', new THREE.BufferAttribute(posiciones, 3));
		const material = new THREE.PointsMaterial({ color: 0x86efac, size: 0.12, transparent: true });
		return new THREE.Points(geometria, material);
	}

	function disponerEscena(escena: THREE.Scene) {
		escena.traverse((objeto) => {
			if (objeto instanceof THREE.Mesh || objeto instanceof THREE.Points) {
				objeto.geometry.dispose();
				const materiales = Array.isArray(objeto.material) ? objeto.material : [objeto.material];
				materiales.forEach((m) => m.dispose());
			}
		});
	}

	$effect(() => {
		if (!visible) return;

		const escena = new THREE.Scene();
		const camara = new THREE.PerspectiveCamera(40, 1, 0.1, 100);
		camara.position.set(0, 0, 4.5);

		const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
		renderer.setSize(TAMANO, TAMANO);
		renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
		contenedor!.appendChild(renderer.domElement);

		escena.add(new THREE.AmbientLight(0xffffff, 0.8));
		const luz = new THREE.DirectionalLight(0xffffff, 0.9);
		luz.position.set(2, 3, 4);
		escena.add(luz);

		const check = construirCheck();
		escena.add(check);
		const particulas = construirParticulas();
		escena.add(particulas);

		const inicio = performance.now();
		let idAnimacion: number;
		let terminado = false;

		function animar(ahora: number) {
			const t = Math.min(1, (ahora - inicio) / DURACION_MS);

			check.scale.setScalar(t < 0.6 ? easeOutBack(t / 0.6) : 1);
			check.rotation.y = t * Math.PI;
			particulas.rotation.z = t * Math.PI * 0.5;
			(particulas.material as THREE.PointsMaterial).opacity = 1 - t;

			const opacidadCheck = t > 0.75 ? 1 - (t - 0.75) / 0.25 : 1;
			check.children.forEach((hijo) => {
				((hijo as THREE.Mesh).material as THREE.MeshStandardMaterial).opacity = opacidadCheck;
			});

			renderer.render(escena, camara);

			if (t < 1) {
				idAnimacion = requestAnimationFrame(animar);
			} else {
				terminado = true;
				visible = false;
			}
		}
		idAnimacion = requestAnimationFrame(animar);

		return () => {
			if (!terminado) cancelAnimationFrame(idAnimacion);
			renderer.dispose();
			disponerEscena(escena);
			contenedor!.removeChild(renderer.domElement);
		};
	});
</script>

{#if visible}
	<div class="overlay-exito" aria-hidden="true">
		<div class="lienzo-exito" bind:this={contenedor}></div>
	</div>
{/if}

<style>
	.overlay-exito {
		position: fixed;
		inset: 0;
		display: flex;
		align-items: center;
		justify-content: center;
		pointer-events: none;
		z-index: 260;
	}

	.lienzo-exito {
		width: 180px;
		height: 180px;
	}
</style>
