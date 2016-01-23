#include <MsgBoxConstants.au3>

; COM Test file
;
; Counting the number of open shell windows

Local $oShell = ObjCreate("shell.application") ; Get the Windows Shell Object
Local $oShellWindows = $oShell.windows ; Get the collection of open shell Windows

If IsObj($oShellWindows) Then

	; String for displaying purposes
	Local $s = ""

	; Count all existing shell windows
	For $oWindow In $oShellWindows
		$s &= $oWindow.LocationName & @CRLF
	Next

	MsgBox($MB_SYSTEMMODAL, "Shell Windows", "You have the following shell windows:" & @CRLF & @CRLF & $s);

EndIf
