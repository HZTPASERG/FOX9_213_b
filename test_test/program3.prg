SELECT * FROM tab_rep001 WHERE EXISTS(;
SELECT * FROM CurM01 WHERE CurM01.kod_det = tab_rep001.kod_det);
ORDER BY cex, kod_det INTO CURSOR CurC00