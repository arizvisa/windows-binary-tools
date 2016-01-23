#include <APISysConstants.au3>
#include <WinAPISys.au3>

; Create compressed and uncompressed buffers
Local $a_pBuffer[2]
For $i = 0 To 1
	$a_pBuffer[$i] = _WinAPI_CreateBuffer(1024)
Next

; Compress binary data
Local $dData = Binary('0x00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF00112233445566778899AABBCCDDEEFF')
Local $iSize = BinaryLen($dData)
DllStructSetData(DllStructCreate('byte[' & $iSize & ']', $a_pBuffer[0]), 1, $dData)
$iSize = _WinAPI_CompressBuffer($a_pBuffer[0], $iSize, $a_pBuffer[1], 1024, BitOR($COMPRESSION_FORMAT_LZNT1, $COMPRESSION_ENGINE_MAXIMUM))
If Not @error Then
	ConsoleWrite('Compressed:   ' & DllStructGetData(DllStructCreate('byte[' & $iSize & ']', $a_pBuffer[1]), 1) & @CRLF)
EndIf

; Decompress data
$iSize = _WinAPI_DecompressBuffer($a_pBuffer[0], 1024, $a_pBuffer[1], $iSize)
If Not @error Then
	ConsoleWrite('Uncompressed: ' & DllStructGetData(DllStructCreate('byte[' & $iSize & ']', $a_pBuffer[0]), 1) & @CRLF)
EndIf

; Free memory
For $i = 0 To 1
	_WinAPI_FreeMemory($a_pBuffer[$i])
Next
