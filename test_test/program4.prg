*table_osm/table_vsm
SELECT 'O' AS mat, SPACE(4) AS tr, i, kod_mat, naim_mat, cp AS cex, SUM(norma_na_i) AS q FROM table_osm GROUP BY i, kod_mat, cp;
UNION ALL;
SELECT 'V' AS mat, SPACE(4) AS tr, i, kod_vsm AS kod_mat, naim_mat, cp AS cex, SUM(norma_na_i) AS q FROM table_vsm GROUP BY i, kod_vsm, cp;
INTO CURSOR CurM01
*
SELECT *, COUNT(*) AS kol FROM CurM01 GROUP BY tr, i, kod_mat, cex INTO CURSOR Cur01
*
SELECT * FROM CurM01 WHERE EXISTS(;
SELECT * FROM Cur01 WHERE Cur01.i = CurM01.i AND Cur01.kod_mat = CurM01.kod_mat AND Cur01.cex = CurM01.cex AND Cur01.kol > 1);
ORDER BY i, kod_mat, cex INTO CURSOR Cur02
*
SELECT *, COUNT(*) AS kol FROM table_rm GROUP BY tr, i, kod, cex INTO CURSOR Cur03
*table_rm
SELECT * FROM table_rm WHERE EXISTS(;
SELECT * FROM Cur03 WHERE Cur03.i = table_rm.i AND Cur03.kod = table_rm.kod AND Cur03.cex = table_rm.cex AND Cur03.kol > 1);
ORDER BY i, kod, cex INTO CURSOR Cur04
*
SELECT * FROM CurM01 WHERE EXISTS(;
SELECT * FROM Cur04 WHERE Cur04.tr = CurM01.tr AND Cur04.i = CurM01.i AND Cur04.kod = CurM01.kod_mat AND Cur04.cex = CurM01.cex);
ORDER BY tr, i, kod_mat, cex INTO CURSOR Cur05