LOCAL oLCls
oLCls = CREATEOBJECT('LenAA')
*
CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DPO;
DATABASE DPO
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
CLOSE DATABASE
*
nR = SQLEXEC(nKonHandle,'SELECT kod_mat, naim_mat, marka, gost_marka, sortament, gost_sort, razmer, kod_izm, ed_izm, ;
CAST(cd AS FLOAT) AS cd, CAST(cp AS FLOAT) AS cp FROM table95','Cur95')
SELECT * FROM Cur95 ORDER BY kod_mat INTO TABLE table95
*
nR = SQLEXEC(nKonHandle,'SELECT kod_kom, naim_kom, tip, tex_xar, gost, kod_ei, naim_ei, ;
CAST(cd AS FLOAT) AS cd, CAST(cp AS FLOAT) AS cp FROM table96','Cur96')
SELECT * FROM Cur96 ORDER BY kod_kom INTO TABLE table96
*
*Œ—ÕŒ¬Õ€≈ Ã¿“≈–»¿À€ * ¬—œŒÃ¿√¿“≈À‹Õ€≈ Ã¿“≈–»¿À€
SELECT SPACE(4) AS tr, i, kod_mat, naim_mat, cp AS cex, SUM(norma_na_i) AS q FROM table_osm GROUP BY i, kod_mat, cp;
UNION ALL;
SELECT tr, i, kod_mat, IIF(ISNUL(naim_mat), 'Õ≈“ ¬ 1081‡', naim_mat) AS naim_mat, cp AS cex, SUM(norma_na_i) AS q;
FROM trTable_osm WHERE !EMPTY(kod_mat) GROUP BY tr, i, kod_mat, cp;
UNION ALL;
SELECT SPACE(4) AS tr, i, kod_vsm AS kod_mat, naim_mat, cp AS cex, SUM(norma_na_i) AS q FROM table_vsm GROUP BY i, kod_vsm, cp;
UNION ALL;
SELECT tr, i, kod_vsm AS kod_mat, IIF(ISNUL(naim_mat), 'Õ≈“ ¬ 1081‡', naim_mat) AS naim_mat, cp AS cex, SUM(norma_na_i) AS q;
FROM trTable_vsm GROUP BY tr, i, kod_vsm, cp INTO CURSOR CurM01
*
SELECT tr, i, kod_mat, naim_mat, cex, SUM(q) AS q FROM CurM01 GROUP BY tr, i, cex, kod_mat ORDER BY tr, i, cex, kod_mat INTO CURSOR CurM02
*
SELECT * FROM CurM02 WHERE !EXISTS(;
SELECT * FROM table95 WHERE table95.kod_mat = CurM02.kod_mat);
INTO CURSOR CurM03
*
* ŒÃœÀ≈ “”ﬁŸ»≈
SELECT SPACE(4) AS tr, i, kompl AS kod_kompl, naim_kompl, cex, SUM(norma_na_i) AS q FROM table_kpl GROUP BY i, kompl, cex;
UNION ALL;
SELECT tr, i, kompl AS kod_kompl, IIF(ISNUL(naim_kompl), 'Õ≈“ ¬ 10856', naim_kompl) AS naim_kompl, cex, SUM(norma_na_i) AS q FROM trTable_kpl GROUP BY tr, i, kompl, cex;
INTO CURSOR CurK01
*
SELECT tr, i, kod_kompl, naim_kompl, cex, q FROM CurK01 ORDER BY tr, i, cex, kod_kompl INTO CURSOR CurK02
*
SELECT * FROM CurK02 WHERE !EXISTS(;
SELECT * FROM table96 WHERE table96.kod_kom = CurK02.kod_kompl);
INTO CURSOR CurK03
*
*¬Ã≈—“≈
*Œ—ÕŒ¬Õ€≈ Ã¿“≈–»¿À€ * ¬—œŒÃ¿√¿“≈À‹Õ€≈ Ã¿“≈–»¿À€
SET DECIMAL TO 2
SELECT kod_mat, oLCls.fLenAA(naim_mat,30) AS naim_mat,;
sortament, oLCls.fLenAA(marka,19) AS marka, razm, ed_izm AS naim_ei FROM table_osm;
UNION ALL;
SELECT kod_mat, oLCls.fLenAA(naim_mat,30) AS naim_mat,;
sortament, oLCls.fLenAA(marka,19) AS marka, razm, ed_izm AS naim_ei FROM trTable_osm;
UNION ALL;
SELECT kod_vsm AS kod_mat, oLCls.fLenAA(naim_mat,30) AS naim_mat, sortament,;
oLCls.fLenAA(marka,19) AS marka, oLCls.fLenAA(razmer,26) AS razm, ed_izm AS naim_ei FROM table_vsm;
UNION ALL;
SELECT kod_vsm AS kod_mat, oLCls.fLenAA(naim_mat,30) AS naim_mat, sortament,;
oLCls.fLenAA(marka,19) AS marka, oLCls.fLenAA(razm,26) AS razm, ed_izm AS naim_ei FROM trTable_vsm;
INTO CURSOR CurM03000
*
SELECT * FROM CurM03000;
GROUP BY kod_mat ORDER BY kod_mat INTO CURSOR CurM0300
*
* ŒÃœÀ≈ “”ﬁŸ»≈
SELECT kompl AS kod_kompl, naim_kompl, oLCls.fLenAA(tip,10) AS tip, tex_xar,;
oLCls.fLenAA(gost,26) AS gost, naim_ei FROM table_kpl;
UNION ALL;
SELECT kompl AS kod_kompl, naim_kompl, oLCls.fLenAA(tip,10) AS tip, tex_xar,;
oLCls.fLenAA(gost,26) AS gost, naim_ei FROM trTable_kpl;
INTO CURSOR CurK03000
*
SELECT * FROM CurK03000;
GROUP BY kod_kompl ORDER BY kod_kompl INTO CURSOR CurK0300
*
*¬Ã≈—“≈*¬Ã≈—“≈
SELECT 'M' AS p, CurM03.kod_mat AS kod, CurM0300.naim_mat AS naim, sortament AS sort_tip, marka AS mar_tx,;
razm AS raz_gos, naim_ei, 0000000.00 AS cd, 0000000.00 AS cp FROM CurM03, CurM0300;
WHERE CurM03.kod_mat = CurM0300.kod_mat;
UNION ALL;
SELECT 'K' AS p, CurK03.kod_kompl AS kod, CurK0300.naim_kompl AS naim, tip AS sort_tip, tex_xar AS mar_tx,;
gost AS raz_gos, naim_ei, 0000000.00 AS cd, 0000000.00 AS cp FROM CurK03, CurK0300;
WHERE CurK03.kod_kompl = CurK0300.kod_kompl;
INTO CURSOR CurA01
*
*
SELECT * FROM CurA01 GROUP BY kod ORDER BY p, kod INTO TABLE table9596
STORE RECCOUNT() TO nCount
*!*	IF nCount = 0
 nR = SQLEXEC(nKonHandle,'SELECT CAST(tr AS FLOAT) AS transp FROM table99','Cur99')
 SELECT tr, i, kod_mat, naim_mat, cex, q, transp FROM CurM02, Cur99 INTO CURSOR CurTr01
 SELECT tr, i, kod_kompl, naim_kompl, cex, q, transp FROM CurK02, Cur99 INTO CURSOR CurTr02
 *
 SELECT tr, i, cex, CurTr01.kod_mat, IIF(ISNULL(table95.naim_mat),CurTr01.naim_mat,table95.naim_mat) AS naim_mat, IIF(ISNULL(marka),SPACE(7),marka) AS marka,;
 IIF(ISNULL(gost_marka),SPACE(15),gost_marka) AS gost_marka, IIF(ISNULL(sortament),SPACE(10),sortament) AS sortament,;
 IIF(ISNULL(gost_sort),SPACE(15),gost_sort) AS gost_sort, IIF(ISNULL(razmer),SPACE(14),razmer) AS razmer,;
 IIF(ISNULL(kod_izm),SPACE(2),kod_izm) AS kod_izm, IIF(ISNULL(ed_izm),SPACE(10),ed_izm) AS ed_izm,;
 IIF(ISNULL(cd),ROUND(00000,2),cd) AS cd, IIF(ISNULL(cp),ROUND(00000,2),cp) AS cp;
 FROM CurTr01 LEFT JOIN table95 ON CurTr01.kod_mat=table95.kod_mat INTO CURSOR CurTmp95
 
 SELECT CurTr01.tr, CurTr01.i, CurTr01.kod_mat, CurTr01.cex, CurTmp95.naim_mat, marka, gost_marka, sortament, gost_sort, razmer, kod_izm, ed_izm,;
 q, transp, cd, cp, (q * cd) AS cd_0, (q * cp) AS cp_0, (q * cd) * (1 + (transp / 100)) AS cd_tr, (q * cp) * (1 + (transp / 100)) AS cp_tr;
 FROM CurTr01, CurTmp95 WHERE CurTr01.tr=CurTmp95.tr AND CurTr01.i=CurTmp95.i AND CurTr01.cex=CurTmp95.cex AND CurTr01.kod_mat=CurTmp95.kod_mat;
 INTO CURSOR CurTr03
 *
 SELECT tr, i, cex, CurTr02.kod_kompl AS kod_kom, naim_kom, tip,;
 tex_xar, gost, kod_ei, naim_ei, cd, cp FROM CurTr02, table96 WHERE CurTr02.kod_kompl=table96.kod_kom ;
 	UNION ALL ;
 SELECT tr, i, cex, CurK03.kod_kompl AS kod_kom, CurK0300.naim_kompl AS naim_kom, tip,;
	 tex_xar, gost, naim_ei AS kod_ei, naim_ei, 0000000.00 AS cd, 0000000.00 AS cp;
	 FROM CurK03, CurK0300 WHERE CurK03.kod_kompl = CurK0300.kod_kompl;
	 INTO CURSOR CurTmp96

 SELECT CurTr02.tr, CurTr02.i, CurTr02.kod_kompl, CurTr02.cex, naim_kom, tip, tex_xar, gost, kod_ei, naim_ei,;
 q, transp, cd, cp, (q * cd) AS cd_0, (q * cp) AS cp_0, (q * cd) * (1 + (transp / 100)) AS cd_tr, (q * cp) * (1 + (transp / 100)) AS cp_tr;
 FROM CurTr02, CurTmp96 WHERE CurTr02.tr=CurTmp96.tr AND CurTr02.i=CurTmp96.i AND CurTr02.cex=CurTmp96.cex AND;
 CurTr02.kod_kompl=CurTmp96.kod_kom INTO CURSOR CurTr04
 *
 SELECT tr, i, naim_izd, kod_mat AS kod, cex, naim_mat AS naim, marka, gost_marka, sortament, gost_sort, razmer, kod_izm, ed_izm,;
 CurTr03.q, transp, cd, cp, cd_0, cp_0, cd_tr, cp_tr FROM CurTr03, table_zakaz WHERE CurTr03.tr = table_zakaz.zak AND CurTr03.i = table_zakaz.kod_izd;
 ORDER BY tr, i, cex, kod_mat INTO TABLE table_rm
 *
 SELECT tr, i, naim_izd, kod_kompl AS kod, cex, naim_kom AS naim, tip, tex_xar, gost, kod_ei, naim_ei,;
 CurTr04.q, transp, cd, cp, cd_0, cp_0, cd_tr, cp_tr FROM CurTr04, table_zakaz WHERE CurTr04.tr = table_zakaz.zak AND CurTr04.i = table_zakaz.kod_izd;
 ORDER BY tr, i, cex, kod_kompl INTO TABLE table_rk
 *
 SELECT izd, tr, a.i AS kod_det, CAST(inn AS VARCHAR(254)) AS inn, ci, cp, w, q FROM b402pw a, table10857 b WHERE a.i = b.i ;
	UNION ALL ;
	SELECT a.izd, a.tr, a.i AS kod_det, CAST(IIF(ISNULL(inn), '', inn) AS VARCHAR(254)) AS inn, ci, cp, w, q FROM b402pw a LEFT JOIN trTable10857 b ON a.i = b.i ;
		WHERE !EXISTS(SELECT * FROM table10857 c WHERE c.i = a.i) ;
	INTO CURSOR Cur402pw

 SELECT a.tr, b.kod_izd, b.naim_izd, kod_det AS kod, inn, ci, cp, w, a.q FROM Cur402pw a, table_zakaz b WHERE a.tr = b.zak AND a.izd = b.kod_izd;
 ORDER BY a.tr, b.kod_izd, kod_det, w INTO TABLE table_402
 *
 DO FORM fRez NAME oRez LINKED
 oRez.cRun = 'R'
 oRez.FormRun
 DO dp_rez.prg
*!*	ELSE
*!*	 DO FORM f9596
*!*	ENDIF
***************************************************************************************CLASS********************************************************************************************************
DEFINE CLASS LenAA AS CUSTOM
 FUNCTION fLenAA
  PARAMETER cLText00, nLLen
  LOCAL cLText01
  STORE IIF( LEN(ALLTRIM(cLText00)) < nLLen, ALLTRIM(cLText00) + SPACE(nLLen - LEN(ALLTRIM(cLText00))), LEFT(ALLTRIM(cLText00), nLLen) ) TO cLText01
  RETURN IIF(ISNULL(cLText01), SPACE(nLLen), cLText01)
 ENDFUNC
ENDDEFINE
***************************************************************************************CLASS********************************************************************************************************