#include <Clipboard.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $iFormat

	; Create GUI
	GUICreate("Clipboard", 600, 400)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Register a new clipboard format
	$iFormat = _ClipBoard_RegisterFormat("AutoIt Library Text")
	If $iFormat <> 0 Then

		; Show new format
		MemoWrite(_ClipBoard_GetFormatName($iFormat))
	Else
		_WinAPI_ShowError("_ClipBoard_RegisterFormat failed")
	EndIf

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
