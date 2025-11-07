DEFINE MENU MaineMenu BAR

DEFINE PAD pad02 OF MaineMenu PROMPT 'Расчёт'
DEFINE PAD pad04 OF MaineMenu PROMPT 'Готовые изделия'
DEFINE PAD pad01 OF MaineMenu PROMPT 'Справочники цен'
DEFINE PAD pad03 OF MaineMenu PROMPT 'Условно-расчётные цены'
DEFINE PAD pad1 OF MaineMenu PROMPT 'Разное'
DEFINE PAD pad05 OF MaineMenu PROMPT 'Закрыть'

ON PAD pad01 OF MaineMenu ACTIVATE POPUP pad01_popup
ON PAD pad04 OF MaineMenu ACTIVATE POPUP pad04_popup
ON PAD pad1 OF MaineMenu ACTIVATE POPUP pad1_popup
ON SELECTION PAD pad02 OF MaineMenu DO pRasch IN definepad
ON SELECTION PAD pad03 OF MaineMenu DO pURC IN definepad
ON SELECTION PAD pad05 OF MaineMenu DO pClose IN definepad

DEFINE POPUP pad01_popup MARGIN RELATIVE
DEFINE POPUP pad04_popup MARGIN RELATIVE
DEFINE POPUP pad1_popup MARGIN RELATIVE

DEFINE BAR 1 OF pad01_popup PROMPT '\Материалы'
DEFINE BAR 2 OF pad01_popup PROMPT '\Комплектующие'
DEFINE BAR 1 OF pad04_popup PROMPT 'Текущий период'
DEFINE BAR 2 OF pad04_popup PROMPT 'Предыдущий период'
DEFINE BAR 5 OF pad04_popup PROMPT '\-'
DEFINE BAR 3 OF pad04_popup PROMPT '\Перерасчёт цен'
DEFINE BAR 4 OF pad04_popup PROMPT '\Сохранить текущий период'
DEFINE BAR 1 OF pad1_popup PROMPT 'Нормы расхода осн. мат. на ДСЕ'
DEFINE BAR 2 OF pad1_popup PROMPT '\-'
DEFINE BAR 3 OF pad1_popup PROMPT 'SQL-обновление'

ON SELECTION BAR 1 OF pad01_popup DO pCenM IN definepad
ON SELECTION BAR 2 OF pad01_popup DO pCenK IN definepad
ON SELECTION BAR 1 OF pad04_popup DO pAllIzd IN definepad
ON SELECTION BAR 2 OF pad04_popup DO pAllIzdG IN definepad
ON SELECTION BAR 3 OF pad04_popup DO pRasCen IN definepad
ON SELECTION BAR 4 OF pad04_popup DO pSaveMK IN definepad
ON SELECTION BAR 1 OF pad1_popup DO FORM fMat
ON SELECTION BAR 3 OF pad1_popup DO pSer IN definepad

ACTIVATE MENU MaineMenu NOWAIT

PROCEDURE pSer
 nMes = MESSAGEBOX('Продолжить?', 4 + 32 + 256, 'SQL-обновление')
 IF nMes = 6
 ADIR(uDBF,'*.dbf')
 *
 PUBLIC uVdbf(ALEN(uDBF,1)), uVcdx(ALEN(uDBF,1))
 *
 FOR nI = 1 TO ALEN(uDBF,1)
  STORE ALLTRIM(STRTRAN(uDBF(nI,1),'.DBF','')) TO cDBF
  IF USED(cDBF)
   uVdbf(nI) = cDBF
   SELECT &cDBF
   uVcdx(nI) = SYS(22)
  ELSE
   uVdbf(nI) = '' 
  ENDIF
 ENDFOR 
 *
 DO ser.prg
 DO p_vsm.prg
 DO nnd.prg
 *
 ADIR(uDBF,'*.dbf')
 FOR nI = 1 TO ALEN(uDBF,1)
  STORE ALLTRIM(STRTRAN(uDBF(nI,1),'.DBF','')) TO cDBF
  IF USED(cDBF)
   SELECT &cDBF
   USE
  ENDIF
 ENDFOR
 FOR nI = 1 TO SELECT(1)
  IF !EMPTY(ALIAS(nI))
   SELECT ALIAS(nI)
   USE
  ENDIF 
 ENDFOR
 *
 FOR nI = 1 TO ALEN(uVdbf)
  IF !EMPTY(uVdbf(nI))
   STORE ALLTRIM(STRTRAN(uVdbf(nI),'.DBF','')) TO cDBF
   IF !USED(cDBF)
    USE &cDBF IN 0
   ENDIF
   IF !EMPTY(uVcdx(nI))
    SELECT &cDBF
    SET ORDER TO TAG &uVcdx(nI)
   ENDIF
  ENDIF 
 ENDFOR
 ENDIF
 
PROCEDURE pCenM
 DO pSelM IN definepad
 SELECT * FROM table95 INTO CURSOR Cur95d
 *
 PUBLIC cX
 cX = 'M'
 DO FORM fCena
 fCena.Form1.Caption = 'ЦЕНЫ - "МАТЕРИАЛЫ"'

