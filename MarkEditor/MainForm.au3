#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=c:\users\ganji\documents\markeditor\main.kxf
$Main = GUICreate("MarkEditor @Asian_In4est", 1182, 721, 448, 192)
$MenuItem1 = GUICtrlCreateMenu("Файл")
$mOpen = GUICtrlCreateMenuItem("Открыть", $MenuItem1)
$mSave = GUICtrlCreateMenuItem("Сохранить", $MenuItem1)
GUICtrlSetState(-1, $GUI_DISABLE)
$mClose = GUICtrlCreateMenuItem("Закрыть", $MenuItem1)
GUICtrlSetState(-1, $GUI_DISABLE)
$border = GUICtrlCreateMenuItem("", $MenuItem1)
$mQuit = GUICtrlCreateMenuItem("Выход", $MenuItem1)
$MenuItem7 = GUICtrlCreateMenu("Метки")
$MenuItem6 = GUICtrlCreateMenu("Загрузить из файла", $MenuItem7)
$mLoadVox = GUICtrlCreateMenuItem("voxelMap", $MenuItem6)
$mLoadJour = GUICtrlCreateMenuItem("journeymap", $MenuItem6)
$mSaveJour = GUICtrlCreateMenu("Сохранить в файл", $MenuItem7)
$mSaveVox = GUICtrlCreateMenuItem("voxelMap", $mSaveJour)
$MenuItem2 = GUICtrlCreateMenuItem("journeymap", $mSaveJour)
$MenuItem3 = GUICtrlCreateMenu("Хэш")
$mScanLog = GUICtrlCreateMenuItem("Сканить лог", $MenuItem3)
$mAddHash = GUICtrlCreateMenuItem("Добавить хэш", $MenuItem3)
$mCopyHash = GUICtrlCreateMenuItem("Копировать хэш в буфер", $MenuItem3)
$List1 = GUICtrlCreateList("", 0, 0, 497, 695, BitOR($LBS_STANDARD, $LBS_EXTENDEDSEL))
GUICtrlSetData(-1, "aaaaaaaaa|bbbbbbbbb|ccccccccccc")
$List2 = GUICtrlCreateList("", 682, 1, 497, 695, BitOR($LBS_STANDARD, $LBS_EXTENDEDSEL))
$bLeftOne = GUICtrlCreateButton("<< 1 ТУДА", 520, 32, 147, 89)
$bLeftAll = GUICtrlCreateButton("<<<< ВСЕ ТУДА", 520, 217, 147, 89)
$bRightOne = GUICtrlCreateButton("1 ТУДА >>", 520, 401, 147, 89)
$bRightAll = GUICtrlCreateButton("ВСЕ ТУДА >>>>", 520, 586, 147, 89)
Dim $Main_AccelTable[4][2] = [["^o", $mOpen],["^s", $mSave],["^w", $mClose],["^q", $mQuit]]
GUISetAccelerators($Main_AccelTable)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func Main()
   While 1
	   $nMsg = GUIGetMsg()
	   Switch $nMsg
		   Case $GUI_EVENT_CLOSE
			   Exit

		   Case $mOpen
		   Case $mSave
		   Case $mClose
		   Case $mQuit
			   mQuit_Click()
		   Case $mLoadVox
		   Case $mLoadJour
		   Case $mSaveJour
		   Case $mSaveVox
		   Case $mScanLog
		   Case $mAddHash
		   Case $mCopyHash
		   Case $List1
		   Case $bLeftOne
		   Case $bLeftAll
		   Case $bRightOne
		   Case $bRightAll
	   EndSwitch
	WEnd
 EndFunc



