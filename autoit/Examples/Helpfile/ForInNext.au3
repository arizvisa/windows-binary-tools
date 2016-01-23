#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Using an Array
	Local $aArray[4]

	$aArray[0] = "a"
	$aArray[1] = 0
	$aArray[2] = 1.3434
	$aArray[3] = "test"

	Local $sString = ""
	For $vElement In $aArray
		$sString = $sString & $vElement & @CRLF
	Next

	MsgBox($MB_SYSTEMMODAL, "", "For..IN Arraytest:" & @CRLF & "Result is: " & @CRLF & $sString)

	; Using an Object Collection

	Local $oShell = ObjCreate("shell.application")
	Local $oShellWindows = $oShell.windows

	If IsObj($oShellWindows) Then
		$sString = ""

		For $Window In $oShellWindows
			$sString = $sString & $Window.LocationName & @CRLF
		Next

		MsgBox($MB_SYSTEMMODAL, "", "You have the following windows open:" & @CRLF & $sString)
	Else

		MsgBox($MB_SYSTEMMODAL, "", "You have no open shell windows.")
	EndIf
EndFunc   ;==>Example
