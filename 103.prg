CREATE CURSOR Cursor103;
(U INT(2), I CHAR(12), ik CHAR(12), ich CHAR(12), q N(8,2) )
SET DECIMAL TO 15
SELECT Table61050pl.naim_plan, Table61050pl.n_pl, Table61050pl.gr,;
Table61050pl.zakaz, Table61050pl.i, Table61050pl.q,;
Table61050pl.io, Table61050pl.inn, Table61050pl.ci, Table61050pl.gk;
FROM table61050pl INTO TABLE MyPlan
SELECT i, ci, gr, 00001 AS q FROM MyPlan GROUP BY i, ci, gr INTO CURSOR CurTempMP
**Проверка на присутствие в изделии упаковки (поле "і" из плана, поля "kod_iz_ot" и "kod_iz_do" из table469)
SELECT CurTempMP.i, ci, gr, CurTempMP.q FROM CurTempMP, table469 WHERE CurTempMP.i BETWEEN table469.kod_iz_ot AND table469.kod_iz_do;
GROUP BY CurTempMP.i, CurTempMP.ci, CurTempMP.gr INTO CURSOR Cur469_1
STORE RECCOUNT() TO nRec
IF !nRec = 0
 SELECT Cur469_1.i, table469.kod_upak, Cur469_1.ci, Cur469_1.gr, Cur469_1.q AS Qprim, primen AS Qupak; 
 FROM Cur469_1, table469 WHERE Cur469_1.i BETWEEN table469.kod_iz_ot AND table469.kod_iz_do;
 INTO CURSOR Cur469_11
 *
 SELECT i, kod_upak, ci, gr, qPrim, qUpak, z7 FROM Cur469_11, table10153_37 WHERE Cur469_11.kod_upak = table10153_37.kod_det;
 INTO CURSOR Cur469_111
 SELECT * FROM Cur469_111 GROUP BY i, kod_upak, ci, gr, z7 INTO CURSOR Cur469_2
 *
 SELECT MyPlan.naim_plan, MyPlan.n_pl, MyPlan.gr, MyPlan.zakaz, Cur469_2.i AS izd, Cur469_2.kod_upak AS i,; 
 CEILING(SUM(Cur469_2.qPrim/qUpak)) AS q, SPACE(12) AS io, SPACE(25) AS inn, Cur469_2.z7 AS ci FROM Cur469_2, MyPlan; 
 WHERE Cur469_2.i = MyPlan.i AND Cur469_2.ci = MyPlan.ci AND Cur469_2.gr = MyPlan.gr GROUP BY Cur469_2.kod_upak, MyPlan.gr, Cur469_2.z7;
 INTO CURSOR Cur469_3
 *
 SET DECIMAL TO 2
 *
 SELECT naim_plan, n_pl, gr, zakaz, i, INT(VAL(STR(q, 5,0))) AS q, io,;
 IIF(LEN(ALLTRIM(inn))<=25, ALLTRIM(inn) + SPACE(25-LEN(ALLTRIM(inn))), LEFT(ALLTRIM(inn),25)) AS inn, ci FROM MyPlan; 
 INTO TABLE MyPlan469
 SELECT * FROM MyPlan469 GROUP BY i INTO CURSOR My61050pl_1 
ELSE
 SELECT naim_plan, n_pl, gr, zakaz, i AS izd, i, q, io, inn, ci FROM MyPlan WHERE 1 = 0 INTO CURSOR Cur469_3
 SELECT * FROM MyPlan INTO TABLE MyPlan469
 SELECT * FROM MyPlan469 GROUP BY i INTO CURSOR My61050pl_1 
ENDIF
**Сжатие масива расчёта по коду изделия
 nWaitI = 1
SELECT My61050pl_1
STORE RECCOUNT() TO nRecRec
SET FILTER TO
SCAN
 WAIT 'Расчёт 103-ей....' + CHR(13) + CHR(13) + 'Общее кол-во изд.'  + STR(nRecRec) + CHR(13) + 'Изделие № п/п' + SPACE(7) + STR(nWaitI) WINDOW NOWAIT
SELECT My61050pl_1 
STORE I TO cIzd 
nU = 2

IF !USED('table10150')
 USE table10150.dbf IN 0 EXCLUSIVE
ENDIF
SELECT table10150
SET ORDER TO TAG tIk
***************************************************************************************************
*!*	UNION ALL;
*!*	SELECT 1 AS U, cIzd AS I, cIzd AS ik, i AS ich, ROUND(q, 2) AS q FROM Cur469_3 WHERE izd = cIzd;
***************************************************************************************************
SELECT 1 AS U, cIzd AS I, ik, ich, ROUND(q, 2) AS q FROM table10150 WHERE ik = cIzd;
UNION ALL;
SELECT 1 AS U, cIzd AS i, cIzd AS ik, kod_det AS ich, q FROM table01 WHERE kod_izd = cIzd;
INTO CURSOR CurTemp
SELECT CurTemp
***************************************************************************************************
SELECT U, I, ik, ich, SUM(q) AS q FROM CurTemp GROUP BY ich INTO TABLE Izd103
SELECT Izd103
STORE RECCOUNT() TO nCount
***************************************************************************************************
DO WHILE !nCount = 0
***************************************************************************************************
IF nU = 2
 cFile = ALLTRIM('Izd') + ALLTRIM('103')
 cFileQ = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM('.q')
 cFileIch = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM('.ich') 
 cFileNext = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM(STR(nU))
 SELECT Cursor103
 APPEND FROM Izd103
ELSE
 cFile = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM(STR(nU - 1))
 cFileQ = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM(STR(nU - 1)) + ALLTRIM('.q') 
 cFileIch = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM(STR(nU - 1)) + ALLTRIM('.ich')  
 cFileNext = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM(STR(nU))
 SELECT Cursor103
 APPEND FROM &cFile
ENDIF
***************************************************************************************************
 SELECT nU AS U, cIzd AS I, table10150.ik, table10150.ich, (table10150.q * &cFileQ) AS q;
 FROM table10150 INNER JOIN &cFile ON table10150.ik = &cFileIch;
 INTO CURSOR CurTemp
 
 SELECT * FROM CurTemp INTO TABLE &cFileNext  
                                                                                                                                        
 SELECT &cFileNext
 STORE RECCOUNT() TO nCount
 nU = nU + 1
ENDDO
 SELECT Cursor103
 APPEND BLANK
 REPLACE U WITH 1;
                   I WITH cIzd;
                   Ik WITH cIzd;
                   Ich WITH cIzd;
                   q WITH 1
 DROP TABLE Izd103
 FOR nI = 2 TO nU - 1
  cDelFile = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM( STR(nI) )
  DROP TABLE &cDelFile
 ENDFOR
 nWaitI= nWaitI+ 1
ENDSCAN
***************************************************************************************************
SELECT u, i, ik, ich, SUM(q) AS q FROM Cursor103 GROUP BY u, i, ik, ich ORDER BY u, i, ik, ich;
INTO TABLE My103
SELECT My103
INDEX ON i TAG tIzd
INDEX ON ik TAG tIk
INDEX ON ich TAG tIch
SET ORDER TO
***************************************************************************************************
SELECT u, My103.i, ik, ich, (My103.q * MyPlan.q) AS q FROM My103, MyPlan;
WHERE My103.i = MyPlan.i ORDER BY My103.i, u, ik, ich INTO CURSOR CurMy103q
*
SELECT u, i, ik, ich, SUM(q) AS q FROM CurMy103q  GROUP BY i, u, ik, ich ORDER BY i, u, ik, ich INTO TABLE My103q
***************************************************************************************************
WAIT CLEAR