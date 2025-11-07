CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DTR;
DATABASE DTR
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle, 'DISPWARNINGS', .T.)
CLOSE DATABASE
*
SET DECIMAL TO 8
nWaitI = 1
DECLARE uX(3)
SELECT CurSt
STORE RECCOUNT() TO nRecRec
SCAN
 WAIT 'Запрос на сервер....' + CHR(13) + CHR(13) + 'Общее кол-во ТР'  + STR(nRecRec) + CHR(13) + 'ТР № п/п' + SPACE(7) + STR(nWaitI) WINDOW NOWAIT
 STORE tr TO uX(1)
 STORE dat TO uX(3)
 STORE RECNO() TO uX(2)
 *
 nR = SQLEXEC(nKonHandle,'SELECT tr, izd, ik, ich, CAST(q AS INT) AS q , ;
 CAST(ink AS INT) AS ink FROM table10150 WHERE tr = ?uX(1) AND dat=?uX(3)','Cur10150')
 *
 nR = SQLEXEC(nKonHandle,'SELECT tr, izd, kod_det, z1, z2, z3, z4, z5, z6, z7 FROM table10153 ;
 WHERE tr = ?uX(1) AND dat=?uX(3)','Cur10153')
 *
 nR = SQLEXEC(nKonHandle,'SELECT tr, izd, i, inn, io FROM table10857 ;
 WHERE tr = ?uX(1) AND dat=?uX(3)','Cur10857')
 *
 cSql=[SELECT tr,izd,kod_det,ei,CAST(massa_det AS FLOAT) AS massa_det,kod_mat,raz_zag,kol_det_za,CAST(norma_na_d AS FLOAT) AS norma_na_d,]+;
 [cp,CAST(dl AS FLOAT) AS tol,r,CAST(shir AS FLOAT) AS shir,e,CAST(tol AS FLOAT) AS dl FROM table11050 WHERE tr = ?uX(1) AND dat=?uX(3)]
 nR = SQLEXEC(nKonHandle,cSql,'Cur11050')
 *
 nR = SQLEXEC(nKonHandle,'SELECT tr,izd,kod_mat,kod_gr_mat,naim_mat,cp,marka,;
 gost_marka,sortament,razmer,gost_sort,ed_izm,kod_izm,CAST(cena AS FLOAT) AS cena,;
 CAST(norma_na_d AS FLOAT) AS norma_na_d FROM table11052 ;
 WHERE tr = ?uX(1) AND dat=?uX(3)','Cur11052')
 *
 nR = SQLEXEC(nKonHandle,' SELECT tr,izd,kod_mat,kod_gr_mat,naim_mat,marka,;
 gost_marka,sortament,razmer,gost_sort,ed_izm,kod_izm,;
 CAST(cena_uch AS FLOAT) cena_uch FROM table1081a WHERE tr = ?uX(1) AND dat=?uX(3)','Cur1081a')
 *
 nR = SQLEXEC(nKonHandle,'SELECT tr, izd, kod_kompl, naim_kompl, tip, tex_xar, gost, naim_ei, kod_ei,;
 CAST(cena AS FLOAT) AS cena FROM table10856 WHERE tr = ?uX(1) AND dat=?uX(3)','Cur10856')
 *
 nR = SQLEXEC(nKonHandle,'SELECT tr, izd, kod_ved, kod_izd, cex, kompl, CAST(q AS FLOAT) AS q FROM table10869 WHERE tr = ?uX(1) AND dat=?uX(3)','Cur10869')
 **
 IF uX(2) = 1
  SELECT tr, izd, ik, ich, q, ink FROM Cur10150 INTO TABLE Trtable10150
  SELECT tr, izd, kod_det, z1, z2, z3, z4, z5, z6, z7 FROM Cur10153 INTO TABLE Trtable10153
  SELECT tr, izd, i, inn, io FROM Cur10857 INTO TABLE Trtable10857
  SELECT tr, izd, kod_det, ei, massa_det, kod_mat, raz_zag, kol_det_za,;
  norma_na_d, cp, tol, r, shir, e, dl FROM Cur11050 INTO TABLE Trtable11050
  SELECT tr, izd, kod_mat, kod_gr_mat, naim_mat, cp, marka, gost_marka,;
  sortament, razmer, gost_sort, ed_izm, kod_izm, cena, norma_na_d FROM Cur11052 INTO TABLE Trtable11052
  SELECT tr, izd, kod_mat, kod_gr_mat, naim_mat, marka, gost_marka, sortament, razmer,;
  gost_sort, ed_izm, kod_izm, cena_uch FROM Cur1081a INTO TABLE Trtable1081a
  SELECT tr, izd, kod_kompl, naim_kompl, tip, tex_xar, gost, naim_ei, kod_ei, cena FROM Cur10856 INTO TABLE Trtable10856
  SELECT tr, izd, kod_ved, kod_izd, cex, kompl, q FROM Cur10869 INTO TABLE Trtable10869
 ELSE
  SELECT tr, izd, ik, ich, q, ink FROM Cur10150;
  UNION ALL;
  SELECT * FROM Trtable10150;
  INTO CURSOR CurTemp
  SELECT * FROM CurTemp ORDER BY tr INTO TABLE Trtable10150
  *
  SELECT tr, izd, kod_det, z1, z2, z3, z4, z5, z6, z7 FROM Cur10153;
  UNION ALL;
  SELECT * FROM Trtable10153;
  INTO CURSOR CurTemp
  SELECT * FROM CurTemp ORDER BY tr INTO TABLE Trtable10153
  *
  SELECT tr, izd, i, inn, io FROM Cur10857;
  UNION ALL;
  SELECT * FROM Trtable10857;
  INTO CURSOR CurTemp
  SELECT * FROM CurTemp ORDER BY tr INTO TABLE Trtable10857
  *
  SELECT tr, izd, kod_det, ei, massa_det, kod_mat, raz_zag, kol_det_za,;
  norma_na_d, cp, tol, r, shir, e, dl FROM Cur11050;
  UNION ALL;
  SELECT * FROM Trtable11050;
  INTO CURSOR CurTemp
  SELECT * FROM CurTemp ORDER BY tr INTO TABLE Trtable11050
  *
  SELECT tr, izd, kod_mat, kod_gr_mat, naim_mat, cp, marka, gost_marka,;
  sortament, razmer, gost_sort, ed_izm, kod_izm, cena, norma_na_d FROM Cur11052;
  UNION ALL;
  SELECT * FROM Trtable11052;
  INTO CURSOR CurTemp
  SELECT * FROM CurTemp ORDER BY tr INTO TABLE Trtable11052
  *
  SELECT tr, izd, kod_mat, kod_gr_mat, naim_mat, marka, gost_marka, sortament, razmer,;
  gost_sort, ed_izm, kod_izm, cena_uch FROM Cur1081a;
  UNION ALL;
  SELECT * FROM Trtable1081a;
  INTO CURSOR CurTemp
  SELECT * FROM CurTemp ORDER BY tr INTO TABLE Trtable1081a
  *
  SELECT tr, izd, kod_kompl, naim_kompl, tip, tex_xar, gost, naim_ei, kod_ei, cena FROM Cur10856;
  UNION ALL;
  SELECT * FROM Trtable10856;
  INTO CURSOR CurTemp
  SELECT * FROM CurTemp ORDER BY tr INTO TABLE Trtable10856
  *
  SELECT tr, izd, kod_ved, kod_izd, cex, kompl, q FROM Cur10869;
  UNION ALL;
  SELECT * FROM Trtable10869;
  INTO CURSOR CurTemp
  SELECT * FROM CurTemp ORDER BY tr INTO TABLE Trtable10869
 ENDIF
 nWaitI = nWaitI + 1
ENDSCAN
****************************************************************************************************
SELECT tr, izd, kod_det, IIF(z1 = '37' AND !z2 = '00', '', ALLTRIM(z1) ) + IIF( z2 = '37' OR z2 = '00', '', ALLTRIM(z2) ) + ;
IIF(z3 = '37' OR z3 = '00', '', ALLTRIM(z3)) + IIF(z4 = '37' OR z4 = '00', '', ALLTRIM(z4)) + ;
IIF(z5 = '37' OR z5 = '00', '', ALLTRIM(z5)) + IIF(z6 = '37' OR z6 = '00', '', ALLTRIM(z6)) + ;
ALLTRIM(z7)  +  SPACE(10) AS cex ;
FROM Trtable10153 WHERE z1 = '37' OR z2 = '37' OR z3 = '37' OR z4 = '37' OR z5 = '37' OR z6 = '37';
INTO CURSOR table1
****************************************************************************************************
SELECT tr, izd, kod_det, IIF(z1 = '39' AND !z2 = '00', '', ALLTRIM(z1) ) + IIF( z2 = '39' OR z2 = '00', '', ALLTRIM(z2) ) + ;
IIF(z3 = '39' OR z3 = '00', '', ALLTRIM(z3)) + IIF(z4 = '39' OR z4 = '00', '', ALLTRIM(z4)) + ;
IIF(z5 = '39' OR z5 = '00', '', ALLTRIM(z5)) + IIF(z6 = '39' OR z6 = '00', '', ALLTRIM(z6)) + ;
ALLTRIM(z7)  +  SPACE(10) AS cex ;
FROM Trtable10153 WHERE z1 = '39' OR z2 = '39' OR z3 = '39' OR z4 = '39' OR z5 = '39' OR z6 = '39';
INTO CURSOR table11
****************************************************************************************************
SELECT tr, izd, kod_det, LEFT(ALLTRIM(cex), 2) AS z1, IIF(LEN(ALLTRIM(cex)) > 4, SUBSTR(cex, 3, 2), '00') AS z2, ;
IIF(LEN(ALLTRIM(cex)) > 6, SUBSTR(cex, 5, 2), '00') AS z3, IIF(LEN(ALLTRIM(cex)) > 8, SUBSTR(cex, 7, 2), '00') AS z4, ;
IIF(LEN(ALLTRIM(cex)) > 10, SUBSTR(cex, 9, 2), '00') AS z5, IIF(LEN(ALLTRIM(cex)) > 12, SUBSTR(cex, 11, 2), '00') AS z6,;
RIGHT(ALLTRIM(cex), 2) AS z7 FROM table1;
UNION ALL;
SELECT tr, izd, kod_det, LEFT(ALLTRIM(cex), 2) AS z1, IIF(LEN(ALLTRIM(cex)) > 4, SUBSTR(cex, 3, 2), '00') AS z2, ;
IIF(LEN(ALLTRIM(cex)) > 6, SUBSTR(cex, 5, 2), '00') AS z3, IIF(LEN(ALLTRIM(cex)) > 8, SUBSTR(cex, 7, 2), '00') AS z4, ;
IIF(LEN(ALLTRIM(cex)) > 10, SUBSTR(cex, 9, 2), '00') AS z5, IIF(LEN(ALLTRIM(cex)) > 12, SUBSTR(cex, 11, 2), '00') AS z6,;
RIGHT(ALLTRIM(cex), 2) AS z7 FROM table11;
UNION ALL;  
SELECT tr, izd, kod_det, z1, z2, z3, z4, z5, z6, z7 FROM Trtable10153;
WHERE !z1 = '37' AND !z2 = '37' AND !z3 = '37' AND !z4 = '37' AND !z5 = '37' AND !z6 = '37' AND;
!z1 = '39' AND !z2 = '39' AND !z3 = '39' AND !z4 = '39' AND !z5 = '39' AND !z6 = '39';
INTO CURSOR table2
SELECT * FROM table2;
ORDER BY tr, kod_det, z7, z1 INTO TABLE Trtable10153_37
***************************************************************************************************
*
SELECT Trtable11050
INDEX ON kod_det TAG tDet
SELECT Trtable1081a
INDEX ON kod_mat TAG tMat
SELECT Trtable10857
INDEX ON i TAG ti
SELECT Trtable10153
INDEX ON kod_det TAG tkod_det 
SELECT Trtable10153_37
INDEX ON kod_det TAG tkod_det 
SELECT Trtable10150
INDEX ON ik TAG tik
INDEX ON ich TAG tich
SELECT Trtable11052
INDEX ON kod_mat TAG tMat
SELECT Trtable10856
INDEX ON kod_kompl TAG tKom
SELECT Trtable10869
INDEX ON kod_izd TAG tIzd
SELECT Trtable10869
INDEX ON kompl TAG tKom
*
WAIT 'ГОТОВО' WINDOW TIMEOUT 2