#include <MsgBoxConstants.au3>

; COM Test file
;
; Stops and starts the 'Windows Update' service
;
; http://msdn.microsoft.com/library/en-us/shellcc/platform/shell/reference/objects/ishelldispatch2/ishelldispatch2.asp

; Open Windows Shell object
Local $oShell = ObjCreate("shell.application")

If $oShell.IsServiceRunning("wuauserv") Then

	$oShell.ServiceStop("wuauserv", False)

	MsgBox($MB_SYSTEMMODAL, "Service Stopped", "Service: automatic update services is now stopped")

	$oShell.ServiceStart("wuauserv", False)

	MsgBox($MB_SYSTEMMODAL, "Service Started", "Service: automatic update services is started again")

EndIf
