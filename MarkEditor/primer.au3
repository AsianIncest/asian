$sText = "This is a text line which should be compressed using built-in compression/decompression function. One thing to remember though is that during the development process, make sure that you have the ability to output the compressed string in both binary and ascii form, because while you won't be compressing anything in the ascii form, you'll definitely have an easier time reading it"
ConsoleWrite("Length uncompressed: " & BinaryLen(StringToBinary($sText)) & " bytes" & @CRLF)
$bCompressed = Compress($sText)
ConsoleWrite("Compressed binary string: "& $bCompressed & @CRLF)
ConsoleWrite("Length compressed: " & BinaryLen($bCompressed) & " bytes" & @CRLF)
$sDecompressed = BinaryToString(Decompress($bCompressed))
ConsoleWrite("Decompressed String: " & $sDecompressed & @CRLF & @CRLF)

Func Compress($binString, $iCompressionStrength = 1)
    If Not IsBinary($binString) Then $binString = Binary($binString)
    Local $tCompressed
    Local $tSource = DllStructCreate('byte[' & BinaryLen($binString) & ']')
    DllStructSetData($tSource, 1, $binString)
    _WinAPI_LZNTCompress($tSource, $tCompressed, $iCompressionStrength)
    Local $binCompressed = DllStructGetData($tCompressed, 1)
    $tSource = 0
    Return Binary($binCompressed)
EndFunc   ;==>Compress

Func Decompress($binString)
    If Not IsBinary($binString) Then $binString = Binary($binString)
    Local $tSource = DllStructCreate('byte[' & BinaryLen($binString) & ']')
    DllStructSetData($tSource, 1, $binString)
    Local $tDecompress
    _WinAPI_LZNTDecompress($tSource, $tDecompress)
    $tSource = 0
    Local $bString = Binary(DllStructGetData($tDecompress, 1))
    Return  $bString
EndFunc

Func _WinAPI_LZNTDecompress(ByRef $tInput, ByRef $tOutput, $iBufferSize = 0x800000)
    Local $tBuffer, $Ret
    $tOutput = 0
    $tBuffer = DllStructCreate('byte[' & $iBufferSize & ']')
    If @error Then Return SetError(1, 0, 0)
    $Ret = DllCall('ntdll.dll', 'uint', 'RtlDecompressBuffer', 'ushort', 0x0002, 'ptr', DllStructGetPtr($tBuffer), 'ulong', $iBufferSize, 'ptr', DllStructGetPtr($tInput), 'ulong', DllStructGetSize($tInput), 'ulong*', 0)
    If @error Then Return SetError(2, 0, 0)
    If $Ret[0] Then Return SetError(3, $Ret[0], 0)
    $tOutput = DllStructCreate('byte[' & $Ret[6] & ']')
    If Not _WinAPI_MoveMemory(DllStructGetPtr($tOutput), DllStructGetPtr($tBuffer), $Ret[6]) Then
        $tOutput = 0
        Return SetError(4, 0, 0)
    EndIf
    Return $Ret[6]
EndFunc   ;==>_WinAPI_LZNTDecompress

; #FUNCTION# ====================================================================================================================
; Name...........:  _WinAPI_LZNTCompress
; Description....:  Compresses an input data.
; Syntax.........:  _WinAPI_LZNTCompress ( $tInput, ByRef $tOutput [, $fMaximum] )
; Parameters.....:  $tInput   - "byte[n]" or any other structure that contains the data to be compressed.
;                           $tOutput  - "byte[n]" structure that is created by this function, and contain the compressed data.
;                           $fMaximum - Specifies whether use a maximum data compression, valid values:
;                           |TRUE     - Uses an algorithm which provides maximum data compression but with relatively slower performance.
;                           |FALSE    - Uses an algorithm which provides a balance between data compression and performance. (Default)
; Return values..:  Success   - The size of the compressed data, in bytes.
;                           Failure   - 0 and sets the @error flag to non-zero, @extended flag may contain the NTSTATUS code.
; Author.........:  trancexx
; Modified.......:  Yashied, UEZ
; Remarks........:  The input and output buffers must be different, otherwise, the function fails.
; Related........:
; Link...........:      @@MsdnLink@@ RtlCompressBuffer
; Example........:  Yes
; ===============================================================================================================================
Func _WinAPI_LZNTCompress(ByRef $tInput, ByRef $tOutput, $fMaximum = True)
    Local $tBuffer, $tWorkSpace, $Ret
    Local $COMPRESSION_FORMAT_LZNT1 = 0x0002, $COMPRESSION_ENGINE_MAXIMUM = 0x0100
    If $fMaximum Then $COMPRESSION_FORMAT_LZNT1 = BitOR($COMPRESSION_FORMAT_LZNT1, $COMPRESSION_ENGINE_MAXIMUM)
    $tOutput = 0
    $Ret = DllCall('ntdll.dll', 'uint', 'RtlGetCompressionWorkSpaceSize', 'ushort', $COMPRESSION_FORMAT_LZNT1, 'ulong*', 0, 'ulong*', 0)
    If @error Then Return SetError(1, 0, 0)
    If $Ret[0] Then Return SetError(2, $Ret[0], 0)
    $tWorkSpace = DllStructCreate('byte[' & $Ret[2] & ']')
    $tBuffer = DllStructCreate('byte[' & (2 * DllStructGetSize($tInput)) & ']')
    $Ret = DllCall('ntdll.dll', 'uint', 'RtlCompressBuffer', 'ushort', $COMPRESSION_FORMAT_LZNT1, 'ptr', DllStructGetPtr($tInput), 'ulong', DllStructGetSize($tInput), 'ptr', DllStructGetPtr($tBuffer), 'ulong', DllStructGetSize($tBuffer), 'ulong', 4096, 'ulong*', 0, 'ptr', DllStructGetPtr($tWorkSpace))
    If @error Then Return SetError(3, 0, 0)
    If $Ret[0] Then Return SetError(4, $Ret[0], 0)
    $tOutput = DllStructCreate('byte[' & $Ret[7] & ']')
    If Not _WinAPI_MoveMemory(DllStructGetPtr($tOutput), DllStructGetPtr($tBuffer), $Ret[7]) Then
        $tOutput = 0
        Return SetError(5, 0, 0)
    EndIf
    Return $Ret[7]
EndFunc   ;==>_WinAPI_LZNTCompress

Func _WinAPI_MoveMemory($pDestination, $pSource, $iLenght)
    DllCall('ntdll.dll', 'none', 'RtlMoveMemory', 'ptr', $pDestination, 'ptr', $pSource, 'ulong_ptr', $iLenght)
    If @error Then Return SetError(1, 0, 0)
    Return 1
EndFunc   ;==>_WinAPI_MoveMemory