; COM Test file
;
; Test usage of Events with WMI

; See also: http://msdn.microsoft.com/library/en-us/wmisdk/wmi/making_an_asynchronous_call_with_vbscript.asp

#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

; WMI Requires a separate Sink Event Handler
Global $g_oWMISink = ObjCreate("WbemScripting.SWbemSink")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "Error opening oWMISink. Error code: " & @error)
	Exit
EndIf

; Initialize our Event Handler and connect it to the WMI Sink
Local $oSinkObject = ObjEvent($g_oWMISink, "MYSINK_")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "Error initializing Events. Error code: " & @error)
	Exit
EndIf

; Make a simple GUI to output events
GUICreate("WMI Event Test", 640, 480)
Global $g_idEdit = GUICtrlCreateEdit("WMI Active processes list:" & @CRLF, 10, 10, 600, 400)
GUISetState() ;Show GUI

; Open WMI
Local $oWMI = ObjGet("winmgmts:root\cimv2")

; Execute our asynchronous query
$oWMI.ExecQueryAsync($g_oWMISink, "SELECT Name FROM Win32_Process")

; Loop until user closes window
Local $iMsg
While 1
	$iMsg = GUIGetMsg()
	If $iMsg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd
GUIDelete()

Exit

; ---My Event Functions---

Func MYSINK_Cancel()
	; WMI Wants us to cancel the event
	$g_oWMISink.Cancel
	GUICtrlSetData($g_idEdit, @CRLF & "Cancel was requested." & @CRLF, "append")
EndFunc   ;==>MYSINK_Cancel

Func MYSINK_OnProgress()
EndFunc   ;==>MYSINK_OnProgress

Func MYSINK_OnObjectReady($oObject, $oAsyncContext)
	#forceref $oAsyncContext

	GUICtrlSetData($g_idEdit, "Active Process name is: " & $oObject.Name & @CRLF, "append")
EndFunc   ;==>MYSINK_OnObjectReady

Func MYSINK_OnCompleted($iHResult, $oErrorObject, $oAsyncContext)
	#forceref $iHResult, $oErrorObject, $oAsyncContext

	$g_oWMISink.Cancel ; Cancel any leftovers
	GUICtrlSetData($g_idEdit, "Completed: WMI Asynchronous operation is done." & @CRLF, "append")
	GUICtrlSetData($g_idEdit, @CRLF & "You can now close this window" & @CRLF, "append")
EndFunc   ;==>MYSINK_OnCompleted
