WAIT 'ОБРАБОТКА СПРАВОЧНИКА ВСМ' WINDOW NOWAIT
**Если 11050.код_цеха <> 37 и 11050.код_цеха <> 39 - цех берём с 11050
SELECT kod_det, SPACE(7) AS kod_oper, kod_vsm, kod_osm_ot, ei_vsm, cp AS cex_vsm, udn_norm,;
norma_na_d, ( udn_norm * norma_na_d ) AS norma_vsm FROM table52, table11050 ;
WHERE kod_osm_ot = kod_mat AND ( !cp = '37' AND !cp = '39' ) INTO CURSOR Cur1
**Если 11050.код_цеха = 37 или 11050.код_цеха = 39 - цех берём с 52 масива
SELECT kod_det, SPACE(7) AS kod_oper, kod_vsm, kod_osm_ot, ei_vsm, LEFT(cex_vsm, 2) AS cex_vsm, udn_norm,;
norma_na_d, ( udn_norm * norma_na_d ) AS norma_vsm FROM table52, table11050 ;
WHERE kod_osm_ot = kod_mat AND ( cp = '37' OR cp = '39' ) INTO CURSOR Cur2
**Делаем обьединение 
SELECT * FROM Cur1;
UNION ALL;
SELECT * FROM Cur2;
INTO CURSOR Cur3
*
** Ведём сравнение 52-го масива с 10152 по коду операции, цех забераем с 10152
SELECT kod_det, table52.kod_oper, kod_vsm, kod_osm_ot, ei_vsm, cex AS cex_vsm, udn_norm, kol_vo,;
( udn_norm * kol_vo) AS norma_vsm FROM table52, table10152 WHERE table52.kod_oper = table10152.kod_oper;
INTO CURSOR Cur4
**Делаем обьединение
SELECT kod_det, kod_oper, kod_osm_ot, kod_vsm, ei_vsm, cex_vsm, udn_norm,;
norma_na_d, norma_vsm FROM Cur3;
UNION ALL;
SELECT kod_det, kod_oper, kod_osm_ot, kod_vsm, ei_vsm, cex_vsm, udn_norm,;
 kol_vo AS norma_na_d, norma_vsm FROM Cur4;
INTO CURSOR Cur5
*
SELECT kod_det, kod_vsm, cex_vsm AS cex, SUM(norma_vsm) AS norma_vsm FROM Cur5;
GROUP BY kod_det, kod_vsm, cex_vsm ORDER BY kod_det, kod_vsm, cex_vsm INTO TABLE vBasa
*
WAIT 'ГОТОВО' WINDOW TIMEOUT 1