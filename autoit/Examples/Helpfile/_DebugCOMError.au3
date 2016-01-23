#include <Debug.au3>
#include <MsgBoxConstants.au3>

_DebugSetup(Default, True, 1, Default, True) ; 1 = GUI output with timestamping

Example()

; *****************************************************************************
; Example
; Generate a COM error and let _DebugCOMError display the error
; *****************************************************************************
Func Example()
	; Create application object for the Microsoft Internet Explorer
	Local $oIE = ObjCreate("InternetExplorer.Application")
	If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "_DebugCOMError UDF", "Error creating a new IE application object." & _
			@CRLF & "@error = " & @error & ", @extended = " & @extended)
	; Set up the COM error handler to write error messages using a GUI and exit on error
	_DebugCOMError(1)
	; Provoke a COM error. Functions is unknown
	$oIE.xyz()
	If @error <> 0 Then Return MsgBox($MB_SYSTEMMODAL, "_DebugCOMError UDF", "Error occurred and handled." & _
			@CRLF & "@error = " & @error)
	; Close the IE
	$oIE.Quit()
	$oIE = 0
EndFunc   ;==>Example
