SELECT oi_a AS io, ni_a AS inn, cen FROM tIzd_ynik ORDER BY oi_a INTO CURSOR Cur01
SELECT oi_a AS io, ni_a AS inn, IIF(LEN(ALLTRIM(STR(ze_a))) = 1, '0' + ALLTRIM(STR(ze_a)), ALLTRIM(STR(ze_a)) ) AS cex,;
ss_c_i AS cen_mat, sym AS cen_kom, zar FROM tIzd_m_k;
ORDER BY oi_a INTO CURSOR Cur02
*
SELECT IIF(LEN(ALLTRIM(STR(ze_a))) = 1, '0' + ALLTRIM(STR(ze_a)), ALLTRIM(STR(ze_a)) ) AS cex, nachisl AS nar, obhe_poiz AS pvo,;
admin AS adm, zatr_zb AS zbt, proh_opr AS pch, fin_zat AS fin FROM tze_nak INTO CURSOR Cur03
*
SELECT Cur02.io, Cur02.inn, Cur02.cex, Cur02.Cen_mat, Cur02.Cen_kom, Cur02.zar, Cur03.nar, Cur03.pvo FROM Cur02 LEFT JOIN Cur03;
ON Cur02.cex = Cur03.cex ORDER BY io INTO CURSOR Cur04
*
SELECT io, inn, cex, cen_mat, cen_kom, zar, nar, pvo, ((zar*nar)/100) AS s_nar, ((cen_mat + zar + ((zar*nar)/100)) * pvo)/100 AS s_pvo FROM Cur04;
ORDER BY io INTO CURSOR Cur05
*
SELECT io, inn, cex, cen_mat, cen_kom, zar, nar, pvo,  cen_mat + cen_kom + zar + s_nar + s_pvo AS sst FROM Cur05;
ORDER BY io INTO CURSOR Cur06
*
SELECT io, inn, SUM(sst) AS cena FROM Cur06 GROUP BY io ORDER BY io INTO CURSOR Cur07
*яепбеп
CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DPO;
DATABASE DPO
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
CLOSE DATABASE
*
*97
DECLARE uX(6)
SELECT Cur02
SCAN
 STORE RECCOUNT() TO nCount
 STORE RECNO() TO nRec
 WAIT ALLTRIM(STR(nRec)) + SPACE(2) + ALLTRIM(STR(nCount)) WINDOW NOWAIT
 STORE ALLTRIM(io) TO uX(1)
 STORE ALLTRIM(cex) TO uX(2)
 STORE cen_mat TO uX(3)
 STORE cen_kom TO uX(4)
 STORE zar TO uX(5)
 STORE '' TO uX(6)
 nR = SQLEXEC(nKonHandle,'EXEC Ins97io ?uX(6), ?uX(1), ?uX(2), ?uX(3), ?uX(4), ?uX(5)')
ENDSCAN
*98
DECLARE uX(7)
SELECT Cur03
SCAN
 STORE RECCOUNT() TO nCount
 STORE RECNO() TO nRec
 WAIT ALLTRIM(STR(nRec)) + SPACE(2) + ALLTRIM(STR(nCount)) WINDOW NOWAIT
 STORE ALLTRIM(cex) TO uX(1)
 STORE nar TO uX(2)
 STORE pvo TO uX(3)
 STORE adm TO uX(4)
 STORE zbt TO uX(5)
 STORE pch TO uX(6)
 STORE fin TO uX(7)
 nR = SQLEXEC(nKonHandle,'EXEC Ins98 ?uX(1), ?uX(2), ?uX(3), ?uX(4), ?uX(5), ?uX(6), ?uX(7)')
ENDSCAN