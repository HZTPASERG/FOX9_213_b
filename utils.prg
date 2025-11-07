* ****************************************************************************************
* Подпрограмма: ErrorHandler
* Описание: процедура опрацювання помилок користувача
* Создание:  08.11.2007, С.М. Антонюк
* Изменение: 08.11.2007, С.М. Антонюк
* ****************************************************************************************
FUNCTION ErrorHandler(nError,cMethod,nLine)
* ****************************************************************************************
*nError - номер помилки
*cMethod - ім`я програми в якій виникла помилка
*nLine - номер стрічки програми
* ****************************************************************************************
	LOCAL lcErrorMsg, lcCodeLineMsg
	PRIVATE m.ptErrorTime
	WAIT CLEAR
	lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)
	lcErrorMsg=lcErrorMsg+"Метод:    "+cMethod
	lcCodeLineMsg=MESSAGE(1)
	m.ptErrorTime = DATETIME()
*!*		SaveLogError(nError, MESSAGE(), cMethod, nLine, lcCodeLineMsg)
	IF BETWEEN(nLine,1,10000) AND NOT lcCodeLineMsg="..."
		lcErrorMsg=lcErrorMsg+CHR(13)+"Стрічка №:         "+ALLTRIM(STR(nLine))
		IF NOT EMPTY(lcCodeLineMsg)
			lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
		ENDIF
	ENDIF
	IF MESSAGEBOX(lcErrorMsg,17,_screen.Caption)#1
		ON ERROR
		RETURN .F.
	ENDIF
ENDFUNC
* ****************************************************************************************
* Подпрограмма: LenTextAA
* Описание: Вирівнює стрічку до вказаної кількості знаків
* Создание:  04.02.2008, C.М. Антонюк
* Изменение: 04.02.2008, C.М. Антонюк
* ****************************************************************************************
PROCEDURE LenTextAA
	LPARAMETER cText00, nLen
* ****************************************************************************************
* cText00 - стрічка
* nLen - необхідна довжина стрічки
* ****************************************************************************************
	STORE IIF( LEN(ALLTRIM(cText00)) < nLen, ALLTRIM(cText00) + SPACE(nLen - LEN(ALLTRIM(cText00))), LEFT(ALLTRIM(cText00), nLen) ) TO cText01
	RETURN cText01
 ENDFUNC
 
 * ****************************************************************************************
* Подпрограмма: ToXls
* Описание:  Формування XLS-файла
* Создание:  23.06.2008, C.М. Антонюк
* Изменение: 23.06.2008, C.М. Антонюк
* ****************************************************************************************
PROCEDURE ToXls
	LPARAMETERS m.tcTable, m.tcFile
* ****************************************************************************************
* m.tcTable - назва таблиці, на основі якої формується XLS-файл
*m.tcFile - повний шлях до XLS-файла
* ****************************************************************************************
  SELECT (m.tcTable)
  COPY TO '' + m.tcFile  TYPE XLS
  cRun = '' + m.tcFile
 LOCAL loError AS Exception
 TRY
	 ox=CreateObject("Excel.application")
 CATCH TO loError
 ENDTRY
 
 IF VARTYPE(loError) <> "O"
	 ox.workbooks.add(cRun)
	 ox.Visible=.T.
 ELSE
	IF OOoIsInstalled()  && Проверка установлен ли пакет OpenOffice.org  
		oDoc = OOoOpenFile(  cRun)
	ELSE
		MESSAGEBOX('Пакет OpenOffice.org не установлен на данном компьютере!',48,'Измените настройки программы')
	ENDIF
 ENDIF
ENDPROC