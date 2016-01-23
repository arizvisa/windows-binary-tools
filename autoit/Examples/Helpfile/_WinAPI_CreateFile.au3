#include <WinAPI.au3>

Local $sTempFile, $hFile, $sText, $nBytes, $tBuffer, $iSize

; 1) create file and write data to it
$sTempFile = @TempDir & '\test.txt'
$sText = 'abcdefghijklmnopqrstuvwxyz'
$tBuffer = DllStructCreate("byte[" & StringLen($sText) & "]")
DllStructSetData($tBuffer, 1, $sText)
$hFile = _WinAPI_CreateFile($sTempFile, 1)
_WinAPI_WriteFile($hFile, $tBuffer, StringLen($sText), $nBytes)
$iSize = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('1):' & $iSize & ' ' & FileRead($sTempFile) & @CRLF)

; 2) read 6 bytes from position 3
$tBuffer = DllStructCreate("byte[6]")
$hFile = _WinAPI_CreateFile($sTempFile, 2, 2)
$iSize = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_ReadFile($hFile, $tBuffer, 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$sText = BinaryToString(DllStructGetData($tBuffer, 1))
ConsoleWrite('2):' & $iSize & ' ' & $sText & @CRLF)

; 3) write previously read 6 bytes from position 3 to the same position but in UpperCase
DllStructSetData($tBuffer, 1, StringUpper($sText))
$hFile = _WinAPI_CreateFile($sTempFile, 2, 4)
$iSize = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_WriteFile($hFile, $tBuffer, 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$tBuffer = 0
ConsoleWrite('3):' & $iSize & ' ' & FileRead($sTempFile) & @CRLF)

; 4) truncate file size to 12 bytes
$hFile = _WinAPI_CreateFile($sTempFile, 2, 4)
_WinAPI_SetFilePointer($hFile, 12)
_WinAPI_SetEndOfFile($hFile)
$iSize = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('4):' & $iSize & ' ' & FileRead($sTempFile) & @CRLF)

FileDelete($sTempFile)
