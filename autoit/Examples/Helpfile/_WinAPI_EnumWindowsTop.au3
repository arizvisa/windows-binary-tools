#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $aWindows, $i, $sText
	$aWindows = _WinAPI_EnumWindowsTop()
	For $i = 1 To $aWindows[0][0]
		$sText = "Window Handle: " & $aWindows[$i][0] & @CRLF
		$sText &= "Window Class: " & $aWindows[$i][1] & @CRLF
		$sText &= "Window Title: " & WinGetTitle($aWindows[$i][0]) & @CRLF
		$sText &= "Window Text: " & WinGetText($aWindows[$i][0]) & @CRLF
		$sText &= "Window Process: " & WinGetProcess($aWindows[$i][0])
		MsgBox($MB_SYSTEMMODAL, "Item " & $i & " of " & $aWindows[0][0], $sText)
	Next
EndFunc   ;==>Example
