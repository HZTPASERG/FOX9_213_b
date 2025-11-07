SET DECIMAL TO 8
CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DPO;
DATABASE DPO
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle, 'DISPWARNING', .T.)
CLOSE DATABASE
*
nR = SQLEXEC(nKonHandle,'SELECT zak, kod_izd FROM table93 GROUP BY zak, kod_izd ORDER BY zak, kod_izd','Cur93izd')
STORE zak TO cZak
STORE kod_izd TO cIzd
nR = SQLEXEC(nKonHandle,'EXEC Sel93 ?cZak, ?cIzd','Cur93')
*!*	nR = SQLEXEC(nKonHandle,'EXEC Sel94','Cur94')
*
SELECT zak, kod_izd, .F. AS p FROM Cur93izd ORDER BY zak, kod_izd INTO TABLE table93izd
*
SELECT zak, kod_izd, naim_izd, kod, naim_mat, sortament, marka, razmer, ed_izm, q, cex,;
ROUND(transp,2) AS transp, ROUND(cd,2) AS cd, ROUND(cp,2) AS cp, cd_0, cp_0, cd_tr, cp_tr;
FROM Cur93 LEFT JOIN table1081a ON Cur93.kod = table1081a.kod_mat;
ORDER BY zak, kod_izd, kod, cex INTO TABLE table93
*
*!*	SELECT zak, kod_izd, naim_izd, kod, naim_kompl, tip, tex_xar, gost, q, cex,;
*!*	ROUND(transp,2) AS transp, ROUND(cd,2) AS cd, ROUND(cp,2) AS cp, cd_0, cp_0, cd_tr, cp_tr;
*!*	FROM Cur94 LEFT JOIN table10856 ON Cur94.kod = table10856.kod_kompl;
*!*	ORDER BY zak, kod_izd, kod, cex INTO TABLE table94
*
DO FORM fRez
*
fRez.NewTree_