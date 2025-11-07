WAIT 'РАСЧЁТ ОСНОВНЫХ МАТРЕИАЛОВ' WINDOW NOWAIT
*
SET DECIMAL TO 8
SELECT i, ich AS kod_det, z1, z2, z3, z4, z5, z6, z7, SUM(q) AS q FROM My103m;
WHERE LEFT(ich, 1) BETWEEN '7' AND '9' GROUP BY i, ich, z1, z7 ORDER BY i, ich, z1, z7 INTO CURSOR Cur103mq
*
SELECT * FROM table11050 WHERE cp = '37' OR cp = '39' ORDER BY kod_det INTO CURSOR Cur11050_37
SELECT * FROM table11050 WHERE !cp = '37' AND !cp = '39' ORDER BY kod_det INTO CURSOR Cur11050
*Для всех строк 11050 где цех-изг не равно 37 и 39
SELECT Cur103mq.i, Cur103mq.kod_det, kod_mat, raz_zag, ei, massa_det, norma_na_d, cp AS ci,;
ALLTRIM(STR(tol, 8, 2)) + '*' + ALLTRIM(STR(shir, 8, 2)) + '*' + ALLTRIM(STR(Dl, 8, 2)) AS razm,;
VAL(ALLTRIM(STR(q, 8,2))) AS q, VAL(ALLTRIM(STR(q * norma_na_d, 13,8))) AS norma_na_i FROM Cur103mq, Cur11050;
WHERE Cur103mq.kod_det = Cur11050.kod_det ORDER BY Cur103mq.i, Cur103mq.kod_det;
INTO CURSOR CurOsm
*Для всех строк 11050 где цех-изг равно 37 или 39
SELECT Cur103mq.i, Cur103mq.kod_det, kod_mat, raz_zag, ei, massa_det, norma_na_d,;
z1, z2, z3, z4, z5, z6, z7, SPACE(2) AS ci, ALLTRIM(STR(tol, 8, 2)) + '*' + ALLTRIM(STR(shir, 8, 2)) + '*' + ALLTRIM(STR(Dl, 8, 2)) AS razm,;
VAL(ALLTRIM(STR(q, 8,2))) AS q, VAL(ALLTRIM(STR(q * norma_na_d, 13,8))) AS norma_na_i FROM Cur103mq, Cur11050_37;
WHERE Cur103mq.kod_det = Cur11050_37.kod_det ORDER BY Cur103mq.i, Cur103mq.kod_det;
INTO TABLE TabOsm_37
*Обработка строк 11050 на 37 и 39 цех (07)
SCAN
 REPLACE ci WITH IIF( !z1 = '37' AND !z1 = '39', z1, IIF( !z2 = '00' AND !z2 = '37' AND !z2 = '07' AND !z2 = '15' AND !z2 = '39', z2,;
 IIF( !z3 = '00' AND !z3 = '37' AND !z3 = '07' AND !z3 = '15' AND !z3 = '39', z3, IIF( !z4 = '00' AND !z4 = '37' AND !z4 = '07' AND !z4 = '15' AND !z4 = '39', z4,;
 IIF( !z5 = '00' AND !z5 = '37' AND !z5 = '07' AND !z5 = '15' AND !z5 = '39', z5, IIF( !z6 = '00' AND !z6 = '37' AND !z6 = '07' AND !z6 = '15' AND !z6 = '39', z6, z7 ) ) ) ) ) )
