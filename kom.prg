WAIT '–¿—◊®“  ŒÃœÀ≈ “”ﬁŸ»’' WINDOW NOWAIT
*
SET DECIMAL TO 2
*
SELECT i, ich AS kod_det, z1, z2, z3, z4, z5, z6, z7, SUM(q) AS q FROM My103m;
GROUP BY i, ich, z1, z7 ORDER BY i, ich, z1, z7 INTO CURSOR Cur103mq
*-- «¿ ŒÃ≈Õ“Œ¬¿ÕŒ 20201210
*!*	SELECT i, ich AS kod_det, kompl, cex, kod_ved, table10869.q AS norma_na_k,;
*!*	VAL(ALLTRIM(STR(My103q.q, 8,2))) AS q, VAL(ALLTRIM(STR(My103q.q * table10869.q, 8,2))) AS norma_na_i;
*!*	FROM My103q, table10869 WHERE My103q.ich = table10869.kod_izd AND LEFT(My103q.ich,1) BETWEEN '0' AND '6' AND !pr = '9';
*!*	ORDER BY i, ich, kompl, cex INTO CURSOR Cur01
*-- «¿Ã≤Õ≈ÕŒ Õ¿ “¿ »… —¿Ã»… ¬¿–≤¿Õ“ “≤À‹ » ¡≈« LEFT(My103q.ich,1) BETWEEN '0' AND '6'
SELECT i, ich AS kod_det, kompl, cex, kod_ved, table10869.q AS norma_na_k,;
VAL(ALLTRIM(STR(My103q.q, 8,2))) AS q, VAL(ALLTRIM(STR(My103q.q * table10869.q, 8,2))) AS norma_na_i;
FROM My103q, table10869 WHERE My103q.ich = table10869.kod_izd AND !pr = '9';
ORDER BY i, ich, kompl, cex INTO CURSOR Cur01
*¬Â‰ÓÏÓÒÚË Ë ÍÓÏÔÎÂÍÚÛ˛˘ËÂ ËÁ Ú‡·ÎËˆ˚ table91, table92
SELECT i, kod_izd AS kod_det, kod_kom AS kompl, SPACE(2) AS cex, SPACE(11) AS kod_ved,;
0000 AS norma_na_k, VAL(ALLTRIM(STR(table91.q, 8,2))) AS q, VAL(ALLTRIM(STR(table91.q, 8,2))) AS norma_na_i;
FROM table91, Cur103mq WHERE table91.kod_izd = Cur103mq.i;
GROUP BY kod_izd , kod_kom ORDER BY kod_izd, kod_kom INTO CURSOR CurKom_91
*
SELECT CurKom_91.i, CurKom_91.kod_det, kompl, z1, z2, z3, z4, z5, z6, z7, cex, kod_ved, norma_na_k, CurKom_91.q, norma_na_i FROM CurKom_91, Cur103mq;
WHERE CurKom_91.i = Cur103mq.i AND CurKom_91.kod_det = Cur103mq.kod_det GROUP BY CurKom_91.i, CurKom_91.kod_det, kompl;
ORDER BY CurKom_91.i, CurKom_91.kod_det, kompl INTO TABLE TabKom_91
*
SCAN
 REPLACE cex WITH IIF( !z1 = '37' AND !z1 = '39', z1, IIF( !z2 = '00' AND !z2 = '37' AND !z2 = '07' AND !z2 = '15' AND !z2 = '39', z2,;
 IIF( !z3 = '00' AND !z3 = '37' AND !z3 = '07' AND !z3 = '15' AND !z3 = '39', z3, IIF( !z4 = '00' AND !z4 = '37' AND !z4 = '07' AND !z4 = '15' AND !z4 = '39', z4,;
 IIF( !z5 = '00' AND !z5 = '37' AND !z5 = '07' AND !z5 = '15' AND !z5 = '39', z5, IIF( !z6 = '00' AND !z6 = '37' AND !z6 = '07' AND !z6 = '15' AND !z6 = '39', z6, z7 ) ) ) ) ) )
ENDSCAN
*
SELECT table92.kod_izd AS i, table92.kod_izd AS kod_det, kompl, cex, table92.kod_ved, table10869.q AS norma_na_k,;
VAL(ALLTRIM(STR(table92.q, 8,2))) AS q, VAL(ALLTRIM(STR(table92.q * table10869.q, 8,2))) AS norma_na_i;
FROM table92, table10869 WHERE table92.kod_ved = table10869.kod_ved GROUP BY table92.kod_izd, table92.kod_ved, table10869.kompl;
ORDER BY table92.kod_izd, kompl, cex INTO CURSOR CurKom_92
*
SELECT i, kod_det, kompl, cex, kod_ved, norma_na_k, q, norma_na_i FROM Cur01;
UNION ALL;
SELECT i, kod_det, kompl, cex, kod_ved, norma_na_k, q, norma_na_i FROM TabKom_91;
UNION ALL;
SELECT i, kod_det, kompl, cex, kod_ved, norma_na_k, q, norma_na_i FROM CurKom_92;
INTO CURSOR CurTemp
*
SELECT i, kod_det, kompl, cex, kod_ved, SUM(norma_na_i) AS norma_na_i;
FROM CurTemp GROUP BY i, kod_det, kompl, cex ORDER BY i, kod_det, kompl, cex INTO CURSOR Cur01
*
DROP TABLE TabKom_91
*
SELECT Cur01.i, Cur01.kod_det, Cur01.kod_ved, Cur01.kompl, table10856.naim_kompl, Cur01.cex,;
table10856.tip, table10856.tex_xar, table10856.gost, table10856.naim_ei, norma_na_i;
FROM Cur01 LEFT JOIN table10856 ON Cur01.kompl = table10856.kod_kompl;
ORDER BY Cur01.i, Cur01.kod_det, Cur01.kod_ved, Cur01.kompl;    
INTO CURSOR Cur02
*
SELECT Cur02.i, kod_det, inn, kod_ved, kompl, naim_kompl, cex, tip, tex_xar, gost, naim_ei, norma_na_i;
FROM Cur02 LEFT JOIN table10857 ON Cur02.kod_det = table10857.i;
ORDER BY Cur02.i, kod_det, kod_ved, kompl INTO TABLE table_kpl
*
WAIT CLEAR