#include <Clipboard.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $id_SetData, $id_GetData, $hMemory, $tData

	; Create GUI
	$hGUI = GUICreate("Clipboard", 600, 450)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	$id_SetData = GUICtrlCreateButton("Set ClipBoard Data", 150, 410, 120, 30)
	$id_GetData = GUICtrlCreateButton("Get ClipBoard Data", 300, 410, 120, 30)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $id_SetData
				_ClipBoard_SetData("ClipBoard Library")
			Case $id_GetData
				; Open the clipboard
				If _ClipBoard_Open($hGUI) Then

					; Read clipboard text
					$hMemory = _ClipBoard_GetDataEx($CF_TEXT)
					If $hMemory = 0 Then _WinAPI_ShowError("_ClipBoard_GetDataEx failed")
					$tData = DllStructCreate("char Text[8192]", $hMemory)
					MemoWrite(DllStructGetData($tData, "Text"))

					; Close the clipboard
					_ClipBoard_Close()
				Else
					_WinAPI_ShowError("_ClipBoard_Open failed")
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
