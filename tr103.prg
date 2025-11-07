nWaitI = 1
SELECT trTable61050pl
STORE RECCOUNT() TO nCount
SCAN
 STORE tr TO cTr
 STORE I TO cIzd
 STORE RECNO() TO nRec
 *
 CREATE CURSOR Cursor103;
 (U INT(2), I CHAR(80), ik CHAR(80), ich CHAR(80), q INT(5), ink INT(8) )
 *
 WAIT 'Расчёт 103-ей....' + SPACE(3) + 'Изд.№' + ALLTRIM(STR(nRec)) + CHR(13) + CHR(13) + 'Общее кол-во изд.'  + STR(nCount) + CHR(13) +;
 'Изделие № п/п' + SPACE(7) + STR(nWaitI) WINDOW NOWAIT
 *
 SELECT ik, ich, q, ink FROM trTable10150 WHERE tr = cTr AND izd = cIzd INTO CURSOR Cur10150
 INDEX ON ik TAG tIk
 *
 nU = 2
 SELECT Cur10150
 SET ORDER TO TAG tIk
 ***************************************************************************************************
 SELECT 1 AS U, cIzd AS I, ik, ich, q, ink FROM Cur10150 WHERE ik = cIzd;
 INTO CURSOR CurTemp
 ***************************************************************************************************
 SELECT U, I, ik, ich, SUM(q) AS q, ink FROM CurTemp GROUP BY ich INTO TABLE Izd103
 STORE RECCOUNT() TO nCount
 ***************************************************************************************************
 DO WHILE !nCount = 0
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
  SELECT nU AS U, cIzd AS I, Cur10150.ik, Cur10150.ich, ( Cur10150.q * &cFileQ) AS q, Cur10150.ink;
  FROM Cur10150 INNER JOIN &cFile ON Cur10150.ik = &cFileIch;
  INTO CURSOR CurTemp
  *
  SELECT * FROM CurTemp INTO TABLE &cFileNext  
  *
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
                  q WITH 1;
                  ink WITH 0
 DROP TABLE Izd103
 FOR nI = 2 TO nU - 1
  cDelFile = ALLTRIM('Izd') + ALLTRIM('103') + ALLTRIM( STR(nI) )
  DROP TABLE &cDelFile
 ENDFOR
 nWaitI= nWaitI+ 1
 *
 IF nRec = 1
  SELECT cTr AS tr, u, i, ik, ich, SUM(q) AS q, ink FROM Cursor103 GROUP BY i, u, ik, ich ORDER BY i, u, ik, ich;
  INTO TABLE TrMy103
 ELSE
  SELECT cTr AS tr, u, i, ik, ich, SUM(q) AS q, ink FROM Cursor103 GROUP BY i, u, ik, ich ORDER BY i, u, ik, ich;
  INTO CURSOR CurMy103_0
  SELECT * FROM CurMy103_0;
  UNION ALL;
  SELECT * FROM TrMy103;
  INTO CURSOR CurMy103_1
  SELECT * FROM CurMy103_1 ORDER BY tr, i, u, ik, ich INTO TABLE TrMy103
 ENDIF
ENDSCAN
***************************************************************************************************
SELECT TrMy103
INDEX ON i TAG tIzd
INDEX ON ik TAG tIk
INDEX ON ich TAG tIch
SET ORDER TO
***************************************************************************************************
SELECT TrMy103.tr, u, TrMy103.i, ik, ich, (TrMy103.q * trTable61050pl.q) AS q FROM TrMy103, trTable61050pl;
WHERE TrMy103.tr = trTable61050pl.tr AND TrMy103.i = trTable61050pl.i ORDER BY TrMy103.i, u, ik, ich INTO CURSOR CurTrMy103q
*
SELECT tr, u, i, ik, ich, SUM(q) AS q FROM CurTrMy103q  GROUP BY i, u, ik, ich ORDER BY i, u, ik, ich INTO TABLE TrMy103q
***************************************************************************************************
WAIT 'ГОТОВО' WINDOW TIMEOUT 1