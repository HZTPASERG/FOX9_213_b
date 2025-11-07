 CREATE CURSOR Cursor10153;
 (U INT(4), I CHAR(12), ik CHAR(12), ich CHAR(12), ci CHAR(2), z1 CHAR(2), z2 CHAR(2), z3 CHAR(2), z4 CHAR(2), z5 CHAR(2), ;
  z6 CHAR(2), z7 CHAR(2), q N(8,2), pzb CHAR(1) )
***************************************************************************************************   
IF !USED('My103')
 USE my103.dbf IN 0 EXCLUSIVE
ENDIF

*

SELECT i, ci, 1 AS q FROM MyPlan GROUP BY i, ci INTO CURSOR Cur1
SELECT u, My103.i, ik, ich, My103.q, ci FROM My103, Cur1 WHERE My103.i = Cur1.i ORDER BY My103.i, ci, u, ik, ich INTO CURSOR Cur2

SELECT * FROM Cur2 WHERE ik <> ich ORDER BY u INTO TABLE My103i

SELECT ik AS dse FROM Cur2 WHERE u = 1 GROUP BY ik;
UNION ALL;
SELECT ich AS dse FROM Cur2 GROUP BY ich;
INTO CURSOR PerDSE103

SELECT * FROM table10153 WHERE EXISTS(SELECT * FROM PerDSE103; 
WHERE PerDSE103.dse = table10153.kod_det ) ORDER BY kod_det INTO TABLE My10153

*
SELECT * FROM Cur2 WHERE ik = ich ORDER BY u INTO CURSOR Cur3

SELECT u, i, ik, ich, ci, q, z1, z2, z3, z4, z5, z6, z7 FROM Cur3, My10153;
WHERE Cur3.ich = My10153.kod_det AND Cur3.ci = My10153.z7 GROUP BY u, i, ik, ich, ci, q INTO CURSOR CurA

SELECT * FROM Cur3 WHERE !EXISTS( SELECT * FROM My10153; 
 WHERE My10153.kod_det = Cur3.ich AND My10153.z7 = Cur3.ci) INTO CURSOR Cur21

SELECT * FROM Cur3 WHERE !EXISTS( SELECT * FROM My10153; 
WHERE My10153.kod_det = Cur3.ich ) INTO CURSOR Cur22

SELECT * FROM Cur21 WHERE !EXISTS( SELECT * FROM Cur22;
WHERE Cur22.i = Cur21.i AND Cur22.ik = Cur21.ik AND Cur22.ich = Cur21.ich ) INTO CURSOR Cur23

SELECT u, i, ik, ich, ci, q, '28' AS z1, '00' AS z2, '00' AS z3, '00' AS z4, '00' AS z5, '00' AS z6, ci AS z7 FROM Cur22;
INTO CURSOR CurB

SELECT u, i, ik, ich, ci, q, My10153.z1, z2, z3, z4, z5, z6, Cur23.ci AS z7 FROM Cur23, My10153;
WHERE ich = kod_det AND !LEFT(ik, 6) = '503384' GROUP BY i, ik, ich, ci INTO CURSOR CurC

