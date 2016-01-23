#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Ping the AutoIt website with a timeout of 250ms.
	Local $iPing = Ping("autoitscript.com", 250)

	If $iPing Then ; If a value greater than 0 was returned then display the following message.
		MsgBox($MB_SYSTEMMODAL, "", "The roundtrip-time took: " & $iPing & "ms.")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred with @error value of: " & @error)
	EndIf
EndFunc   ;==>Example
