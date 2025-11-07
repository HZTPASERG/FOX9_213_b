CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DPO;
DATABASE DPO
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
CLOSE DATABASE
*
nR = SQLEXEC(nKonHandle,'SELECT kod_mat, naim_mat, marka, sortament, razmer, ed_izm,;
CAST(cd AS FLOAT) AS cd, CAST(cp AS FLOAT) AS cp FROM table95','Cur95')
SELECT * FROM Cur95 ORDER BY kod_mat INTO TABLE table95
*
SELECT kod_mat, COUNT(*) AS kol FROM table95 GROUP BY kod_mat INTO CURSOR Cur01
*
SELECT kod_mat AS kod, naim_mat AS naim, marka, sortament, razmer, ed_izm, cd, cp FROM table95 WHERE EXISTS(;
SELECT * FROM Cur01 WHERE Cur01.kod_mat = table95.kod_mat AND Cur01.kol > 1);
ORDER BY kod_mat INTO TABLE tab_rep
*
*!*	SELECT kod_kom, COUNT(*) AS kol FROM table96 GROUP BY kod_kom INTO CURSOR Cur02
*!*	*
*!*	SELECT kod_kom AS kod, naim_kom AS naim, cd, cp FROM table96 WHERE EXISTS(;
*!*	SELECT * FROM Cur02 WHERE Cur02.kod_kom = table96.kod_kom AND Cur01.kol > 1);
*!*	ORDER BY kod_kom INTO TABLE tab_rep