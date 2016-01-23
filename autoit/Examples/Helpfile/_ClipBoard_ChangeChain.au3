#include <Clipboard.au3>
#include <GUIConstantsEx.au3>
#include <SendMessage.au3>
#include <WindowsConstants.au3>

Global $g_idMemo, $g_hNext = 0

Example()

Func Example()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("Clipboard", 600, 400)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Initialize clipboard viewer
	$g_hNext = _ClipBoard_SetViewer($hGUI)

	GUIRegisterMsg($WM_CHANGECBCHAIN, "WM_CHANGECBCHAIN")
	GUIRegisterMsg($WM_DRAWCLIPBOARD, "WM_DRAWCLIPBOARD")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Shut down clipboard viewer
	_ClipBoard_ChangeChain($hGUI, $g_hNext)
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

; Handle $WM_CHANGECBCHAIN messages
Func WM_CHANGECBCHAIN($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg
	; Show that message was received
	MemoWrite("***** $WM_CHANGECBCHAIN *****")

	; If the next window is closing, repair the chain
	If $wParam = $g_hNext Then
		$g_hNext = $lParam
		; Otherwise pass the message to the next viewer
	ElseIf $g_hNext <> 0 Then
		_SendMessage($g_hNext, $WM_CHANGECBCHAIN, $wParam, $lParam, 0, "hwnd", "hwnd")
	EndIf
EndFunc   ;==>WM_CHANGECBCHAIN

; Handle $WM_DRAWCLIPBOARD messages
Func WM_DRAWCLIPBOARD($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg
	; Display any text on clipboard
	MemoWrite(_ClipBoard_GetData())

	; Pass the message to the next viewer
	If $g_hNext <> 0 Then _SendMessage($g_hNext, $WM_DRAWCLIPBOARD, $wParam, $lParam)
EndFunc   ;==>WM_DRAWCLIPBOARD
