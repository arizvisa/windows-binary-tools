#include <MsgBoxConstants.au3>

; COM Test File
;
; Shows processor information

Example()

Func Example()
	Local $sMyCompName = @ComputerName

	Local $oWMIservice = ObjGet("winmgmts:\\" & $sMyCompName & "\root\cimv2")

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "error getting object. Error code: " & @error)
		Return -1
	EndIf

	Local $oColProcessors = $oWMIservice.ExecQuery("Select * from Win32_Processor")

	If IsObj($oColProcessors) Then
		Local $iCounter = 1

		For $oProcessor In $oColProcessors
			MsgBox($MB_SYSTEMMODAL, "WMI Test", "Processor " & $iCounter & @CRLF & "Id: " & $oProcessor.processorid & @CRLF & _
					"Maximum Clock Speed: " & $oProcessor.MaxClockSpeed)
			$iCounter += 1
		Next

		; CleanUp
		$oColProcessors = ''
	EndIf

	; CleanUp
	$oWMIservice = ''

EndFunc   ;==>Example
