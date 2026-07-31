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


def _cluster_mas_similar(embedding: list[float], clusters: list[_Cluster]) -> tuple[_Cluster | None, float]:
    mejor, mejor_similitud = None, -1.0
    for cluster in clusters:
        similitud = _coseno(embedding, cluster.centroide)
        if similitud > mejor_similitud:
            mejor, mejor_similitud = cluster, similitud
    return mejor, mejor_similitud


def _centroide_actualizado(centroide: list[float], nuevo: list[float], n: int) -> list[float]:
    return [(c * (n - 1) + e) / n for c, e in zip(centroide, nuevo)]


def agrupar_por_similitud(embeddings: list[list[float]], umbral: float = 0.86) -> list[list[int]]:
    """Agrupa índices cuyo embedding es similar (coseno >= umbral).

    Asignación voraz: cada vector se une al cluster existente más parecido si
    supera el umbral, si no abre uno nuevo. Devuelve los grupos de mayor a
    menor tamaño, cada uno como lista de índices sobre `embeddings`.
    """
    clusters: list[_Cluster] = []
    for i, embedding in enumerate(embeddings):
        cluster, similitud = _cluster_mas_similar(embedding, clusters)
        if cluster is not None and similitud >= umbral:
            cluster.indices.append(i)
            cluster.centroide = _centroide_actualizado(cluster.centroide, embedding, len(cluster.indices))
        else:
            clusters.append(_Cluster(centroide=list(embedding), indices=[i]))

    clusters.sort(key=lambda c: len(c.indices), reverse=True)
    return [c.indices for c in clusters]
