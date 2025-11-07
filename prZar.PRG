SET DECIMAL TO 2
*
SELECT tr, i, naim_izd, cex, SUM(cp_tr) AS cm FROM CurRepM;
GROUP BY tr, i, cex ORDER BY tr, i, cex INTO CURSOR CurZM01
*
SELECT tr, i, naim_izd, cex, SUM(cp_tr) AS ck FROM CurRepK;
GROUP BY tr, i, cex ORDER BY tr, i, cex INTO CURSOR CurZK01
*
SELECT tr, i, naim_izd, cex, VAL(STR(ROUND(cm,2),10,2)) AS cm, VAL(STR(ROUND(cm-cm,2),10,2)) AS ck FROM CurZM01;
UNION ALL;
SELECT tr, i, naim_izd, cex, VAL(STR(ROUND(ck-ck,2),10,2)) AS cm, VAL(STR(ROUND(ck,2),10,2)) AS ck FROM CurZK01;
INTO CURSOR CurZ01
*
SELECT tr, i AS kod_izd, naim_izd, cex, SUM(cm) AS cm, SUM(ck) AS ck, VAL(STR(ROUND(ck-ck,2),4,2)) AS zpl,;
VAL(STR(ROUND(ck-ck,2),7,2)) AS nar, VAL(STR(ROUND(ck-ck,2),7,2)) AS pvo, VAL(STR(ROUND(ck-ck,2),7,2)) AS ss FROM CurZ01;
GROUP BY tr, i, cex ORDER BY tr, i, cex INTO CURSOR CurZ02
*
SELECT cex, VAL(STR(cm,7,2)) AS cm, VAL(STR(ck,7,2)) AS ck, zpl, nar, pvo, ss, tr, kod_izd, naim_izd FROM CurZ02;
ORDER BY tr, kod_izd, cex INTO TABLE table_zar
*
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
DECLARE uX(8)
SELECT table_zar
SCAN
 STORE tr TO uX(8)
 STORE ALLTRIM(kod_izd) TO uX(1)
 STORE ALLTRIM(cex) TO uX(2)
 STORE cm TO uX(3)
 STORE ck TO uX(4)
 nR = SQLEXEC(nKonHandle,'SELECT CAST(zpl AS FLOAT) AS zpl FROM table97 WHERE zak = ?uX(8) AND kod_izd = ?uX(1) AND cex = ?uX(2)','CurSql97')
 STORE zpl TO uX(5)
 nR = SQLEXEC(nKonHandle,'SELECT CAST(nar AS FLOAT) AS nar, CAST(pvo AS FLOAT) AS pvo FROM table98 WHERE cex = ?uX(2)','CurSql98')
 STORE nar TO uX(6)
 STORE pvo TO uX(7)
 SELECT table_zar
 REPLACE zpl WITH uX(5);
                  nar WITH (uX(5) * uX(6))/100;
                  pvo WITH ((uX(3) + uX(5) + ( (uX(5) * uX(6))/100 )) * uX(7))/100;
                  ss WITH uX(3) + uX(4) + uX(5) + ( (uX(5) * uX(6))/100 ) + ( ((uX(3) + uX(5) + ( (uX(5) * uX(6))/100 )) * uX(7))/100 )
ENDSCAN