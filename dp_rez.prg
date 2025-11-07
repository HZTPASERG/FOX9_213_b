DEFINE PAD pad02 OF MaineMenu PROMPT '\Расчёт'
DEFINE PAD pad04 OF MaineMenu PROMPT '\Готовые изделия'
DEFINE PAD pad01 OF MaineMenu PROMPT '\Справочники цен'
DEFINE PAD pad03 OF MaineMenu PROMPT '\Условно-расчётные цены'
DEFINE PAD pad1 OF MaineMenu PROMPT '\Разное'
DEFINE PAD pad05 OF MaineMenu PROMPT '\Закрыть'
DEFINE PAD pad06 OF MaineMenu PROMPT 'Результат'

ON PAD pad06 OF MaineMenu ACTIVATE POPUP pad06_popup

DEFINE POPUP pad06_popup MARGIN RELATIVE

DEFINE BAR 3 OF pad06_popup PROMPT 'Печать'
DEFINE BAR 4 OF pad06_popup PROMPT 'Сохранить'
DEFINE BAR 2 OF pad06_popup PROMPT '\-'
DEFINE BAR 1 OF pad06_popup PROMPT 'Закрыть'

ON SELECTION BAR 1 OF pad06_popup DO pRClos IN dp_rez
ON SELECTION BAR 4 OF pad06_popup DO pRSave IN dp_rez
ON BAR 3 OF pad06_popup ACTIVATE POPUP pad06_bar3_popup

DEFINE POPUP pad06_bar3_popup MARGIN RELATIVE

DEFINE BAR 1 OF pad06_bar3_popup PROMPT 'Общая'
DEFINE BAR 2 OF pad06_bar3_popup PROMPT 'По цеху'
*!*	DEFINE BAR 3 OF pad06_bar3_popup PROMPT 'Xls-файл'

ON SELECTION BAR 1 OF pad06_bar3_popup DO pRPrint01 IN dp_rez
ON SELECTION BAR 2 OF pad06_bar3_popup DO pRPrint02 IN dp_rez
*!*	ON SELECTION BAR 3 OF pad06_bar3_popup DO pRXls01 IN dp_rez

PROCEDURE pRClos
 oRez.Release

PROCEDURE pRSave
 oRez.pPropF()
 oRez.SelCheck()
 DO prZar.prg
 DO FORM fZar NAME oZar LINKED
 oZar.Form1.Show
 oZar.pSum

PROCEDURE pRPrint01
 STORE 'All' TO oRez.cPrint
 oRez.pPrint()

PROCEDURE pRPrint02
 STORE 'Cex' TO oRez.cPrint
 oRez.pPrint()
 
PROCEDURE pRXls01
FOR nI = 1 TO SELECT(1)
 IF ALIAS(nI) = 'CURPAGEMAT'
  SELECT CURPAGEMAT
  COPY TO '' + SYS(5) + SYS(2003) + '\xls\mat'  TYPE XL5
  cRun = '' + SYS(5) + SYS(2003) + ALLTRIM('\xls\mat.xls')
  RUN /N C:\Program Files\Microsoft Office\Office10\EXCEL.EXE &cRun
 ENDIF
ENDFOR
