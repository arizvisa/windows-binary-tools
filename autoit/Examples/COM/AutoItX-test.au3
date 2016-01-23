#include <MsgBoxConstants.au3>

; COM Test file
;
; Test usage of AutoItX from within AutoItCOM

Example("I am copied to the clipboard")
Exit

Func Example($sExampleText)

	Local $oAutoIt = ObjCreate("AutoItX3.Control")
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "AutoItX Test", "Failed to open AutoItX. Error code: " & Hex(@error, 8))
		Return -1
	EndIf

	$oAutoIt.ClipPut($sExampleText)

	Local $sTextFromClipboard = $oAutoIt.ClipGet()
	Local $sTestInfo = "Clipboard contains: " & $sTextFromClipboard & @CRLF & @CRLF & "Press OK to create a tooltip in the upper left corner."

	MsgBox($MB_SYSTEMMODAL, "Clipboard test", $sTestInfo)

	; This will create a tooltip in the upper left of the screen
	$oAutoIt.ToolTip("This is a tooltip", 0, 0)

	; Sleep to give tooltip time to display
	$oAutoIt.Sleep(1000)

	MsgBox($MB_SYSTEMMODAL, "End of Test", "OK")

	; CleanUp - relase memory
	$oAutoIt = ''

EndFunc   ;==>Example
