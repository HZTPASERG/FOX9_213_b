DEFINE PAD pad02 OF MaineMenu PROMPT '\Расчёт'
DEFINE PAD pad04 OF MaineMenu PROMPT '\Готовые изделия'
DEFINE PAD pad01 OF MaineMenu PROMPT '\Справочники цен'
DEFINE PAD pad03 OF MaineMenu PROMPT '\Условно-расчётные цены'
DEFINE PAD pad1 OF MaineMenu PROMPT '\Разное'
DEFINE PAD pad05 OF MaineMenu PROMPT '\Закрыть'
DEFINE PAD pad06 OF MaineMenu PROMPT 'Печать'
DEFINE PAD pad07 OF MaineMenu PROMPT '\Накладные расходы'
DEFINE PAD pad08 OF MaineMenu PROMPT '\Расчёт'
*
ON PAD pad06 OF MaineMenu ACTIVATE POPUP pad06_popup
ON SELECTION PAD pad07 OF MaineMenu DO pNakld IN dp_urc
ON SELECTION PAD pad08 OF MaineMenu DO pUpdNakld IN dp_urc

DEFINE POPUP pad06_popup MARGIN RELATIVE

DEFINE BAR 1 OF pad06_popup PROMPT 'По цеху'
DEFINE BAR 2 OF pad06_popup PROMPT 'По изделию'

ON SELECTION BAR 1 OF pad06_popup DO pRep01 IN dp_urc
ON SELECTION BAR 2 OF pad06_popup DO pRep02 IN dp_urc

PROCEDURE pRep01
 DO FORM fRentab NAME oRentab LINKED
 oRentab.cPrint = 'Cex'
 oRentab.cPrint01 = 1

PROCEDURE pRep02
 DO FORM fRentab NAME oRentab LINKED
 oRentab.cPrint = 'Izd'
 oRentab.cPrint01 = 1

PROCEDURE pNakld
 DO FORM fNakld

PROCEDURE pUpdNakld
 nMes = MESSAGEBOX('Начать перерасчёт?', 1 + 32 + 256, 'Условно-расчётные цены')
 IF nMes = 1
  oZar.Form2.Grid1.RecordSource = ''
  oZar.Form2.Grid1.Refresh
  oZar.Form2.TreeView1.Nodes.Clear
  oZar.cTreeTr = ''
  oZar.cTreeDse = ''
  *
  DO ras_urc.prg
  *
  oZar.pSql
  oZar.pGrid
  oZar.pActivate
  oZar.Form2.Show
  oZar.Form2.Grid1.Column2.SetFocus
 ENDIF