#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Error monitoring. This will trap all COM errors while alive.
	; This particular object is declared as local, meaning after the function returns it will not exist.
	Local $oErrorHandler = ObjEvent("AutoIt.Error", "_ErrFunc")

	; Create Internet Explorer object
	Local $oIE = ObjCreate("InternetExplorer.Application")
	; Check for errors
	If @error Then Return

	$oIE.Visible = True ; set visibility

	; Custom sink object
	Local $oIEEvents = ObjEvent($oIE, "_IEEvent_", "DWebBrowserEvents2")

	; Navigate somewhere
	$oIE.navigate("http://www.google.com/")
	; Check for errors while loading
	If @error Then
		$oIE.Quit()
		Return
	EndIf

	; Wait for page to load
	While 1
		If $oIE.readyState = "complete" Or $oIE.readyState = 4 Then ExitLoop
		Sleep(10)
	WEnd

	; Deliberately cause error by calling non-existing method
	$oIE.PlayMeARockAndRollSong()

	; Check for errors
	If @error Then MsgBox($MB_SYSTEMMODAL, "COM Error", "@error is set to COM error number." & @CRLF & "@error = 0x" & Hex(@error))

	; Wait few seconds to see if more events will be fired
	Sleep(3000)

	; Nothing more to do. Close IE and return from the function
	$oIE.Quit()

	#forceref $oErrorHandler, $oIEEvents
EndFunc   ;==>Example

; BeforeNavigate2 method definition
Func _IEEvent_BeforeNavigate2($oIEpDisp, $sIEURL, $iIEFlags, $sIETargetFrameName, $sIEPostData, $iIEHeaders, $bIECancel)
	ConsoleWrite("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--BeforeNavigate2 fired--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! " & @CRLF & _
			"$oIEpDisp = " & $oIEpDisp() & "  -  " & ObjName($oIEpDisp) & @CRLF & _ ; e.g. default property and name for the object
			"$sIEURL = " & $sIEURL & @CRLF & _
			"$iIEFlags = " & $iIEFlags & @CRLF & _
			"$sIETargetFrameName = " & $sIETargetFrameName & @CRLF & _
			"$sIEPostData = " & $sIEPostData & @CRLF & _
			"$iIEHeaders = " & $iIEHeaders & @CRLF & _
			"$bIECancel = " & $bIECancel & @CRLF & _
			"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! " & @CRLF & @CRLF)
EndFunc   ;==>_IEEvent_BeforeNavigate2

; User's COM error function. Will be called if COM error occurs
Func _ErrFunc($oError)
	; Do anything here.
	ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") : ==> COM Error intercepted !" & @CRLF & _
			@TAB & "err.number is: " & @TAB & @TAB & "0x" & Hex($oError.number) & @CRLF & _
			@TAB & "err.windescription:" & @TAB & $oError.windescription & @CRLF & _
			@TAB & "err.description is: " & @TAB & $oError.description & @CRLF & _
			@TAB & "err.source is: " & @TAB & @TAB & $oError.source & @CRLF & _
			@TAB & "err.helpfile is: " & @TAB & $oError.helpfile & @CRLF & _
			@TAB & "err.helpcontext is: " & @TAB & $oError.helpcontext & @CRLF & _
			@TAB & "err.lastdllerror is: " & @TAB & $oError.lastdllerror & @CRLF & _
			@TAB & "err.scriptline is: " & @TAB & $oError.scriptline & @CRLF & _
			@TAB & "err.retcode is: " & @TAB & "0x" & Hex($oError.retcode) & @CRLF & @CRLF)
EndFunc   ;==>_ErrFunc
