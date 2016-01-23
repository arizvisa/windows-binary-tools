#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $fFloat, $sText, $iInt
	$fFloat = 10.55
	$iInt = _WinAPI_FloatToInt($fFloat)
	$sText = "The float " & $fFloat & " is converted to the Integer " & $iInt & " (Hex = " & Hex($iInt) & ")"
	MsgBox($MB_SYSTEMMODAL, "_WinAPI_FloatToInt Example Results", $sText)
EndFunc   ;==>Example
