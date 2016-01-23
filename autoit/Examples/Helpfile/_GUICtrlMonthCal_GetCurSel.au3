#include <GUIConstantsEx.au3>
#include <GuiMonthCal.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $tTime, $idMonthCal

	; Create GUI
	GUICreate("Month Calendar Get Cur Sel", 400, 300)
	$idMonthCal = GUICtrlCreateMonthCal("", 4, 4, -1, -1, $WS_BORDER, 0x00000000)

	; Create memo control
	$g_idMemo = GUICtrlCreateEdit("", 4, 168, 392, 128, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Get/Set current selection
	_GUICtrlMonthCal_SetCurSel($idMonthCal, @YEAR, 8, 19)
	$tTime = _GUICtrlMonthCal_GetCurSel($idMonthCal)
	MemoWrite("Current selection : " & StringFormat("%02d/%02d/%04d", DllStructGetData($tTime, "Month"), _
			DllStructGetData($tTime, "Day"), _
			DllStructGetData($tTime, "Year")))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
