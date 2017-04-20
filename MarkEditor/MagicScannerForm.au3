#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("MagicScanner", 599, 441, 239, 160)
$Group1 = GUICtrlCreateGroup("Рулетка", 8, 8, 585, 193)
$Label1 = GUICtrlCreateLabel("Щелкни сканером в 1 точке, потом в 2", 112, 24, 346, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x3399FF)
$Input1 = GUICtrlCreateInput("Input1", 160, 80, 257, 37)
GUICtrlSetFont(-1, 18, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Вольтметр", 8, 208, 585, 225)
$Label3 = GUICtrlCreateLabel("Щелкни по буферу 2 раза, с промежутком в неск. сек", 64, 240, 479, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x3399FF)
$Input2 = GUICtrlCreateInput("Input1", 163, 299, 257, 37)
GUICtrlSetFont(-1, 18, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

