#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

Global $g_idMemo, $g_aRange[14] = [True, @YEAR, 1, 1, 21, 45, 32, True, @YEAR, 12, 31, 23, 59, 59]

Example()

Func Example()
	Local $hDTP

	; Create GUI
	GUICreate("DateTimePick Set Range", 400, 300)
	$hDTP = GUICtrlGetHandle(GUICtrlCreateDate("", 2, 6, 190))
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Set the display format
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; Set date range
	_GUICtrlDTP_SetRange($hDTP, $g_aRange)

	; Display date range
	$g_aRange = _GUICtrlDTP_GetRange($hDTP)
	MemoWrite("Minimum date: " & GetDateStr(0))
	MemoWrite("Maximum date: " & GetDateStr(7))
	MemoWrite("Minimum time: " & GetTimeStr(4))
	MemoWrite("Maximum time: " & GetTimeStr(11))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Returns the date portion
Func GetDateStr($iOff = 0)
	Return StringFormat("%02d/%02d/%04d", $g_aRange[$iOff + 2], $g_aRange[$iOff + 3], $g_aRange[$iOff + 1])
EndFunc   ;==>GetDateStr

; Returns the time portion
Func GetTimeStr($iOff = 0)
	Return StringFormat("%02d:%02d:%02d", $g_aRange[$iOff], $g_aRange[$iOff + 1], $g_aRange[$iOff + 2])
EndFunc   ;==>GetTimeStr

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
