#include <EventLog.au3>
#include <GUIConstantsEx.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hEventLog, $aEvent

	; Create GUI
	GUICreate("EventLog", 400, 300)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 300, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Read most current event record
	$hEventLog = _EventLog__Open("", "Application")
	$aEvent = _EventLog__Read($hEventLog, True, False) ; read last event
	; $hEventLog = _EventLog__Open("", "System")
	; $aEvent = _EventLog__Read($hEventLog)
	; $aEvent = _EventLog__Read($hEventLog, True, False)
	MemoWrite("Result ............: " & $aEvent[0])
	MemoWrite("Record number .....: " & $aEvent[1])
	MemoWrite("Submitted .........: " & $aEvent[2] & " " & $aEvent[3])
	MemoWrite("Generated .........: " & $aEvent[4] & " " & $aEvent[5])
	MemoWrite("Event ID ..........: " & $aEvent[6])
	MemoWrite("Type ..............: " & $aEvent[8])
	MemoWrite("Category ..........: " & $aEvent[9])
	MemoWrite("Source ............: " & $aEvent[10])
	MemoWrite("Computer ..........: " & $aEvent[11])
	MemoWrite("Username ..........: " & $aEvent[12])
	MemoWrite("Description .......: " & $aEvent[13])
	_EventLog__Close($hEventLog)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
