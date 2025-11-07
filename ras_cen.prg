CREATE DATABASE data1
OPEN DATABASE data1
CREATE CONNECTION Con1;
DATASOURCE DPO;
DATABASE DPO
nKonHandle = SQLCONNECT('Con1')
SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
CLOSE DATABASE
*
IF !USED('table95')
 USE table95 IN 0 EXCLUSIVE
ENDIF
IF !USED('table96')
 USE table96 IN 0 EXCLUSIVE
ENDIF
*
nWaitI = 1
DECLARE uX(4)
nR = SQLEXEC(nKonHandle,'SELECT CAST(tr AS FLOAT) AS transp FROM table99','Cur99')
STORE transp TO uX(4)
SELECT table95
STORE RECCOUNT() TO nCount
SCAN
 WAIT 'Ã¿“≈–»¿À€' + CHR(13) + '¬ÒÂ„Ó ÒÚÓÍ:' + SPACE(3) + ALLTRIM(STR(nCount)) + CHR(13) + 'πÔ/Ô:' + SPACE(3) + ALLTRIM(STR(nWaitI));
 WINDOW NOWAIT
 STORE kod_mat TO uX(1)
 STORE cd TO uX(2)
 STORE cp TO uX(3)
 nR = SQLEXEC(nKonHandle,'EXEC RasCenM ?uX(1), ?uX(2), ?uX(3), ?uX(4)')
 nWaitI = nWaitI + 1
ENDSCAN
*
nWaitI = 1
SELECT table96
STORE RECCOUNT() TO nCount
SCAN
 WAIT ' ŒÃœÀ≈ “”ﬁŸ»≈' + CHR(13) + '¬ÒÂ„Ó ÒÚÓÍ:' + SPACE(3) + ALLTRIM(STR(nCount)) + CHR(13) + 'πÔ/Ô:' + SPACE(3) + ALLTRIM(STR(nWaitI));
 WINDOW NOWAIT
 STORE kod_kom TO uX(1)
 STORE cd TO uX(2)
 STORE cp TO uX(3)
 nR = SQLEXEC(nKonHandle,'EXEC RasCenK ?uX(1), ?uX(2), ?uX(3), ?uX(4)')
 nWaitI = nWaitI + 1
ENDSCAN
*
WAIT 'œ≈–≈–¿—◊®“ ÷≈Õ «¿ ŒÕ◊≈Õ' WINDOW TIMEOUT 2