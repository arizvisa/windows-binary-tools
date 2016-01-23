#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Local $sStr1 = "Tiësto"
Local $sStr2 = "TIËSTO"

; Compare two strings without using case sensitivity.
Local $iCmp = StringCompare($sStr1, $sStr2)
MsgBox($MB_SYSTEMMODAL, "", _
		"Comparing '" & $sStr1 & "' To '" & $sStr2 & "'" & @CRLF & _
		"StringCompare Result (mode $STR_NOCASESENSE): " & $iCmp)

; Compare two strings with using case sensitivity.
$iCmp = StringCompare($sStr1, $sStr2, $STR_CASESENSE)
MsgBox($MB_SYSTEMMODAL, "", _
		"Comparing '" & $sStr1 & "' To '" & $sStr2 & "'" & @CRLF & _
		"StringCompare Result (mode $STR_CASESENSE): " & $iCmp)

; Compare two strings without using case sensitivity.
$iCmp = StringCompare($sStr1, $sStr2, $STR_NOCASESENSEBASIC)
MsgBox($MB_SYSTEMMODAL, "", _
		"Comparing '" & $sStr1 & "' To '" & $sStr2 & "'" & @CRLF & _
		"StringCompare Result (mode $STR_NOCASESENSEBASIC): " & $iCmp)
