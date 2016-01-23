#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

Global $g_idMemo, $g_tRange

Example()

Func Example()
	Local $hDTP

	; Create GUI
	GUICreate("DateTimePick Get RangeEx", 400, 300)
	$hDTP = GUICtrlGetHandle(GUICtrlCreateDate("", 2, 6, 190))
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Set the display format
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; Set date range
	$g_tRange = DllStructCreate($tagDTPRANGE)
	DllStructSetData($g_tRange, "MinValid", True)
	DllStructSetData($g_tRange, "MinYear", @YEAR)
	DllStructSetData($g_tRange, "MinMonth", 1)
	DllStructSetData($g_tRange, "MinDay", 1)
	DllStructSetData($g_tRange, "MinHour", 0)
	DllStructSetData($g_tRange, "MinMinute", 0)
	DllStructSetData($g_tRange, "MinSecond", 1)
	DllStructSetData($g_tRange, "MaxValid", True)
	DllStructSetData($g_tRange, "MaxYear", @YEAR)
	DllStructSetData($g_tRange, "MaxMonth", 12)
	DllStructSetData($g_tRange, "MaxDay", 31)
	DllStructSetData($g_tRange, "MaxHour", 12)
	DllStructSetData($g_tRange, "MaxMinute", 59)
	DllStructSetData($g_tRange, "MaxSecond", 59)
	_GUICtrlDTP_SetRangeEx($hDTP, $g_tRange)

	; Display date range
	$g_tRange = _GUICtrlDTP_GetRangeEx($hDTP)
	MemoWrite("Minimum date: " & GetDateStr("Min"))
	MemoWrite("Maximum date: " & GetDateStr("Max"))
	MemoWrite("Minimum time: " & GetTimeStr("Min"))
	MemoWrite("Maximum time: " & GetTimeStr("Max"))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Returns the date portion
Func GetDateStr($sPrefix)
	If $sPrefix = "Min" Then
		Return StringFormat("%02d/%02d/%04d", DllStructGetData($g_tRange, "MinMonth"), DllStructGetData($g_tRange, "MinDay"), DllStructGetData($g_tRange, "MinYear"))
	Else
		Return StringFormat("%02d/%02d/%04d", DllStructGetData($g_tRange, "MaxMonth"), DllStructGetData($g_tRange, "MaxDay"), DllStructGetData($g_tRange, "MaxYear"))
	EndIf
EndFunc   ;==>GetDateStr

; Returns the time portion
Func GetTimeStr($sPrefix)
	If $sPrefix = "Min" Then
		Return StringFormat("%02d:%02d:%02d", DllStructGetData($g_tRange, "MinHour"), DllStructGetData($g_tRange, "MinMinute"), DllStructGetData($g_tRange, "MinSecond"))
	Else
		Return StringFormat("%02d:%02d:%02d", DllStructGetData($g_tRange, "MaxHour"), DllStructGetData($g_tRange, "MaxMinute"), DllStructGetData($g_tRange, "MaxSecond"))
	EndIf
EndFunc   ;==>GetTimeStr

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
