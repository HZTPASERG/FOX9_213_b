*ÎÑÍÎÂÍÛÅ ÌÀÒÅÐÈÀËÛ * ÂÑÏÎÌÀÃÀÒÅËÜÍÛÅ ÌÀÒÅÐÈÀËÛ
SELECT i, kod_det, naim_det, kod_mat, naim_mat, cp AS cex, q, norma_na_d, norma_na_i FROM table_osm;
UNION ALL;
SELECT i, kod_det, naim_det, kod_vsm AS kod_mat, naim_mat, cp AS cex, q, norma_vsm AS norma_na_d, norma_na_i FROM table_vsm;
INTO CURSOR CurM00
*
SELECT i, kod_det, naim_det, kod_mat, naim_mat, cex, q, norma_na_d, norma_na_i FROM CurM00;
ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM001
*
SELECT kod_izd AS i, kod_det, naimdet AS naim_det, kod_mat, naim_mat, ci AS cex, q, norma_rm AS norma_na_d, norm_ras_i AS norma_na_i FROM t105res;
INTO CURSOR CurM01
*
SELECT i, kod_det, naim_det, kod_mat, naim_mat, cex, SUM(q) AS q, ROUND(norma_na_d, 8) AS norma_na_d,;
ROUND(SUM(norma_na_i), 8) AS norma_na_i FROM CurM01;
GROUP BY i, kod_det, kod_mat, cex ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM011
*
*ÑÒÐÎÊÈ ÈÇ ÌÀÑÈÂÀ TABLE_OSM/TABLE_VSM
SELECT * FROM CurM001 WHERE !EXISTS(;
SELECT * FROM CurM011 WHERE CurM011.i = CurM001.i AND CurM011.kod_det = CurM001.kod_det AND;
CurM011.kod_mat = CurM001.kod_mat AND CurM011.cex = CurM001.cex) ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM002
SELECT * FROM CurM002 INTO TABLE tab_rep001
REPORT FORM rep_001 TO PRINT PREVIEW NOCONSOLE
*
SELECT * FROM CurM001 WHERE !EXISTS(;
SELECT * FROM CurM002 WHERE CurM002.i = CurM001.i AND CurM002.kod_det = CurM001.kod_det AND;
CurM002.kod_mat = CurM001.kod_mat AND CurM002.cex = CurM001.cex) ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM003
*
SELECT * FROM CurM003 WHERE !EXISTS(;
SELECT * FROM CurM011 WHERE CurM011.i = CurM003.i AND CurM011.kod_det = CurM003.kod_det AND;
CurM011.kod_mat = CurM003.kod_mat AND CurM011.cex = CurM003.cex AND CurM011.norma_na_i = CurM003.norma_na_i);
ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM004
*
SELECT CurM004.*, CurM011.q AS q_, CurM011.norma_na_d AS norma_na_d_, CurM011.norma_na_i AS norma_na_i_ FROM CurM004, CurM011;
WHERE CurM004.i = CurM011.i AND CurM004.kod_det = CurM011.kod_det AND CurM004.kod_mat = CurM011.kod_mat AND CurM004.cex = CurM011.cex;
ORDER BY CurM004.kod_det, CurM004.kod_mat, CurM004.cex INTO CURSOR CurM005
*
SELECT * FROM CurM005 WHERE ABS(norma_na_i - norma_na_i_) >= 0.01 ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM006
SELECT * FROM CurM006 INTO TABLE tab_rep002
REPORT FORM rep_002 TO PRINT PREVIEW NOCONSOLE
*
*ÑÒÐÎÊÈ ÈÇ ÌÀÑÈÂÀ T105RES
SELECT * FROM CurM011 WHERE !EXISTS(;
SELECT * FROM CurM001 WHERE CurM001.i = CurM011.i AND CurM001.kod_det = CurM011.kod_det AND;
CurM001.kod_mat = CurM011.kod_mat AND CurM001.cex = CurM011.cex) ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM012
SELECT * FROM CurM012 INTO TABLE tab_rep011
*
SELECT * FROM CurM011 WHERE !EXISTS(;
SELECT * FROM CurM012 WHERE CurM012.i = CurM011.i AND CurM012.kod_det = CurM011.kod_det AND;
CurM012.kod_mat = CurM011.kod_mat AND CurM012.cex = CurM011.cex) ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM013
*
SELECT * FROM CurM013 WHERE !EXISTS(;
SELECT * FROM CurM001 WHERE CurM001.i = CurM013.i AND CurM001.kod_det = CurM013.kod_det AND;
CurM001.kod_mat = CurM013.kod_mat AND CurM001.cex = CurM013.cex AND CurM001.norma_na_i = CurM013.norma_na_i);
ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM014
*
SELECT CurM014.*, CurM001.q AS q_, CurM001.norma_na_d AS norma_na_d_, CurM001.norma_na_i AS norma_na_i_ FROM CurM014, CurM001;
WHERE CurM014.i = CurM001.i AND CurM014.kod_det = CurM001.kod_det AND CurM014.kod_mat = CurM001.kod_mat AND CurM014.cex = CurM001.cex;
ORDER BY CurM014.kod_det, CurM014.kod_mat, CurM014.cex INTO CURSOR CurM015
*
SELECT * FROM CurM015 WHERE ABS(norma_na_i - norma_na_i_) >= 0.01 ORDER BY kod_det, kod_mat, cex INTO CURSOR CurM016
SELECT * FROM CurM016 INTO TABLE tab_rep012
*
DO Program2.prg
DO Program3.prg