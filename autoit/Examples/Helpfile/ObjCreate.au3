#include <MsgBoxConstants.au3>

; Counting the number of open shell windows

Local $oShell = ObjCreate("shell.application") ; Get the Windows Shell Object
Local $oShellWindows = $oShell.Windows() ; Get the collection of open shell Windows

If IsObj($oShellWindows) Then
	Local $sString = "" ; String for displaying purposes

	For $oWnd In $oShellWindows ; Count all existing shell windows
		$sString &= $oWnd.LocationName & @CRLF
	Next

	MsgBox($MB_SYSTEMMODAL, "", "Shell Windows:" & @CRLF & "You have the following shell windows:" & @CRLF & @CRLF & $sString)
EndIf
