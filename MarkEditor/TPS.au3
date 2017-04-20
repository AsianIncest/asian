#cs
[22:17:16] [Client thread/INFO]: [CHAT] 2 secs
[22:17:16] [Client thread/INFO]: [CHAT] 450 secs

[22:23:56] [Client thread/INFO]: [CHAT] 400 secs
[22:23:56] [Client thread/INFO]: [CHAT] 450 secs


[22:44:01] [Client thread/INFO]: [CHAT] ----- X: 3063 Y: 71 Z: -2205 -----
[22:44:01] [Client thread/INFO]: [CHAT] Name: tile.leaves  MetaData: 1
[22:44:01] [Client thread/INFO]: [CHAT] Hardness: 0.2  Blast Resistance: 0.2
[22:44:01] [Client thread/INFO]: [CHAT] Pollution in Chunk: 0
[22:44:06] [Client thread/INFO]: [CHAT] Телепортирование...
[22:44:23] [Client thread/INFO]: [CHAT] ----- X: 60 Y: 72 Z: -420 -----



#include <Date.au3>

local $r, $h, $m, $s
$r = (_TimeToTicks(22, 23, 56) - _TimeToTicks(22,17,16))/1000
msgbox(0,'',$r)
_TicksToTime($r, $h, $m, $s)
MsgBox($MB_SYSTEMMODAL, '', 'New Time:' & $h & ":" & $m & ":" & $s)
#ce

local $x1 = 3063, $x2 = 60
local $y1 = -2205, $y2 = -420

ConsoleWrite(Sqrt(($x2-$x1)^2 - ($y2-$y1)^2) & @LF)