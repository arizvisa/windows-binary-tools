#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGui, $tLOGFONT, $hFont, $hDTP

	; Create GUI
	$hGui = GUICreate("DateTimePick Set Month Calendar Font", 400, 300)
	$hDTP = _GUICtrlDTP_Create($hGui, 2, 6, 190)
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Set the display format
	_GUICtrlDTP_SetFormat($hDTP, "ddd MMM dd, yyyy hh:mm ttt")

	; Create a new font for the month control
	$tLOGFONT = DllStructCreate($tagLOGFONT)
	DllStructSetData($tLOGFONT, "Height", 13)
	DllStructSetData($tLOGFONT, "Weight", 400)
	DllStructSetData($tLOGFONT, "FaceName", "Verdana")
	$hFont = _WinAPI_CreateFontIndirect($tLOGFONT)
	_GUICtrlDTP_SetMCFont($hDTP, $hFont)

	; Get month control font handle
	MemoWrite("Font Handle: " & "0x" & Hex(_GUICtrlDTP_GetMCFont($hDTP), 6))
	MemoWrite("IsPtr  = " & IsPtr(_GUICtrlDTP_GetMCFont($hDTP)) & " IsHWnd  = " & IsHWnd(_GUICtrlDTP_GetMCFont($hDTP)))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