SELECT u, i, ik, ich, ci, q, My10153.z1, z2, z3, z4, z5, z6, z7 FROM Cur23, My10153;
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
*
SELECT My103i
GO BOTTOM
STORE U TO nU
GO TOP
***************************************************************************************************  
 FOR j = 1 TO nU
 WAIT 'Расчёт 103-ей с маршрутом....' + CHR(13) + CHR(13) + 'Общее кол-во уровней'+ STR(nU)  + CHR(13) + 'Уровень № '  + STR(J) WINDOW NOWAIT
 IF j = 1
  SELECT u, i, ik, ich, ci, q FROM My103i;
  WHERE U = 1 GROUP BY ik, ich, ci INTO CURSOR Cursor11
  
  SELECT Cursor11.u, Cursor11.i, Cursor11.ik, Cursor11.ich, Cursor11.ci, Cursor11.q, My103j.z1 FROM My103j, Cursor11;
  WHERE My103j.u = Cursor11.u AND My103j.ich = Cursor11.ik AND My103j.ci = Cursor11.ci ;
  INTO CURSOR Cursor12
 ELSE
  SELECT ich, ci, z1 FROM Cursor10153 WHERE u = j - 1 GROUP BY ich, ci INTO CURSOR Cursor11
  
  SELECT My103i.u, My103i.i, My103i.ik, My103i.ich, My103i.ci, My103i.q, z1 FROM My103i, Cursor11;
  WHERE My103i.u = j AND My103i.ik = Cursor11.ich AND My103i.ci = Cursor11.ci ;
  INTO CURSOR Cursor12 
 ENDIF

 SELECT u, i, ik, ich, ci, q, My10153.z1, z2, z3, z4, z5, z6, z7 FROM Cursor12, My10153;
 WHERE ich = kod_det AND Cursor12.z1 = My10153.z7 GROUP BY i, ik, ich, ci INTO CURSOR CursorA

 SELECT * FROM Cursor12 WHERE !EXISTS( SELECT * FROM My10153; 
  WHERE My10153.kod_det = Cursor12.ich AND My10153.z7 = Cursor12.z1) INTO CURSOR Cursor21

 SELECT * FROM Cursor12 WHERE !EXISTS( SELECT * FROM My10153; 
  WHERE My10153.kod_det = Cursor12.ich ) INTO CURSOR Cursor22

 SELECT * FROM Cursor21 WHERE !EXISTS( SELECT * FROM Cursor22;
  WHERE Cursor22.i = Cursor21.i AND Cursor22.ik = Cursor21.ik AND Cursor22.ich = Cursor21.ich ) INTO CURSOR Cursor23

  SELECT u, i, ik, ich, ci, q, '28' AS z1, '00' AS z2, '00' AS z3, '00' AS z4, '00' AS z5, '00' AS z6, z1 AS z7 FROM Cursor22;
  INTO CURSOR CursorB

  SELECT u, i, ik, ich, ci, q, My10153.z1, z2, z3, z4, z5, z6, Cursor23.z1 AS z7 FROM Cursor23, My10153;
  WHERE ich = kod_det AND !LEFT(ik, 6) = '503384' GROUP BY i, ik, ich, ci INTO CURSOR CursorC

  SELECT u, i, ik, ich, ci, q, My10153.z1, z2, z3, z4, z5, z6, z7 FROM Cursor23, My10153;
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
*
SELECT u, i, ik, ich, ci, q, z1, z2, z3, z4, z5, z6, z7 FROM Cursor10153;
UNION;
SELECT u, i, ik, ich, ci, q, z1, z2, z3, z4, z5, z6, z7 FROM My103j;
INTO CURSOR Cursor10153i
*
SELECT * FROM Cursor10153i;
GROUP BY u, i, ik, ich, ci, z1, z2, z3, z4, z5, z6, z7 ORDER BY i, ci, U, ik, ich ; 
INTO CURSOR Cur001
*
SELECT u, Cur001.i, ik, ich, Cur001.ci, (Cur001.q * MyPlan.q) AS q, z1, z2, z3, z4, z5, z6, z7 FROM Cur001, MyPlan;
WHERE Cur001.i = MyPlan.i ORDER BY Cur001.i, Cur001.ci, ik, ich INTO CURSOR Cur002
*
SELECT u, i, ik, ich, ci, SUM(q) AS q, z1, z2, z3, z4, z5, z6, z7 FROM Cur002;
GROUP BY i, u, ik, ich ORDER BY i, u, ik, ich INTO TABLE My103m
*
SELECT Cursor10153
USE
SELECT PerDSE103
USE
DROP TABLE My10153
*
WAIT CLEAR