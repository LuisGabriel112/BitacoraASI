import math
from dataclasses import dataclass, field


@dataclass
class _Cluster:
    centroide: list[float]
    indices: list[int] = field(default_factory=list)


def _coseno(a: list[float], b: list[float]) -> float:
    punto = sum(x * y for x, y in zip(a, b))
    norma_a = math.sqrt(sum(x * x for x in a))
    norma_b = math.sqrt(sum(x * x for x in b))
    if norma_a == 0 or norma_b == 0:
        return 0.0
    return punto / (norma_a * norma_b)


def agrupar_por_similitud(embeddings: list[list[float]], umbral: float = 0.86) -> list[list[int]]:
    """Agrupa índices cuyo embedding es similar (coseno >= umbral).

    Asignación voraz: cada vector se une al cluster existente más parecido si
    supera el umbral, si no abre uno nuevo. Devuelve los grupos de mayor a
    menor tamaño, cada uno como lista de índices sobre `embeddings`.
    """
    clusters: list[_Cluster] = []
    for i, emb in enumerate(embeddings):
        mejor, mejor_sim = None, -1.0
        for c in clusters:
            sim = _coseno(emb, c.centroide)
            if sim > mejor_sim:
                mejor, mejor_sim = c, sim
        if mejor is not None and mejor_sim >= umbral:
            mejor.indices.append(i)
            n = len(mejor.indices)
            mejor.centroide = [(mejor.centroide[d] * (n - 1) + emb[d]) / n for d in range(len(emb))]
        else:
            clusters.append(_Cluster(centroide=list(emb), indices=[i]))

    clusters.sort(key=lambda c: len(c.indices), reverse=True)
    return [c.indices for c in clusters]
