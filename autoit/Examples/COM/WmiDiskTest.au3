#include <MsgBoxConstants.au3>

; COM Test File
;
; Use WMI to collect logical drive information

Example()
Exit

Func Example()
	Local $oCol = ObjGet("winmgmts:")

	If Not IsObj($oCol) Then
		Return -1
	Else
		Local $oInstance = $oCol.instancesof("Win32_LogicalDisk")

		If @error Then
			MsgBox($MB_SYSTEMMODAL, "", "error getting object. Error code: " & @error)
			Return -2
		EndIf

		Local $s = "driveletter:" & @TAB & @TAB & "size:" & @CRLF

		For $oDrive In $oInstance
			$s &= $oDrive.deviceid & @TAB & @TAB & $oDrive.size & @CRLF
		Next

		MsgBox($MB_SYSTEMMODAL, "Drive test", "Drive information: " & @CRLF & $s)

		; CleanUp
		$oInstance = ''
		$oCol = ''
	EndIf
EndFunc   ;==>Example
