WAIT 'напюанрйю яопюбнвмхйю 11050' WINDOW NOWAIT
*
SELECT kod_det, kod_mat, norma_na_d, cp FROM table11050;
GROUP BY kod_det ORDER BY kod_det INTO CURSOR CurMat01
*
SELECT kod_det, cp, CurMat01.kod_mat, IIF(ISNULL(naim_mat), 'мер б 1081Ю', naim_mat) AS naim_mat,;
IIF(ISNULL(sortament), 'мер б 1081Ю', sortament) AS sortament, IIF(ISNULL(marka), 'мер б 1081Ю', marka) AS marka,;
IIF(ISNULL(razmer), 'мер б 1081Ю', razmer) AS razmer, IIF(ISNULL(ed_izm), 'мер б 1081Ю', ed_izm) AS ed_izm, norma_na_d;
FROM CurMat01 LEFT JOIN table1081a ON CurMat01.kod_mat = table1081a.kod_mat;
ORDER BY kod_det INTO CURSOR CurMat02
*
SELECT kod_det, IIF(ISNULL(inn), 'мер б 10857', inn) AS inn, cp, kod_mat, naim_mat, sortament, marka, razmer, ed_izm, norma_na_d;
FROM CurMat02 LEFT JOIN table10857 ON CurMat02.kod_det = table10857.i ORDER BY kod_det INTO CURSOR CurMat03
*
SELECT * FROM table_nnd WHERE pr = .T. INTO CURSOR CurMat04
*
SELECT CurMat03.kod_det, CurMat03.inn, CurMat03.cp, CurMat03.kod_mat, CurMat03.naim_mat, CurMat03.sortament, CurMat03.marka,;
CurMat03.razmer, CurMat03.ed_izm, CurMat03.norma_na_d, CurMat04.q, CurMat04.pr FROM CurMat03, CurMat04;
WHERE CurMat03.kod_det = CurMat04.kod_det;
UNION ALL;
SELECT kod_det, inn, cp, kod_mat, naim_mat, sortament, marka, razmer, ed_izm, norma_na_d, ROUND(001,0) AS q, .F. AS pr;
FROM CurMat03 WHERE !EXISTS(SELECT * FROM CurMat04 WHERE CurMat04.kod_det = CurMat03.kod_det AND CurMat04.pr = .T.);
INTO CURSOR CurMat05
*
SELECT * FROM CurMat05 ORDER BY kod_det INTO TABLE table_nnd
*
WAIT 'цнрнбн' WINDOW TIMEOUT 1