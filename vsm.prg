WAIT 'пюяв╗р бяонлюцюрекэмшу люрпехюкнб' WINDOW NOWAIT
*
SET DECIMAL TO 8
SELECT i, ich, SUM(q) AS q FROM My103q GROUP BY i, ich ORDER BY i, ich INTO CURSOR Cur01
*
SELECT i, ich AS kod_det, kod_vsm, VAL(ALLTRIM(STR(q, 8,2))) AS q, VAL(ALLTRIM(STR(norma_vsm, 13,8))) AS norma_vsm,;
VAL(ALLTRIM(STR(q * norma_vsm, 13,8))) AS norma_na_i, cex FROM Cur01, vBasa;
WHERE Cur01.ich = vBasa.kod_det ORDER BY i, ich, kod_vsm INTO CURSOR Cur02
*
SELECT i, kod_det, kod_vsm, naim_mat, sortament, marka, cex AS cp, razmer, ed_izm, q, norma_vsm, norma_na_i;
FROM Cur02, table1081a WHERE Cur02.kod_vsm = table1081a.kod_mat ORDER BY i, kod_mat INTO CURSOR Cur03
*
SELECT Cur03.i, kod_det, inn AS naim_det, kod_vsm, naim_mat, sortament, marka, cp, razmer, ed_izm, q, norma_vsm, norma_na_i FROM Cur03 LEFT JOIN table10857;
ON Cur03.kod_det = table10857.i ORDER BY Cur03.i, kod_det, kod_vsm INTO CURSOR Cur04
*
SET DECIMAL TO 8
SELECT i, kod_det, IIF(ISNULL(naim_det),'мер б 10857',naim_det) AS naim_det, kod_vsm, IIF(ISNULL(naim_mat),'мер б 1081a',naim_mat) AS naim_mat,;
sortament, marka, cp, razmer, ed_izm, q, norma_vsm, norma_na_i FROM Cur04 ORDER BY i, kod_det, kod_vsm INTO TABLE table_vsm
*
WAIT CLEAR