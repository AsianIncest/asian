#include <Array.au3>
#include <File.au3>
;Example starts here
#include "JSON.au3"
#include "JSON_Translate.au3"


;;$aReturn = _JSON_Decode($sText)
MsgBox($MB_ICONINFORMATION, @ScriptName, "Скрипт переноса меток на voxelmap, (c) Asian")

$sJpath = EnvGet("appdata") & '\.redserver\clients\HardTech\journeymap\data\mp\~HardTech\waypoints'
$x = InputBox(@ScriptName, "Читаем отсюда?", $sJpath)
if Not $x Then Exit
$sVpath = EnvGet("appdata") & '\.redserver\clients\HardTech\mods\VoxelMods\voxelMap'

Global $Folder = $sJpath
Global $Mask = "*.json"
Global $Files = _FileListToArrayRec($Folder, $Mask, 1, 1, 0, 2)
If @error Then Exit

;;$vox = FileOpen($sVpath & '\s4.red-server.ru~colon~16000.points')
$res = ""
For $i=1 To UBound($Files) -1
   $h = FileOpen($Files[$i])
   $r = FileRead($h)
   FileClose($h)
   $j = _JSONDecode($r,'JSON_unpack')
   $sName = $j[2][1]
   $sX = $j[4][1]
   $sY = $j[5][1]
   $sZ = $j[6][1]
   $templ = 'name:%n,x:%x,z:%z,y:%y,enabled:true,red:0.0,green:1.0,blue:0.0,suffix:,world:,dimensions:0#'
   $l = StringReplace($templ, '%n', $j[2][1])
   $l = StringReplace($l, '%x', $j[4][1])
   $l = StringReplace($l, '%y', $j[5][1])
   $l = StringReplace($l, '%z', $j[6][1])
   $res = $res & $l & @CRLF
   ;;_ArrayDisplay($j,'test')

Next

$x = InputBox(@ScriptName, "Верный путь?", $sVpath & '\s4.red-server.ru~colon~16000.points')
if $x Then
   FileWrite($x, $res)
   MsgBox(0, @ScriptName, "Готово!")
EndIf