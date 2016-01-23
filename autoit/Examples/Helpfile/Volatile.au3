_COM_Example()

Func _COM_Example()
	; Create Internet Explorer object
	Local $oIE = ObjCreate("InternetExplorer.Application")
	; Check for errors
	If @error Then Return
	$oIE.Visible = True ; set visibility
	; Custom sink object
	ObjEvent($oIE, "_IEEvent_", "DWebBrowserEvents2")
	; Navigate somewhere
	$oIE.navigate("http://www.google.com")
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

	; Wait few seconds to see if more events will be fired
	Sleep(3000)
	; Nothing more to do. Close IE and return from the function
	$oIE.Quit()
EndFunc   ;==>_COM_Example

; BeforeNavigate2 method definition
Volatile Func _IEEvent_BeforeNavigate2($oIEpDisp, $sIEURL, $iIEFlags, $sIETargetFrameName, $sIEPostData, $iIEHeaders, ByRef $bIECancel)

	ConsoleWrite("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--BeforeNavigate2 fired--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! " & @CRLF & _
			"$oIEpDisp = " & $oIEpDisp() & "  -  " & ObjName($oIEpDisp) & @CRLF & _ ; e.g. default property and name for the object
			"$sIEURL = " & $sIEURL & @CRLF & _
			"$iIEFlags = " & $iIEFlags & @CRLF & _
			"$sIETargetFrameName = " & $sIETargetFrameName & @CRLF & _
			"$sIEPostData = " & $sIEPostData & @CRLF & _
			"$iIEHeaders = " & $iIEHeaders & @CRLF & _
			"$bIECancel = " & $bIECancel & @CRLF & _
			"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! " & @CRLF & @CRLF)

	; Cancel navigation
	$bIECancel = True
EndFunc   ;==>_IEEvent_BeforeNavigate2
