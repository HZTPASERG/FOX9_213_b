nWaitI = 1
SELECT trTable61050pl
STORE RECCOUNT() TO nCount
SCAN
 STORE tr TO cTr
 STORE I TO cIzd
 STORE RECNO() TO nRec
 *
 WAIT 'Расчёт 103-ей с маршрутом....' + SPACE(3) + 'Изд.№' + ALLTRIM(STR(nRec)) + CHR(13) + CHR(13) + 'Общее кол-во изд.'  + STR(nCount) + CHR(13) +;
 'Изделие № п/п' + SPACE(7) + STR(nWaitI) WINDOW NOWAIT
 *
 CREATE CURSOR Cursor10153;
 (U INT(4), I CHAR(80), ik CHAR(80), ich CHAR(80), ci CHAR(2), z1 CHAR(2), z2 CHAR(2), z3 CHAR(2), z4 CHAR(2), z5 CHAR(2), ;
  z6 CHAR(2), z7 CHAR(2), q INT(4), ink INT(8) )
 ***************************************************************************************************
 *10153 на даное ТР
 SELECT izd, kod_det, z1, z2, z3, z4, z5, z6, z7 FROM Trtable10153 WHERE tr = cTr AND izd = cIzd;
 ORDER BY izd, kod_det, z1, z7 INTO TABLE My10153
 INDEX ON kod_det TAG tDet
 INDEX ON z7 TAG tZ7
 *My103 на даное ТР
 SELECT u, i, ik, ich, q, ink FROM TrMy103 WHERE tr = cTr AND i = cIzd ORDER BY i, u, ik, ich INTO CURSOR CurMy103
 *MyPlan на даное ТР
 SELECT i, z7 AS ci, 1 AS q FROM trTable61050pl WHERE tr = cTr AND i = cIzd GROUP BY i, z7 INTO CURSOR Cur1
 SELECT * FROM Cur1 INTO CURSOR CurMyPlan
 *My103 на даное ТР с цехом-изг.
 SELECT u, CurMy103.i, ik, ich, CurMy103.q, ink, ci FROM CurMy103, Cur1 WHERE CurMy103.i = Cur1.i ORDER BY CurMy103.i, ci, u, ik, ich INTO CURSOR Cur2
 ***************************************************************************************************
 SELECT * FROM Cur2 WHERE ik <> ich ORDER BY u INTO CURSOR Cur103i
 *
 SELECT * FROM Cur2 WHERE ik = ich ORDER BY u INTO CURSOR Cur3
 *
 SELECT u, i, ik, ich, ci, q, ink, z1, z2, z3, z4, z5, z6, z7 FROM Cur3, My10153;
 WHERE Cur3.ich = My10153.kod_det AND Cur3.ci = My10153.z7 GROUP BY u, i, ik, ich, ci, q INTO CURSOR CurA
 *
 SELECT * FROM Cur3 WHERE !EXISTS( SELECT * FROM My10153; 
 WHERE My10153.kod_det = Cur3.ich AND My10153.z7 = Cur3.ci) INTO CURSOR Cur21
 
 SELECT * FROM Cur3 WHERE !EXISTS( SELECT * FROM My10153; 
 WHERE My10153.kod_det = Cur3.ich ) INTO CURSOR Cur22
 
 SELECT * FROM Cur21 WHERE !EXISTS( SELECT * FROM Cur22;
 WHERE Cur22.i = Cur21.i AND Cur22.ik = Cur21.ik AND Cur22.ich = Cur21.ich ) INTO CURSOR Cur23
 
 SELECT u, i, ik, ich, ci, q, ink, '28' AS z1, '00' AS z2, '00' AS z3, '00' AS z4, '00' AS z5, '00' AS z6, ci AS z7 FROM Cur22;
 INTO CURSOR CurB
 
 SELECT u, i, ik, ich, ci, q, ink, My10153.z1, z2, z3, z4, z5, z6, Cur23.ci AS z7 FROM Cur23, My10153;
 WHERE ich = kod_det AND !LEFT(ik, 6) = '503384' GROUP BY i, ik, ich, ci INTO CURSOR CurC
 
 SELECT u, i, ik, ich, ci, q, ink, My10153.z1, z2, z3, z4, z5, z6, z7 FROM Cur23, My10153;
 WHERE ich = kod_det AND LEFT(ik, 6) = '503384' GROUP BY i, ik, ich, ci INTO CURSOR CurD
 
 SELECT * FROM CurA;
 UNION ALL;
 SELECT * FROM CurB;
 UNION ALL;
 SELECT * FROM CurC;
 UNION ALL;
 SELECT * FROM CurD;
 INTO TABLE My103j
 *
 SELECT Cur1
 USE
 SELECT Cur2
 USE
 SELECT Cur3
 USE
 *
 SELECT CurA
 USE
 SELECT CurB
 USE
 SELECT CurC
 USE
 SELECT CurD
 USE
 SELECT Cur21
 USE
 SELECT Cur22
 USE
 SELECT Cur23
 USE
 ***************************************************************************************************  
 SELECT * FROM Cur103i ORDER BY u, ik, ich INTO TABLE My103i
 GO BOTTOM
 STORE U TO nU
 GO TOP
 ***************************************************************************************************  
 FOR j = 1 TO nU
  WAIT 'Расчёт 103-ей с маршрутом....' + SPACE(3) + 'Изд.№' + ALLTRIM(STR(nRec)) + CHR(13) + CHR(13) + 'Общее кол-во изделий'+ STR(nCount)  + CHR(13) +;
  'Изделие № п/п' + SPACE(7) + STR(nWaitI) + CHR(13) + CHR(13) + 'Общее кол-во уровней'+ STR(nU)  + CHR(13) + 'Уровень № ' + SPACE(3) +;
  STR(J) WINDOW NOWAIT
  IF j = 1
   SELECT u, i, ik, ich, ci, q, ink FROM My103i;
   WHERE U = 1 GROUP BY ik, ich, ci INTO CURSOR Cursor11
   
   SELECT Cursor11.u, Cursor11.i, Cursor11.ik, Cursor11.ich, Cursor11.ci, Cursor11.q, Cursor11.ink, My103j.z1 FROM My103j, Cursor11;
   WHERE My103j.u = Cursor11.u AND My103j.ich = Cursor11.ik AND My103j.ci = Cursor11.ci ;
   INTO CURSOR Cursor12
  ELSE
   SELECT i, ich, ci, z1 FROM Cursor10153 WHERE u = j - 1 GROUP BY i, ich, ci, z1 INTO CURSOR Cursor11
   
   SELECT My103i.u, My103i.i, My103i.ik, My103i.ich, My103i.ci, My103i.q, My103i.ink, z1 FROM My103i, Cursor11;
   WHERE My103i.u = j AND My103i.i = Cursor11.i AND My103i.ik = Cursor11.ich AND My103i.ci = Cursor11.ci ;
   INTO CURSOR Cursor12 
  ENDIF
 
  SELECT u, i, ik, ich, ci, q, ink, My10153.z1, z2, z3, z4, z5, z6, z7 FROM Cursor12, My10153;
  WHERE ich = kod_det AND Cursor12.z1 = My10153.z7 GROUP BY i, ik, ich, ci INTO CURSOR CursorA
 
  SELECT * FROM Cursor12 WHERE !EXISTS( SELECT * FROM My10153; 
  WHERE My10153.kod_det = Cursor12.ich AND My10153.z7 = Cursor12.z1) INTO CURSOR Cursor21
 
  SELECT * FROM Cursor12 WHERE !EXISTS( SELECT * FROM My10153; 
  WHERE My10153.kod_det = Cursor12.ich ) INTO CURSOR Cursor22
 
  SELECT * FROM Cursor21 WHERE !EXISTS( SELECT * FROM Cursor22;
  WHERE Cursor22.i = Cursor21.i AND Cursor22.ik = Cursor21.ik AND Cursor22.ich = Cursor21.ich ) INTO CURSOR Cursor23

  SELECT u, i, ik, ich, ci, q, ink, '28' AS z1, '00' AS z2, '00' AS z3, '00' AS z4, '00' AS z5, '00' AS z6, z1 AS z7 FROM Cursor22;
  INTO CURSOR CursorB
 
  SELECT u, i, ik, ich, ci, q, ink, My10153.z1, z2, z3, z4, z5, z6, Cursor23.z1 AS z7 FROM Cursor23, My10153;
  WHERE ich = kod_det AND !LEFT(ik, 6) = '503384' GROUP BY i, ik, ich, ci INTO CURSOR CursorC
  
  SELECT u, i, ik, ich, ci, q, ink, My10153.z1, z2, z3, z4, z5, z6, z7 FROM Cursor23, My10153;
  WHERE ich = kod_det AND LEFT(ik, 6) = '503384' GROUP BY i, ik, ich, ci INTO CURSOR CursorD
  
  SELECT * FROM CursorA;
  UNION ALL;
  SELECT * FROM CursorB;
  UNION ALL;
  SELECT * FROM CursorC;
  UNION ALL;
  SELECT * FROM CursorD;
  INTO TABLE TabTab
   
  SELECT Cursor10153
  APPEND FROM TabTab
  * 
  SELECT Cursor11
  USE
  SELECT Cursor12
  USE
  SELECT Cursor21
  USE
  SELECT Cursor22
  USE
  SELECT Cursor23
  USE
  SELECT CursorA
  USE
  SELECT CursorB
  USE
  SELECT CursorC
  USE
  SELECT CursorD
  USE
  DROP TABLE TabTab  
 ENDFOR
 ***************************************************************************************************  
 IF nRec = 1
  SELECT cTr AS tr, u, i, ik, ich, ci, q, z1, z2, z3, z4, z5, z6, z7, ink FROM Cursor10153;
  UNION;
  SELECT cTr AS tr, u, i, ik, ich, ci, q, z1, z2, z3, z4, z5, z6, z7, ink FROM My103j;
  INTO CURSOR Cursor10153i
  *
  SELECT * FROM Cursor10153i;
  GROUP BY u, i, ik, ich, ci, z1, z2, z3, z4, z5, z6, z7, ink ORDER BY tr, i, ci, U, ik, ich ; 
  INTO TABLE TrMy103m
 ELSE
  SELECT cTr AS tr, u, i, ik, ich, ci, q, z1, z2, z3, z4, z5, z6, z7, ink FROM Cursor10153;
  UNION;
  SELECT cTr AS tr, u, i, ik, ich, ci, q, z1, z2, z3, z4, z5, z6, z7, ink FROM My103j;
  INTO CURSOR Cursor10153i
  *
  SELECT * FROM Cursor10153i;
  GROUP BY u, i, ik, ich, ci, z1, z2, z3, z4, z5, z6, z7, ink ORDER BY tr, i, ci, U, ik, ich ; 
  INTO CURSOR CursorTemp10153i
  *
  SELECT * FROM CursorTemp10153i;
  UNION ALL;
  SELECT * FROM TrMy103m;
  INTO CURSOR CursorTempTemp10153i
  *
  SELECT * FROM CursorTempTemp10153i ORDER BY tr, i, ci, u, ik, ich INTO TABLE TrMy103m
 ENDIF
 nWaitI = nWaitI + 1
ENDSCAN
***************************************************************************************************  
SELECT Cursor10153
USE
DROP TABLE My10153
*
SELECT TrMy103m.tr, u, TrMy103m.i, TrMy103m.ik, TrMy103m.ich, TrMy103m.ci, z1, z2, z3, z4, z5, z6, TrMy103m.z7, TrMy103m.q AS q103,;
trTable61050pl.q AS qPl, (TrMy103m.q * trTable61050pl.q) AS q, ink FROM TrMy103m, trTable61050pl;
WHERE TrMy103m.tr = trTable61050pl.tr AND TrMy103m.i = trTable61050pl.i AND TrMy103m.ci = trTable61050pl.Z7 INTO CURSOR Cur103mq
*
SELECT tr, u, i, ik, ich, ci, z1, z2, z3, z4, z5, z6, z7, q103, qPl, SUM(q) AS q, ink FROM Cur103mq;
GROUP BY tr, i, ci, u, ik, ich ORDER BY tr, i, ci, u, ik, ich INTO TABLE TrMy103mq
ALTER TABLE TrMy103mq;
ALTER COLUMN q N(9)
*
WAIT 'ГОТОВО' WINDOW TIMEOUT 1