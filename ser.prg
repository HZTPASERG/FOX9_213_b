SET DECIMAL TO 8
CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DNSI;
DATABASE DNSI
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle, 'DISPWARNING', .T.)
CLOSE DATABASE
*
nR = SQLEXEC(nKonHandle, 'SELECT ik, ich, CAST(q AS INT) AS q FROM table10150', 'Cur10150')
nR = SQLEXEC(nKonHandle, 'SELECT * FROM table10857 ORDER BY i', 'Cur10857')
nR = SQLEXEC(nKonHandle," SELECT * FROM table10153 ", 'Cur10153')
nR = SQLEXEC(nKonHandle," SELECT kod_upak, rez1, kod_iz_ot, rez2, kod_iz_do, rez3,; 
CAST(primen AS INT) AS primen, naim_izd, pr_iz FROM table469 ", 'Cur469')
nR = SQLEXEC(nKonHandle,'SELECT n_pach, kod_det, ei, CAST(massa_det AS FLOAT) AS massa_det, kod_mat, raz_zag, ;
kol_det_za, CAST(norma_na_d AS FLOAT) AS norma_na_d, cp, CAST(dl AS FLOAT) AS tol, ;
r, CAST(shir AS FLOAT) AS shir, e, CAST(tol AS FLOAT) AS dl FROM table11050', 'Cur11050') 
nR = SQLEXEC(nKonHandle,'SELECT sklad, kod_mat, kod_gr_mat, naim_mat, marka, gost_marka, sortament, razmer, ;
gost_sort, ed_izm, kod_izm, CAST(cena_pl AS FLOAT) AS cena_pl FROM table1081a', 'Cur1081a')
nR = SQLEXEC(nKonHandle," SELECT pr, kod_ved, kod_izd, cex, kompl, CAST(q AS INT) AS q FROM table10869", 'Cur10869')
nR =  SQLEXEC(nKonHandle,"SELECT pr_iz, kod_sklad, kod_kompl, naim_kompl, tip, tex_xar, gost, naim_ei, kod_ei, ;
CAST(cena AS FLOAT) AS cena FROM table10856", 'Cur10856')
nR =  SQLEXEC(nKonHandle,"SELECT kod_tabl, kod_oper, pr_1n_orv, kod_vsm, ei_vsm, cex_vsm, kod_osm_ot, kod_osm_do, ;
ei_osm, cex_osm, CAST(udn_norm AS FLOAT) AS udn_norm, CAST(udn_ves AS FLOAT) AS udn_ves FROM table52", 'Cur52')
nR = SQLEXEC(nKonHandle, "SELECT pr_iz, kod_det, kod_oper, CAST(kol_vo AS FLOAT) AS kol_vo, cex FROM table10152", 'Cur10152')
*
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 10150' WINDOW NOWAIT
SELECT * FROM Cur10150 INTO TABLE table10150
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 10857' WINDOW NOWAIT
SELECT * FROM Cur10857 INTO TABLE table10857
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 10153' WINDOW NOWAIT
SELECT * FROM Cur10153 INTO TABLE table10153
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 469' WINDOW NOWAIT
SELECT * FROM Cur469 INTO TABLE table469
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 11050' WINDOW NOWAIT
SELECT * FROM Cur11050 INTO TABLE table11050
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 1081a' WINDOW NOWAIT
SELECT * FROM Cur1081a INTO TABLE table1081a
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 10869' WINDOW NOWAIT
SELECT * FROM Cur10869 INTO TABLE table10869
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 10856' WINDOW NOWAIT
SELECT * FROM Cur10856 INTO TABLE table10856
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 52' WINDOW NOWAIT
SELECT * FROM Cur52 INTO TABLE table52
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Таблица 10152' WINDOW NOWAIT
SELECT * FROM Cur10152 INTO TABLE table10152
****************************************************************************************************
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Подготовка маршрута 10153' WINDOW NOWAIT
SELECT kod_det,   IIF(z1 = '37' AND !z2 = '00', '', ALLTRIM(z1) ) + IIF( z2 = '37' OR z2 = '00', '', ALLTRIM(z2) ) + ;
 IIF(z3 = '37' OR z3 = '00', '', ALLTRIM(z3)) + IIF(z4 = '37' OR z4 = '00', '', ALLTRIM(z4)) + ;
 IIF(z5 = '37' OR z5 = '00', '', ALLTRIM(z5)) + IIF(z6 = '37' OR z6 = '00', '', ALLTRIM(z6)) + ;
 ALLTRIM(z7)  +  SPACE(10) AS cex ;
 FROM table10153 WHERE z1 = '37' OR z2 = '37' OR z3 = '37' OR z4 = '37' OR z5 = '37' OR z6 = '37';
 INTO CURSOR table1
****************************************************************************************************
SELECT kod_det,   IIF(z1 = '39' AND !z2 = '00', '', ALLTRIM(z1) ) + IIF( z2 = '39' OR z2 = '00', '', ALLTRIM(z2) ) + ;
 IIF(z3 = '39' OR z3 = '00', '', ALLTRIM(z3)) + IIF(z4 = '39' OR z4 = '00', '', ALLTRIM(z4)) + ;
 IIF(z5 = '39' OR z5 = '00', '', ALLTRIM(z5)) + IIF(z6 = '39' OR z6 = '00', '', ALLTRIM(z6)) + ;
 ALLTRIM(z7)  +  SPACE(10) AS cex ;
 FROM table10153 WHERE z1 = '39' OR z2 = '39' OR z3 = '39' OR z4 = '39' OR z5 = '39' OR z6 = '39';
 INTO CURSOR table11
****************************************************************************************************
 SELECT kod_det, LEFT(ALLTRIM(cex), 2) AS z1, IIF(LEN(ALLTRIM(cex)) > 4, SUBSTR(cex, 3, 2), '00') AS z2, ;
  IIF(LEN(ALLTRIM(cex)) > 6, SUBSTR(cex, 5, 2), '00') AS z3, IIF(LEN(ALLTRIM(cex)) > 8, SUBSTR(cex, 7, 2), '00') AS z4, ;
  IIF(LEN(ALLTRIM(cex)) > 10, SUBSTR(cex, 9, 2), '00') AS z5, IIF(LEN(ALLTRIM(cex)) > 12, SUBSTR(cex, 11, 2), '00') AS z6,;
  RIGHT(ALLTRIM(cex), 2) AS z7 FROM table1;
  UNION ALL;
 SELECT kod_det, LEFT(ALLTRIM(cex), 2) AS z1, IIF(LEN(ALLTRIM(cex)) > 4, SUBSTR(cex, 3, 2), '00') AS z2, ;
  IIF(LEN(ALLTRIM(cex)) > 6, SUBSTR(cex, 5, 2), '00') AS z3, IIF(LEN(ALLTRIM(cex)) > 8, SUBSTR(cex, 7, 2), '00') AS z4, ;
  IIF(LEN(ALLTRIM(cex)) > 10, SUBSTR(cex, 9, 2), '00') AS z5, IIF(LEN(ALLTRIM(cex)) > 12, SUBSTR(cex, 11, 2), '00') AS z6,;
  RIGHT(ALLTRIM(cex), 2) AS z7 FROM table11;
  UNION ALL;  
  SELECT kod_det, z1, z2, z3, z4, z5, z6, z7 FROM table10153;
  WHERE !z1 = '37' AND !z2 = '37' AND !z3 = '37' AND !z4 = '37' AND !z5 = '37' AND !z6 = '37' AND;
  !z1 = '39' AND !z2 = '39' AND !z3 = '39' AND !z4 = '39' AND !z5 = '39' AND !z6 = '39';
  INTO CURSOR table2
  SELECT * FROM table2;
  ORDER BY kod_det, z7, z1 INTO TABLE table10153_37
***************************************************************************************************
*
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 10150 ik' WINDOW NOWAIT
SELECT table10150
INDEX ON ik TAG tik
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 10150 ich' WINDOW NOWAIT
INDEX ON ich TAG tich
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 10857' WINDOW NOWAIT
SELECT table10857
INDEX ON i TAG ti
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 10153' WINDOW NOWAIT
SELECT table10153
INDEX ON kod_det TAG tkod_det
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 11050' WINDOW NOWAIT
SELECT table11050
INDEX ON kod_det TAG tkod_det
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 1081a' WINDOW NOWAIT
SELECT table1081a
INDEX ON kod_mat TAG tkod_mat
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 10869' WINDOW NOWAIT
SELECT table10869
INDEX ON kod_izd TAG tkod_izd
INDEX ON kod_ved TAG tkod_ved
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 10856' WINDOW NOWAIT
SELECT table10856
INDEX ON kod_kompl TAG tkod_kompl
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 52' WINDOW NOWAIT
SELECT table52
INDEX ON kod_osm_ot TAG tOsm
INDEX ON kod_oper TAG tOper
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация 10152' WINDOW NOWAIT
SELECT table10152
INDEX ON kod_oper TAG tkod_oper
*
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Перечень ДСЕ' WINDOW NOWAIT
SELECT ik AS dse, inn, q FROM table10150 LEFT JOIN table10857; 
ON table10150.ik = table10857.i GROUP BY ik INTO CURSOR Cur1
SELECT ich AS dse, inn, q FROM table10150 LEFT JOIN table10857; 
ON table10150.ich = table10857.i GROUP BY ich INTO CURSOR Cur2
SELECT * FROM Cur1;
UNION;
SELECT * FROM Cur2;
INTO CURSOR Cur3
*
SET DECIMAL TO 2
SELECT dse, IIF(ISNULL(inn), SPACE(25), inn) AS inn, q + 0.00 AS q, .F. AS p FROM Cur3 GROUP BY dse ORDER BY dse INTO TABLE table_izd
*
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Индексация перечня ДСЕ' WINDOW NOWAIT
SELECT table_izd
INDEX ON dse TAG tdse
*
SET DECIMAL TO 2
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Перечень материалов' WINDOW NOWAIT
SELECT kod_mat, naim_mat, 00000.00 AS q, .F. AS p FROM table1081a GROUP BY kod_mat ORDER BY kod_mat INTO TABLE table_mat
*
SET DECIMAL TO 2
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Перечень комплектующих' WINDOW NOWAIT
SELECT kod_kompl, naim_kompl, 00000.00 AS q, .F. AS p FROM table10856 GROUP BY kod_kompl ORDER BY kod_kompl INTO TABLE table_kom
*
SET DECIMAL TO 2
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Перечень ведомостей' WINDOW NOWAIT
SELECT kod_ved, SPACE(25) AS inn, 00001.00 AS q, .F. AS p FROM table10869;
GROUP BY kod_ved ORDER BY kod_ved INTO TABLE table_ved
*
WAIT 'ОБНОВЛЕНИЕ ИНФОРМАЦИИ ...' + CHR(13) +  CHR(13) + 'Удаление временных файлов' WINDOW NOWAIT
CLOSE ALL
WAIT 'ГОТОВО' WINDOW NOWAIT TIMEOUT 3
WAIT CLEAR