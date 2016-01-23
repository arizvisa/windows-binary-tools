#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $tTime, $aTime

	; Create GUI
	GUICreate("Time", 400, 300)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Get current system time
	$tTime = _Date_Time_GetSystemTime()
	$aTime = _Date_Time_SystemTimeToArray($tTime)
	MemoWrite("Month ........: " & $aTime[0])
	MemoWrite("Day ..........: " & $aTime[1])
	MemoWrite("Year .........: " & $aTime[2])
	MemoWrite("Hour .........: " & $aTime[3])
	MemoWrite("Minute .......: " & $aTime[4])
	MemoWrite("Second .......: " & $aTime[5])
	MemoWrite("Milliseconds .: " & $aTime[6])
	MemoWrite("Day of week ..: " & $aTime[7])

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