ENDSCAN
*Материалы из таблицы table90
SELECT i, kod_izd AS kod_det, kod_mat, SPACE(13) AS raz_zag, SPACE(2) AS ei, 0000.00000000 AS massa_det,;
0000.00000000 AS norma_na_d, SPACE(2) AS ci, SPACE(26) AS razm, VAL(ALLTRIM(STR(table90.q, 8,2))) AS q,;
VAL(ALLTRIM(STR(table90.q, 13,8))) AS norma_na_i FROM table90, Cur103mq;
WHERE table90.kod_izd = Cur103mq.i GROUP BY kod_izd, kod_mat ORDER BY kod_izd INTO CURSOR CurOsm_90
*
SELECT CurOsm_90.i, CurOsm_90.kod_det, kod_mat, raz_zag, ei, massa_det, norma_na_d, z1, z2, z3, z4, z5, z6, z7, ci, razm,;
CurOsm_90.q, norma_na_i FROM CurOsm_90, Cur103mq WHERE CurOsm_90.i = Cur103mq.i AND;
CurOsm_90.kod_det = Cur103mq.kod_det GROUP BY CurOsm_90.i, CurOsm_90.kod_det, kod_mat;
ORDER BY CurOsm_90.i, CurOsm_90.kod_det, CurOsm_90.kod_mat INTO TABLE TabOsm_90
*
SCAN
 REPLACE ci WITH IIF( !z1 = '37' AND !z1 = '39', z1, IIF( !z2 = '00' AND !z2 = '37' AND !z2 = '07' AND !z2 = '15' AND !z2 = '39', z2,;
 IIF( !z3 = '00' AND !z3 = '37' AND !z3 = '07' AND !z3 = '15' AND !z3 = '39', z3, IIF( !z4 = '00' AND !z4 = '37' AND !z4 = '07' AND !z4 = '15' AND !z4 = '39', z4,;
 IIF( !z5 = '00' AND !z5 = '37' AND !z5 = '07' AND !z5 = '15' AND !z5 = '39', z5, IIF( !z6 = '00' AND !z6 = '37' AND !z6 = '07' AND !z6 = '15' AND !z6 = '39', z6, z7 ) ) ) ) ) )
ENDSCAN
*
SELECT i, kod_det, kod_mat, raz_zag, ei, massa_det, norma_na_d, q, ci, razm, norma_na_i FROM CurOsm;
UNION ALL;
SELECT i, kod_det, kod_mat, raz_zag, ei, massa_det, norma_na_d, q, ci, razm, norma_na_i FROM TabOsm_37;
UNION ALL;
SELECT i, kod_det, kod_mat, raz_zag, ei, massa_det, norma_na_d, q, ci, razm, norma_na_i FROM TabOsm_90;
INTO CURSOR CurOsm0
*
DROP TABLE TabOsm_37
DROP TABLE TabOsm_90
*
SELECT i, kod_det, kod_mat, raz_zag, ei, SUM(q) AS q, razm, norma_na_d, ci AS cp, SUM(norma_na_i) AS norma_na_i FROM CurOsm0;
GROUP BY i, kod_det, kod_mat, ci ORDER BY i, kod_det, kod_mat, ci INTO CURSOR Cur01
* Сравниваем с 1081а 
SELECT Cur01.i, Cur01.kod_det, Cur01.kod_mat, table1081a.naim_mat, table1081a.sortament, table1081a.marka,;
Cur01.razm, Cur01.ei, Cur01.q, Cur01.norma_na_d, Cur01.cp, Cur01.norma_na_i FROM Cur01 LEFT JOIN table1081a;
ON Cur01.kod_mat = table1081a.kod_mat ORDER BY Cur01.i, Cur01.kod_det, Cur01.kod_mat INTO CURSOR Cur02
*
SELECT i, kod_det, kod_mat, naim_mat, sortament, marka, razm, ed_izm, q, norma_na_d, cp, norma_na_i;
FROM Cur02 LEFT JOIN table_ei ON Cur02.ei = table_ei.kod_izm ORDER BY i, kod_det, kod_mat INTO CURSOR Cur03
* Сравниваем с 10857
SELECT Cur03.i, Cur03.kod_det, inn AS naim_det, Cur03.kod_mat, Cur03.naim_mat, Cur03.cp, Cur03.sortament,;
Cur03.marka, Cur03.razm, Cur03.ed_izm, Cur03.q, Cur03.norma_na_d, Cur03.norma_na_i;
FROM  Cur03 LEFT OUTER JOIN table10857 ON Cur03.kod_det = Table10857.i;
ORDER BY Cur03.i, Cur03.kod_det, Cur03.kod_mat INTO TABLE table_osm
*
WAIT CLEAR