PROCEDURE pCenK
 DO pSelK IN definepad
 SELECT * FROM table96 INTO CURSOR Cur96d
 *
 PUBLIC cX
 cX = 'K'
 DO FORM fCena
 fCena.Form1.Caption = 'ЦЕНЫ - "КОМПЛЕКТУЮЩИЕ"'

PROCEDURE pURC
 DO FORM fZar NAME oZar LINKED
 oZar.pSql
 oZar.pGrid
 oZar.pActivate
 oZar.Form2.Show
 oZar.Form2.Grid1.Column2.SetFocus
 DO dp_urc.prg

PROCEDURE pRasch
 DO FORM fZakaz NAME oZakaz LINKED

PROCEDURE pAllIzd
 DO FORM fRez NAME oRez LINKED
 oRez.cRun = 'G'
 oRez.cRunG = 'T'
 oRez.FormRun
 DO dp_rez.prg
 DEFINE BAR 4 OF pad06_popup PROMPT '\Сохранить'

PROCEDURE pAllIzdG
 DO FORM fRez NAME oRez LINKED
 oRez.cRun = 'G'
 oRez.cRunG = 'P'
 oRez.FormRun
 DO dp_rez.prg
 DEFINE BAR 4 OF pad06_popup PROMPT '\Сохранить'

PROCEDURE pRasCen
 nMes = MESSAGEBOX('Начать перерасчёт цен?', 4 + 32 + 256, 'ПЕРЕРАСЧЁТ ЦЕН!')
 IF nMes = 6
  DO pSelM IN definepad
  DO pSelK IN definepad
  *
  DO FORM fTransp NAME oTransp LINKED
  oTransp.cRun = 'G'
 ENDIF

PROCEDURE pSaveMK
 nMes = MESSAGEBOX('Начать сохранение текущего периода?', 4 + 32 + 256, 'СОХРАНЕНИЕ ТЕКУЩЕГО ПЕРИОДА!')
 IF nMes = 6
  CREATE DATABASE data1
  OPEN DATABASE data1
  CREATE CONNECTION Con1;
  DATASOURCE DPO;
  DATABASE DPO
  nKonHandle = SQLCONNECT('Con1')
  SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
  CLOSE DATABASE
  *
  WAIT 'СОХРАНЕНИЕ МАТЕРИАЛОВ' WINDOW NOWAIT
  nR = SQLEXEC(nKonHandle,'EXEC SaveM')
  WAIT 'СОХРАНЕНИЕ КОМПЛЕКТУЮЩИХ' WINDOW NOWAIT
  nR = SQLEXEC(nKonHandle,'EXEC SaveK')
  WAIT 'ГОТОВО' WINDOW TIMEOUT 1
 ENDIF

PROCEDURE pSelM
 CREATE DATABASE data1
 OPEN DATABASE data1
 CREATE CONNECTION Con1;
 DATASOURCE DPO;
 DATABASE DPO
 nKonHandle = SQLCONNECT('Con1')
 SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
 CLOSE DATABASE
 *
 nR = SQLEXEC(nKonHandle,'SELECT kod_mat, naim_mat, marka, gost_marka, sortament, razmer, ed_izm,;
 CAST(cd AS FLOAT) AS cd, CAST(cp AS FLOAT) AS cp FROM table95','Cur95')
 SELECT kod_mat, naim_mat, IIF(marka = '0' OR marka = '%', SPACE(7), marka) AS marka,;
 IIF(gost_marka = '0' OR gost_marka = '%', SPACE(15), gost_marka) AS gost_marka,;
 IIF(sortament = '0' OR sortament = '%', SPACE(10), sortament) AS sortament,;
 IIF(razmer = '0' OR razmer = '%', SPACE(14), razmer) AS razmer, ed_izm, cd, cp FROM Cur95;
 ORDER BY kod_mat INTO TABLE table95

PROCEDURE pSelK
 CREATE DATABASE data1
 OPEN DATABASE data1
 CREATE CONNECTION Con1;
 DATASOURCE DPO;
 DATABASE DPO
 nKonHandle = SQLCONNECT('Con1')
 SQLSETPROP(nKonHandle,'DISPWARNING',.T.)
 CLOSE DATABASE
 *
 nR = SQLEXEC(nKonHandle,'SELECT kod_kom, naim_kom, tip, tex_xar, gost, naim_ei,;
 CAST(cd AS FLOAT) AS cd, CAST(cp AS FLOAT) AS cp FROM table96','Cur96')
 SELECT kod_kom, naim_kom, IIF(tip = '0' OR tip = '%', SPACE(9), tip) AS tip,;
 IIF(tex_xar = '0' OR tex_xar = '%', SPACE(19), tex_xar) AS tex_xar, IIF(gost = '0' OR gost = '%', SPACE(16), gost) AS gost,;
 naim_ei, cd, cp FROM Cur96 ORDER BY kod_kom INTO TABLE table96

PROCEDURE pClose
 CLEAR EVENTS