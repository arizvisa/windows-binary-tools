#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $iWord = 11 * 65535
	MsgBox($MB_SYSTEMMODAL, $iWord, "HiWord: " & _WinAPI_HiWord($iWord) & @CRLF & "LoWord: " & _WinAPI_LoWord($iWord))
EndFunc   ;==>Example
