CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DPO;
DATABASE DPO
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
CLOSE DATABASE
*00-Изделия
DECLARE uX(3)
SELECT zak, kod_izd, ob_izd, naim_izd, pri AS q, gr FROM table_zakaz WHERE pr = '00' GROUP BY kod_izd ORDER BY kod_izd INTO CURSOR CurIzd
SCAN
 STORE zak TO uX(1)
 STORE kod_izd TO uX(2)
 STORE q TO uX(3)
 nR = SQLEXEC(nKonHandle,'EXECUTE Ins00 ?uX(1), ?uX(2), ?uX(3)')
ENDSCAN
*01-Составные
DECLARE uX(4)
SELECT * FROM table_zakaz WHERE pr BETWEEN '01' AND '87' AND LEN(ALLTRIM(kod_izd)) = 12 ORDER BY gr, pr INTO CURSOR CurSos01
*
SELECT CurSos01.zak, CurIzd.kod_izd, CurSos01.kod_izd AS kod_det, CurSos01.ob_izd AS ob_det, CurSos01.naim_izd AS naim_det, CurSos01.gr,;
CurSos01.pr, CurSos01.pri AS q FROM CurSos01, CurIzd WHERE CurSos01.gr = CurIzd.gr ORDER BY CurSos01.gr, CurSos01.pr INTO CURSOR CurSos02
SCAN
 STORE zak TO uX(1)
 STORE kod_izd TO uX(2)
 STORE kod_det TO uX(3)
 STORE q TO uX(4)
 nR = SQLEXEC(nKonHandle,'EXECUTE Ins01 ?uX(1), ?uX(2), ?uX(3), ?uX(4)')
ENDSCAN
*90-Ведомость
DECLARE uX(4)
SELECT * FROM table_zakaz WHERE pr = '90' AND LEN(ALLTRIM(kod_izd)) = 11 ORDER BY gr, pr INTO CURSOR CurVed01
*
SELECT CurVed01.zak, CurIzd.kod_izd, CurVed01.kod_izd AS kod_ved, CurVed01.gr, CurVed01.pr, CurVed01.pri AS q FROM CurVed01, CurIzd;
WHERE CurVed01.gr = CurIzd.gr ORDER BY CurVed01.gr, CurVed01.pr INTO CURSOR CurVed02
SCAN
 STORE zak TO uX(1)
 STORE kod_izd TO uX(2)
 STORE kod_ved TO uX(3)
 STORE q TO uX(4)
 nR = SQLEXEC(nKonHandle,'EXECUTE Ins92 ?uX(1), ?uX(2), ?uX(3), ?uX(4)')
ENDSCAN
*91-Комплектующие
DECLARE uX(4)
SELECT * FROM table_zakaz WHERE pr = '91' AND LEN(ALLTRIM(kod_izd)) = 7 ORDER BY gr, pr INTO CURSOR CurKom01
*
SELECT CurKom01.zak, CurIzd.kod_izd, CurKom01.kod_izd AS kod_kom, CurKom01.gr, CurKom01.pr, CurKom01.pri AS q FROM CurKom01, CurIzd;
WHERE CurKom01.gr = CurIzd.gr ORDER BY CurKom01.gr, CurKom01.pr INTO CURSOR CurKom02
SCAN
 STORE zak TO uX(1)
 STORE kod_izd TO uX(2)
 STORE kod_kom TO uX(3)
 STORE q TO uX(4)
 nR = SQLEXEC(nKonHandle,'EXECUTE Ins91 ?uX(1), ?uX(2), ?uX(3), ?uX(4)')
ENDSCAN
*92-Материалы
DECLARE uX(4)
SELECT * FROM table_zakaz WHERE pr = '92' AND LEN(ALLTRIM(kod_izd)) = 7 ORDER BY gr, pr INTO CURSOR CurMat01
*
SELECT CurMat01.zak, CurIzd.kod_izd, CurMat01.kod_izd AS kod_mat, CurMat01.gr, CurMat01.pr, CurMat01.pri AS q FROM CurMat01, CurIzd;
WHERE CurMat01.gr = CurIzd.gr ORDER BY CurMat01.gr, CurMat01.pr INTO CURSOR CurMat02
SCAN
 STORE zak TO uX(1)
 STORE kod_izd TO uX(2)
 STORE kod_mat TO uX(3)
 STORE q TO uX(4)
 nR = SQLEXEC(nKonHandle,'EXECUTE Ins90 ?uX(1), ?uX(2), ?uX(3), ?uX(4)')
ENDSCAN
*!*	SET DECIMAL TO 2
*!*	nR = SQLEXEC(nKonHandle,'SELECT zak, kod_izd, ob_izd, naim_izd, CAST(q AS FLOAT) AS q FROM table00','Cur00')