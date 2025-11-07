SELECT TabPw
STORE RECCOUNT() TO nCountPw
SCAN
 STORE RECNO() TO nRecPw
 WAIT 'Обработка маршрута....' + CHR(13) + CHR(13) + 'Всего:'  + SPACE(6) + STR(nCountPw) + CHR(13) + '№п/п:' + SPACE(7) + STR(nRecPw) WINDOW NOWAIT
 STORE z1 TO cPw_z1
 STORE z2 TO cPw_z2
 STORE z3 TO cPw_z3
 STORE z4 TO cPw_z4
 STORE z5 TO cPw_z5
 STORE z6 TO cPw_z6
 STORE z7 TO cPw_z7
 *
 REPLACE z1 WITH IIF( !cPw_z1 = '37' AND !cPw_z1 = '39', cPw_z1,;
 IIF( !cPw_z2 = '00' AND !cPw_z2 = '37' AND !cPw_z2 = '07' AND !cPw_z2 = '15' AND !cPw_z2 = '39', cPw_z2,;
 IIF( !cPw_z3 = '00' AND !cPw_z3 = '37' AND !cPw_z3 = '07' AND !cPw_z3 = '15' AND !cPw_z3 = '39', cPw_z3,;
 IIF( !cPw_z4 = '00' AND !cPw_z4 = '37' AND !cPw_z4 = '07' AND !cPw_z4 = '15' AND !cPw_z4 = '39', cPw_z4,;
 IIF( !cPw_z5 = '00' AND !cPw_z5 = '37' AND !cPw_z5 = '07' AND !cPw_z5 = '15' AND !cPw_z5 = '39', cPw_z5,;
 IIF( !cPw_z6 = '00' AND !cPw_z6 = '37' AND !cPw_z6 = '07' AND !cPw_z6 = '15' AND !cPw_z6 = '39', cPw_z6, cPw_z7 ) ) ) ) ) )
 *
 REPLACE z2 WITH IIF( !cPw_z1 = '37' AND !cPw_z1 = '39', cPw_z2,;
 IIF(!cPw_z3 = '37' AND !cPw_z3 = '07' AND !cPw_z3 = '15' AND !cPw_z3 = '39', cPw_z3,;
 IIF(!cPw_z4 = '37' AND !cPw_z4 = '07' AND !cPw_z4 = '15' AND !cPw_z4 = '39', cPw_z4,;
 IIF(!cPw_z5 = '37' AND !cPw_z5 = '07' AND !cPw_z5 = '15' AND !cPw_z5 = '39', cPw_z5,;
 IIF(!cPw_z6 = '37' AND !cPw_z6 = '07' AND !cPw_z6 = '15' AND !cPw_z6 = '39', cPw_z6, '00' ) ) ) ) )
 *
 REPLACE z3 WITH IIF( !cPw_z1 = '37' AND !cPw_z1 = '39', cPw_z3,;
 IIF(!cPw_z4 = '37' AND !cPw_z4 = '07' AND !cPw_z4 = '15' AND !cPw_z4 = '39', cPw_z4,;
 IIF(!cPw_z5 = '37' AND !cPw_z5 = '07' AND !cPw_z5 = '15' AND !cPw_z5 = '39', cPw_z5,;
 IIF(!cPw_z6 = '37' AND !cPw_z6 = '07' AND !cPw_z6 = '15' AND !cPw_z6 = '39', cPw_z6, '00' ) ) ) )
 *
 REPLACE z4 WITH IIF( !cPw_z1 = '37' AND !cPw_z1 = '39', cPw_z4,;
 IIF(!cPw_z5 = '37' AND !cPw_z5 = '07' AND !cPw_z5 = '15' AND !cPw_z5 = '39', cPw_z5,;
 IIF(!cPw_z6 = '37' AND !cPw_z6 = '07' AND !cPw_z6 = '15' AND !cPw_z6 = '39', cPw_z6, '00' ) ) )
 *
 REPLACE z5 WITH IIF( !cPw_z1 = '37' AND !cPw_z1 = '39', cPw_z5,;
 IIF(!cPw_z6 = '37' AND !cPw_z6 = '07' AND !cPw_z6 = '15' AND !cPw_z6 = '39', cPw_z6, '00' ) )
 *
 REPLACE z6 WITH IIF( !cPw_z1 = '37' AND !cPw_z1 = '39', cPw_z6, '00' )
ENDSCAN