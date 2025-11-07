*!*	CREATE DATABASE data1
*!*	OPEN DATABASE data1
*!*	CREATE CONNECTION Con1;
*!*	DATASOURCE DPO;
*!*	DATABASE DPO
*!*	nKonHandle = SQLCONNECT('Con1')
*!*	SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
*!*	CLOSE DATABASE
*!*	*
*!*	nR = SQLEXEC(nKonHandle,'SELECT zak, kod_izd, cex FROM table97 ORDER BY zak, kod_izd, cex','Cur97')
*!*	******************************************************************************************************************************************************************************************************
SELECT oi_a AS io, ni_a AS inn, IIF(LEN(ALLTRIM(STR(ze_a))) = 1, '0' + ALLTRIM(STR(ze_a)), ALLTRIM(STR(ze_a)) ) AS cex,;
ss_c_i AS cen_mat, sym AS cen_kom, zar FROM tIzd_m_k;
ORDER BY oi_a INTO CURSOR Cur01
*
SELECT i, oi AS io, ni AS inn FROM str213 GROUP BY i, oi ORDER BY i INTO CURSOR Cur03
*
SELECT * FROM Cur01 WHERE LEN(ALLTRIM(io)) > 12 ORDER BY io INTO CURSOR Cur04
*
SELECT i, Cur04.io, Cur04.inn, Cur04.cex, Cur04.cen_mat, Cur04.cen_kom, Cur04.zar FROM Cur04 LEFT JOIN Cur03;
ON Cur04.io = Cur03.io ORDER BY i INTO CURSOR Cur05
*
SELECT * FROM Cur05 WHERE !ISNULL(i) ORDER BY i INTO CURSOR Cur06
*
*!*	DECLARE uX(6)
*!*	SELECT Cur06
*!*	SCAN
*!*	 STORE RECCOUNT() TO nCount
*!*	 STORE RECNO() TO nRec
*!*	 WAIT ALLTRIM(STR(nRec)) + SPACE(2) + ALLTRIM(STR(nCount)) WINDOW NOWAIT
*!*	 *
*!*	 STORE ALLTRIM(i) TO uX(1)
*!*	 STORE ALLTRIM(cex) TO uX(2)
*!*	 STORE cen_mat TO uX(3)
*!*	 STORE cen_kom TO uX(4)
*!*	 STORE zar TO uX(5)
*!*	 STORE '' TO uX(6)
*!*	 *
*!*	 SELECT * FROM Cur97 WHERE kod_izd = uX(1) AND cex = uX(2) INTO CURSOR CurTemp
*!*	 IF RECCOUNT() = 0
*!*	  nR = SQLEXEC(nKonHandle,'EXEC Ins97dse ?uX(6), ?uX(1), ?uX(2), ?uX(3), ?uX(4), ?uX(5)')
*!*	 ELSE
*!*	  nR = SQLEXEC(nKonHandle,'EXEC Upd97zpl ?uX(6), ?uX(1), ?uX(2), ?uX(5)')
*!*	 ENDIF
*!*	ENDSCAN
***************************************************************************************************************************************************************************************************
SELECT *, COUNT(*) AS kol FROM Cur06 GROUP BY i, cex INTO CURSOR CurTemp00
*
SELECT * FROM Cur06 WHERE EXISTS(;
SELECT * FROM CurTemp00 WHERE CurTemp00.i = Cur06.i AND CurTemp00.cex = Cur06.cex AND CurTemp00.kol > 1);
ORDER BY i, cex INTO TABLE tab_rep