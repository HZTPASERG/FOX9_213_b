SELECT SPACE(12) AS i, oi AS io FROM str213 GROUP BY oi;
ORDER BY oi INTO TABLE tab_io
SCAN
 DO CASE
 CASE !ATC('ар', io) = 0
  REPLACE i WITH STRTRAN(io, 'ар', '02')
 CASE !ATC('бо', io) = 0
  REPLACE i WITH STRTRAN(io, 'бо', '03')
 CASE !ATC('юф', io) = 0
  REPLACE i WITH STRTRAN(io, 'юф', '07')
 CASE !ATC('ба', io) = 0
  REPLACE i WITH STRTRAN(io, 'ба', '08')
 CASE !ATC('сл', io) = 0
  REPLACE i WITH STRTRAN(io, 'сл', '09')
 CASE !ATC('рб', io) = 0
  IF ATC('рб', io) = 2
   REPLACE i WITH STRTRAN(io, 'рб', '13')
  ELSE
   IF ATC('рб', io) = 1
    REPLACE i WITH ALLTRIM(SUBSTR(io,3,1)) + 'рб' + ALLTRIM(SUBSTR(io,4,9))
   ENDIF
  ENDIF
 CASE !ATC('йю', io) = 0
   REPLACE i WITH STRTRAN(io, 'йю', '14')
 CASE !ATC('ян', io) = 0
   REPLACE i WITH STRTRAN(io, 'ян', '19')
 CASE !ATC('рд', io) = 0
   REPLACE i WITH STRTRAN(io, 'рд', '40')
 CASE !ATC('бы', io) = 0
   REPLACE i WITH STRTRAN(io, 'бы', '40')
 CASE !ATC('бцех', io) = 0
   REPLACE i WITH SUBSTR(io, 5) + STRTRAN(SPACE(12-IIF(LEN(ALLTRIM(SUBSTR(io, 5)))<=12,LEN(ALLTRIM(SUBSTR(io, 5))),0) ),' ','0')
 CASE !ATC('бехж', io) = 0
   REPLACE i WITH SUBSTR(io, 5) + STRTRAN(SPACE(12-IIF(LEN(ALLTRIM(SUBSTR(io, 5)))<=12,LEN(ALLTRIM(SUBSTR(io, 5))),0) ),' ','0')
 CASE !ATC('хад', io) = 0
   REPLACE i WITH SUBSTR(io, 4) + STRTRAN(SPACE(12-IIF(LEN(ALLTRIM(SUBSTR(io, 4)))<=12,LEN(ALLTRIM(SUBSTR(io, 4))),0) ),' ','0')
 CASE !ATC('хаьд', io) = 0
   REPLACE i WITH SUBSTR(io, 5) + STRTRAN(SPACE(12-IIF(LEN(ALLTRIM(SUBSTR(io, 5)))<=12,LEN(ALLTRIM(SUBSTR(io, 5))),0) ),' ','0')
 CASE !ATC('хб', io) = 0
   REPLACE i WITH SUBSTR(io, 3) + STRTRAN(SPACE(12-IIF(LEN(ALLTRIM(SUBSTR(io, 3)))<=12,LEN(ALLTRIM(SUBSTR(io, 3))),0) ),' ','0')
 CASE !ATC('хмач', io) = 0
   REPLACE i WITH SUBSTR(io, 5) + STRTRAN(SPACE(12-IIF(LEN(ALLTRIM(SUBSTR(io, 5)))<=12,LEN(ALLTRIM(SUBSTR(io, 5))),0) ),' ','0')
 ENDCASE
ENDSCAN
*
SELECT tab_io.i, oi, ni, km, n, e, sn, nm, zd, zp, to, tz, ze, s_d, s_p FROM str213, tab_io;
WHERE str213.oi = tab_io.io ORDER BY tab_io.i INTO CURSOR CurTemp
*
SELECT * FROM CurTemp ORDER BY i INTO TABLE str213