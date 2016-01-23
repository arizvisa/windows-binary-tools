#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $aCursor, $sText
	$aCursor = _WinAPI_GetCursorInfo()
	$sText = "Was the operation sucessful? " & $aCursor[0] & @CRLF
	$sText &= "Is the cursor showing? " & $aCursor[1] & @CRLF & @CRLF
	$sText &= "Cursor Handle: " & $aCursor[2] & @CRLF
	$sText &= "X Coordinate: " & $aCursor[3] & @CRLF
	$sText &= "Y Coordinate: " & $aCursor[4]
	MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetCursorInfo Example", $sText)
EndFunc   ;==>Example
