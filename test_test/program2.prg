cDse = '803940903019'
*
SELECT i, kod_det, naim_det, kod_mat, naim_mat, cp AS cex, q, norma_na_d, norma_na_i FROM table_osm;
WHERE kod_det = cDse INTO CURSOR CurOsm001
SELECT i, kod_det, naim_det, kod_vsm AS kod_mat, naim_mat, cp AS cex, q, norma_vsm AS norma_na_d, norma_na_i FROM table_vsm;
WHERE kod_det = cDse INTO CURSOR CurVsm001
*
SELECT * FROM CurM01 WHERE EXISTS(SELECT * FROM CurOsm001 WHERE CurOsm001.i = CurM01.i AND;
CurOsm001.kod_det = CurM01.kod_det AND CurOsm001.kod_mat = CurM01.kod_mat AND CurOsm001.cex = CurM01.cex);
INTO CURSOR CurOsm002
SELECT * FROM CurM01 WHERE EXISTS(SELECT * FROM CurVsm001 WHERE CurVsm001.i = CurM01.i AND;
CurVsm001.kod_det = CurM01.kod_det AND CurVsm001.kod_mat = CurM01.kod_mat AND CurVsm001.cex = CurM01.cex);
INTO CURSOR CurVsm002