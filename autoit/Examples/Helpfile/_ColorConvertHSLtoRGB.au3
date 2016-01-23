#include <Color.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aiInput[3] = [120, 180, 160], $aiHSL, $aiRGB, $sOutput

	$aiRGB = _ColorConvertHSLtoRGB($aiInput)
	$aiHSL = _ColorConvertRGBtoHSL($aiRGB)

	$sOutput &= StringFormat("| H: %.3f" & @TAB & "| R: %.3f" & @TAB & "| H: %.3f" & @CRLF, $aiInput[0], $aiRGB[0], $aiHSL[0])
	$sOutput &= StringFormat("| S: %.3f" & @TAB & "| G: %.3f" & @TAB & "| S: %.3f" & @CRLF, $aiInput[1], $aiRGB[1], $aiHSL[1])
	$sOutput &= StringFormat("| L: %.3f" & @TAB & "| B: %.3f" & @TAB & "| L: %.3f" & @CRLF, $aiInput[2], $aiRGB[2], $aiHSL[2])
	MsgBox($MB_SYSTEMMODAL, "AutoIt", $sOutput)
EndFunc   ;==>Example
