#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Азиатский инцест

 Script Function:
	Менеджер меток

 Script Version:
    0.1

#ce ----------------------------------------------------------------------------

; ПОЕХАЛИ!

#include <MsgBoxConstants.au3>
#include <MainForm.au3>
Main()

Func mQuit_Click()
   if MsgBox($MB_YESNO, @ScriptName, "Уже уходишь?") = 6 Then
	  if isChanged() Then
		 if MsgBox($MB_YESNO, @ScriptName, "Сохранить изменения в файл?") = 6 Then _
			Save()
	  EndIf
   Else
	  Return
   EndIf
   Exit
EndFunc

Func isChanged()
   Return False
EndFunc

Func Save()
   Return
EndFunc