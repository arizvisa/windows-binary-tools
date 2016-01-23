#include <EventLog.au3>
#include <GUIConstantsEx.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hEventLog

	; Create GUI
	GUICreate("EventLog", 400, 300)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 300, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	$hEventLog = _EventLog__Open("", "Application")
	_EventLog__Backup($hEventLog, "C:\EventLog.bak")
	_EventLog__Close($hEventLog)

	$hEventLog = _EventLog__OpenBackup("", "C:\EventLog.bak")
	MemoWrite("Log full ........: " & _EventLog__Full($hEventLog))
	MemoWrite("Log record count : " & _EventLog__Count($hEventLog))
	MemoWrite("Log oldest record: " & _EventLog__Oldest($hEventLog))
	_EventLog__Close($hEventLog)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
