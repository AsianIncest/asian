#pragma compile(UPX, Flase)
#pragma compile(Compatibility, win7)

#cs
[00:53:05] [Client thread/INFO]: [CHAT] ----- X: 3022 Y: 106 Z: -2103 -----
[00:53:05] [Client thread/INFO]: [CHAT] Name: batterybuffer.16.tier.06  MetaData: 2
[00:53:05] [Client thread/INFO]: [CHAT] Hardness: 1.0  Blast Resistance: 10.0
[00:53:05] [Client thread/INFO]: [CHAT] Progress: 33,554,432 / 11,307,148
[00:53:05] [Client thread/INFO]: [CHAT] Max IN: 32768 EU
[00:53:05] [Client thread/INFO]: [CHAT] Max OUT: 32768 EU at 5 Amperes
[00:53:05] [Client thread/INFO]: [CHAT] Energy: 11,307,148 / 33,554,432EU
[00:53:05] [Client thread/INFO]: [CHAT] Owned by: Asian_In4est
[00:53:05] [Client thread/INFO]: [CHAT] gt.blockmachines.batterybuffer.16.tier.06.name
[00:53:05] [Client thread/INFO]: [CHAT] Stored Items:
[00:53:05] [Client thread/INFO]: [CHAT] 4,042,648,978 EU /
[00:53:05] [Client thread/INFO]: [CHAT] 5,033,554,432 EU
[00:53:05] [Client thread/INFO]: [CHAT] Pollution in Chunk: 0
[00:53:05] [Client thread/INFO]: [CHAT] Meta-ID: 196 valid
[00:53:05] [Client thread/INFO]: [CHAT] This particular TileEntity has caused an average CPU-load of ~0.2ms over the last 25 ticks.
[00:53:05] [Client thread/INFO]: [CHAT] Is accessible for you
[00:53:05] [Client thread/INFO]: [CHAT] Machine is inactive
#ce
#include <Array.au3>
#include <MagicScannerForm.au3>
#include <MsgBoxConstants.au3>
#include <GuiEdit.au3>
#include <Date.au3>
Main()

Func Meter()
   Local $msg
   Local $file = @AppDataDir & '\.redserver\clients\HardTech\logs\latest.Log'
   ; страховочка
   if not FileExists($file) Then
	  $msg = "Ой, всё! Не могу найти файл:" & @lf & $file
	  if @Compiled Then
		 MsgBox($MB_ICONERROR, @ScriptName, $msg)
		 Exit
	  Else
		 ConsoleWrite($msg)
		 Exit
	  EndIf
   EndIf

   $text = FileReadToArray($file)
   if @error  Then
	  $msg = "Ой, всё! Файл не читается, иди в жопу!" & @LF & $file
	  if @Compiled Then
		 MsgBox($MB_ICONERROR, @ScriptName, $msg)
		 Exit
	  Else
		 ConsoleWrite($msg)
		 Exit
	  EndIf
   EndIf

   Local $search = '[Client thread/INFO]: [CHAT] ----- X: ', $c = 0, $cord1="", $cord2=""

   for $i = UBound($text) -1 to 0 Step -1
	  $line = $text[$i]
	  $l = StringInStr($line, $search)
	  if not $l = 0 Then
		 Select
		 Case $c = 0
			$cord2 = $line
			$c=1
			ContinueLoop
		 Case $c = 1
			$cord1 = $line
			ExitLoop
		 EndSelect
	  EndIf
   Next

   if $cord1 = "" Or $cord2 = "" Then
	  Return "----"
   EndIf

   $m1 = StringSplit($cord1, ' ')
   $m2 = StringSplit($cord2, ' ')
   ;_ArrayDisplay($m2)

   $x1 = int($m1[7])
   $y1 = int($m1[11])
   $z1 = int($m1[9])
   $x2 = int($m2[7])
   $y2 = int($m2[11])
   $z2 = int($m2[9])
   ;ConsoleWrite(@lf & $cord1 & @lf & 'x=' & $x2 & ',y=' & $y2 & '!' & @lf)
   #cs
   return String( _
	  round( _
		 sqrt( _
			abs( _
			($x2-$x1)^2 - ($y2-$y1)^2 _
			) _
		 ) _
	  )+1 _
   )
   #ce
   ;_ArrayDisplay($m1)
   Local $z1=1, $z2=1
   return _
      round( _
         sqrt( _
            sqrt( _
              ( abs($x1-$x2)^2 + abs($y1-$y2)^2 )^2 _
               ) _
            + abs($z1-$z2)^2 _
         ) _
      )




