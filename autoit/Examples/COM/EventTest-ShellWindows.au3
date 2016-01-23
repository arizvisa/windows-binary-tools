#include <MsgBoxConstants.au3>

; COM Test file
;
; Test receiving Events from an open shell window
;
; See also:
; http://msdn.microsoft.com/library/en-us/shellcc/platform/shell/programmersguide/shell_basics/shell_basics_programming/objectmap.asp

Local $sWindowName = "COM" ;  Change this to an existing Window title

Global $g_nComError = 0, $g_oMyError = ObjEvent("AutoIt.Error", "MyErrFunc") ; Catch any COM Errors

Local $oShell = ObjCreate("shell.application")

; See also: http://msdn.microsoft.com/library/en-us/shellcc/platform/shell/reference/objects/shellwindows/shellwindows.asp
Local $oShellWindows = $oShell.windows ; Get the collection of open shell Windows

If IsObj($oShellWindows) Then

	Local $sString = ""
	Local $vMyWindow = ""

	; Search in all windows for a window with the given name
	For $oWindow In $oShellWindows
		If $oWindow.LocationName = $sWindowName Then $vMyWindow = $oWindow ; Found a window
	Next

	If IsObj($vMyWindow) Then
		; MyWindow is an Internet Explorer Object !
		;
		; See also:
		; http://msdn.microsoft.com/workshop/browser/webbrowser/reference/objects/internetexplorer.asp

		; Now we try to hook up our Event handler to this window

		Local $oMyEvent = ObjEvent($vMyWindow, "MyEvent_")

		If @error Then ; Failed to initialize event handler

			MsgBox($MB_SYSTEMMODAL, "COM Test", "Error trying to hook Eventhandler on Window. Error number: " & Hex(@error, 8))
			$vMyWindow = ""
			$oShellWindows = ""
			Exit

		EndIf
		MsgBox($MB_SYSTEMMODAL, "COM Test", "Successfully received Events from a shell Window !");
	EndIf

Else

	MsgBox($MB_SYSTEMMODAL, "", "you have no open shell window with the name " & $sWindowName)

EndIf

Exit

; -------------------
; Shell Window Events
; -------------------

Func MyEvent_aa() ; Dummy
EndFunc   ;==>MyEvent_aa

; ----------------

Func MyErrFunc()
	Local $sHexNumber = Hex($g_oMyError.number, 8)

	MsgBox($MB_SYSTEMMODAL, "", "We intercepted a COM Error !" & @CRLF & @CRLF & _
			"err.description is: " & @TAB & $g_oMyError.description & @CRLF & _
			"err.windescription:" & @TAB & $g_oMyError.windescription & @CRLF & _
			"err.number is: " & @TAB & $sHexNumber & @CRLF & _
			"err.lastdllerror is: " & @TAB & $g_oMyError.lastdllerror & @CRLF & _
			"err.scriptline is: " & @TAB & $g_oMyError.scriptline & @CRLF & _
			"err.source is: " & @TAB & $g_oMyError.source & @CRLF & _
			"err.helpfile is: " & @TAB & $g_oMyError.helpfile & @CRLF & _
			"err.helpcontext is: " & @TAB & $g_oMyError.helpcontext _
			)

	$g_nComError = $g_oMyError.number ; to check for after this function returns
EndFunc   ;==>MyErrFunc
