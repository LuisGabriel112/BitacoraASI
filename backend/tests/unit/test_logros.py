from datetime import datetime, timezone

from app.services.logros import reglas_de_horario, reglas_de_horario_soporte


def test_antes_de_jornada():
    assert reglas_de_horario(datetime(2026, 8, 4, 8, 59)) == ["antes_de_jornada"]


def test_limite_exacto_9am_no_dispara_antes_de_jornada():
    assert reglas_de_horario(datetime(2026, 8, 4, 9, 0)) == []


def test_horario_normal_no_dispara_nada():
    assert reglas_de_horario(datetime(2026, 8, 4, 12, 0)) == []


def test_recta_final_del_dia_5_a_6pm():
    assert reglas_de_horario(datetime(2026, 8, 4, 17, 30)) == ["ultimas_del_dia"]


def test_limite_exacto_6pm_ya_es_despues_de_hora_no_recta_final():
    assert reglas_de_horario(datetime(2026, 8, 4, 18, 0)) == ["despues_de_hora"]


def test_despues_de_hora_de_salida():
    assert reglas_de_horario(datetime(2026, 8, 4, 19, 0)) == ["despues_de_hora"]


def test_ultimos_10_minutos_del_dia_tambien_es_despues_de_hora():
    logros = reglas_de_horario(datetime(2026, 8, 4, 23, 55))
    assert set(logros) == {"despues_de_hora", "ultimos_10_min_dia"}


def test_viernes_en_recta_final_suma_ultima_hora_viernes():
    logros = reglas_de_horario(datetime(2026, 8, 7, 17, 30))
    assert set(logros) == {"ultimas_del_dia", "ultima_hora_viernes"}


def test_jueves_en_recta_final_no_dispara_ultima_hora_viernes():
    logros = reglas_de_horario(datetime(2026, 8, 6, 17, 30))
    assert logros == ["ultimas_del_dia"]


def test_sabado_dispara_guardia():
    assert reglas_de_horario(datetime(2026, 8, 8, 12, 0)) == ["sabado_guardia"]


def test_sabado_antes_de_jornada_combina_ambos():
    logros = reglas_de_horario(datetime(2026, 8, 8, 8, 0))
    assert set(logros) == {"antes_de_jornada", "sabado_guardia"}


def test_soporte_antes_de_jornada():
    assert reglas_de_horario_soporte(datetime(2026, 8, 4, 8, 59)) == ["antes_de_jornada_soporte"]


def test_soporte_recta_final_del_dia():
    assert reglas_de_horario_soporte(datetime(2026, 8, 4, 17, 30)) == ["ultimas_del_dia_soporte"]


def test_soporte_sabado_guardia():
    assert reglas_de_horario_soporte(datetime(2026, 8, 8, 12, 0)) == ["sabado_guardia_soporte"]


def test_claves_de_soporte_no_se_repiten_con_las_de_mesas():
    momento = datetime(2026, 8, 8, 8, 0)
    logros_mesa = set(reglas_de_horario(momento))
    logros_soporte = set(reglas_de_horario_soporte(momento))
    assert logros_mesa.isdisjoint(logros_soporte)


def test_datetime_con_utc_se_convierte_a_hora_local_antes_de_evaluar():
    # 11:25am en Ciudad de Mexico (UTC-6) == 17:25 UTC. Sin convertir, caia
    # dentro de la ventana 17-18h y disparaba "recta final del dia" por error.
    once_25_locales_en_utc = datetime(2026, 8, 12, 17, 25, tzinfo=timezone.utc)
    assert reglas_de_horario_soporte(once_25_locales_en_utc) == []


def test_datetime_con_utc_si_dispara_recta_final_cuando_de_verdad_es_esa_hora_local():
    cinco_30_locales_en_utc = datetime(2026, 8, 12, 23, 30, tzinfo=timezone.utc)
    assert reglas_de_horario_soporte(cinco_30_locales_en_utc) == ["ultimas_del_dia_soporte"]


def test_datetime_naive_no_se_toca_sigue_siendo_hora_local():
    assert reglas_de_horario(datetime(2026, 8, 4, 17, 30)) == ["ultimas_del_dia"]