EndFunc

Func EU()
   Local $file = @AppDataDir & '\.redserver\clients\HardTech\logs\latest.Log'
   ; страховочка
   if not FileExists($file) Then
	  $msg = "Ой, всё! Не могу найти файл:" & @lf & $file
	  if @Compiled Then
		 MsgBox($MB_ICONERROR, @ScriptName, $msg)
		 Exit
	  Else
		 ConsoleWrite($msg)
		 Exit
	  EndIf
   EndIf

   $text = FileReadToArray($file)
   if @error  Then
	  $msg = "Ой, всё! Файл не читается, иди в жопу!" & @LF & $file
	  if @Compiled Then
		 MsgBox($MB_ICONERROR, @ScriptName, $msg)
		 Exit
	  Else
		 ConsoleWrite($msg)
		 Exit
	  EndIf
   EndIf

   Local $search = '[Client thread/INFO]: [CHAT] gt.blockmachines.batterybuffer', $c = 0, $eu1="", $eu2=""

   for $i = UBound($text) -1 to 0 Step -1
	  $line = $text[$i]
	  $l = StringInStr($line, $search)
	  if not $l = 0 Then
		 Select
		 Case $c = 0
			$eu2 = $text[$i+2]
			$c=1
			ContinueLoop
		 Case $c = 1
			$eu1 = $text[$i+2]
			ExitLoop
		 EndSelect
	  EndIf
   Next

   if $eu1 = "" Or $eu2 = "" Then
	  Return "----"
   EndIf
   ConsoleWrite($eu1 & @lf & $eu2 & @lf)
   ;;_TimeToTicks ( [$iHours = @HOUR [, $iMins = @MIN [, $iSecs = @SEC]]] )

   $r = StringSplit($eu1,']')
   ;_ArrayDisplay($r)
   $time = StringSplit(stringright($r[1], stringlen($r[1])-1), ':')
   $h = $time[1]
   $m = $time[2]
   $s = $time[3]
   $t1 = _TimeToTicks($h, $m, $s)
   $eu1 = StringReplace($r[4], ' EU /', '')
   $eu1 = StringReplace($eu1, ',', '')

   $r = StringSplit($eu2,']')
   ;_ArrayDisplay($r)
   $time = StringSplit(stringright($r[1], stringlen($r[1])-1), ':')
   $h = $time[1]
   $m = $time[2]
   $s = $time[3]
   $t2 = _TimeToTicks($h, $m, $s)
   $eu2 = StringReplace($r[4], ' EU /', '')
   $eu2 = StringReplace($eu2, ',', '')
   $tick = (int($t2) - int($t1))/1000*20
   $energy = round((int($eu2) - int($eu1)) / $tick)
   ConsoleWrite(@lf & 'enrj: ' & $energy & @lf)
   ConsoleWrite("[['eu1', " & $eu1 & "], ['eu2', " & $eu2 & "], ['time1', " & $t1 & "], ['time2', " & $t2 & "]]")
   Return String($energy)
EndFunc

Func Main()
   $tmr = TimerInit()
   While 1
	   $nMsg = GUIGetMsg()
	   Switch $nMsg
		   Case $GUI_EVENT_CLOSE
			   Exit

	   EndSwitch
	   if TimerDiff($tmr) > 1000 Then
		 _GUICtrlEdit_SetText ( $input1, meter() & ' M')
		 _GUICtrlEdit_SetText ( $input2, eu() & ' Eu/t')
		 Replicator()
		 $tmr = TimerInit()
	  EndIf
	WEnd
 EndFunc

 Func Replicator()
	$tit = ' (R: ' & meter() & ' ;EU: ' & eu() & ' Eu\t)'
	WinSetTitle('Minecraft', '', 'Minecraft 1.7.10' & $tit)
EndFunc

