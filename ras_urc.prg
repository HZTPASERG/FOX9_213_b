CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DPO;
DATABASE DPO
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
CLOSE DATABASE
*
nR = SQLEXEC(nKonHandle,'SELECT zak, kod_izd, cex, CAST(SUM(cp_tr) AS FLOAT) AS cp_tr FROM table93 ;
GROUP BY zak, kod_izd, cex ORDER BY zak, kod_izd, cex','Cur93')
nR = SQLEXEC(nKonHandle,'SELECT zak, kod_izd, cex, CAST(SUM(cp_tr) AS FLOAT) AS cp_tr FROM table94 ;
GROUP BY zak, kod_izd, cex ORDER BY zak, kod_izd, cex','Cur94')
nR = SQLEXEC(nKonHandle,'SELECT zak, kod_izd, cex FROM table97 ORDER BY zak, kod_izd, cex','Cur97')
*
SELECT zak, kod_izd, cex, cp_tr AS cm, (cp_tr - cp_tr) AS ck FROM Cur93 WHERE EXISTS(;
SELECT * FROM Cur97 WHERE Cur97.zak = Cur93.zak AND Cur97.kod_izd = Cur93.kod_izd AND Cur97.cex = Cur93.cex);
UNION ALL;
SELECT zak, kod_izd, cex, (cp_tr - cp_tr) AS cm, cp_tr AS ck FROM Cur94 WHERE EXISTS(;
SELECT * FROM Cur97 WHERE Cur97.zak = Cur94.zak AND Cur97.kod_izd = Cur94.kod_izd AND Cur97.cex = Cur94.cex);
INTO CURSOR CurUrc01
*
SELECT zak, kod_izd, cex, SUM(cm) AS cm, SUM(ck) AS ck FROM CurUrc01;
GROUP BY zak, kod_izd, cex ORDER BY zak, kod_izd, cex INTO CURSOR CurUrc02
nWaitI = 1
DECLARE uX(5)
STORE RECCOUNT() TO nCount
SCAN
 WAIT 'ÈÄ¨Ò ÏÅÐÅÐÀÑ×¨Ò' + CHR(13) + CHR(13) + 'Âñåãî ñòðîê:' + SPACE(3) + ALLTRIM(STR(nCount)) + CHR(13) + '¹ï/ï:' + SPACE(3) + ALLTRIM(STR(nWaitI));
 WINDOW NOWAIT
 STORE zak TO uX(1)
 STORE kod_izd TO uX(2)
 STORE cex TO uX(3)
 STORE cm TO uX(4)
 STORE ck TO uX(5)
 nR = SQLEXEC(nKonHandle,'UPDATE table97 SET cm = ?uX(4), ck = ?uX(5) WHERE zak = ?uX(1) AND kod_izd = ?uX(2) AND cex = ?uX(3)')
 nWaitI = nWaitI + 1
ENDSCAN
WAIT 'ÏÅÐÅÐÀÑ×¨Ò ÇÀÊÎÍ×ÅÍ' WINDOW TIMEOUT 2