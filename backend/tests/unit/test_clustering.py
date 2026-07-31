from app.services.clustering import agrupar_por_similitud


def _vector(*, primer_componente: float) -> list[float]:
    """Vector 2D controlable: variar primer_componente cambia el ángulo (y el coseno)."""
    return [primer_componente, 1.0 - primer_componente]


def test_agrupa_indices_similares_y_separa_el_distinto():
    embeddings = [
        _vector(primer_componente=0.9),
        _vector(primer_componente=0.1),
        _vector(primer_componente=0.91),
    ]

    grupos = agrupar_por_similitud(embeddings, umbral=0.999)

    assert [0, 2] in grupos
    assert [1] in grupos


def test_grupos_ordenados_de_mayor_a_menor_tamano():
    embeddings = [
        _vector(primer_componente=0.9),
        _vector(primer_componente=0.1),
        _vector(primer_componente=0.91),
        _vector(primer_componente=0.89),
    ]

    grupos = agrupar_por_similitud(embeddings, umbral=0.999)

    tamanos = [len(g) for g in grupos]
    assert tamanos == sorted(tamanos, reverse=True)


def test_vectores_identicos_siempre_quedan_juntos():
    identico = [0.42, 0.13, 0.9]
    grupos = agrupar_por_similitud([identico, identico], umbral=1.0)

    assert grupos == [[0, 1]]


def test_lista_vacia_no_produce_grupos():
    assert agrupar_por_similitud([], umbral=0.86) == []


def test_vector_cero_no_se_agrupa_con_nada_incluso_con_umbral_bajo():
    """Coseno indefinido con norma 0: no debe considerarse similar a ningún vector."""
    cero = [0.0, 0.0]
    normal = _vector(primer_componente=0.5)

    grupos = agrupar_por_similitud([cero, normal], umbral=0.5)

    assert [0] in grupos
    assert [1] in grupos
