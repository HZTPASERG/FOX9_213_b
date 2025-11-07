WAIT '“– - –¿—◊®“ ¬—œŒÃ¿√¿“≈À‹Õ€’ Ã¿“–≈»¿ÀŒ¬' WINDOW NOWAIT
*
SET DECIMAL TO 8
SELECT trTable61050pl.tr, trTable61050pl.i AS izd, Trtable11052.izd AS kod_det, kod_mat, kod_gr_mat, naim_mat, sortament, marka,;
gost_sort, gost_marka, razmer AS razm, kod_izm AS ei, ed_izm AS naim_ei, cena, cp AS ci, (q * norma_na_d) AS norm_izd;
FROM trTable61050pl, Trtable11052 WHERE trTable61050pl.tr = Trtable11052.tr AND trTable61050pl.i = Trtable11052.izd;
ORDER BY trTable61050pl.tr, trTable61050pl.i, Trtable11052.kod_mat INTO CURSOR CurVsm0
*
SELECT CurVsm0.tr, CurVsm0.izd, kod_det, io, inn, kod_mat, kod_gr_mat, naim_mat, sortament, marka,;
gost_sort, gost_marka, razm, ei, naim_ei, cena, ci, norm_izd FROM CurVsm0 LEFT JOIN Trtable10857;
ON CurVsm0.tr = Trtable10857.tr AND CurVsm0.izd = Trtable10857.izd AND CurVsm0.kod_det = Trtable10857.i;
ORDER BY CurVsm0.tr, CurVsm0.izd, CurVsm0.kod_det, CurVsm0.kod_mat INTO CURSOR CurVsm1
*
SELECT tr, izd AS i, kod_det, inn AS naim_det, kod_mat AS kod_vsm, naim_mat, sortament, marka, ci AS cp,;
razm, naim_ei AS ed_izm, SUM(norm_izd) AS norma_na_i FROM CurVsm1 GROUP BY tr, izd, kod_det, kod_mat, ci;
ORDER BY tr, izd, kod_det, kod_mat INTO TABLE trTable_vsm