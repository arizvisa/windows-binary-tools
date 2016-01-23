#include <MsgBoxConstants.au3>

; COM test file
;
; Wscript.Network Example

Example()
Exit

Func Example()
	Local $oNetwork = ObjCreate("WScript.Network")

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Wscript.network Test", "I'm sorry, but creation of object $oNetwork failed. Error code: " & @error)
		Return -1
	EndIf

	Local $oColDrives = $oNetwork.EnumNetworkDrives

	If Not IsObj($oColDrives) Then
		MsgBox($MB_SYSTEMMODAL, "Wscript.network Test", "I'm sorry, but creation of object $oColDrives failed.")
		Return -2
	EndIf

	Local $iNumDrives = $oColDrives.Count

	If $iNumDrives = 0 Then
		MsgBox($MB_SYSTEMMODAL, "wscript.network", "You have currently no network drives")
	Else
		For $i = 0 To $oColDrives.Count - 1 Step 2
			MsgBox($MB_SYSTEMMODAL, "Wscript.network", "Drive letter: " & $oColDrives.Item($i) & @TAB & " is mapped to: " & $oColDrives.Item($i + 1))
		Next
	EndIf

	; CleanUp
	$oColDrives = ''
	$oNetwork = ''

EndFunc   ;==>Example
