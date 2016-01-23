#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

Global $g_idMemo, $g_tDate

Example()

Func Example()
	Local $hDTP

	; Create GUI
	GUICreate("DateTimePick Set System TimeEx", 400, 300)
	$hDTP = GUICtrlGetHandle(GUICtrlCreateDate("", 2, 6, 190))
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Set the display format
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; Set system time
	$g_tDate = DllStructCreate($tagSYSTEMTIME)
	DllStructSetData($g_tDate, "Year", @YEAR)
	DllStructSetData($g_tDate, "Month", 8)
	DllStructSetData($g_tDate, "Day", 19)
	DllStructSetData($g_tDate, "Hour", 21)
	DllStructSetData($g_tDate, "Minute", 57)
	DllStructSetData($g_tDate, "Second", 34)
	_GUICtrlDTP_SetSystemTimeEx($hDTP, $g_tDate)

	; Display system time
	$g_tDate = _GUICtrlDTP_GetSystemTimeEx($hDTP)
	MemoWrite("Selected date: " & GetDateStr())
	MemoWrite("Selected time: " & GetTimeStr())

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Returns the date portion
Func GetDateStr()
	Return StringFormat("%02d/%02d/%04d", DllStructGetData($g_tDate, "Month"), DllStructGetData($g_tDate, "Day"), DllStructGetData($g_tDate, "Year"))
EndFunc   ;==>GetDateStr

; Returns the time portion
Func GetTimeStr()
	Return StringFormat("%02d:%02d:%02d", DllStructGetData($g_tDate, "Hour"), DllStructGetData($g_tDate, "Minute"), DllStructGetData($g_tDate, "Second"))
EndFunc   ;==>GetTimeStr

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
