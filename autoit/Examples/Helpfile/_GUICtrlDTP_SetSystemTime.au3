#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

Global $g_idMemo, $g_aDate

Example()

Func Example()
	Local $hDTP, $a_Date[7] = [False, @YEAR, 8, 19, 21, 57, 34]

	; Create GUI
	GUICreate("DateTimePick Set System Time", 400, 300)
	$hDTP = GUICtrlGetHandle(GUICtrlCreateDate("", 2, 6, 190))
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Set the display format
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; Set system time
	_GUICtrlDTP_SetSystemTime($hDTP, $a_Date)

	; Display system time
	$g_aDate = _GUICtrlDTP_GetSystemTime($hDTP)
	MemoWrite("Selected date: " & GetDateStr())
	MemoWrite("Selected time: " & GetTimeStr())

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Returns the date portion
Func GetDateStr()
	Return StringFormat("%02d/%02d/%04d", $g_aDate[1], $g_aDate[2], $g_aDate[0])
EndFunc   ;==>GetDateStr

; Returns the time portion
Func GetTimeStr()
	Return StringFormat("%02d:%02d:%02d", $g_aDate[3], $g_aDate[4], $g_aDate[5])
EndFunc   ;==>GetTimeStr

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
